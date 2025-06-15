<template>
	<div>
		<top @showList="showList" :page="page" :limit="limit" 
		 :currentTime="currentTime"
		 :currentType="currentType"
		 :currentTName="currentTName">
		 </top>
		<list @showList="showList" :total="total" :tableData="tableData" :page="page" :limit="limit" :loading="loading"
		 :dataText="dataText"
		 :currentTime="currentTime"
		 :currentType="currentType"
		 :currentTName="currentTName">
		 
		</list>
	</div>
</template>

<script>
	import Top from './components/Top.vue';
	import List from './components/List.vue';
	import axios from 'axios';
	export default {
		name: '',
		data() {
			return {
				tableData: [],
				total: 0,
				currentTime: "",
				currentType: "2",
				currentTName: null,
				page: 1,
				limit: 10,
				loading: true,
				dataText: "  "
			}
		},
		components: {
			Top,
			List,
		},
		methods: {
			// 查询分页数据
			showList(time, tName, type, page, limit) {
				if (type == "请选择收支类型") {
					type = "2"
				}
				this.currentTime = time
				this.currentType = type
				this.page = page
				this.currentTName = tName
				this.limit = limit
				this.loading = true
				this.dataText = "  "
				axios.get(this.$global_msg.adminRoute + '/detailMoney/selectDetailMoney', {
						params: {
							time: time,
							tName: tName,
							type: type,
							page: page,
							limit: limit
						}
					})
					.then((res) => {
						// console.log(res)
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
