<template>
	<div class="con">
		<div class="top">
			<div class="top-show">
				<span>累计收入</span>
				<i class="el-icon-coin"></i>
				<span>{{sumMoney}}</span>
			</div>
			<div class="top-show">
				<span>剩余金额</span>
				<i class="el-icon-coin"></i>
				<span>{{surplusMoney}}</span>
			</div>
			<div class="top-show">
				<span>免费课程应发总金额</span>
				<i class="el-icon-coin"></i>
				<span>{{freeMoneySum}}</span>
			</div>
			<div class="top-show">
				<span>收费课程应发总金额</span>
				<i class="el-icon-coin"></i>
				<span>{{chargeMoneySum}}</span>
			</div>
		</div>
	</div>
</template>

<script>
	import axios from 'axios';
	export default {
		name: 'PersonalTop',
		props: {
			sumMoney: Number,
			surplusMoney: Number,
			freeMoneySum: Number,
			chargeMoneySum: Number,
		},
		data() {
			return {};
		},
		mounted() {
			this.getTotelMoney();
		},
		methods: {
			getTotelMoney() {
				this.$emit('getTotelMoney');
			}
		}
	};
</script>

<style scoped="scoped">
	.con {
		padding: 10px;
	}

	.top {
		display: flex;
		/* margin-bottom: 10px; */
		height: 40px;
		line-height: 40px;
	}

	.top-search>.el-input {
		width: 220px;
	}

	.top span {
		color: rgb(102, 102, 102);
		margin-right: 10px;
	}

	.top .top-show {
		margin-left: 20px;
		width: 255px;
		user-select: none;
	}

	.top .searchBtn {
		margin-right: 30px;
	}

	.top i {
		margin: 3px;
	}
</style>
