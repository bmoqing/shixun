<template>
	<div id="components-layout-demo-basic" class="body">
		<a-layout>
			<a-layout-header>
				<a-menu id="my-a" v-model="current" mode="horizontal">
					<a-menu-item id="logo">
						<router-link @click.native="emptyCName()" to="/">
							<img src="../../assets/logo.png" height="35px" />
						</router-link>
					</a-menu-item>

					<a-menu-item :class="[isClick1 ? onClick : noClick]" key="live">
						<router-link @click.native="emptyCName()" to="/live">直播区</router-link>
					</a-menu-item>

					<a-menu-item :class="[isClick2 ? onClick : noClick]" key="video">
						<router-link id="video" @click.native="emptyCName()" to="/video">视频区</router-link>
					</a-menu-item>

					<a-menu-item :class="[isClick3 ? onClick : noClick]" key="communication">
						<router-link id="communication" @click.native="emptyCName()" to="/communication">交流区</router-link>
					</a-menu-item>
         
                    <a-menu-item :class="[isClick4 ? onClick : noClick]" key="source">
						<router-link id="source" @click.native="emptyCName()" to="/source">资料区</router-link>
					</a-menu-item>

                    <a-menu-item :class="[isClick5 ? onClick : noClick]" key="focus">
						<router-link id="focus" @click.native="emptyCName()" to="/focus">订阅区</router-link>
					</a-menu-item>
					<a-menu-item id="search">
						<a-input-search class="input-search" v-model="cName" placeholder="请输入关键字" style="width: 350px" @pressEnter="searchByCName()"
						 @search="searchByCName()" />
					</a-menu-item>
					<a-menu-item :class="[isClick3 ? onClick : noClick]" v-if="show" id="mine">
						<router-link to="/mine">
							<a-avatar class="headImg" size="large" shape="square" :src="head" />
							{{nickname}}
						</router-link>
					</a-menu-item>
					<a-menu-item v-if="!show" id="register" @click="isOpen = true;isLogin = false">注册</a-menu-item>
					<a-menu-item selectable=false v-if="!show" id="gang">/</a-menu-item>
					<a-menu-item v-if="!show" id="login" @click="isOpen = true">登录</a-menu-item>
				</a-menu>
			</a-layout-header>
			<a-layout-content style="background-color: rgb(247,247,247);min-height: 500px;">
				<div id="my-content">
					<router-view></router-view>
				</div>
			</a-layout-content>
			<a-layout-footer>
			</a-layout-footer>
		</a-layout>
		<div class="login_box" v-if="isOpen">
			<div class="login_header">
				<h1>
					<span :class="[isLogin ? 'lan' : '']" @click="loginShow">登录</span>
					<span :class="[isLogin ? '' : 'lan']" style="margin-left: 30px;" @click="registryShow">注册</span></h1>
				<a-icon type="close" class="box_close" @click="isOpen = false" />
			</div>
			<div class="put">
				<input type="text" v-model="email" class="ipt" placeholder="请输入邮箱" />
				<template v-if="!isLogin">
					<div style="position: relative;">
						<input type="text" v-model="code" maxlength="6" class="ipt" placeholder="请输验证码" />
						<p v-if="!isSend" class="yanzheng" @click="getYanZheng">获取验证码</p>
						<p v-else class="yanzheng" style="color:black;">
							<span v-text="one_min"></span><span>s</span>
						</p>
					</div>

				</template>
				<input type="password" v-model="pwd" class="ipt" placeholder="请输入密码" />
			</div>
			<div class="findPass">
				<span @click="openFind">忘记密码？马上找回</span>
			</div>
			<div class="login_btn">
				<button v-if="isLogin" @click="login">登录</button>
				<button v-else @click="registry">立即注册</button>
			</div>
		</div>
		<div class="login_bg" v-if="isOpen" @click="isOpen = false"></div>
		<FindPass @closeFind="closeFind" :visible="visible"></FindPass>
	</div>
</template>

