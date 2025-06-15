<template>
	<div class="top">
		<div class="banner">
			<Banner :listData="listData"></Banner>
		</div>

		<div class="natice">
			<Notice :noticeList="noticeList"></Notice>
		</div>
	</div>
</template>

<script>
	import Banner from './components/Banner'
	import Notice from './components/Notice'
	import axios from 'axios'
	export default {
		name: 'BannerAndNotice',
		data() {
			return {
				// listData: [],
				// noticeList:[]
				listData: [{
        id: 1,
        title: "促销活动1",
        img: require("@/assets/images/1.jpg"),  // 本地图片
        link: "#"
      },
      {
        id: 2,
        title: "促销活动2",
        img: require("@/assets/images/4.jpg"), 
        link: "#"
      }],
	  noticeList: [
      { id: 1, name: "系统维护通知", time: "2025-05-08" , "content": "尊敬的用户，为了给您提供更稳定、更高效的服务，我们计划于 2025 年 05 月 12 日 00:00 - 06:00 对系统进行维护升级。在此期间，部分功能可能会受到影响，给您带来的不便，我们深表歉意，感谢您的理解与支持。"},
      { id: 2, name: "数据库升级维护通知", time: "2025-05-07" , "content": "亲爱的用户，我们将于 2025 年 05 月 13 日 23:00 - 03:00 对数据库进行升级维护。维护期间，可能会出现短暂的系统卡顿或部分数据无法实时更新的情况，请您耐心等待。维护完成后，系统性能将得到显著提升，祝您使用愉快！"},
	  { id: 3, name: "新用户注册福利活动", time: "2025-05-10" , "content": "欢迎新用户加入我们的大家庭！即日起，新用户注册即可免费领取价值 100 元的课程优惠券，还能获得 3 天的会员体验资格，畅享更多优质课程资源。快来注册，开启您的学习新征程！"},
      { id: 4, name: "直播课程筛选功能上线公告", time: "2025-05-11" , "content": "为了让您更便捷地找到心仪的课程，我们全新推出了直播课程筛选功能。您现在可以根据课程类型、授课老师等条件快速筛选出符合您需求的课程。快来体验吧，开启您的学习之旅！"},
	  { id: 5, name: "视频播放进度保存功能上线", time: "2025-05-12" , "content": "好消息！我们的视频播放模块新增了进度保存功能。当您观看视频中途退出后，下次进入可直接从上次观看的位置继续播放，无需再手动调整进度。希望这个新功能能为您带来更好的观看体验！"},
      { id: 6, name: "限时课程折扣活动公告", time: "2025-05-13" , "content": "惊喜来袭！为回馈广大用户，我们将于 2025 年 05 月 15 日 - 05 月 20 日推出限时课程折扣活动。部分热门课程低至 5 折，机会难得，不容错过！赶快抓住这次优惠，提升自己的技能吧！"},
    ]
			};
		},
		mounted() {
			// this.showImg();
			// this.showNotice(1, 7);
		},
		methods: {
			showImg() {
				axios.get(this.$global_msg.userRoute + "/banner/showImg")
					.then(res => {
						this.listData = res.data.data

					})
			},
			showNotice(page, limit) {
				axios.get(this.$global_msg.userRoute + "/notice/showNotice", {
						params:{
							page: page,
							limit: limit
						}
					})
					.then(res => {
						this.noticeList = res.data.data
						// this.listData = res.data.data

					})
			}
		},
		components: {
			Banner,Notice
		}
	};
</script>

<style scoped="scoped">
	.top {
		display: flex;
		flex-direction: row;
		justify-content: center;
		padding: 32px 0;
	}

	.banner {
		/* float: left;	 */
		width: 765px;
		height: 380px;
		overflow: hidden;
		position: relative;
		margin-right: 20px;
	}

	.natice {
		width: 435px;
		height: 380px;
		/* background-color: #2DB55D; */
		/* border-radius: 0 10px 10px 0; */
		border-radius: 10px;
	}
</style>
