<template>
	<div>
		<notice-top @changeProps="changeProps" @clickSearchBtn="clickSearchBtn"></notice-top>
		<notice-list :empty_text="empty_text" :loading="loading" :tableData="tableData" @del="clickSearchBtn"></notice-list>
		<page-list @changePage="changePage" :currentPage="currentPage" :count="count"></page-list>
	</div>
</template>

<script>
	import axios from 'axios'
	import NoticeTop from './components/Top'
	import NoticeList from './components/NoticeList'
	import PageList from './components/PageList'
	export default {
		name: 'Notice',
		data() {
			return {
				name: '',
				time: '',
				tableData: [],
				currentPage: 1,
				count: 10,
				page_size: 10,
				loading: true,
				empty_text: " "
			}
		},
		mounted() {
			this.showList(1, 10);
		},
		methods: {
			changeProps(name, time) {
				this.name = name
				this.time = time
				// console.log(name, time)
			},
			changePage(currentPage, page_size) {
				this.currentPage = currentPage;
				this.page_size = page_size;
				this.showList(currentPage, page_size)
				// console.log(currentPage, page_size);
			},
			clickSearchBtn() {
				this.showList(this.currentPage, this.page_size)
			},
			//展示数据
			showList(currentPage, count) {
				this.loading = true;
				this.empty_text = " "
				if ((this.name === "" || this.name === null) && (this.time === "" || this.time === null)) {
					axios.get(this.$global_msg.adminRoute + "/notice/showAll", {
						params: {
							page: currentPage,
							limit: count
						}
					}).then(res => {
					this.loading = !this.loading
					if (res && res.data) {
						const data = res.data;
						// console.log(data);
						this.count = data.count;
						this.tableData = data.data;
					}
					this.empty_text = "暂无数据"
				})

			} else {
				axios.get(this.$global_msg.adminRoute +"/notice/findBlurry", {
					params: {
						name: this.name,
						time: this.time,
						page: currentPage,
						limit: count
					}
				}).then(res => {
					this.loading = !this.loading
					if (res && res.data) {
						const data = res.data;
						// console.log(data);
						this.count = data.count;
						this.tableData = data.data;
					}
					this.empty_text = "暂无数据"
				})
			}

		},

	},
	components: {
		NoticeTop,
		NoticeList,
		PageList
	}
	}
</script>

<style>

</style>
