<template>
	<div>
		<img class="liveImg" src="../../../assets/liveImg.png" alt="">
		<div class="top_box">
			<span class="title">直播区</span>
			<span class="title">|</span>
			<div ref="menu">
				<span class="my-menu-child my-menu-child-change" @click="changeType(2)">全部</span>
				<span class="my-menu-child" @click="changeType(0)">免费课程</span>
				<span class="my-menu-child" @click="changeType(1)">收费课程</span>
			</div>
			<span style="margin-left: 52%; width: 150px;" class="body">
				<a-input-search style="width: 260px;" v-model="cName" class="input_search" placeholder="请输入关键字" @pressEnter="selectByRequire()" @search="selectByRequire()" />
			</span>
		</div>

	</div>
</template>

<script>
	export default {
		name: 'VideoShow',
		props: {
			tempNum: Number,
		},
		data() {
			return {
				cName: "",
				type: 2
			};
		},
		methods: {
			// 监听查询条件的状态改变
			changeType(type) {
				this.type = type
				// 调用查询方法
				this.selectByType()
				// 将cName清空
				this.cName = ""
			},
			// 根据条件查询数据
			selectByRequire() {
				this.$emit('selectByRequire', this.cName, this.type, 1, 12)
				// console.log(this.cName)
			},
			// 仅根据状态查询
			selectByType() {
				this.$emit('selectByRequire', "", this.type, 1, 12)
			}

		},
		mounted() {
			var obj = this.$refs.menu.children;
			for (var i = 0; i < obj.length; i++) {
				obj[i].index = i;
				obj[i].onclick = function() {
					for (var i = 0; i < obj.length; i++) {
						obj[i].className = "my-menu-child";
					}
					obj[this.index].className = "my-menu-child-change";
				}
			}

			// 刚进入直播区时搜索框中的关键字应使用sessionStorage中存储的
			this.cName = sessionStorage.getItem("cName")
		}
	}
</script>

<style scoped="scoped">
	.liveImg {
		width: 100%;
		margin-top: 10px;
		opacity: 0.9;
	}
	
	.top_box >>> .input_search input {
		width: 260px;
		height: 35px;
		margin-top: 2px;
	}

	.top_box {
		width: 100%;
		height: 3.75rem;
		margin-top: 30px;
		background-color: #fff;
		display: flex;
		flex-wrap: wrap;
	}
	
	.title {
		font-family: cursive;
		font-size: 16px;
		line-height: 3.75rem;
		padding-left: 0.625rem;
	}

	.my-menu-child {
		line-height: 3.75rem;
		padding: 0 0.625rem;
	}

	.my-menu-child:hover {
		color: #F01414;
		cursor: pointer;
	}

	.my-menu-child-change {
		line-height: 3.75rem;
		padding: 0 0.625rem;
		color: red;
	}

	.input_search {
		margin-top: 10px;
		width: 200px;
	}

	.top {
		padding: 14px;
	}

	input .ant-input-affix-wrapper .ant-input:not(:last-child) {
		width: 300px !important;
	}
</style>
