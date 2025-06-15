<template>
	<div>
		<div style="height: 365px;">
			<BuyShow :buyData="buyData" :color_index="color_index" :isBuy="isBuy" :isEnd="isEnd" @buyClick="buyClick"></BuyShow>
		</div>
		<div class="qq" v-if="isBuy">
			购买的小伙伴加群哦！群号：10086
		</div>
		<div class="im">
			<h1>课程封面</h1>
			<img :src="buyData.url" />
		</div>
	</div>
</template>

<script>
	import axios from 'axios'
	import BuyShow from './conponents/BuyShow'
	import cookie from '../../js/cookie.js'
	import { mockLiveCourses } from '../../mockData.js';

	export default {
		name: "BuyLive",
		data() {
			return {
				buyData: {},
				color_index: 0,
				isBuy: false,
				isEnd: false,
			}
		},
		mounted() {
			let id = parseInt(this.$route.params.id);
			if (id <= 0) {
				this.$router.push("/");
			}
			// axios.get(this.$global_msg.liveRoute + "/liveCourse/showOneLiveCourse/" + id)
			// 	.then(res => {
			// 		// console.log(res);
			// 		this.buyData = res.data.data
			// 		this.color_index = parseInt(Math.random() * 4, 10)
			// 		this.timeHandler(this.buyData.endTime)
					
			// 		let user = this._local.get("email");
					// if (user) {
					// 	axios.get(this.$global_msg.liveRoute + "/liveCourse/isBuyLiveById", {
					// 		params: {
					// 			cId: this.buyData.cid,
					// 			uId: user.id
					// 		}
					// 	}).then(res => {
					// 		if(res.data.data >= 1){
					// 			//设置为已购买
					// 			this.isBuy = true
					// 		}
					// 	})
					// }
				// })
	// 从模拟数据中查找课程
    this.buyData = mockLiveCourses.find(course => course.id === id);
    this.color_index = parseInt(Math.random() * 4, 10);
    this.timeHandler(this.buyData.endTime);
    let user = this._local.get("email");
    if (user) {
      // 模拟判断是否已购买，这里简单假设已购买
      this.isBuy = false; 
    }
	window.scrollTo(0, 0)
		},

		methods: {
			timeHandler(endTime) {
				const end = new Date(endTime); // 定义开始时间且延长1小时
				const now = Date.parse(new Date()); // 获取本地时间
				const msec = end - now;
				if (msec <= 0) {
					this.isEnd = true;
				}
			},
			buyClick() {
				let user = this._local.get("email");
				if (!user) {
					this.$message.error('请先登录')
					return false
				}
				let uId = user.id;
				let cId = this.buyData.cid;
				let tId = this.buyData.tid;
				let money = this.buyData.coutMoney;
				if (user.type == 0) {
					console.log("是学生")
					money = this.buyData.cinMoney
				}
      // 模拟购买成功
      this.$message.success("购买成功");
      this.isBuy = true;
	  this.$store.commit('addPurchasedLiveCourse', this.buyData);
				// let buy = new FormData();
				// buy.append("uId", uId)
				// buy.append("cId", cId)
				// buy.append("tId", tId)
				// buy.append("money", money)
				// console.log("学生id =>", uId);
				// console.log("课程id =>", cId);
				// console.log("老师id =>", tId);
				// console.log("实际金钱 =>", money);
				// console.log(this.buyData)
				// axios.post(this.$global_msg.userRoute+"/user/buyLiveCourse",buy)
				// 	.then(res => {
				// 		if(res.data.code == 200){
				// 			this.$message.success("购买成功")
				// 			this.isBuy = true
				// 		}else{
				// 			this.$message.error("购买失败")
				// 		}
				// 	})
			}
		},
		components: {
			BuyShow
		}
	}
</script>

<style scoped>
	.qq{
		width: 100%;
		height: 50px;
		line-height: 40px;
		background-color: #fff;
		margin-top: 10px;
		margin-bottom: 10px;
		padding: 5px 0;
		padding-left: 40px;
		font-weight: 700;
		border-radius: 15px;
	}
	.im {
		width: 100%;
		background-color: #fff;
		margin-top: 30px;
		margin-bottom: 30px;
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		padding: 5px 0;
		border-radius: 15px;
	}

	.im h1 {
		font-weight: 700;
	}

	.im img {
		width: 60%;
	}
</style>
