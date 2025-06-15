<template>
	<div>
		<top @showListAll="showListAll" @showListByName="showListByName" :total="total" :page="page" :limit="limit"></top>
		<list @showListAll="showListAll" @showListByName="showListByName" :total="total" :tableData="tableData" :currentTName="currentTName" :currentType="currentType"
		 :page="page" :limit="limit" :loading="loading" :dataText="dataText">
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
				currentType: "2",
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
			// 查询分页数据 ---> 无条件查询
			showListAll(name, type, page, limit) {
				this.currentTName = name
				this.currentType = type
				this.page = page
				this.limit = limit
				this.loading = true
				this.dataText = "  "
				axios.get(this.$global_msg.adminRoute + '/user/selectAll', {
						params: {
							"name": name,
							"type": type,
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
			// 查询分页数据 ---> 根据昵称与校内外类型
			showListByName(name, type, page, limit) {
				this.currentTName = name
				this.currentType = type
				this.page = page
				this.limit = limit
				this.loading = true
				this.dataText = "  "
				axios.get(this.$global_msg.adminRoute + '/user/selectByName', {
						params: {
							"name": name,
							"type": type,
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
