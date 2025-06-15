import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import Antd from 'ant-design-vue';
import 'ant-design-vue/dist/antd.css';
import global_msg from './js/global.js';   //注意文件路径，实际路径以项目目录结构为准
import axios from 'axios';
import _local from './js/sessionTool.js'
import getVideoTime from './js/getVideoTime.js'

import videoPlayer from 'vue-video-player' // 视频播放器
import 'video.js/dist/video-js.css'
require('video.js/dist/video-js.css')
require('vue-video-player/src/custom-theme.css')
require('./style/video-player.css')

Vue.prototype.$global_msg = global_msg;
Vue.prototype._local = _local;
Vue.prototype.getVideoTime = getVideoTime;
Vue.config.productionTip = false
Vue.use(Antd,videoPlayer);
/*
// 若localStorage的token为则访问接口获取token
router.beforeEach((to, from, next) => {
	// _local.remove('Request-Security')
	if (!_local.get('Request-Security')) {
		axios.get(global_msg.userRoute + '/user/getToken', {
				// 2*24*60*60*1000
			})
			.then((res) => {
				// console.log(res)
				var tokenString = res.data.data
				// 设置token的过期时间与后台设定的过期时间一样为 2 天
				_local.set('Request-Security', tokenString, 2*24*60*60*1000)
				next();
			}).catch((response) => {
				console.log(response);
			})
	} else {
		next();
	}
})

// 请求拦截器, 为所有请求添加请求头token
axios.interceptors.request.use(
	config => {
		if (_local.get("Request-Security") != null &&
			_local.get("Request-Security") != undefined 
		) {
			config.headers["Request-Security"] = _local.get("Request-Security");
		}
		return config;
	},
	err => Promise.reject(err)
);

*/


new Vue({
  router,
  store,
  render: function (h) { return h(App) }
}).$mount('#app')

// //设置跨域访问
// app.all('*', function(req, res, next) {
//     res.header("Access-Control-Allow-Origin", "*");
//     res.header("Access-Control-Allow-Headers", "X-Requested-With");
//     res.header("Access-Control-Allow-Methods","PUT,POST,GET,DELETE,OPTIONS");
//     res.header("X-Powered-By",' 3.2.1')
//     res.header("Content-Type", "application/json;charset=utf-8");
//     next();
// });