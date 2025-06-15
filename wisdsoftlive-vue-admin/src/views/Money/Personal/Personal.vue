<template>
	<div>
		<PersonalTop @getTotelMoney="getTotelMoney" :sumMoney="sumMoney" :surplusMoney="surplusMoney" :freeMoneySum="freeMoneySum"
		 :chargeMoneySum="chargeMoneySum"></PersonalTop>
		<PersonalList @changePOrL="changePOrL" @getTotelMoney="getTotelMoney" :tableData="tableData" :dataText="dataText"
		 :loading="loading" :toId="toId"></PersonalList>
		<PersonalPage @changePOrL="changePOrL" :total="total" :page="page" :limit="limit"></PersonalPage>
	</div>
</template>
<script>
	import PersonalTop from './components/PersonalTop.vue';
	import PersonalList from './components/PersonalList.vue';
	import PersonalPage from './components/PersonalPage.vue';
	import axios from 'axios';
	export default {
		name: 'Personal',
		components: {
			PersonalTop,
			PersonalList,
			PersonalPage
		},
		data() {
			return {
				tableData: [],
				total: 0,
				page: 1,
				limit: 10,
				dataText: "暂无数据",
				loading: false,
				sumMoney: 0.00,
				surplusMoney: 0.00,
				toId: 1,
				freeMoneySum: 0,
				chargeMoneySum: 0,
			}
		},
		methods: {
			changePOrL(page, limit) {
				this.page = page;
				this.limit = limit;
				this.noConditionSearch();
			},
			noConditionSearch() {
				this.changeType();
				axios
					.get(this.$global_msg.adminRoute + '/teacher/selectTeacherOnPage', {
						params: {
							page: this.page,
							limit: this.limit
						}
					})
					.then(res => {
						this.tableData = res.data.data;
						this.total = res.data.count;
						this.changeType();
					})
					.catch(response => {
						console.log(response);
						this.changeType();
					});
			},
			changeType() {
				this.loading = !this.loading;
				if (this.dataText === " ") {
					this.dataText = "暂无数据"
				} else {
					this.dataText = " "
				}
			},
			getTotelMoney() {
				axios
					.get(this.$global_msg.adminRoute + '/totalMoney/selectTotalMoney')
					.then(res => {
						for (var index in res.data.data) {
							var myData = res.data.data[0];
							this.sumMoney = myData.sumMoney;
							this.surplusMoney = myData.surplusMoney;
							this.toId = myData.id;
						}
					})
					.catch(response => {
						console.log(response);
					});
				axios
					.get(this.$global_msg.adminRoute + '/teacher/selectTeacherMoneySum')
					.then(res => {
						var data = res.data.data
						this.freeMoneySum = data[0]
						this.chargeMoneySum = data[1]
					})
					.catch(response => {
						console.log(response);
					});
			}
		}
	}
</script>

<style scoped="scoped">
</style>
