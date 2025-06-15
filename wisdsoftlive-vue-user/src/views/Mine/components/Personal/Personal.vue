<template>
	<div class="body">
		<div class="top">
			个人资料
		</div>
		<div class="body_02">
			<input id="id" hidden="hidden" />
			<div class="head">
				<img class="head_img" :src='userData.url' />
				<div class="change-head">
					<a-button @click="open">更换头像</a-button>
					<ChangeHead :visible="visible" @closeHead="closeHead" @changeHead="changeHead" :imgId="userData.img" :img="userData.url"></ChangeHead>
				</div>
			</div>
			<div class="ji">
				基本信息
			</div>
			<div class="lei">
				<div class="tips">昵称</div>
				<div class="my-input">
					<a-input v-model="userData.name" />
				</div>
				<div class="sub" @click="changeName">
					<a-button type="primary">
						保存
					</a-button>
				</div>
			</div>
			<div class="lei">
				<div class="tips">学号</div>
				<div v-if="authentication" class="show">
					220580902172
				</div>
				<div v-if="!authentication" class="show">
					<a-button type="link" @click="openNumber">
						<a-icon type="alert" />去认证
					</a-button>
					<ChangeNumber @changeAuthenticationType="changeAuthenticationType" @closeNumber="closeNumber" :visibleNumber="visibleNumber"></ChangeNumber>
				</div>
				<div v-if="authentication" class="update">
					<a-tag color="green">
						已认证
					</a-tag>
				</div>
				<div v-if="!authentication" class="update">
					<a-tag color="red">
						未认证
					</a-tag>
				</div>
			</div>
			<div class="lei">
				<div class="tips">电子邮箱</div>
				<div class="show">
					{{userData.email}}
				</div>
				<div class="update" @click="openEmail">
					<a-button type="link">
						<a-icon type="edit" />编辑
					</a-button>
				</div>
				<ChangeEmail @changeIsOk="changeIsOk" @closeEmail="closeEmail" :visibleEmail="visibleEmail" :email="userData.email"></ChangeEmail>
			</div>
			<div class="lei">
				<div class="tips">密码</div>
				<div class="show">
					{{passshow}}
				</div>
				<div class="update" @click="openPassword">
					<a-button type="link">
						<a-icon type="redo" />重置
					</a-button>
				</div>
				<ChangePassword :id="userData.id" @closePass="closePass" :visiblePassword="visiblePassword"></ChangePassword>
			</div>
		</div>
	</div>
</template>

<script>
	import ChangeHead from './components/ChangeHead.vue'
	import ChangeEmail from './components/ChangeEmail.vue'
	import ChangePassword from './components/ChangePassword.vue'
	import ChangeNumber from './components/ChangeNumber.vue'
	import Bus from '../../../../js/bus.js'
	import axios from 'axios';
	export default {
		name: 'Personal',
		components: {
			ChangeHead,
			ChangeEmail,
			ChangePassword,
			ChangeNumber
		},
		data() {
			return {
				//是否认证
				authentication: true,
				//是否打开修改头像抽屉
				visible: false,
				//是否打开修改邮件页面
				visibleEmail: false,
				//修改密码抽屉
				visiblePassword: false,
				visibleNumber: false,
				//用户的信息
				userData: {},
				passshow: ''
			};
		},
		methods: {
			//头像的开关
			open() {
				this.visible = true
			},
			openEmail() {
				this.visibleEmail = true
			},
			openPassword() {
				this.visiblePassword = true
			},
			openNumber() {
				this.visibleNumber = true
			},
			closeHead() {
				this.visible = false
			},
			closeEmail() {
				this.visibleEmail = false
			},
			closePass() {
				this.visiblePassword = false
			},
			closeNumber() {
				this.visibleNumber = false
			},
			changeAuthenticationType(number) {
				this.authentication = !this.authentication;
				this.userData.number = number
			},
			changeHead(headId, url) {
				if (this.userData.img === headId) {
					return;
				}
				let userVo = {
					id: this.userData.id,
					img: headId
				};
				axios
					.post(this.$global_msg.userRoute + '/user/updateImgById', userVo)
					.then(a => {
						if (a.data.code === 200) {
							this.userData.url = url;
							this.userData.img = headId;
							Bus.$emit('giveHead', this.userData.url)
							this.$message.success('修改成功');
						} else {
							this.$message.error('修改失败');
						}
					})
					.catch(e => {
						this.$message.error('修改失败');
					});
			},
			changeName() {
				let userVo = {
					id: this.userData.id,
					name: this.userData.name
				};
				// 模拟修改成功
				this.$message.success('修改成功');
				// 更新本地数据
				this._local.set("email", {...this.userData, ...userVo }, 3 * 60 * 60 * 10000); 
				this.$emit('nameChanged', this.userData.name);
			},
			changeIsOk(newEmail) {
				this.visibleEmail = false;
				this.userData.email = newEmail;
			}
		},
		// src/views/Mine/components/Personal/Personal.vue
			mounted() {
				if(this._local.get("email")) {
					let user = this._local.get("email");
					// 直接使用本地存储的用户信息，无需再发送接口请求
					this.userData = user; 
					this.authentication = this.userData.type === 0;
					this.passshow = "********";
				}
			}
	};
