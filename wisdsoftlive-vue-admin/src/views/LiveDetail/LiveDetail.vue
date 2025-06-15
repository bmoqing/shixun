<template>
	<div>
		<top @showList="showList" :page="page" :limit="limit" 
		 :uEmail="uEmail"
		 :cName="cName"
		 >
		 </top>
		<list @showList="showList" :total="total" :tableData="tableData" :page="page" :limit="limit" :loading="loading"
		 :dataText="dataText"
		 :uEmail="uEmail"
		 :cName="cName">
		 
		</list>
	</div>
</template>

<script>
	import Top from './components/Top.vue';
	import List from './components/List.vue';
	import axios from 'axios';
	export default {
		name: 'LiveDetail',
		data() {
			return {
				tableData: [],
				total: 0,
				uEmail: "",
				cName: "",
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
			showList(uEmail, cName, page, limit) {
				this.uEmail = uEmail
				this.cName = cName
				this.page = page
				this.limit = limit
				this.loading = true
				this.dataText = "  "
				axios.get(this.$global_msg.adminRoute + '/user/selectPowerBySome', {
						params: {
							uEmail: uEmail,
							cName: cName,
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
		},
	}
</script>

<style></style>
