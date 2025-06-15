<template>
	<div class="con">
		<div class="top">
			<div class="top-search">
				<span>标题</span>
				<el-input v-model="name" prefix-icon="el-icon-search" type="text" placeholder="标题内容" style="width:220px">
				</el-input>
			</div>
			<div class="top-search">
				<span>日期</span>
				<el-date-picker v-model="time" type="date" format="yyyy 年 MM 月 dd 日" value-format="yyyy-MM-dd"
				 placeholder="选择日期">
				</el-date-picker>
			</div>
			<el-button class="searchBtn" @click="handleClickSerachBlurry" type="primary" size="medium" plain>查询</el-button>
			<el-button type="primary" size="medium" @click="dialogFormVisible = true;
	        " plain>添加</el-button>
		</div>

		<el-dialog z-index="1" title="公告" @close="close" @open="open" :visible.sync="dialogFormVisible" :fullscreen="true"
		 :destroy-on-close="false">
			<el-form :model="form" :rules="rules" ref="ruleForm">
				<el-form-item label="标题" :label-width="formLabelWidth" prop="name">
					<el-input v-model="form.name" autocomplete="off"></el-input>
				</el-form-item>
				<el-form-item label="发布时间"  :label-width="formLabelWidth" prop="time">
					<el-date-picker :picker-options="pickerOptions" v-model="form.time" type="date" format="yyyy 年 MM 月 dd 日" value-format="yyyy-MM-dd" placeholder="选择日期"
					 autocomplete="off">
					</el-date-picker>
				</el-form-item>
				<el-form-item label="状态" :label-width="formLabelWidth" prop="state">
					<el-radio-group v-model="form.state">
						<el-radio :label="1">启用</el-radio>
						<el-radio :label="0">禁用</el-radio>
					</el-radio-group>
				</el-form-item>
				<el-form-item label="内容" :label-width="formLabelWidth" prop="content">
					<template>
						<div class="components-container">
							<tinymce-editor ref="editor" v-model="form.content" />

						</div>
					</template>
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
	import TinymceEditor from './TinymceEdit.vue'
	export default {

		name: 'NoticeTop',
		data() {
			return {
				pickerOptions: {
					disabledDate(time) {
						//此条为设置禁止用户选择今天之前的日期，包含今天。
						// return time.getTime() <= (Date.now());
						//此条为设置禁止用户选择今天之前的日期，不包含今天。
						return time.getTime() <= (Date.now() - (24 * 60 * 60 * 1000));
					}
				},
				name: "",
				time: "",
				dialogFormVisible: false,
				form: {
					state: 0
				},
				formLabelWidth: "120px",
				rules: {
					name: [{
						required: true,
						message: '请输入公告标题',
						trigger: "change"
					}],
					time: [{
						required: true,
						message: '请输入发布时间',
						trigger: "change"
					}],
					content: [{
						required: true,
						message: '请输入内容',
						trigger: "change"
					}],
					state: [{
						required: true,
						message: '请选择状态',
						trigger: "change"
					}],
				}
			}
		},
		watch: {
			name: function(val, oldVal) {
				this.changeProps()
			},
			time: function(val, oldVal) {
				this.changeProps()
			}
		},
		methods: {
			yesOrNO(msg,type){
				this.$message({
					message: msg,
					type: type
				});
			},
			close() {
				this.form ={state : 0}
				this.$refs['ruleForm'].clearValidate();
			},
			open() {
				
			},
			//用与模糊查询
			handleClickSerachBlurry() {
				this.$emit("clickSearchBtn");
			},
			changeProps() {
				this.$emit("changeProps", this.name, this.time);
			},
			//添加方法
			addNotice() {
				this.$refs['ruleForm'].validate((valid) => {
					if (valid) {
						let notice = {
							name: this.form.name,
							content: this.form.content,
							time: this.form.time,
							state: this.form.state
						};
						axios.post(this.$global_msg.adminRoute +"/notice/add", notice)
							.then(res => {
								if (res && res.data) {
									this.$emit("clickSearchBtn");
									this.yesOrNO("添加成功","success")
								}
							})
							.catch(e => {
								console.log(e);
								this.yesOrNO("添加成功","error")
							});
						this.dialogFormVisible = false;
					} else {
						return false;
					}

				});
			}
		},
		mounted() {},
		components: {
			TinymceEditor
		}
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
