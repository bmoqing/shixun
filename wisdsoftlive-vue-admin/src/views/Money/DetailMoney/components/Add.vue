<template>
	<div class="top-search">
		<!-- 添加收支明细 -->
		<el-dialog title="课程信息" :visible.sync="dialogFormVisible" @close="empty()">
			<el-form :model="form" :rules="rules" ref="form" class="demo-ruleForm">
				<el-form-item label="教师名称" :label-width="formLabelWidth" prop="tname">
					<el-select v-model="form.tname">
						<el-option v-for="item in teachers" :key="item.id" :label="item.name" :value="item.name"></el-option>
					</el-select>
				</el-form-item>
				<el-form-item label="操作金额" :label-width="formLabelWidth" prop="money">
					<el-input v-model.number="form.money" autocomplete="off"></el-input>
				</el-form-item>
				<el-form-item label="操作用途" :label-width="formLabelWidth" prop="detail">
					<el-input v-model="form.detail" autocomplete="off"></el-input>
				</el-form-item>
				<el-form-item label="收支类型" :label-width="formLabelWidth" placement="top" prop="type">
					<el-radio-group v-model="form.type">
						<el-radio :label="1">收入</el-radio>
						<el-radio :label="0">支出</el-radio>
					</el-radio-group>
				</el-form-item>
			</el-form>
			<div slot="footer" class="dialog-footer">
				<el-button @click="dialogFormVisible = false">取 消</el-button>
				<el-button type="primary" @click="add(form,'form')">确 定</el-button>
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
			currentTime: String,
			currentTName: String,
			currentType: String,
			page: Number,
			limit: Number,
		},
		data() {
			return {
				formLabelWidth: "120px",
				dialogFormVisible: false,
				form: {
					cid: 0,
					uid: 0,
					time: ""
				},
				systemTime: "",
				t_id: 0,
				teachers: {},
				// 表单验证
				rules: {
					tname: [{
						required: true,
						message: '请输入教师名称',
						trigger: 'change'
					}, ],
					detail: [{
						required: true,
						message: '请输入操作用途',
						trigger: 'change'
					}, ],
					money: [{
						required: true,
						message: '请输入金额',
						trigger: 'change'
					}, {
						type: 'number',
						message: '请输入数字类型',
						trigger: 'change'
					}],
					type: [{
						required: true,
						message: '请输入收支类型',
						trigger: 'change'
					}],
				},
			}
		},
		methods: {
			// 取消添加或者添加成功后将form中的数据清空
			empty() {
				this.form = {}
				this.form.cid = 0
				this.form.uid = 0
				this.form.time = ""
				this.$refs['form'].clearValidate();
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
			// 找到教师姓名所对应的教师id外键
			findTId(tName) {
				for(var index in this.teachers) {
					var teacher = this.teachers[index]
					if(teacher.name == this.form.tname) {
						this.t_id = teacher.id
					}
				}
			},
			// 获取当前时间
			getNowTime() {
				let nowDate = new Date()
				
				// 获取系统当前日期
				this.systemTime = nowDate.toLocaleDateString().replace("/","-").replace("/","-")
				
				let date = {
					h: nowDate.getHours(),
					m: nowDate.getMinutes(),
					s: nowDate.getSeconds()
				}
				this.systemTime = this.systemTime + ' ' + date.h + ':' + date.m + ':' + date.s
				console.log(this.systemTime)
			},
			// 添加收支明细信息
			add(form, forName) {
				this.$refs[forName].validate((valid) => {
					// 添加收支明细信息
					if (valid) {
						// 获取当前系统时间
						this.getNowTime()
						// 找到教师姓名所对应的教师id外键
						this.findTId(this.form.tname);
						this.form.tid = this.t_id;
						this.form.time = this.systemTime
						// this.form.cId = '0',
						// this.form.uId = '0'
						let formData = JSON.stringify(form)
						axios({
								method: "post",
								url: this.$global_msg.adminRoute + "/detailMoney/addDetailMoney",
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
										this.$emit('search', this.currentTime, this.currentTName, this.currentType, this.page, this.limit)
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
					} else {
						return false;
					}
				});

			}
		},
		mounted() {
			this.findTeacher();
		},

	};
</script>

<style scoped>
	.top-search {
		margin-top: 3px;
	}
</style>
