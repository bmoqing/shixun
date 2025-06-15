<template>
	<div>
		<top @showList="showList" :currentTName="currentTName" :currentCName="currentCName" :page="page" :limit="limit"></top>
		<list @showList="showList" :total="total" :tableData="tableData" :currentTName="currentTName" :currentCName="currentCName" :page="page" :limit="limit" :loading="loading"
		 :dataText="dataText">
		</list>
	</div>
</template>

<script>
	import Top from './components/Top.vue';
	import List from './components/List.vue';
	// import Add from './components/Add.vue';
	import axios from 'axios';
	export default {
		name: 'LiveCourse',
		data() {
			return {
				tableData: [],
				total: 0,
				currentTName: "",
				currentCName: "",
				page: 1,
				limit: 10,
				loading: true,
				dataText: "  "
			}
		},
		components: {
			Top,
			List,
			// Add
		},
		methods: {
			// 查询分页数据
			showList(tName,cName, page, limit) {
				this.currentTName = tName
				this.currentCName = cName
				this.page = page
				this.limit = limit
				this.loading = true
				this.dataText = "  "
				axios.get(this.$global_msg.adminRoute + '/liveCourse/selectLiveCourse', {
						params: {
							"tName": tName,
							"cName": cName,
							"page": page,
							"limit": limit
						}
					})
					.then((res) => {
						this.tableData = res.data.data;
						this.total = res.data.count;
						this.changeLoadingType();
					}).catch((response) => {
						console.log(response);
						this.changeLoadingType();
					})

			},
			changeLoadingType() {
				this.dataText = "暂无数据"
				this.loading = false
			}


		}
	}
</script>

<style></style>
