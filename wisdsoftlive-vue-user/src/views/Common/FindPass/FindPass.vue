<template>
	<a-modal :destroyOnClose="true" :footer="null" :centered="true" width="1200px" title="找回密码" :visible="findVisible"
	 @cancel="close()">
		<div class="body">
			<div>
				<a-steps :current="current">
					<a-step v-for="item in steps" :key="item.title" :title="item.title" />
				</a-steps>
				<div class="content">
					<div class="content_body" v-show="current == 0">
						<div class="email_page">
							<div class="mailtext">账号:</div>
							<a-input v-model="email" style="margin-right: 82px; width: 60%;margin-bottom: 5px;" placeholder="输入您的邮箱账号" />
							<a-button v-show="buttonShow" @click="sendVC()">发送验证码</a-button>
							<a-button v-show="!buttonShow" :disabled="true">
								{{time}}秒
							</a-button>

							<div class="mailtext">验证码:</div>
							<a-input v-model="vc" style="margin-right: 82px; width: 60%;" placeholder="输入验证码" />
						</div>
					</div>
					<div class="content_body" v-show="current == 1">
						<div class="pass_page">
							<a-input-password v-model="newPass" placeholder="新密码 长度6-18 可以使用数字、字母或 _ 和 ." />
							<div ref="diff1" class="diff"></div>
							<div ref="diff2" class="diff"></div>
							<div ref="diff3" class="diff"></div>
							<div ref="text" class="text textColor1">{{showDif}}</div>
							<a-input-password v-model="newPasst" placeholder="验证新密码" />
						</div>
					</div>
					<div class="content_body" v-show="current == 2">
						<a-result v-if="changeType" status="success" title="密码修改成功" sub-title="妥善保管您的密码,以防被盗"></a-result>
						<a-result v-if="!changeType" status="error" title="密码修改失败" sub-title="请稍后重试"></a-result>
					</div>
				</div>
				<div class="steps-action">
					<a-button v-if="current < steps.length - 1" type="primary" @click="next">
						下一步
					</a-button>
					<a-button v-if="current == steps.length - 1" type="primary" @click="close()">
						关闭
					</a-button>
				</div>
			</div>
		</div>
	</a-modal>
</template>

