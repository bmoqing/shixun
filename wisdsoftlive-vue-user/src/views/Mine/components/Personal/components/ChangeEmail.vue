<template>
	<div>
		<a-drawer :maskClosable="false" title="修改邮箱" :width="720" :visible="visibleEmail" :body-style="{ paddingBottom: '80px' }"
		 @close="onClose">
			<div class="body" v-if="!showNew">
				<div class="tips">验证旧邮箱</div>
				<div class="smallBody">
					<a-input :disabled="true" v-model="oldEmail" />
					<a-button v-show="button1Show" @click="sendVC1">发送验证码</a-button>
					<a-button v-show="!button1Show" :disabled="true">
						{{time1}}秒
					</a-button>
				</div>
				<div class="smallBody">
					<a-input placeholder="请填写6位验证码" v-model="vc1" />
					<a-button @click="verify1">验证</a-button>
				</div>
			</div>

			<div class="body" v-if="showNew">
				<div class="tips">验证新邮箱</div>
				<div class="smallBody">
					<a-input v-model="newEmail" placeholder="请输入新邮箱" />
					<a-button v-show="button2Show" @click="sendVC2">发送验证码</a-button>
					<a-button v-show="!button2Show" :disabled="true">
						{{time2}}秒
					</a-button>
				</div>
				<div class="smallBody">
					<a-input placeholder="请填写6位验证码" v-model="vc2" />
					<a-button @click="verify2">验证</a-button>
				</div>
			</div>
		</a-drawer>
	</div>
</template>

<script>
	import axios from 'axios';
	export default {
		name: 'ChangeEmail',
		props: {
			visibleEmail: Boolean,
			email: String
		},
		data() {
			return {
				oldEmail: '',
				newEmail: '',
				button1Show: true,
				button2Show: true,
				timer1: '',
				timer2: '',
				time1: 0,
				time2: 2,
				vc1: '',
				vc2: '',
				showNew: false,
			};
		},
		methods: {
			onClose() {
				this.$emit('closeEmail');
				this.newEmail = '';
				this.vc1 = '';
				this.vc2 = '';
				this.showNew = false;
			},
			onFinish() {
				console.log('finished!');
			},sendVC1() {
    this.$message.success('验证码已发送，请注意查看邮箱');
    this.start1();
},
verify1() {
    if (this.vc1 === '' || this.vc1.length < 6) {
        this.$message.error('请填写6位验证码');
        return;
    }
    this.$message.success('验证成功');
    this.showNew = true;
},
sendVC2() {
    if (!/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/.test(this.newEmail)) {
        this.$message.error('请输入正确邮箱');
        return;
    }
    this.$message.success('验证码已发送，请注意查看邮箱');
    this.start2();
},
verify2() {
    if (this.vc2 === '' || this.vc2.length < 6) {
        this.$message.error('请填写6位验证码');
        return;
    }
    this.$message.success('验证成功，邮箱已修改');
    // 更新本地数据
    this.$emit('changeIsOk', this.newEmail);
    this._local.set("email", {...this._local.get("email"), email: this.newEmail }, 3 * 60 * 60 * 10000); 
},
			start1() {
				this.button1Show = false;
				this.time1 = 60;
				this.timer1 = setInterval(() => {
					if (this.time1 > 0) {
						this.time1--
					} else {
						clearInterval(this.timer1);
						this.button1Show = true;
					}
				}, 1000)
			},
			start2() {
				this.button2Show = false;
				this.time2 = 60;
				this.timer2 = setInterval(() => {
					if (this.time2 > 0) {
						this.time2--
					} else {
						clearInterval(this.timer2);
						this.button2Show = true;
					}
				}, 1000)
			}
		},
		watch: {
			email() {
				this.oldEmail = this.email
			}
		}
	};
</script>

<style scoped="scoped">
	.tips {
		width: 100%;
		height: 30px;
		line-height: 30px;
		border-bottom: 1px solid #ebebeb;
		color: black;
	}

	.body {
		border-bottom: 1px solid #ebebeb;
		margin-bottom: 40px;
	}

	.ant-input {
		width: 50%;
		margin-right: 30%;
	}

	.smallBody {
		width: 100%;
		margin: 15px;
	}
</style>
