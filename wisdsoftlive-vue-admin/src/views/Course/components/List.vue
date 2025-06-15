<template>
	<div>
		<el-table :data="tableData" :height="500" :stripe="true"
			:empty-text="dataText"
			v-loading="loading"
			element-loading-text="拼命加载中"
			element-loading-spinner="el-icon-loading"
			element-loading-background="rgba(0, 0, 0, 0.06)" 
			border>
			<el-table-column prop="id" v-if="false" align="center" label="id" min-width="8%">
			</el-table-column>
			<el-table-column prop="name" align="center" label="课程名称" :show-overflow-tooltip="true" min-width="12%">
			</el-table-column>
			<el-table-column prop="content" align="center" label="课程介绍" :show-overflow-tooltip="true" min-width="12%">
			</el-table-column>
			<el-table-column prop="sectionNumber" align="center" label="课程节数" :show-overflow-tooltip="true" min-width="12%">
			</el-table-column>

			<el-table-column prop="type" align="center" label="是否收费" sortable min-width="8%">
				<template slot-scope="scope">
					<div v-if="scope.row.type == 1">
						<span class="shoufei">收费</span>
					</div>
					<div v-if="scope.row.type == 0">
						<span class="mianfei">免费</span>
					</div>
				</template>
			</el-table-column>
			<el-table-column prop="oldMoney" align="center" label="折前价格" sortable min-width="12%">
			</el-table-column>
			<el-table-column prop="inMoney" align="center" sortable label="校内收费金额" min-width="12%">
			</el-table-column>
			<el-table-column prop="outMoney" align="center" sortable label="校外收费金额" min-width="12%">
			</el-table-column>
			<el-table-column label="操作" align="center" min-width="12%">
				<template slot-scope="scope">
					<edit style="display: inline; padding-right: 5px;" :scope="scope.row"></edit>
					<el-button size="small" type="danger" plain @click="handleDelete(scope.row)">删除</el-button>
				</template>
			</el-table-column>
		</el-table>
		<el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="page" :page-sizes="[10, 20, 30, 40]"
		 :page-size="100" layout="total, sizes, prev, pager, next, jumper" :total="this.total">
		</el-pagination>
	</div>
</template>

<script>
	import axios from 'axios';
	import Edit from './Edit.vue';
	export default {
		name: 'List',
		data() {
			return {
				formLabelWidth: "120px",
				currentPage: 1,
				pageLimit: 10,

			};
		},
		props: {
			total: Number,
			tableData: Array,
			page: Number,
			limit: Number,
			loading: Boolean,
			dataText: String,
			name: String
		},
		components: {
			Edit
		},
		methods: {
			// 展示分页数据
			showListCount(name, currentPage, pageLimit) {
				this.$emit('showList', name, currentPage, pageLimit)
			},
			// 删除课程信息
			handleDelete(row) {
				this.$confirm("确定删除 " + row.name + "课程么?", "提示", {
						confirmButtonText: "确定",
						cancelButtonText: "取消",
						type: "warning",
					})

					.then((res) => {
						axios.post(this.$global_msg.adminRoute + '/course/delCourse/' +  row.id)
							.then((res) => {
								console.log(res);
								if (res.data.code == 200) {
									this.$message({
										type: "success",
										message: "删除成功!",
									});
									// 重新渲染页面数据
									this.handleCurrentChange(this.currentPage);
								} else {
									this.$message({
										type: "error",
										message: "删除失败!",
									});
								}
							})
							.catch((e) => {});
					})
					.catch(() => {
						this.$message({
							type: "info",
							message: "已取消删除",
						});
					});
			},
			// 监听改变分页总条数
			handleSizeChange(val) {
				this.pageLimit = val;
				this.showListCount(this.name, 1, this.pageLimit)
			},
			// 监听改变切换页码, 并渲染数据
			handleCurrentChange(val) {
				this.currentPage = val;
				this.showListCount(this.name, this.currentPage, this.pageLimit)
			},

		},
		mounted() {
			this.currentPage = this.page
			this.pageLimit = this.limit
			this.showListCount(this.name, this.currentPage, this.pageLimit)
		}
	};
</script>

<style scoped>
	.shoufei {
		color: rgb(64 158 255);
	}

	.mianfei {
		color: #e02f2fde;
	}

	.has-gutter {
		line-height: 0px;
	}
</style>
