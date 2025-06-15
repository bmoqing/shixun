<template>
	<div class="top">
		<div class="top-search">
			<span>课程名</span>
			<el-input style="width: 220px" v-model="cName" prefix-icon="el-icon-search" type="text" placeholder="课程名">
			</el-input>
			<span style="margin-left: 15px;">教师名</span>
			<el-input style="width: 220px" v-model="tName" prefix-icon="el-icon-search" type="text" placeholder="教师">
			</el-input>
		</div>
		<el-button class="searchBtn" type="primary" size="medium" plain  @click="searchBtn()">查询</el-button>
		<add @showData="showData" :currentTName="currentTName" :currentCName="currentCName" :page="page" :limit="limit"></add>
	</div>
</template>

<script>
	import Add from './Add.vue'
	export default {
		name: 'Top',
		data() {
			return {
				cName: "",
				tName: ""
			};
		},
		props: {
			currentTName: String,
			currentCName: String,
			page: Number,
			limit: Number,
		},
		components: {
			Add
		},
		methods: {
			// 查询课程信息
			searchBtn: function() {
				// 查询数据
				this.$emit('showList', this.tName, this.cName, 1, this.limit)
			},
			// 提供给Add子模块的刷新方法
			showData(tName, cName, page, limit) {
				// 查询数据
				this.$emit('showList', tName, cName, page, limit)
			}
		},
	};
</script>

<style scoped>
	.top {
	  display: flex;
	  margin-bottom: 10px;
	  margin-top: 5px;
	}
	.top .top-search {
	  margin-right: 20px;
	  margin-left: 20px;
	}
	.top span {
	  color: rgb(102, 102, 102);
	  margin-right: 10px;
	}
	.top .searchBtn {
	  height: 35px;
	  margin-right: 30px;
	  margin-top: 3px;
	}
	.top .insertBtn {
	  height: 35px;
	  margin-top: 3px;
	}
</style>
