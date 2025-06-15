<template>
	<div>
		<el-table :data="tableData" :height="500" :stripe="true" :empty-text="dataText" v-loading="loading"
		 element-loading-text="拼命加载中" element-loading-spinner="el-icon-loading" element-loading-background="rgba(0, 0, 0, 0.06)"
		 border>
			<el-table-column prop="id" v-if="false" align="center" label="id" min-width="8%">
			</el-table-column>
			<el-table-column prop="name" align="center" label="昵称" sortable min-width="12%">
			</el-table-column>
			<el-table-column prop="number" align="center" label="账号" sortable min-width="12%">
			</el-table-column>
		
			
			<el-table-column prop="type" align="center" sortable label="账号类型" min-width="15%">
				<template slot-scope="scope">
					<div v-if="scope.row.type == 0">
						<span class="shoufei">校内验证</span>
					</div>
					<div v-if="scope.row.type == 1">
						<span class="mianfei">校外账号</span>
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
			currentTName: String,
			currentType: String,
			page: Number,
			limit: Number,
			loading: Boolean,
			dataText: String
		},
		methods: {
			// 一进入的展示分页数据
			showListCount(name, type, currentPage, pageLimit) {
				this.$emit('showListAll', name, type, currentPage, pageLimit)
			},
			// 按条件的展示分页数据
			showListByName(name, type, currentPage, pageLimit) {
				this.$emit('showListByName', name, type, currentPage, pageLimit)
			},
			// 监听改变分页总条数
			handleSizeChange(val) {
				this.pageLimit = val;
				this.showListByName(this.currentTName, this.currentType, this.currentPage, this.pageLimit)
			},
			// 监听改变切换页码, 并渲染数据
			handleCurrentChange(val) {
				this.currentPage = val;
				this.showListByName(this.currentTName, this.currentType, this.currentPage, this.pageLimit)
			},

		},
		mounted() {
			this.currentPage = this.page
			this.pageLimit = this.limit
			this.showListCount("", "2", 1, this.pageLimit)
		},
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

	.el-table td div {
		box-sizing: border-box;
		display: inline-block !important;
	}
</style>
