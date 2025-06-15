<template>
	<div class="top">
		<div class="top-search">
			<span>课程名</span>
			<el-input style="width: 220px" v-model="newName" prefix-icon="el-icon-search" type="text" placeholder="课程名">
			</el-input>
		</div>
		<el-button class="searchBtn" type="primary" size="medium" plain @click="searchBtn()">查询</el-button>
		<add @showData="showData" :name="name" :page="page" :limit="limit"></add>
	</div>
</template>

<script>
	import Add from './Add.vue'
	export default {
		name: 'Top',
		data() {
			return {
				// 模糊查询: 新的名字
				newName: "",
				// 旧的名字
				oldName: "",
				
				// // 添加: 要添加的名字
				// name: ""
			};
		},
		props: {
			page: Number,
			limit: Number,
			name: String
		},
		components: {
			Add
		},
		methods: {
			// 查询课程信息
			searchBtn: function() {
				// 查询数据
				this.$emit('showList', this.newName, 1, this.limit)
				// 将旧的值重置
				this.oldName = this.newName
			},
			// 提供给Add子模块的刷新方法
			showData(name, page, limit) {
				// 查询数据
				this.$emit('showList', name, page, limit)
			}
		},
		// watch: {
		// 	name: function(val) {
		// 		console.log("name的值改变了")
		// 	}
		// }
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
