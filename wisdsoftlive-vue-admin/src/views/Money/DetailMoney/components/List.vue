<template>
	<div>
		<el-table :data="tableData" :height="500" :stripe="true" :empty-text="dataText" v-loading="loading"
		 element-loading-text="拼命加载中" element-loading-spinner="el-icon-loading" element-loading-background="rgba(0, 0, 0, 0.06)"
		 border>
			<el-table-column prop="id" v-if="false" align="center" label="id" min-width="8%">
			</el-table-column>
			<el-table-column align="center" label="角色" min-width="8%">
				<el-table-column prop="uname" align="center" label="学生" sortable min-width="8%">
					<template slot-scope="scope">
						<div v-if="scope.row.uname == null">
							<span class="mianfei">未涉及学生</span>
						</div>
						
						<div v-if="scope.row.uname != null">
							{{scope.row.uname}}
						</div>
					</template>
				</el-table-column>

				<el-table-column pro="tname" align="center" label="老师" sortable min-width="8%">
					<template slot-scope="scope">
						<div v-if="scope.row.tname == null">
							<span class="mianfei">未涉及老师</span>
						</div>
						<div v-if="scope.row.tname != null">
							{{scope.row.tname}}
						</div>
					</template>
				</el-table-column>
			</el-table-column>

			
			<el-table-column prop="cname" align="center" sortable label="所属课程" min-width="12%">
				<template slot-scope="scope">
					<div v-if="scope.row.cname == null">
						<span class="mianfei">未涉及课程</span>
					</div>
					<div v-if="scope.row.cname != null">
						{{scope.row.cname}}
						<span v-if="scope.row.ctype == 0">
							(直播课程)
						</span>
						<span v-if="scope.row.ctype == 1">
							(视频课程)
						</span>
					</div>
				</template>
			</el-table-column>
			<el-table-column prop="money" align="center" label="操作金额" sortable min-width="12%">
			</el-table-column>
			<el-table-column prop="detail" align="center" :show-overflow-tooltip="true" label="操作用途" min-width="12%">
			</el-table-column>
			<el-table-column prop="time" align="center" label="操作时间" sortable min-width="12%">
			</el-table-column>

			<el-table-column prop="type" align="center" label="收支类型" sortable min-width="8%">
				<template slot-scope="scope">
					<div v-if="scope.row.type == 1">
						<span class="shoufei">收入</span>
					</div>
					<div v-if="scope.row.type == 0">
						<span class="mianfei">支出</span>
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
			currentTime: String,
			currentTName: String,
			currentType: String,
			page: Number,
			limit: Number,
			loading: Boolean,
			dataText: String
		},
		methods: {
			// 展示分页数据
			showListCount(time, tName, type, currentPage, pageLimit) {
				this.$emit('showList', time, tName, type, currentPage, pageLimit)
			},
			// 监听改变分页总条数
			handleSizeChange(val) {
				this.pageLimit = val;
				this.showListCount(this.time, this.currentTName, this.currentType, 1, this.pageLimit)
			},
			// 监听改变切换页码, 并渲染数据
			handleCurrentChange(val) {
				this.currentPage = val;
				this.showListCount(this.time, this.currentTName, this.currentType, this.currentPage, this.pageLimit)
			},

		},
		mounted() {
			this.currentPage = this.page
			this.pageLimit = this.limit
			this.showListCount(this.time, this.currentTName, this.currentType, this.currentPage, this.pageLimit)
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
