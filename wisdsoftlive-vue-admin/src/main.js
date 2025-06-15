import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import axios from 'axios';

import global_msg from './js/global.js'; //注意文件路径，实际路径以项目目录结构为准
Vue.prototype.$global_msg = global_msg;

Vue.config.productionTip = false
Vue.use(ElementUI);

// 若localStorage的token为空存在或是空跳转到路由
router.beforeEach((to, from, next) => {
	if (to.path == '/login' || sessionStorage.getItem('admin')) {
		next();
	} else {
		next('/login');
	}
})

// 请求拦截器, 为所有请求添加请求头
axios.interceptors.request.use(
	config => {
		if (sessionStorage.getItem("T-Token") != null &&
			sessionStorage.getItem("T-Token") != undefined &&
			config.url.indexOf('/login') == -1
			// token如果存在并且不是登录接口，则统一在http请求的header都加上token，这样后台根据token判断你的登录情况，
			//在这里插一嘴axios的请求设置头name后台接收时必须也设置接收这个请求头name（一一对应）,否者会报415
		) {
			config.headers["T-Token"] = sessionStorage.getItem("T-Token");
		}
		return config;
	},
	err => Promise.reject(err)
);

new Vue({
	router,
	store,
	render: h => h(App)
}).$mount('#app')




