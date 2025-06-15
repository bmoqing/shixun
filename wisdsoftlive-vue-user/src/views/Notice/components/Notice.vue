<template>
	<div class="notice-content">
		<div class="title" id="title">公告</div>
		<ul class="content">
			<li v-for="notice in noticeList" :key="notice.id">
				<span class="item-type">公告</span>
				<span class="item-href" @click="showOne(notice)">{{notice.name}}</span>
				<span class="item-time">{{notice.time}}</span>
			</li>
		</ul>
		<a-pagination show-quick-jumper :current="page" :default-current="page" :defaultPageSize="12" :total="total" @change="onChange" />
		<a-anchor v-show="false" :affix="false">
			<a-anchor-link href="#title" ref="anchor_link" />
		</a-anchor>
	</div>
</template>

<script>
	export default {
		props: {
			noticeList: Array,
			total: {
				type: Number,
				default: 12
			},
			page: Number
		},
		name: 'Notice',
		data() {
			return {
			}
		},
		methods: {
			showOne(notice) {
				this.$router.push({
					name: 'ShowOne',
					params: notice
				});
			},
			onChange(pageNumber) {
				//手动跳到锚点出
				this.$refs.anchor_link.handleClick()
				this.$emit('change', pageNumber, 12);
			},
		}
	}
</script>

<style scoped="scoped">
	.title {
		width: 100%;
		height: 55px;
		text-align: center;
		line-height: 80px;
		background-color: rgb(247, 247, 247);
		color: #676767;
		;
		font-size: 18px;
		font-weight: 500;
		box-sizing: border-box;
	}

	.content {
		height: 753px;
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
		box-sizing: border-box;
		font-size: 12px;
		line-height: 18px;
		text-align: center;
	}

	.item-href {
		display: inline-block;
		vertical-align: middle;
		overflow: hidden;
		width: 623px;
		height: 60px;
		line-height: 60px;
		margin-left: 20px;
		font-size: 14px;
		letter-spacing: 1px;
		cursor: pointer;
	}

	.item-href:hover {
		color: #c5ab86;
	}

	.item-time {
		display: inline-block;
		vertical-align: middle;
		width: 80px;
		height: 60px;
		line-height: 60px;
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

	.more:hover {
		background-color: #dad8d8;
		border-radius: 4px;
	}

	ul {
		margin: 0;
		padding: 20px 40px 0 40px;
	}

	.ant-pagination {
		height: 115px;
		line-height: 4;
		display: flex;
		justify-content: center;
		align-items: center;
	}

	.ant-pagination>>>.ant-pagination-options {
		line-height: 1px !important;
	}
</style>
