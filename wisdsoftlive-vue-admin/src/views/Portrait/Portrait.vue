<template>
	<div>
		<PortraitTop @search="search" @changeName="changeName" @reload="reload"></PortraitTop>
		<PortraitList @remove="romove" :tableData="tableData" :dataText="dataText" :loading="loading"></PortraitList>
		<PortraitPage @changePOrL="changePOrL" :total="total" :page="page" :limit="limit"></PortraitPage>
	</div>
</template>

<script>
	import PortraitTop from './components/PortraitTop.vue';
	import PortraitPage from './components/PortraitPage.vue';
	import PortraitList from './components/PortraitList.vue';
	import axios from 'axios';
	export default {
		name: 'Portrait',
		components: {
			PortraitTop,
			PortraitPage,
			PortraitList
		},
		data() {
			return {
				tableData: [],
				total: 0,
				page: 1,
				limit: 10,
				name: '',
				dataText: "暂无数据",
				loading: false
			};
		},
		methods: {
			//查询
			search(name) {
				this.page = 1
				if (name === '') {
					this.noConditionSearch();
				} else {
					this.conditionSearch(name);
				}
			},
			reload() {
				if (this.name === '') {
					this.noConditionSearch();
				} else {
					this.conditionSearch(this.name);
				}
			},
			changePOrL(page, limit) {
				this.page = page;
				this.limit = limit;
				if (this.name === '') {
					this.noConditionSearch();
				} else {
					this.conditionSearch(this.name);
				}
			},
			romove() {
				this.noConditionSearch();
			},
			conditionSearch(name) {
				this.changeType();
				axios
					.get(this.$global_msg.adminRoute + '/portrait/selectLike', {
						params: {
							page: this.page,
							limit: this.limit,
							name: this.name
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
					.get(this.$global_msg.adminRoute + '/portrait/select', {
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
			changeName(name) {
				this.name = name;
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

<style>

</style>
