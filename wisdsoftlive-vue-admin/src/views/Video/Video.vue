<template>
	<div>
		<VideoTop @search="search" @changeTOrC="changeTOrC" @reload="reload"></VideoTop>
		<VideoList @remove="romove" :tableData="tableData" :dataText="dataText" :loading="loading"></VideoList>
		<VideoPage @changePOrL="changePOrL" :total="total" :page="page" :limit="limit"></VideoPage>
	</div>
</template>

<script>
	import VideoTop from './components/VideoTop.vue';
	import VideoList from './components/VideoList.vue';
	import VideoPage from './components/VideoPage.vue';
	import axios from 'axios';
	export default {
		name: 'Video',
		components: {
			VideoTop,
			VideoList,
			VideoPage
		},
		data() {
			return {
				tableData: [],
				total: 0,
				page: 1,
				limit: 10,
				tValue: '',
				cValue: '',
				dataText: "暂无数据",
				loading: false
			};
		},
		methods: {
			//查询
			search(tValue, cValue) {
				this.page = 1
				if (tValue === '' && cValue === '') {
					this.noConditionSearch();
				} else {
					this.conditionSearch(tValue, cValue);
				}
			},
			reload() {
				if (this.tValue === '' && this.cValue === '') {
					this.noConditionSearch();
				} else {
					this.conditionSearch(tValue, cValue);
				}
			},
			changePOrL(page, limit) {
				this.page = page;
				this.limit = limit;
				if (this.tValue === '' && this.cValue === '') {
					this.noConditionSearch();
				} else {
					this.conditionSearch(this.tValue, this.cValue);
				}
			},
			romove() {
				this.noConditionSearch();
			},
			conditionSearch(tValue, cValue) {
				this.changeType();
				axios
					.get(this.$global_msg.adminRoute + '/video/selectLike', {
						params: {
							page: this.page,
							limit: this.limit,
							tName: tValue,
							cName: cValue
						}
					})
					.then(a => {
						this.tableData = a.data.data;
						this.total = a.data.count;
						this.changeType();
					})
					.catch(e => {
						console.log(e);
						this.changeType();
					});

			},
			noConditionSearch() {
				this.changeType();
				axios
					.get(this.$global_msg.adminRoute + '/video/select', {
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
			changeTOrC(tValue, cValue) {
				this.tValue = tValue
				this.cValue = cValue
			},
			changeType() {
				this.loading = !this.loading;
				if (this.dataText === " ") {
					this.dataText = "暂无数据"
				} else {
					this.dataText = " "
				}
			}
		}
	};
</script>

<style scoped="scoped"></style>
