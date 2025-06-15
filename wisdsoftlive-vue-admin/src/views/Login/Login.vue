<template>
	<div class="login-container">
		<el-form :model="form" :rules="rules" ref="form" label-width="80px" class="login-form demo-ruleForm">
			<h2 class="login-title">管理系统</h2>
			<el-form-item label="用户名" prop="username">
				<el-input v-model="form.username"></el-input>
			</el-form-item>
			<el-form-item label="密码" prop="password">
				<el-input v-model="form.password"></el-input>
			</el-form-item>
			<div style="display: flex;">
				<el-form-item>
					<el-button type="primary" @click="onSubmit('form')">登录</el-button>
				</el-form-item>
				<span v-if="!isTrue" style="line-height: 40px; margin-left: 30px; color: red;">
					{{ msg }}
				</span>
			</div>
		</el-form>
	</div>
</template>

<script>
import axios from 'axios';
export default {
	name: 'Login',
	data() {
		return {
			form: {
				username: "",
				password: ""
			},
			msg: "用户名密码错误",
			isTrue: true,
			// 表单验证
			rules: {
				username: [{
					required: true,
					message: '请输入用户名',
					trigger: 'change'
				},],
				password: [{
					required: true,
					message: '请输入密码',
					trigger: 'change'
				},],
			},
		}
	},
	components: {

	},
	methods: {
		onSubmit(forName) {
			this.$refs[forName].validate((valid) => {
				// if (valid) {
				// 	axios
				// 		.get(this.$global_msg.adminRoute + '/admin/selectAdmin', {
				// 			params: {
				// 				username: this.form.username,
				// 				password: this.form.password
				// 			}
				// 		})
				// 		.then(res => {
				// 			if (res.data.code == "200") {
				// 				// 将admin存入sessionStorage
				// 				sessionStorage.setItem("admin", "admin")
				// 				sessionStorage.setItem("T-Token", res.data.data)
				// 				// sessionStorage.setAge
				// 				// 跳转路由
				// 				this.$router.push('/live/banner')
				// 				this.username = "";
				// 				this.password = "";
				// 			} else {
				// 				this.isTrue = false
				// 				this.$refs['form'].clearValidate();
				// 			}

				// 		})
				// 		.catch(response => {
				// 			console.log(response);
				// 		});
				// } else {
				// 	return false;
				// }
				const res = { data: { code: 200, data: 'ceshi' } }
				if (res.data.code == "200") {
					// 将admin存入sessionStorage
					sessionStorage.setItem("admin", "admin")
					sessionStorage.setItem("T-Token", res.data.data)
					// sessionStorage.setAge
					// 跳转路由
					this.$router.push('/live/banner')
					this.username = "";
					this.password = "";
				} else {
					this.isTrue = false
					this.$refs['form'].clearValidate();
				}
			}
			);
		}
	},
	mounted() {
		this.isTrue = true
		this.username = "";
		this.password = "";
	}
}
</script>

<style acoped>
.login-form {
	width: 350px;
	margin: 160px auto;
	/* 上下间距160px，左右自动居中*/
	background-color: rgb(255, 255, 255, 0.8);
	/* 透明背景色 */
	padding: 30px;
	border-radius: 20px;
	/* 圆角 */
}

/* 背景 */
.login-container {
	position: absolute;
	width: 100%;
	height: 100%;
	background-color: #0080ff1a;
}

/* 标题 */
.login-title {
	color: #303133;
	text-align: center;
	margin-bottom: 10px;
}
</style>
