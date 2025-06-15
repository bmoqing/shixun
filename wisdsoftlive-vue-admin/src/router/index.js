import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home/Home'


Vue.use(VueRouter)

const routes = [
	// {
	//   path: '/',
	//   name: 'Home',
	//   component: Home
	// },
	{
		path: '/',
		name: 'Login',
		component: () => import("../views/Login/Login"),
		redirect: '/login'

	},
	{
		path: '/',
		name: 'Login',
		component: () => import("../views/Login/Login"),
		children: [{
			path: 'login',
			name: 'Login',
			component: () => import("../views/Login/Login"),
			meta: {
				title: "管理员登录"
			}
		}]
	},
	{
		path: '/live',
		name: 'Home',
		component: Home,
		children: [{
			path: 'banner',
			name: 'Banner',
			component: () => import("../views/Banner/Banner"),
			meta: {
				title: "banner管理"
			}
		}]
	},
	{
		path: '/live',
		name: 'Home',
		component: Home,
		children: [{
			path: 'notice',
			name: 'Notice',
			component: () => import("../views/Notice/Notice"),
			meta: {
				title: "公告信息"
			}
		}]
	},
	{
		path: '/live',
		name: 'Home',
		component: Home,
		children: [{
			path: 'course',
			name: 'Course',
			component: () => import("../views/Course/Course"),
			meta: {
				title: "课程信息"
			}
		}]
	},
	{
		path: '/live',
		name: 'Home',
		component: Home,
		children: [{
			path: 'liveCourse',
			name: 'Course',
			component: () => import("../views/LiveCourse/LiveCourse"),
			meta: {
				title: "直播课程"
			}
		}]
	},
	{
		path: '/live',
		name: 'Home',
		component: Home,
		children: [{
			path: 'video',
			name: 'Video',
			component: () => import("../views/Video/Video"),
			meta: {
				title: "视频信息"
			}
		}]
	},
	{
		path: '/live',
		name: 'Home',
		component: Home,
		children: [{
			path: 'liveDetail',
			name: 'LiveDetail',
			component: () => import("../views/LiveDetail/LiveDetail"),
			meta: {
				title: "直播明细"
			}
		}]
	},
	{
		path: '/live',
		name: 'Home',
		component: Home,
		children: [{
			path: 'teacher',
			name: 'Teacher',
			component: () => import("../views/Teacher/Teacher"),
			meta: {
				title: "教师信息"
			}
		}],
	},
	{
		path: '/',
		name: 'Home',
		component: Home,
		children: [{
				path: 'money/detailMoney',
				name: 'DetailMoney',
				component: () => import("../views/Money/DetailMoney/DetailMoney"),
				meta: {
					title: "收支明细"
				}
			},
			{
				path: 'money/personal',
				name: 'DetailMoney',
				component: () => import("../views/Money/Personal/Personal"),
				meta: {
					title: "个人收入"
				}
			}
		],

	}, {
		path: '/live',
		name: 'User',
		component: Home,
		children: [{
			path: 'User',
			name: 'User',
			component: () => import("../views/User/User"),
			meta: {
				title: "用户信息"
			}
		}]

	},
	{
		path: '/live',
		name: 'Home',
		component: Home,
		children: [{
			path: 'portrait',
			name: 'Portrait',
			component: () => import("../views/Portrait/Portrait"),
			meta: {
				title: "头像管理"
			}
		}],
	}


]

const router = new VueRouter({
	mode: 'history',
	base: process.env.BASE_URL,
	routes
})

export default router
