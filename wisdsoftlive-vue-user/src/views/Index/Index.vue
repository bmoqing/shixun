<template>
	<div>
		<BannerAndNotice></BannerAndNotice>
		<!-- <div>首页</div> -->
		<!-- 直播区 -->
		<live  :liveCourses="liveCourses" :liveTotal="liveTotal"></live>
		<!-- 视频区 -->
		<videoShow style="margin-top: 20px;" :videos="videos" :videoTotal="videoTotal"></videoShow>
		<!-- 回到顶部 -->
		<BackTop></BackTop>
	</div>
</template>

<script>
	import BannerAndNotice from './BannerAndNotice.vue'
	import axios from 'axios';
	import Live from "./components/Live/Live.vue"
	import VideoShow from "./components/Video/Video.vue"
	import BackTop from "./components/BackTop/BackTop.vue"
	export default {
		name: 'Index',
		data() {
			return {
				// liveCourses: [],
				// videos: [],
				// liveTotal: 0,
				// videoTotal: 0,
				// loading: true,
				// dataText: "  "
		liveCourses: [ 
			{
          id: 1,
          url: require('@/assets/images/5.jpg'), // 替换为实际图片路径
          cname: '免费课程1',
          ccontent: 'Linux',
          ctype: '0',
        },
        {
          id: 2,
          url: require('@/assets/images/6.jpg'),
          cname: '免费课程2',
          ccontent: 'Nginx',
          ctype: '0',
        },
		{
          id: 6,
          url: require('@/assets/images/9.jpg'),
          cname: '收费课程1',
          ccontent: '云计算',
          ctype: '1',
          cinMoney: 99,
          coldMoney: 199,
        },
        {
          id: 7,
          url: require('@/assets/images/8.jpg'),
          cname: '收费课程2',
          ccontent: 'JS框架技术',
          ctype: '1',
          cinMoney: 199,
          coldMoney: 299,
        },
		],
      	videos: [
                        {
                    id: 1,
                    cid: 1,
                    imgTop: require('@/assets/images/1.jpg'),
                    cname: '免费课程 1',
                    ccontent: '免费课程 1 的描述',
                    ctype: '0',
                    cinMoneyShow: '0',
                    coldMoneyShow: '0'
                },
                {
                    id: 2,
                    cid: 2,
                    imgTop: require('@/assets/images/4.jpg'),
                    cname: '免费课程 2',
                    ccontent: '免费课程 2 的描述',
                    ctype: '0',
                    cinMoneyShow: '0',
                    coldMoneyShow: '0'
                },
				{
                    id: 7,
                    cid: 7,
                    imgTop:  require('@/assets/images/8.jpg'),
                    cname: '收费课程 2',
                    ccontent: '收费课程 2 的描述',
                    ctype: '1',
                    cinMoneyShow: '199',
                    coldMoneyShow: '299'
                },
                {
                    id: 8,
                    cid: 8,
                    imgTop:  require('@/assets/images/7.jpg'),
                    cname: '收费课程 3',
                    ccontent: '收费课程 3 的描述',
                    ctype: '1',
                    cinMoneyShow: '299',
                    coldMoneyShow: '399'
                },
      ],
      liveTotal: 1,
      videoTotal: 1
			}
		},
		components: {
			Live,
			VideoShow,
			BackTop,
			BannerAndNotice
		},
		methods: {
			// 首页展示数据-->无查询展示
			selectLiveByLimit() {
				axios.get(this.$global_msg.liveRoute + '/liveCourse/selectByLimit', {

					})
					.then((res) => {
						// console.log(res)
						this.liveCourses = res.data.data
						this.liveTotal = res.data.count
						this.changeLoadingType();
					}).catch((response) => {
						console.log(response);
						this.changeLoadingType();
					})
			},
			selectVideoByLimit() {
				axios.get(this.$global_msg.videoRoute + '/video/selectByLimit', {

					})
					.then((res) => {
						// console.log(res)
						this.videos = res.data.data
						this.videoTotal = res.data.count
						this.changeLoadingType();
					}).catch((response) => {
						console.log(response);
						this.changeLoadingType();
					})
			},
			changeLoadingType() {
				this.dataText = "暂无数据"
				this.loading = false
			},
		},
		// mounted() {
		// 	// 查询直播区数据
		// 	this.selectLiveByLimit()
		// 	// 查询视频区数据
		// 	this.selectVideoByLimit()
		// 	// 每当进入无条件搜索页面时，将session中存储的值变为空字符串
		// 	sessionStorage.setItem("cName", "")
		// }
	};
</script>

<style>
	div {
		color: black;
	}
</style>