<script>
	import axios from 'axios';
	export default {
		name: 'FindPass',
		props: {
			visible: false,
		},
		data() {
			return {
				findVisible: false,
				current: 0,
				steps: [{
						title: '身份验证'
					},
					{
						title: '设置新密码'
					},
					{
						title: '完成修改'
					}
				],
				email: '',
				vc: '',
				newPass: '',
				newPasst: '',
				showDif: '',
				buttonShow: true,
				timer: '',
				time: 0,
				changeType: true
			};
		},
		methods: {
			close() {
				this.current = 0
				this.email = ''
				this.vc = ''
				this.newPass = ''
				this.newPasst = ''
				this.$emit('closeFind')
			},
			next() {
				if (this.current == 0) {
					this.verifyVC();
				} else if (this.current == 1) {
					this.sub();
				}
			},
			start() {
				this.buttonShow = false;
				this.time = 60;
				this.timer = setInterval(() => {
					if (this.time > 0) {
						this.time--
					} else {
						clearInterval(this.timer);
						this.buttonShow = true;
					}
				}, 1000)
			},
			sub() {
				if (!this.verifyAll()) {
					return;
				}
				let data = new FormData();
				data.append("email", this.email);
				data.append("password", this.newPass);
				axios
					.post(this.$global_msg.userRoute + '/user/updateUserPassByEmail', data)
					.then(a => {
						this.changeType = true
						this.current++;
					})
					.catch(e => {
						this.changeType = false
						this.current++;
					});
			},
						sendVC() {
				if (!/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/.test(this.email)) {
					this.$message.error('请输入正确邮箱');
					return
				}
				// 模拟验证邮箱已注册
				this.start();
				this.$message.success('验证码已发送，请注意查看邮箱');
			},
			verifyVC() {
			if (!/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/.test(this.email)) {
				this.$message.error('请输入正确邮箱');
				return
			}
			if (this.vc === '' || this.vc.length < 6) {
				this.$message.error('请填写6位验证码');
				return;
			}
			this.$message.success('验证成功');
			this.current++;
		},
			//验证密码是否符合规范
			verify(pass) {
				if (/[`~!@#$%^&*()_+<>?:"{},\/;'[\]]/.test(pass)) {
					return false;
				}
				if (/(^\s+)|(\s+$)/g.test(pass)) {
					return false;
				}
				return true;
			},
			//验证所有规则
			verifyAll() {
				if (this.newPass === '') {
					this.$message.warning('请输入你的新密码');
					return false;
				}
				if (this.newPasst === '') {
					this.$message.warning('请确认你的新密码');
					return false;
				}
				if (this.newPass.length < 6 && this.newPass.length > 18) {
					this.$message.warning('您的密码应该是6-18位');
					return false;
				}
				if (!this.verify(this.newPass)) {
					this.$message.warning('新密码中包含非法字符或空格');
					return false;
				}
				if (this.newPass !== this.newPasst) {
					this.$message.warning('两次密码不一致');
					return false;
				}
				return true;
			},
			//计算密码难度分数
			calScore(pass) {
				var score = 0;
				//长度评分
				var length = pass.length;
				if (length <= 4) {
					score += 5;
				} else if (length >= 5 && length <= 7) {
					score += 10;
				} else if (length >= 8) {
					score += 25;
				}
				//统计字母数字和符号
				var lower = 0;
				var upper = 0;
				var num = 0;
				var symbol = 0;
				for (let char of pass) {
					if (char >= '0' && char <= '9') {
						num++;
					} else if (char >= 'A' && char <= 'Z') {
						upper++;
					} else if (char >= 'a' && char <= 'z') {
						lower++;
					} else if (char === '_' || char === '.') {
						symbol++;
					}
				}
				if ((lower > 0 && upper == 0) || (upper > 0 && lower == 0)) {
					score += 10;
				} else if (lower > 0 && upper > 0) {
					score += 20;
				}
				if (num == 1) {
					score += 10;
				} else if (num > 1) {
					score += 20;
				}
				if (symbol == 1) {
					score += 10;
				} else if (symbol > 1) {
					score += 20;
				}
				if (lower > 0 && upper > 0 && num > 0 && symbol > 0) {
					score += 5;
				} else if ((lower > 0 || upper > 0) && num > 0 && symbol > 0) {
					score += 3;
				} else if ((lower > 0 || upper > 0) && num > 0) {
					score += 2;
				}
				return score;
			}
		},
		watch: {
			visible() {
				this.findVisible = this.visible
			},
			newPass() {
				if (this.newPass === '') {
					this.showDif = ''
					this.$refs.diff1.className = 'diff'
					this.$refs.diff2.className = 'diff'
					this.$refs.diff3.className = 'diff'
					return;
				}
				var score = this.calScore(this.newPass);
				if (score >= 65) {
					this.showDif = '强'
					this.$refs.text.className = 'text textColor3'
					this.$refs.diff1.className = 'diff diff1'
					this.$refs.diff2.className = 'diff diff2'
					this.$refs.diff3.className = 'diff diff3'
				} else if (score > 40) {
					this.showDif = '中'
					this.$refs.text.className = 'text textColor2'
					this.$refs.diff1.className = 'diff diff1'
					this.$refs.diff2.className = 'diff diff2'
					this.$refs.diff3.className = 'diff'
				} else {
					this.showDif = '弱'
					this.$refs.text.className = 'text textColor1'
					this.$refs.diff1.className = 'diff diff1'
					this.$refs.diff2.className = 'diff'
					this.$refs.diff3.className = 'diff'
				}
			}
		},
	}
</script>

<style scoped="scoped">
	.body {
		height: 480px;
	}

	.steps-content {
		margin-top: 16px;
		border: 1px dashed #e9e9e9;
		border-radius: 6px;
		background-color: #fafafa;
		min-height: 200px;
		text-align: center;
		padding-top: 80px;
	}

	.steps-action {
		margin-top: 24px;
		float: right;
	}

	.content {
		width: 100%;
		height: 350px;
		margin-top: 30px;
	}

	.content_body {
		width: 100%;
		height: 100%;
	}

	.email_page {
		width: 40%;
		margin-left: 30%;
		margin-top: 50px;
	}

	.email_page>>>.ant-input {
		width: 100%;
	}

	.mailtext {
		margin-bottom: 5px;
	}

	.email_page>>>.ant-btn {
		height: 33px;
	}

	.pass_page {
		width: 30%;
		margin: 0 35%;
		margin-top: 50px;
	}

	.diff {
		width: 90px;
		height: 10px;
		margin: 15px 2px;
		border: 1px solid #ebebeb;
		float: left;
		border-radius: 50px;
	}

	.diff1 {
		background-color: rgb(255, 0, 0);
	}

	.diff2 {
		background-color: rgb(255, 255, 0);
	}

	.diff3 {
		background-color: rgb(0, 199, 52);
	}

	.text {
		width: 20px;
		height: 40px;
		float: left;
		line-height: 40px;
		margin-left: 15px;
	}

	.textColor1 {
		color: rgb(255, 0, 0);
	}

	.textColor2 {
		color: rgb(255, 255, 0);
	}

	.textColor3 {
		color: rgb(0, 199, 52);
	}
</style>
