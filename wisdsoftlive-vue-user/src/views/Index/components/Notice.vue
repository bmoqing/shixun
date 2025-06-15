<template>
	<div>
		<div class="title">公告</div>
		<ul class="content">
			<li v-for="item in noticeList" :key="item.id">
				<span class="item-type">公告</span>
				<span class="item-href" @click="showOne(item)">{{item.name}}</span>
				<span class="item-time">{{item.time}}</span>
			</li>
		</ul>
		<div class="more" @click="showList()">阅读更多</div>
	</div>
</template>

<script>
	export default {
		props: {
			noticeList: Array
		},
		name: 'Notice',
		data() {
			return {}
		},
		methods:{
			showOne(notice){
				this.$router.push({
				    name: 'ShowOne',
				    params: notice
				});
			},
			showList(){
				window.location.href = "/notice"
			}
		}
	}
</script>

<style scoped="scoped">
	.title {
		width: 100%;
		height: 35px;
		text-align: center;
		line-height: 35px;
		background-color: rgb(247, 247, 247);
		color: #676767;
		;
		font-size: 18px;
		font-weight: 500;
		box-sizing: border-box;
	}

	.content {
		height: 310px;
		color: #424242;
		list-style: none;
	}

	.content li {
		border-top: 1px #e0e2e2 solid;
	}

	.item-type {
		color: #bb9a6c;
		border: 1px #c5ab86 solid;
		display: inline-block;
		vertical-align: middle;
		width: 36px;
		height: 20px;
		line-height: 20px;
		box-sizing: border-box;
		font-size: 12px;
		line-height: 18px;
		text-align: center;
	}
	.item-href {
		display: inline-block;
		vertical-align: middle;
		overflow: hidden;
		width: 281px;
		height: 43px;
		line-height: 43px;
		margin-left: 20px;
		font-size: 14px;
		letter-spacing: 1px;
		cursor: pointer;
	}
	.item-href:hover{
		color: #c5ab86;
	}
	.item-time {
		display: inline-block;
		vertical-align: middle;
		width: 80px;
		height: 40px;
		line-height: 40px;
		margin-left: 10px;
	}

	.more {
		width: 100%;
		height: 35px;
		text-align: center;
		line-height: 35px;
		background-color: rgb(247, 247, 247);
		color: #676767;
		font-size: 14px;
		font-weight: 500;
		background-color: #e3e2e2;
		box-sizing: border-box;
		cursor: pointer;
	}
	.more:hover{
		background-color: #dad8d8;
		border-radius: 4px;
	}

	ul {
		margin: 0;
		padding: 0;
	}
</style>
