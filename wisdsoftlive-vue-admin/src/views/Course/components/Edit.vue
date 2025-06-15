<template>
	<div>
		<!-- 编辑课程信息 -->
		<el-dialog title="课程信息" :visible.sync="dialogFormVisible" @close="empty()">
			<el-form :model="form" :rules="rules" ref="form" class="demo-ruleForm">
				<el-form-item label="课程名称" :label-width="formLabelWidth" prop="name">
					<el-input v-model="form.name" autocomplete="off" @blur="isNameChanged(form.name)"></el-input>
				</el-form-item>
				<el-form-item label="课程介绍" :label-width="formLabelWidth" prop="content">
					<el-input v-model="form.content" autocomplete="off"></el-input>
				</el-form-item>
				<el-form-item label="课程节数" :label-width="formLabelWidth" prop="sectionNumber">
					<el-input v-model.number="form.sectionNumber" autocomplete="off"></el-input>
				</el-form-item>
				<el-form-item label="是否收费" :label-width="formLabelWidth" placement="top" prop="type">
					<!-- <el-tooltip :content="'Switch value: ' + form.type"> -->
						<el-radio-group style="margin-left: -395px;" v-model="form.type" @change="changeType(form.type)">
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
				<el-button type="primary" @click="update(form,'form')">确 定</el-button>
			</div>
		</el-dialog>

		<!-- 编辑按钮 -->
		<el-button size="small" type="primary" plain @click="
		    handleEdit(scope);
		    dialogFormVisible = true;
		  ">编辑</el-button>

	</div>
</template>

<script>
	import axios from 'axios';
	export default {
		name: 'Edit',
		data() {
			return {
				form: {
					name: "",
					content: "",
					type: 0,
					oldMoney: 0.00,
					inMoney: 0.00,
					outMoney: 0.00
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
					type: [{
						required: true,
						message: '请至少选择一个收费类型',
						trigger: 'change'
					}],
					oldMoney: [{
						required: true,
						message: '请输入金额',
						trigger: 'change'
					}],
					inMoney: [{
						required: true,
						message: '请输入金额',
						trigger: 'change'
					}],
					outMoney: [{
						required: true,
						message: '请输入金额',
						trigger: 'change'
					}],
				},
				// 金额框是否可填
				typeJudge: false,
				formLabelWidth: "120px",
				dialogFormVisible: false,
				// 新的名字
				newName: "",
				// 旧的名字
				oldName: "",
				// 最之前获得的名字
				olderName: ""
			};
		},
		props: {
			page: Number,
			limit: Number,
			scope: {}
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
				this.form = {}
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
			isNameChanged(newName) {
				// 若查询时名字改变了, 并且与最开始获得的name值不相等,则查询新的课程名是否已存在
				if(newName != this.oldName && this.olderName != newName) {
					// 查询新的课程名是否已存在
					this.checkName(newName)
					// 将旧的值重置
					this.oldName = newName
				}
			},
			// 点击编辑课程信息按钮时获得当前行的数据
			handleEdit(row) {
				this.form = row;
				this.oldName = row.name;
				this.olderName = row.name
				if (row.type == 0) {
					this.typeJudge = true;
				} else {
					this.typeJudge = false;
				}
			},
			// 提交编辑课程信息
			update(form,forName) {
				console.log("表单 : " + form )
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
						console.log(formData)
						axios({
							    method:"post",
							    url: this.$global_msg.adminRoute + "/course/updateCourse",
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
										message: "信息修改成功!",
									});
									// 查询数据
									this.$emit('showList', this.name, this.page, this.limit)
								} else {
									this.$message({
										type: "error",
										message: "修改失败!",
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
				
			},
		},
		// mounted() {
		// 	this.$refs['form'].clearValidate();
		// }
	};
</script>

<style scoped>
</style>
