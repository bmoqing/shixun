// src/router/index.js
import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

//路由导航冗余报错（路由重复）
const originalReplace = VueRouter.prototype.replace;
VueRouter.prototype.replace = function replace(location) {
	return originalReplace.call(this, location).catch(err => err);
};

const originalPush = VueRouter.prototype.push
VueRouter.prototype.push = function push(location) {
	return originalPush.call(this, location).catch(err => err)
}

const routes = [{
		path: '/',
		name: 'Home',
		component: () => import("../views/Home/Home"),
		redirect: '/index'
	},
	{
		path: '/',
		name: 'Home',
		component: () => import("../views/Home/Home"),
		children: [{
				path: 'index',
				name: 'Index',
				component: () => import("../views/Index/Index"),
				meta: {
					title: "首页"
				}
			},
			{
				path: 'index/:cName',
				name: 'Index',
				component: () => import("../views/Index/IndexByCName"),
				meta: {
					title: "首页",
				}
			},
			{
				path: 'notice',
				name: 'ShowList',
				component: () => import("../views/Notice/ShowList"),
				meta: {
					title: "公告"
				}
			},
			{
				path: 'videoPlayer/:id',
				name: 'videoPlayer',
				component: () => import("../views/VideoPlay/VideoPlay"),
				meta: {
					title: "视频播放"
				}
			},
			{
				path: 'notice/:id',
				name: 'ShowOne',
				component: () => import("../views/Notice/ShowOne"),
				meta: {
					title: "公告"
				},
			},
			{
				path: 'live',
				name: 'Live',
				component: () => import("../views/Live/Live"),
				meta: {
					title: "直播区"
				}
			},
			{
				path: 'video',
				name: 'Video',
				component: () => import("../views/Video/Video"),
				meta: {
					title: "视频区"
				}
			},

			 {
				path: 'communication',
				name: 'communication',
				component: () => import("../views/Communication/Communication"),
				meta: {
					title: "交流区"
				}
			},

			
			{ // 取消注释这里
				path: 'source',
				name: 'source',
				component: () => import("../views/Source/Source"),
				meta: {
					title: "资料区"
				}
			},
			{
				path: 'focus',
				name: 'focus',
				component: () => import("../views/Focus/Focus"),
				meta: {
					title: "订阅区"
				}
			}, 
			{
				path: 'buy/live/:id',
				name: 'BuyLive',
				component: () => import("../views/Buy/BuyLive"),
				meta: {
					title: "购买直播"
				}
			},
			{
				path: 'buy/video/:id',
				name: 'BuyVideo',
				component: () => import("../views/Buy/BuyVideo"),
				meta: {
					title: "购买视频"
				}
			},
			{
				path: 'mine',
				name: 'Mine',
				component: () => import("../views/Mine/Mine"),
				meta: {
					title: "我的"
				},
				redirect: '/mine/personal'
			},
			{
				path: 'mine',
				name: 'Mine',
				component: () => import("../views/Mine/Mine"),
				children: [{
						path: 'personal',
						name: 'Personal',
						component: () => import("../views/Mine/components/Personal/Personal"),
						meta: {
							title: "个人资料"
						}
					},
					{
						path: 'live',
						name: 'Live',
						component: () => import("../views/Mine/components/Live/Live"),
						meta: {
							title: "我的课程"
						}
					},
					{
						path: 'video',
						name: 'Video',
						component: () => import("../views/Mine/components/Video/Video"),
						meta: {
							title: "我的视频"
						}
					},
				]
			},
		]
	}
]

const router = new VueRouter({
	mode: 'history',
	base: process.env.BASE_URL,
	routes
})

export default router