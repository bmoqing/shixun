<template>
	<a-drawer :maskClosable="false" title="重置密码" :width="500" :visible="visiblePassword" @close="onClose">
		<div class="smallBody">
			<a-input-password v-model="oldPass" placeholder="旧密码" />
		</div>
		<div class="smallBody">
			<a-input-password v-model="newPass" placeholder="新密码 长度6-18 可以使用数字、字母或 _ 和 ." />
		</div>
		<div class="smallBody2">
			<div ref="diff1" class="diff"></div>
			<div ref="diff2" class="diff"></div>
			<div ref="diff3" class="diff"></div>
			<div ref="text" class="text">{{showDif}}</div>
		</div>
		<div class="smallBody">
			<a-input-password v-model="newPasst" placeholder="验证新密码" />
		</div>
		<div class="find">
			<span @click="openFind">忘记密码？马上找回</span>
		</div>
		<FindPass @closeFind="closeFind" :visible="visible"></FindPass>
		<div class="update">
			<a-button type="primary" @click="sub">
				确定
			</a-button>
		</div>
	</a-drawer>
</template>

<script>
	import axios from 'axios';
	import FindPass from '../../../../Common/FindPass/FindPass.vue'
	export default {
		name: 'ChangePassword',
		props: {
			visiblePassword: Boolean,
			id: Number
		},
		components: {
			FindPass
		},
		data() {
			return {
				oldPass: '',
				newPass: '',
				newPasst: '',
				showDif: '',
				visible: false
			};
		},
		methods: {
			openFind() {
				this.visible = true
			},
			closeFind() {
				this.visible = false
			},
			onClose() {
				this.$emit('closePass');
				this.oldPass = ''
				this.newPass = ''
				this.newPasst = ''
			},
			sub() {
				if (!this.verifyAll()) {
					return;
				}
				this.$message.success('修改成功');
				this.onClose();
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
				if (this.oldPass === '') {
					this.$message.warning('请输入你的旧密码');
					return false;
				}
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
		}
	};
</script>

<style scoped="scoped">
	.smallBody {
		width: 345px;
		height: 40px;
		margin: 10px;
	}

	.smallBody2 {
		width: 280px;
		display: flex;
		height: 20px;
		margin: 10px;
		margin-left: 15px;
	}

	.update {
		position: absolute;
		top: 90%;
		left: 80%;
	}

	.diff {
		width: 90px;
		height: 10px;
		margin: 5px 2px;
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
		margin-left: 5px;
		float: left;
		height: 20px;
		line-height: 20px;
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

	.find {
		width: 96%;
		margin-top: 30px;
		color: #d9d9d9;
		text-align: right;
	}

	.find span {
		cursor: pointer;
	}
</style>
