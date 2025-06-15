<template>
	<div class="top-search">
		<!-- 添加收支明细 -->
		<el-dialog width="40%" title="课程信息" :visible.sync="dialogFormVisible" @close="empty()">
			<el-form :model="form" :rules="rules" ref="form" class="demo-ruleForm">
				<el-form-item label="课程名" :label-width="formLabelWidth" prop="cname">
					<el-select v-model="form.cname">
						<el-option v-for="item in courses" :key="item.id" :label="item.name" :value="item.name"></el-option>
					</el-select>
				</el-form-item>
				<el-form-item label="教师名称" :label-width="formLabelWidth" prop="tname">
					<el-select v-model="form.tname">
						<el-option v-for="item in teachers" :key="item.id" :label="item.name" :value="item.name"></el-option>
					</el-select>
				</el-form-item>

				<el-form-item label="QQ群号" :label-width="formLabelWidth" placement="top" prop="qq">
					<el-input v-model.number="form.qq" placeholder="请输入QQ群号">
					</el-input>
				</el-form-item>

				<el-form-item label="报名截止日期" :label-width="formLabelWidth" placement="top" prop="endTime">
					<el-date-picker format="yyyy 年 MM 月 dd 日" value-format="yyyy-MM-dd" v-model="form.endTime" type="date" placeholder="选择日期">
					</el-date-picker>
				</el-form-item>
			</el-form>
			<div slot="footer" class="dialog-footer">
				<el-button @click="dialogFormVisible = false">取 消</el-button>
				<el-button type="primary" @click="add('form')">确 定</el-button>
			</div>
		</el-dialog>
		<el-button class="insertBtn" type="primary" size="medium" plain @click="
		        (dialogFormVisible = true);
		      ">添加</el-button>
	</div>
</template>

<script>
	import axios from 'axios';
	export default {
		name: 'Add',
		props: {
			currentTName: String,
			currentCName: String,
			page: Number,
			limit: Number,
		},
		data() {
			return {
				formLabelWidth: "120px",
				dialogFormVisible: false,
				form: {
					tId: '0',
					cId: '0',
					url: "",
					endTime: "",
					personNumber: 0,
					status: 0,
					systemTime: "",

					tnam: "",
					cname: ""
				},
				// tempForm{},
				t_id: 0,
				c_id: 0,
				teachers: {},
				courses: {},
				// 表单验证
				rules: {
					tname: [{
						required: true,
						message: '请输入教师名称',
						trigger: 'change'
					}, ],
					cname: [{
						required: true,
						message: '请输入课程名',
						trigger: 'change'
					}],
					endTime: [{
						required: true,
						message: '请输入报名截止日期',
						trigger: 'change'
					}],
					qq: [{
						required: true,
						message: '请选择要添加的图片',
						trigger: 'change'
					}, {
						type: 'number',
						message: 'QQ群号为数字类型',
						trigger: 'change'
					}],
				},
			}
		},
		methods: {
			// 取消添加或者添加成功后将form中的数据清空
			empty() {
				this.form.tname = ""
				this.form.cname = ""
				this.form.endTime = ""
				this.form.cId = ""
				this.form.tId = ""
				this.form.qq = ""
				this.$refs['form'].clearValidate();
			},
			// 获取当前时间
			getNowTime() {
				// let nowDate = new Date()

				// // 获取系统当前日期
				// this.systemTime = nowDate.toLocaleDateString().replace("/","-").replace("/","-")
				var nowDate = new Date();
				var year = nowDate.getFullYear();
				var month = nowDate.getMonth() + 1 < 10 ? "0" + (nowDate.getMonth() + 1) :
					nowDate.getMonth() + 1;
				var day = nowDate.getDate() < 10 ? "0" + nowDate.getDate() : nowDate
					.getDate();
				this.systemTime = year + "-" + month + "-" + day;
			},
			// 读取出所有的教师信息
			findTeacher() {
				axios.get(this.$global_msg.adminRoute + '/teacher/select')
					.then(res => {
						this.teachers = res.data.data;
					})
					.catch(response => {
						console.log(response);
					});
			},
			// 读取出所有的教师信息
			findCourse() {
				axios.get(this.$global_msg.adminRoute + '/liveCourse/selectCourseByStatus')
					.then(res => {
						this.courses = res.data.data;
					})
					.catch(response => {
						console.log(response);
					});
			},
			// 找到教师姓名所对应的教师id外键
			findTId(tName) {
				for (var index in this.teachers) {
					var teacher = this.teachers[index]
					if (teacher.name == this.form.tname) {
						this.t_id = teacher.id
					}
				}
			},
			// 找到课程姓名所对应的课程id外键
			findCId(tName) {
				for (var index in this.courses) {
					var course = this.courses[index]
					if (course.name == this.form.cname) {
						this.c_id = course.id
					}
				}
			},
			// 添加课程信息

			// 添加课程信息
			add(forName) {
				this.$refs[forName].validate((valid) => {
					// 添加课程信息
					if (valid) {
						// 找到教师姓名所对应的教师id外键
						this.findTId(this.form.tname);
						// 找到课程名所对应的课程id外键
						this.findCId(this.form.cname);
						this.form.tId = this.t_id;
						this.form.cId = this.c_id
						let formData = JSON.stringify(this.form)
						// 获取系统当前日期
						this.getNowTime()
						// console.log(this.systemTime)
						// console.log(this.form.endTime)
						if (this.form.endTime <= this.systemTime) {
							alert("报名截止日期必须晚于系统当前日期")
						} else {
							axios({
									method: "post",
									url: this.$global_msg.adminRoute + "/liveCourse/addLiveCourse",
									headers: {
										// "Content-Type": "formData;charset=UTF-8"
										'Content-Type': 'application/json;charset=UTF-8',
									},
									data: formData
								})
								.then((res) => {
									if (res.data.code == 200) {
										this.$message({
											type: "success",
											message: "添加成功!",
										});
										setTimeout(() => { //设置延迟执行
											// 展示分页数据
											this.$emit('showData', this.currentTName, this.currentTName, this.page, this.limit)
										}, 1200);

									} else {
										this.$message({
											type: "error",
											message: "添加失败!",
										});
									}
								})
								.catch((e) => {});
							this.dialogFormVisible = false
						}

					} else {
						console.log('error submit!!');
						return false;
					}
				});

			}


		},
		mounted() {
			this.findTeacher();
			this.findCourse();

		},

	};
</script>

<style scoped>
	.top-search {
		margin-top: 3px;
	}


	.avatar {
		width: 250px;
	}

	.avatar-uploader-icon {
		font-size: 28px;
		color: #8c939d;
		width: 150px;
		height: 150px;
		line-height: 150px;
		text-align: center;
		border: 1px #b5b5b5 dashed;
	}

	.avatar-uploader {
		width: 320px;
	}
</style>