</script>

<style scoped="scoped">
	.body {
		margin: 24px 0;
		width: 74%;
		background-color: white;
		box-shadow: 0 1px 5px rgba(1, 1, 1, 0.1);
		border-radius: 4px;
	}

	.top {
		width: 100%;
		padding: 0 20px;
		border-bottom: 1px solid #ebebeb;
		height: 48px;
		line-height: 48px;
		font-size: 16px;
		font-weight: bold;
		color: black;
	}

	.body_02 {
		width: 100%;
		height: 550px;
		padding: 24px 30px;
	}

	.head {
		width: 100%;
		height: 85px;
		margin-bottom: 32px;
	}

	.head_img {
		width: 85px;
		border-radius: 3px;
		margin-right: 20px;
		float: left;
	}

	.change-head {
		padding-top: 53px;
	}

	.ji {
		width: 100%;
		height: 30px;
		color: black;
		font-size: 16px;
		font-weight: 500;
		line-height: 30px;
		margin-bottom: 25px;
		border-bottom: 1px solid #ebebeb;
	}

	.tips {
		width: 100px;
		color: #7a7a7a;
	}

	.lei {
		width: 100%;
		height: 57px;
		border-bottom: 1px solid #ebebeb;
		margin-bottom: 25px;
	}

	.lei div {
		float: left;
		height: 32px;
		line-height: 32px;
	}

	.my-input {
		width: 40%;
	}

	.sub {
		float: right !important;
	}

	.show {
		color: black;
	}

	.update {
		float: right !important;
	}

	.update .ant-btn,
	.show .ant-btn {
		padding: 0 !important;
	}

	.update .ant-tag {
		margin-right: 0 !important;
	}
</style>
<style scoped="scoped">
	.body {
		margin: 24px 0;
		width: 74%;
		background-color: white;
		box-shadow: 0 1px 5px rgba(1, 1, 1, 0.1);
		border-radius: 4px;
	}

	.top {
		width: 100%;
		padding: 0 20px;
		border-bottom: 1px solid #ebebeb;
		height: 48px;
		line-height: 48px;
		font-size: 16px;
		font-weight: bold;
		color: black;
	}

	.body_02 {
		width: 100%;
		height: 550px;
		padding: 24px 30px;
	}

	.head {
		width: 100%;
		height: 85px;
		margin-bottom: 32px;
	}

	.head_img {
		width: 85px;
		border-radius: 3px;
		margin-right: 20px;
		float: left;
	}

	.change-head {
		padding-top: 53px;
	}

	.ji {
		width: 100%;
		height: 30px;
		color: black;
		font-size: 16px;
		font-weight: 500;
		line-height: 30px;
		margin-bottom: 25px;
		border-bottom: 1px solid #ebebeb;
	}

	.tips {
		width: 100px;
		color: #7a7a7a;
	}

	.lei {
		width: 100%;
		height: 57px;
		border-bottom: 1px solid #ebebeb;
		margin-bottom: 25px;
	}

	.lei div {
		float: left;
		height: 32px;
		line-height: 32px;
	}

	.my-input {
		width: 40%;
	}

	.sub {
		float: right !important;
	}

	.show {
		color: black;
	}

	.update {
		float: right !important;
	}

	.update .ant-btn,
	.show .ant-btn {
		padding: 0 !important;
	}

	.update .ant-tag {
		margin-right: 0 !important;
	}
</style>