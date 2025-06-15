<template>
	<div>
		<div style="height: 365px;">
			<BuyShow :buyData="buyData" :color_index="color_index" :isBuy="isBuy" :isVideo="true" :isEnd="isEnd" @buyClick="buyClick"></BuyShow>
		</div>
		<div class="im">
			<h1>课程目录</h1>
			<img :src="buyData.url" />
			<ul>
				<li v-for="(item,index) in menu" :key="item.id">
					<span>
						{{index + 1}}
					</span>
					{{item.courseNumber}}
				</li>
			</ul>
		</div>
	</div>
</template>

<script>
	import axios from 'axios'
	import BuyShow from './conponents/BuyShow'
	import cookie from '../../js/cookie.js'
	import { mockVideos } from '../../mockData.js';
	export default {
		name: "BuyVideo",
		data() {
			return {
				buyData: {},
				color_index: 0,
				isBuy: false,
				isEnd: false,
				menu: []
			}
		},
		mounted() {
			window.scrollTo(0, 0)
			//let id = this.$route.params.id;
			let id = parseInt(this.$route.params.id);
			if (id <= 0) {
				this.$router.push("/")
			}
			this.buyData = mockVideos.find(video => video.id === id);
			this.buyData.cinMoney = this.buyData.cinMoneyShow;
			this.buyData.coutMoney = this.buyData.coutMoneyShow;
			this.buyData.coldMoney = this.buyData.coldMoneyShow;
			this.color_index = parseInt(Math.random() * 4, 10);
			this.menu = [this.buyData]; // 简单模拟菜单
			let user = this._local.get("email");
			if (user) {
			// 模拟判断是否已购买，这里简单假设已购买
			this.isBuy = false; 
			}
			// axios.get(this.$global_msg.videoRoute + "/video/showVideoListById/" + id)
			// 	.then(res => {
			// 		// console.log(res);
			// 		this.buyData = res.data.data[0]
			// 		this.buyData.cinMoney = this.buyData.cinMoneyShow
			// 		this.buyData.coutMoney = this.buyData.coutMoneyShow
			// 		this.buyData.coldMoney = this.buyData.coldMoneyShow
			// 		this.color_index = parseInt(Math.random() * 4, 10)
			// 		this.menu = res.data.data
			// 		let user = this._local.get("email");
			// 		if (user) {
			// 			axios.get(this.$global_msg.videoRoute + "/video/isBuyVideoById", {
			// 				params: {
			// 					cId: this.buyData.cid,
			// 					uId: user.id
			// 				}
			// 			}).then(res => {
			// 				if(res.data.data >= 1){
			// 					//设置为已购买
			// 					this.isBuy = true
			// 				}
			// 			})
			// 		}
			// 	})
		},
		methods: {
			buyClick() {
				let user = this._local.get("email");
				if(!user) {
					this.$message.error('请先登录')
					return false
				}
				let uId = user.id;
				let cId = this.buyData.cid;
				let tId = this.buyData.tid;
				let money = this.buyData.coutMoney;
				if(user.type == 0){
					console.log("是学生")
					money = this.buyData.cinMoney
				}
				// 模拟购买成功
				this.$message.success("购买成功");
				this.isBuy = true;
				// 添加已购买视频课程到 Vuex 存储
    			this.$store.commit('addPurchasedVideoCourse', this.buyData);
				}				
				// let buy = new FormData();
				// buy.append("uId",uId)
				// buy.append("cId",cId)
				// buy.append("tId",tId)
				// buy.append("money",money)
				// axios.post(this.$global_msg.userRoute+"/user/buyVideoCourse",buy)
				// 	.then(res => {
				// 		if(res.data.code == 200){
				// 			this.$message.success("购买成功")
				// 			this.isBuy = true
				// 		}else{
				// 			this.$message.error("购买失败")
				// 		}
				// 	})
			// }
		},
		components: {
			BuyShow
		}
	}
</script>

<style scoped>
	.im {
		width: 830px;
		background-color: #fff;
		margin-top: 30px;
		margin-bottom: 30px;
		padding: 20px 40px 50px 0;
		border-radius: 15px;
	}

	.im h1 {
		font-weight: 700;
		margin-left: 30px;
	}

	.im ul {
		list-style: none;
	}

	.im ul li span {
		margin-right: 10px;
		font-size: 14px;
		color: #666;
	}

	.im ul li {
		height: 55px;
		line-height: 55px;
		color: #666;
		font-size: 16px;
		border-bottom: 1px solid #e6e6e6;
		padding-right: 10px;
	}
</style>
