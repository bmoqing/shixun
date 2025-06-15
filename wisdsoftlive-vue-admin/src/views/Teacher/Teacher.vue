<template>
	<div>
		<teacher-top @changeProps="changeProps" @clickSearchBtn="clickSearchBtn"></teacher-top>
		<teacher-list :empty_text="empty_text" :loading="loading" :tableData="tableData" @del="clickSearchBtn"></teacher-list>
		<page-list @changePage="changePage" :currentPage="currentPage" :count="count"></page-list>
	</div>
</template>

<script>
	import axios from 'axios'
	import TeacherTop from './components/Top'
	import TeacherList from './components/TeacherList'
	import PageList from '../Notice/components/PageList'
	export default {
		name: "Teacher",
		data() {
			return {
				name:"",
				count: 10,
				currentPage: 1,
				page_size: 10,
				empty_text:" ",
				loading: true,
				tableData:[]
			}
		},
		mounted() {
			this.showList(1, 10);
		},
		methods: {
			changeProps(name){
				this.name = name
			},
			changePage(currentPage, page_size) {
				this.currentPage = currentPage;
				this.page_size = page_size;
				this.showList(currentPage, page_size)
				console.log(currentPage, page_size);
			},
			clickSearchBtn(){
				this.showList(this.currentPage,this.page_size)
			},
			showList(currentPage, count) {
				this.loading = true;
				this.empty_text = " "
				if ((this.name === "" || this.name === null)) {
					axios.get(this.$global_msg.adminRoute +"/teacher/selectTeacherOnPage", {
						params: {
							page: currentPage,
							limit: count
						}
					}).then(res => {
						this.loading = !this.loading
						if (res && res.data) {
							const data = res.data;
							console.log(data);
							this.count = data.count;
							this.tableData = data.data;
						}
						this.empty_text = "暂无数据"
					})

				} else {
					axios.get(this.$global_msg.adminRoute +"/teacher/showTeacherByName/" + this.name, ).then(res => {
						this.loading = !this.loading
						if (res && res.data) {
							const data = res.data;
							console.log(data);
							this.count = data.count;
							let a = [];
							a.push(data.data);
							this.tableData = a;
						}
						this.empty_text = "暂无数据"
					})
				}

			},
		},
		components: {
			TeacherTop,
			PageList,
			TeacherList
		}

	}
</script>

<style scoped>
</style>
