<template>
	<div>
		<el-table :data="tableData" :height="500" :stripe="true" :empty-text="dataText" v-loading="loading"
		 element-loading-text="拼命加载中" element-loading-spinner="el-icon-loading" element-loading-background="rgba(0, 0, 0, 0.06)"
		 border>
			<el-table-column prop="id" v-if="false" align="center" label="id" min-width="8%">
			</el-table-column>
			<el-table-column prop="cname" align="center" label="课程名" sortable min-width="12%">
			</el-table-column>
			<el-table-column prop="tname" align="center" label="教师名" sortable min-width="12%">
			</el-table-column>
			<el-table-column prop="url" align="center" label="封面图" sortable min-width="15%">
				<template slot-scope="scope">
					<!-- 预览图片 -->
					<ShowImg :url="scope.row.url"></ShowImg>
					
					<!-- 编辑按钮 -->
					<EditImg
					style="margin-right: 12px;"
					 @showListCount="showListCount"
					:id="scope.row.id" 
					:url="scope.row.url"
					:tName="currentTName"
					:cName="currentCName"
					:page="page" 
					:limit="limit" ></EditImg>
					<span v-if="scope.row.url === isImgNull">
						<img class="noImg_box" src="../../../assets/noImg.png" alt="">
					</span>
					<span v-else>
						<img class="haveImg_box" src="../../../assets/haveImg.png" alt="">
					</span>
				</template>
			</el-table-column>
			<el-table-column prop="qq" align="center" sortable label="QQ群号" min-width="15%">
			</el-table-column>
			<el-table-column prop="endTime" align="center" sortable label="截止报名日期" min-width="15%">
			</el-table-column>
			

			<el-table-column prop="status" align="center" sortable label="状态" min-width="10%">
				<template slot-scope="scope">
					<div v-if="scope.row.status == 1">
						<span class="mianfei">停止报名</span>
					</div>
					<div v-if="scope.row.status == 0">
						<span class="shoufei">可报名</span>
					</div>
				</template>
			</el-table-column>
			
			<el-table-column prop="personNumber" align="center" sortable label="报名人数" min-width="10%">
			</el-table-column>
		</el-table>
		<el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="page" :page-sizes="[10, 20, 30, 40]"
		 :page-size="100" layout="total, sizes, prev, pager, next, jumper" :total="this.total">
		</el-pagination>
	</div>
</template>

<script>
	import axios from 'axios';
	import ShowImg from './ShowImg.vue';
	import EditImg from './EditImg.vue';
	export default {
		name: 'List',
		data() {
			return {
				time: "",
				formLabelWidth: "120px",
				currentPage: 1,
				pageLimit: 10,
				isImgNull: this.$global_msg.adminRoute1 + "null"
			};
		},
		components: {
			ShowImg,
			EditImg
		},
		props: {
			total: Number,
			tableData: Array,
			currentTName: String,
			currentCName: String,
			page: Number,
			limit: Number,
			loading: Boolean,
			dataText: String
		},
		methods: {
			// 编辑封面图
			changeImg(id) {

			},
			// 展示分页数据
			showListCount(tName, cName, currentPage, pageLimit) {
				this.$emit('showList', tName, cName, currentPage, pageLimit)
			},
			// 监听改变分页总条数
			handleSizeChange(val) {
				this.pageLimit = val;
				this.showListCount(this.currentTName, this.currentCName, this.pageLimit, this.pageLimit)
			},
			// 监听改变切换页码, 并渲染数据
			handleCurrentChange(val) {
				this.currentPage = val;
				this.showListCount(this.currentTName, this.currentCName, this.currentPage, this.pageLimit)
			},

		},
		mounted() {
			this.currentPage = this.page
			this.pageLimit = this.limit
			this.showListCount(this.currentTName, this.currentCName, 1, this.pageLimit)
		},
// 		watch: {
// 			form: {  
// 		　　　　　handler(newValue, oldValue) {
// 			// console.log("刷新了")
// 　　　　　　			this.form = newValue
// 　　　　			},  
// 			　　deep: true,
// 				simmediate: true
// 			}  
// 		},  
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
	.noImg_box {
		width: 12px;
		height: 12px;
	}
	
	.haveImg_box {
		width: 12px;
		height: 12px;
	}
</style>
