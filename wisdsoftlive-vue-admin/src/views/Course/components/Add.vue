<template>
	<div class="top-search">
		<!-- 添加课程信息 -->
		<el-dialog title="课程信息" :visible.sync="dialogFormVisible" @close="empty()">
			<el-form :model="form" :rules="rules" ref="form" class="demo-ruleForm">
				<el-form-item label="课程名称" :label-width="formLabelWidth" prop="name">
					<el-input v-model="form.name" autocomplete="off" @blur="checkName(form.name)"></el-input>
				</el-form-item>
				<el-form-item label="课程介绍" :label-width="formLabelWidth" prop="content">
					<el-input v-model="form.content" autocomplete="off"></el-input>
				</el-form-item>
				<el-form-item label="课程节数" :label-width="formLabelWidth" prop="sectionNumber">
					<el-input v-model.number="form.sectionNumber" autocomplete="off"></el-input>
				</el-form-item>
				<el-form-item label="是否收费" :label-width="formLabelWidth" placement="top" prop="type">
					<!-- <el-tooltip :content="'Switch value: ' + form.type"> -->
						<el-radio-group v-model="form.type" @change="changeType(form.type)">
							<el-radio :label="1">收费</el-radio>
							<el-radio :label="0">免费</el-radio>
						</el-radio-group>
					<!-- </el-tooltip> -->
				</el-form-item>
				<el-form-item label="折前价格" :label-width="formLabelWidth" prop="oldMoney">
					<el-input :disabled="typeJudge" v-model.number="form.oldMoney" autocomplete="off"></el-input>
				</el-form-item>
				<el-form-item label="校内人员价格" :label-width="formLabelWidth" prop="inMoney">
					<el-input :disabled="typeJudge" v-model.number="form.inMoney" autocomplete="off"></el-input>
				</el-form-item>
				<el-form-item label="校外人员价格" :label-width="formLabelWidth" prop="outMoney">
					<el-input :disabled="typeJudge" v-model.number="form.outMoney" autocomplete="off"></el-input>
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
			page: Number,
			limit: Number,
			name: String
		},
		data() {
			return {
				formLabelWidth: "120px",
				dialogFormVisible: false,
				form: {
					name: "",
					content: "",
					type: "0",
					oldMoney: 0.00,
					inMoney: 0.00,
					outMoney: 0.00,
					status: 0
				},
				// 表单验证
				rules: {
					name: [{
						required: true,
						message: '请输入课程名称',
						trigger: 'change'
					}, ],
					content: [{	
						required: true,
						message: '请输入课程介绍',
						trigger: 'change'
					}, ],
					sectionNumber: [{
						required: true,
						message: '请输入课程节数',
						trigger: 'change'
					},{
						type: 'number',
						message: '请输入数字类型',
						trigger: 'change'
					}],
					type: [{
						required: true,
						message: '请至少选择一个收费类型',
						trigger: 'change'
					}],
					oldMoney: [{
						required: true,
						message: '请输入金额',
						trigger: 'change'
					},{
						type: 'number',
						message: '请输入数字类型',
						trigger: 'change'
					}],
					inMoney: [{
						required: true,
						message: '请输入金额',
						trigger: 'change'
					},{
						type: 'number',
						message: '请输入数字类型',
						trigger: 'change'
					}],
					outMoney: [{
						required: true,
						message: '请输入金额',
						trigger: 'change'
					},{
						type: 'number',
						message: '请输入数字类型',
						trigger: 'change'
					}],
				},
				// 金额框是否可填
				typeJudge: false,
			}
		},
		methods: {
			// 改变收费类型的判断
			changeType(type) {
				if (type == 0) {
					this.form.oldMoney = 0.00;
					this.form.inMoney = 0.00;
					this.form.outMoney = 0.00;
					this.typeJudge = true;
				} else {
					this.typeJudge = false;
				}
			},
			// 取消添加或者添加成功后将form中的数据清空
			empty() {
				this.form.name =  "",
				this.form.content =  "",
				this.form.type =  "0",
				this.form.oldMoney =  0.00,
				this.form.inMoney =  0.00,
				this.form.outMoney =  0.00
				this.form.status = "0"
				this.form.sectionNumber = ""
				this.$refs['form'].clearValidate();
			},
			// 验证该课程是否已存在
			checkName(name) {
				if (name != "") {
					axios.get(this.$global_msg.adminRoute + '/course/existCourse/' + name)
						.then((res) => {
							if (res.data.code == 500) {
								// message: '该课程名已存在, 请重新输入',
								this.$message({
									type: "error",
									message: "该课程名已存在, 请重新输入!",
								});
							} else {
								this.$message({
									type: "success",
									message: "该课程名可用!",
								});
							}
						}).catch((response) => {
							console.log(response);
						})
				}

			},
			// 添加课程信息
			add(form, forName) {
				this.$refs[forName].validate((valid) => {
					// 添加课程信息
					if (valid) {
						/* formData格式提交： */
						// let formData = new FormData();
						// for(var key in form){
						// 	console.log(form[key])
						// 	formData.append(key,form[key]);
						// }
						let formData = JSON.stringify(form)
						
						axios({
							    method:"post",
							    url:this.$global_msg.adminRoute + "/course/addCourse",
							    headers: {
								  // "Content-Type": "formData;charset=UTF-8"
								  'Content-Type': 'application/json;charset=UTF-8',
							    },
							    data:formData
							})
							.then((res) => {
								if (res.data.code == 200) {
									this.$message({
										type: "success",
										message: "课程信息添加成功!",
									});
									setTimeout(()=>{   //设置延迟执行
									    // 展示分页数据
									    this.$emit('showData', this.name, this.page, this.limit)
									},1200);

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
						console.log('error submit!!');
						return false;
					}
				});

			}
		},
		mounted() {
			// 因为初始添加时默认为不收费, 所以费用禁止添加
			this.typeJudge = true;
			this.form.type = 0
		},

	};
</script>

<style scoped>
	.top-search {
		margin-top: 3px;
	}
</style>
