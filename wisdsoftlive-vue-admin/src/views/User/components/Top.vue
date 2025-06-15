<template>
	<div class="top">
		<div class="top-search">
			<span>用户昵称</span>
			<el-input style="width: 220px" v-model="currentName" prefix-icon="el-icon-search" type="text" placeholder="用户昵称">
			</el-input>
			<span style="margin-left: 10px;">账号类型</span>
			<el-select style="width: 180px;" v-model="currentType" placeholder="请选择账号类型" >
				<el-option  label="校内验证" value="0">校内验证</el-option>
				<el-option label="校外账号" value="1">校外账号</el-option>
				<el-option label="全部类型" value="2">全部类型</el-option>
			</el-select>
		</div>
		<el-button class="searchBtn" type="primary" size="medium" plain @click="searchBtn()">查询</el-button>
		<div class="total_title">
			注册用户总数量为: {{this.total}}
		</div>
	</div>
</template>

<script>
	export default {
		name: 'Top',
		data() {
			return {
				currentName: "",
				currentType: "",
			};
		},
		props: {
			page: Number,
			limit: Number,
			total: Number
		},

		methods: {
			// 一进入的展示分页数据
			showListCount(name, type, currentPage, pageLimit) {
				this.$emit('showListAll', name, type, currentPage, pageLimit)
			},
			// 按照条件查询课程信息
			searchBtn: function() {
				if(this.currentType == "") {
					// 查询数据
					this.$emit('showListByName', this.currentName, "2", this.page, this.limit)
				} else {
					// 查询数据
					this.$emit('showListByName', this.currentName, this.currentType, this.page, this.limit)
				}
				
			},
		},
		mounted() {
			this.showListCount("", "2", 1, 10);
		}
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
	.total_title {
		line-height: 40px!important;
		
		padding-left: 13.5625rem!important;
	}

</style>
