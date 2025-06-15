<template>
	<div class="top">
		<div class="top-search">
			<span>操作日期</span>
			<el-date-picker style="width: 180px;" format="yyyy 年 MM 月 dd 日" value-format="yyyy-MM-dd" v-model="time" type="date" placeholder="选择日期">
			</el-date-picker>
			</el-input>

			<span style="margin-left: 10px;">收支类型</span>
			<el-select style="width: 180px;" v-model="type" placeholder="请选择收支类型" >
				<el-option  label="收入" value="1">收入</el-option>
				<el-option label="支出" value="0">支出</el-option>
				<el-option label="全部类型" value="0">全部类型</el-option>
			</el-select>

			

		</div>
		<el-button class="searchBtn" type="primary" size="medium" plain @click="searchBtn1()">查询</el-button>
		<div style="inputStype" class="top-search">
			<span>教师名</span>
			<el-input style="width: 180px;" v-model="tName" prefix-icon="el-icon-search" type="text" placeholder="教师名">
			</el-input>
			<el-button style="margin-left: 15px;" class="searchBtn" type="primary" size="medium" plain @click="searchBtn2()">查询</el-button>
		</div>
		<add @search="search()"
			:currentTime="currentTime"
			:currentType="currentType"
			:currentTName="currentTName"
			:page="page"
			:limit="limit"
		></add>	
	</div>
</template>

<script>
	import Add from './Add.vue';
	export default {
		name: 'Top',
		data() {
			return {
				currentPage: 1,
				currentLimit: 10,
				type: "请选择收支类型",
				time: "",
				tName: ""
			};
		},
		props: {
			page: Number,
			limit: Number,
			currentTName: String,
			currentTime: String,
			currentType: String
		},
		components: {
			Add
		},
		methods: {
			// 根据时间和收支类型查询课程信息
			searchBtn1: function() {
				// 查询数据
				this.$emit('showList', this.time, null, this.type, 1, this.currentLimit)
			},
			// 根据教师姓名查询课程信息
			searchBtn2: function() {
				// 查询数据
				this.$emit('showList', "", this.tName, "2", 1, this.currentLimit)
			},
			// 传递给add子组件的渲染页面的方法
			search(time, tName, type, page, pageLimit) {
				this.$emit('showList', this.currentTime, this.currentTName, this.currentType, this.page, this.limit)
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
