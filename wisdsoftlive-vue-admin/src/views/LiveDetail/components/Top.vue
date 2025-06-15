<template>
	<div class="top">

		<div style="inputStype" class="top-search">
			<span>课程名</span>
			<el-input style="width: 180px;" v-model="cName" prefix-icon="el-icon-search" type="text" placeholder="课程名">
			</el-input>
			<span style="margin-left: 10px;">用户邮箱</span>
			<el-input style="width: 180px;" v-model="uEmail" prefix-icon="el-icon-search" type="text" placeholder="用户邮箱">
			</el-input>
			<el-button style="margin-left: 15px;" class="searchBtn" type="primary" size="medium" plain @click="searchBtn()">查询</el-button>
		</div>
	</div>
</template>

<script>
	export default {
		name: 'Top',
		data() {
			return {
				uEmail: "",
				cName: ""
			};
		},
		props: {
			page: Number,
			limit: Number,
		},
		methods: {
			// 根据时间和收支类型查询课程信息
			searchBtn: function() {
				// 查询数据
				this.$emit('showList', this.uEmail, this.cName, 1, this.limit)
			},
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
