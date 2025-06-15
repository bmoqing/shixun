<template>
	<div class="con">
		<div class="top">
			<div class="top-search">
				<span>标题</span>
				<el-input v-model="name" prefix-icon="el-icon-search" type="text" placeholder="教师姓名" style="width:220px">
				</el-input>
			</div>
			<el-button class="searchBtn" @click="handleClickSerachBlurry" type="primary" size="medium" plain>查询</el-button>
			<el-button type="primary" size="medium" @click="dialogFormVisible = true;
	        " plain>添加</el-button>
		</div>

		<el-dialog z-index="1" title="教师" @close="close" @open="open" :visible.sync="dialogFormVisible" :destroy-on-close="false">
			<el-form :model="form" :rules="rules" ref="ruleForm">
				<el-form-item label="教师姓名" :label-width="formLabelWidth" prop="name">
					<el-input v-model="form.name" autocomplete="off"></el-input>
				</el-form-item>

			</el-form>
			<div slot="footer" class="dialog-footer">
				<el-button @click="dialogFormVisible = false">取 消</el-button>
				<el-button type="primary" @click="addNotice()">确定</el-button>
			</div>
		</el-dialog>
	</div>
</template>


<script>
	import axios from 'axios'
	export default {
		name: 'NoticeTop',
		data() {
			return {
				name: "",
				dialogFormVisible: false,
				form: {},
				formLabelWidth: "120px",
				rules: {
					name: [{
						required: true,
						message: '请输入教师姓名',
						trigger: "change"
					}]
				}
			}
		},
		watch: {
			name: function(val, oldVal) {
				this.changeProps()
			},
		},
		methods: {
			yesOrNO(msg, type) {
				this.$message({
					message: msg,
					type: type
				});
			},
			close() {
				this.$refs['ruleForm'].clearValidate();
			},
			open() {

			},
			//用与模糊查询
			handleClickSerachBlurry() {
				this.$emit("clickSearchBtn");
			},
			changeProps() {
				this.$emit("changeProps", this.name);
			},
			//添加方法
			addNotice() {
				this.$refs['ruleForm'].validate((valid) => {
					if (valid) {
						let teacher = {
							name: this.form.name
						};
						axios.get(this.$global_msg.adminRoute +"/teacher/showTeacherByName/" + this.form.name, ).then(res => {
							if (res && res.data) {
								const data = res.data;
								console.log(data);
								if (data.data !== null) {
									this.yesOrNO("添加失败,姓名存在", "error")
									return
								} else {
									axios.post(this.$global_msg.adminRoute +"/teacher/addTeacher", teacher)
										.then(res => {
											if (res && res.data) {
												this.$emit("clickSearchBtn");
												this.yesOrNO("添加成功", "success")
											}
										})
										.catch(e => {
											console.log(e);
											this.yesOrNO("添加成功", "error")
										});
									this.dialogFormVisible = false;
								}
							}
						})
					} else {
						return false;
					}

				});
			}
		},
		mounted() {},
		components: {}
	}
</script>
<style scoped>
	.con {
		padding: 10px
	}

	.top {
		display: flex;
		margin-bottom: 10px;
	}

	.top .top-search {
		margin-right: 20px;
	}

	.top span {
		color: rgb(102, 102, 102);
		margin-right: 10px;
	}

	.top .searchBtn {
		margin-right: 30px;
	}
</style>
