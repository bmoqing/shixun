<template>
	<div class="notice">
		<h1 class="title">{{notice.name}}</h1>
		<div class="time">{{notice.time}}</div>
		<div class="content" v-html="notice.content"></div>
	</div>
</template>

<script>
	export default {
		props:{
			notice:Object
		},
		name: "NoticeShow",
		data() {
			return {
			}
		},
	}
</script>

<style scoped>
	.notice {
		width: 850px;
		margin-top: 30px;
		margin-bottom: 30px;
		background-color: #fff;
		border: 1px solid #f1f1f1;;
		/* height: 500px; */
		padding: 0px 40px 0 40px;
	
	}
	.notice .title {
		font-size: 24px;
		color: #444;
		padding-top: 55px;
		margin-bottom: 0;
	}
	.notice .time {
		color: #aaa;
		padding: 20px 0;
		border-bottom: 1px solid #e4e4e4;
	}
	.notice .content {
		padding: 30px 0 50px;
	}
	.notice .content >>> p {
		line-height: 26px;
		padding-bottom: 25px;
		margin-bottom: 0;
	}
</style>