<script>
	import cookie from '../../js/cookie.js'
	import Index from '../Index/Index.vue'
	import Bus from '../../js/bus.js'
	import axios from 'axios';
	import FindPass from '../Common/FindPass/FindPass.vue'
	export default {
		name: 'Home',
		data() {
			return {
				current: [],
				show: false,
				cName: "",
				tempName: "",
				head: '',
				nickname: '',
				isClick1: false,
				isClick2: false,
				isClick3: false,
				onClick: "onClick",
				noClick: "noClick",
				isOpen: false,
				email: '1@1.com',
				pwd: '',
				code: '',
				visible: false,
				isLogin: true,
				isSend: false,
				one_min: 60,

			//登陆账号密码
			    mockAccount: {
     			email: '1@1.com',  // 模拟邮箱
      			password: '123'          // 模拟密码
    			}
			};
			//登陆账号密码
			
		},
		components: {
			Index,
			FindPass,
		},
		methods: {
			
			loginShow() {
				if (!this.isLogin) {
					this.isLogin = true;
					this.email = '';
					this.pwd = '';
					this.code = '';
				}
			},
			registryShow() {
				if (this.isLogin) {
					this.isLogin = false;
					this.email = '';
					this.pwd = '';
					this.code = '';
				}
			},
			// 监听路由方法
			isRouteChange() {
				var path = this.$route.path
				if (path == "/live") {
					this.isClick1 = true
					this.isClick2 = false
					this.isClick3 = false
				}
				if (path == "/video") {
					this.isClick2 = true
					this.isClick1 = false
					this.isClick3 = false
				}
				if (path.indexOf("/mine/") != -1) {
					this.isClick3 = true
					this.isClick1 = false
					this.isClick2 = false
				}
				// 若未登录，手动调转观看视频的路由，则返回原页面
				if (path.indexOf("/videoPlayer/") != -1 && !this._local.get("email")) {
					this.$router.push("/index")
				}
				// 若手动跳转观看视频的路由，并且没有观看视频的权限, 则返回原页面路径
				if (path.indexOf("/videoPlayer/") != -1 && this._local.get("email")) {
					this.isUVPower()
				}
			},
			openFind() {
				this.visible = true
				this.isOpen = false
			},
			closeFind() {
				this.visible = false
			},
			searchByCName() {

				if (this.cName == "") {
					this.$router.push("/index")
				} else {
					this.$router.push("/index/" + this.cName)
				}
				// // 搜索后将绑定的cName值清空
				// this.cName = ""
			},
			emptyCName() {
				this.cName = ""
			},
			// 修改 Home.vue 的 login() 方法
			login() {
			// 原有前端校验（邮箱格式、密码长度）
			if (this.email === '') {
				this.$message.error('邮箱不能为空');
				return;
			}
			if (!/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/.test(this.email)) {
				this.$message.error('请输入正确邮箱');
				return;
			}
			if (this.pwd.length > 20 || this.pwd.length <= 0) {
				this.$message.error('密码在1-20位之间');
				return;
			}

			// 模拟验证：检查输入是否匹配预设的 mockAccount
			if (this.email === this.mockAccount.email && this.pwd === this.mockAccount.password) {
				// 模拟登录成功：存储用户信息到 localStorage（同原逻辑）
				const mockUser = { 
				id: 1, 
				email: this.email, 
				name: '梁宇轩', 
				url: require('@/assets/head/1.jpg'), // 模拟用户信息
				number: '2205080902172',
				type:0
				};
				this._local.set("email", mockUser, 3 * 60 * 60 * 10000); // 存储到本地
				this.$message.success('登录成功');
				this.isOpen = false; // 关闭登录弹窗
				this.$store.commit('setUser', mockUser); // 更新 Vuex 状态
				this.$nextTick(() => {
            	this.show = true;
            	this.showHead(mockUser.id);
        });
			} else {
				this.$message.error('邮箱或密码错误');
			}
			},
			getYanZheng() {
				if (this.email === '') {
					this.$message.error('邮箱不能为空');
					return
				}
				//验证邮箱
				if (!/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/.test(this.email)) {
					this.$message.error('请输入正确邮箱');
					return;
				}
				axios.get(this.$global_msg.userRoute + "/user/selectEmailNum", {
					params: {
						email: this.email
					}
				}).then(res => {
					//存在
					if (res.data.count === 1) {
						this.$message.error("该邮箱已存在")
						return
					} else {
						//发送验证码
						this.isSend = true
						//开启倒计时
						this.jishi();
						axios.get(this.$global_msg.userRoute + "/user/sendVerificationCode",{
							params: {
								email: this.email
							}
						}).then((res) => {
							console.log(res);
						})
					}
				})
			},
			jishi(){
				if(this.one_min <= 0){
					this.one_min = 60;
					this.isSend = false;
					return
				}
				setTimeout(() => {
					this.one_min--;
					this.jishi();
				},1000)
			},
			registry() {
				if (this.email === '') {
					this.$message.error('邮箱不能为空');
					return
				}
				//验证邮箱
				if (!/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/.test(this.email)) {
					this.$message.error('请输入正确邮箱');
					return;
				}
				if(!this.verify(this.pwd)){
					return;
				}
				axios.get(this.$global_msg.userRoute + "/user/selectEmailNum", {
					params: {
						email: this.email
					}
				}).then(res => {
					if (res.data.count === 1) {
						this.$message.error("该邮箱已存在")
						return
					}else{
						
						let formData = new FormData();
						formData.append("email",this.email)
						formData.append("code",this.code)
						formData.append("password",this.pwd)
						axios.post(this.$global_msg.userRoute + "/user/registry",formData)
							.then(res => {
								if(res.data.code === 500){
									this.$message.error("验证码错误")
								}else if(res.data.code  === 501){
									this.$message.error("注册失败")
								}else{
									this.$message.success("注册成功")
									this.isLogin = true;
								}
								console.log(res);
							})
					}
				})
				
			},
			//验证密码是否符合规范
			verify(pass) {
				if (pass.length < 6 && pass.length > 18) {
					this.$message.warning('您的密码应该是6-18位');
					return false;
				}
				if (/[`~!@#$%^&*()_+<>?:"{},\/;'[\]]/.test(pass)) {
					this.$message.warning('密码中包含非法字符或空格');
					return false;
				}
				if (/(^\s+)|(\s+$)/g.test(pass)) {
					this.$message.warning('密码中包含非法字符或空格');
					return false;
				}
				return true;
			},
			//右上角头像
			showHead(id) {
				const user = this._local.get("email");
				if (user) {
					this.head = user.url;
					this.nickname = user.name; // 获取昵称
					console.log('获取到的头像：', this.head, '获取到的昵称：', this.nickname); // 添加日志输出
				}
			},
			// 查看用户是否有权看看此视频，若无权观看，则返回至首页
			isUVPower() {
				axios.get(this.$global_msg.userRoute + '/video/isUVPower', {
						params: {
							uId: this._local.get("email").id,
							cId: this.$route.params.id
						}
					})
					.then((res) => {
						if(res.data.code == 500 || res.data.code == 401) {
							this.$router.push("/index")
						}
					}).catch((response) => {
						console.log(response);
					})
			}
		},
		// 监听router-view的切换，切换时将搜索框内容清空
		watch: {
			$route(to, from) {
				var toPath = to.path.toString()
				var fromPath = from.path.toString()

				// 若不是两个有条件查询中路由切换, 清空
				if (fromPath.indexOf("/index/") != -1 && toPath.indexOf("/index/") == -1) {
					this.tempName = this.cName
					this.cName = ""
				}
				if (fromPath.indexOf("/index/") == -1 && toPath.indexOf("/index/") != -1) {
					this.tempName = this.cName
					this.cName = ""
				}
				// 两个首页中数据的路由切换不清空搜索框的内容, 即重新将原有的值赋值给cName
				if (from.path == "/index" && toPath.indexOf("/index/") != -1) {
					this.cName = this.tempName
				}
				if (toPath == "/live") {
					this.isClick1 = true
					this.isClick2 = false
					this.isClick3 = false
				}
				if (toPath == "/video") {
					this.isClick2 = true
					this.isClick1 = false
					this.isClick3 = false
				}
				if (from.path == "/live") {
					this.isClick1 = false
				}
				if (from.path == "/video") {
					this.isClick2 = false
				}
				// 若未登录，手动跳转观看视频的路由，则返回原页面
				if (toPath.indexOf("/videoPlayer/") != -1 && !this._local.get("email")) {
					this.$router.push("/index")
				}
				// 若手动跳转观看视频的路由，并且没有观看视频的权限, 则返回原页面路径
				if (toPath.indexOf("/videoPlayer/") != -1 && this._local.get("email")) {
					this.isUVPower()
				}
			}
		},
		mounted() {
			this.isRouteChange()
			// let userJson = cookie.getCookie("email");
			let userJson = this._local.get("email")
			if (!this._local.get("email")) {
				//清理vuex中得user
				this.$store.commit('clearUser')
			} else {
				// console.log(this.$store.state.user === null)
				// console.log(this.$store.state.user)
				//cookie里存在user 就存vuex中
				this.show = true
				// let user = JSON.parse(userJson);
				let user = userJson;
				this.$store.commit('setUser', user)
				this.showHead(user.id);
			}
			Bus.$on('giveHead', (data) => {
				this.head = data
			})
			Bus.$on('exit', (data) => {
				this.$nextTick(() => {
					this.show = false
				})
			})
		}
	};
</script>

<style scoped="scoped">
	.onClick>a {
		color: rgb(24, 144, 255);
	}

	.noClick {
		/* color: ; */
	}

	#components-layout-demo-basic .ant-layout-header {
		background: #fff;
		color: #fff;
		border-bottom: 1px solid #dfdfdf;
	}

	#components-layout-demo-basic .ant-layout-footer {
		background: #a8a8a8;
		height: 200px;
		line-height: 1.5;
	}

	#components-layout-demo-basic .ant-layout-content {
		/* color: #fff; */
		min-height: 120px;
	}

	#components-layout-demo-basic>.ant-layout {
		margin-bottom: 48px;
	}

	#components-layout-demo-basic>.ant-layout:last-child {
		margin: 0;
	}

	.body>>>.input-search input {
		width: 350px;
		height: 40px;
	}

	.ant-menu-item-active {
		border: none !important;
	}

	.ant-menu-horizontal>.ant-menu-item,
	.ant-menu-horizontal>.ant-menu-submenu {
		border: none !important;
	}

	.ant-menu-horizontal {
		border: none !important;
	}

	.ant-menu-horizontal>.ant-menu-item-selected {
		color: rgba(0, 0, 0, 0.65);
	}

	#my-a {
		/* width: 1200px !important; */
		margin: 9px auto;
	}

	#mine,
	#login,
	#register,
	#gang {
		float: right;

	}

	#mine,
	#register,
	#gang {
		padding-right: 0;
	}

	#gang {
		padding: 0 !important;
	}

	#logo {
		padding-left: 0;
	}

	#search {
		margin-left: 15%;
	}

	.ant-input-affix-wrapper .ant-input-suffix {
		right: -145px;
	}

	.ant-input-affix-wrapper .ant-input:not(:last-child) {
		height: 40px;
		width: 350px;
	}

	#my-content {
		width: 1200px;
		margin: 0 auto;
	}

	.headImg>>>img {
		border: 1px #c1c1c1 solid;
		border-radius: 5px;
	}

	.headImg {
		margin-right: 2px;
	}

	.login_box {
		position: fixed;
		background: #fff;
		z-index: 100000;
		width: 384px;
		padding-top: 25px;
		padding-bottom: 15px;
		left: 50%;
		top: 50%;
		-webkit-transform: translate(-50%, -50%);
		-moz-transform: translate(-50%, -50%);
		-ms-transform: translate(-50%, -50%);
		transform: translate(-50%, -50%);
		box-shadow: 0 12px 24px 0 rgba(28, 31, 33, .1);
		border-radius: 12px;
		transition: all .2s;
		-webkit-transition: all .2s;
		-moz-transition: all .2s;
		-o-transition: all .2s;
		padding: 30px 32px;
	}

	.login_bg {
		position: fixed;
		top: 0;
		right: 0;
		bottom: 0;
		left: 0;
		z-index: 99;
		background-color: #000;
		opacity: .75;
	}

	.login_header {
		position: relative;
		/* margin-top: 20px; */
	}

	.login_header span {
		font-size: 22px;
		font-weight: 700;
		cursor: pointer;
	}

	.login_header .lan {
		font-size: 26px;
		color: #1890ff;
	}

	.put {
		/* height: 200px; */
	}

	.login_btn {
		/* margin-bottom: 20px; */
	}

	.login_btn button {
		width: 100%;
		box-sizing: border-box;
		padding: 11px 32px;
		font-size: 16px;
		line-height: 24px;
		border-radius: 24px;
		border-style: solid;
		border-width: 1px;
		cursor: pointer;
		-weibkit-transition: all .3s;
		-moz-transition: all .3s;
		transition: all .3s;
		color: #fff;
		background-color: #1890ff;
		border-color: #1890ff;
		opacity: 1;
	}

	.login_btn button:focus {
		border-color: #1890ff;
		outline: 0;
	}

	.box_close {
		position: absolute;
		top: 14px;
		right: 0px;
		font-size: 18px;
		cursor: pointer;
		transition: transform .2s;
		-webkit-transition: transform .2s;
		-moz-transition: transform .2s;
		-o-transition: transform .2s;
		border: none;
		background-color: #fff;
		padding: 0;
	}

	.box_close:hover {
		/* font-size: 20px; */
		background-position: 0 -22px;
		transform: scale(1.1);
		-webkit-transform: scale(1.1);
		-moz-transform: scale(1.1);
	}

	.yanzheng {
		position: absolute;
		right: 10px;
		top: 13px;
		color: #1481b8;
		cursor: pointer;
	}

	.ipt {
		width: 100%;
		height: 48px;
		line-height: 20px;
		box-sizing: border-box;
		padding: 14px;
		box-shadow: 2px 0 5px 0 #fff;
		background: rgba(28, 31, 33, .06);
		border-radius: 8px;
		border: 0;
		margin-bottom: 20px;
	}

	.ipt:focus {
		border-color: #1c1f21;
		outline: 0;
	}

	.findPass {
		width: 100%;
		height: 30px;
		font-size: 12px;
		text-align: right;
	}

	.findPass span {
		cursor: pointer;
	}

	.findPass span:hover {
		color: #0022fe;
	}
</style>
