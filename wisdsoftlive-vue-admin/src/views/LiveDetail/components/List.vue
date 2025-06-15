<template>
	<div>
		<el-table :data="tableData" :height="500" :stripe="true" :empty-text="dataText" v-loading="loading"
		 element-loading-text="拼命加载中" element-loading-spinner="el-icon-loading" element-loading-background="rgba(0, 0, 0, 0.06)"
		 border>
			<el-table-column prop="cname" align="center" label="课程名称" sortable min-width="12%">
			</el-table-column>
			
			<el-table-column prop="tname" align="center" sortable label="授课老师" min-width="12%">
			</el-table-column>
			<el-table-column prop="uname" align="center" label="用户昵称" sortable min-width="12%">
			</el-table-column>
			<el-table-column prop="uemail" align="center" label="用户邮箱" sortable min-width="12%">
			</el-table-column>
			<el-table-column prop="lqq" align="center" label="QQ群" sortable min-width="12%">
			</el-table-column>

			<el-table-column prop="ltype" align="center" label="进行状态" sortable min-width="8%">
				<template slot-scope="scope">
					<div v-if="scope.row.ltype == 0">
						<span class="mianfei">已结课</span>
					</div>
					<div v-if="scope.row.ltype == 1">
						<span class="shoufei">进行中</span>
					</div>
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
	export default {
		name: 'List',
		data() {
			return {
				time: "",
				formLabelWidth: "120px",
				currentPage: 1,
				pageLimit: 10,
			};
		},
		props: {
			total: Number,
			tableData: Array,
			uEmail: String,
			cName: String,
			page: Number,
			limit: Number,
			loading: Boolean,
			dataText: String
		},
		methods: {
			// 展示分页数据
			showListCount(uEmail, cName, currentPage, pageLimit) {
				this.$emit('showList', uEmail, cName, currentPage, pageLimit)
			},
			// 监听改变分页总条数
			handleSizeChange(val) {
				this.pageLimit = val;
				this.showListCount(this.uEmail, this.cName, 1, this.pageLimit)
			},
			// 监听改变切换页码, 并渲染数据
			handleCurrentChange(val) {
				this.currentPage = val;
				this.showListCount(this.uEmail, this.cName, this.currentPage, this.limit)
			},

		},
		mounted() {
			this.showListCount("", "", 1, 10)
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
