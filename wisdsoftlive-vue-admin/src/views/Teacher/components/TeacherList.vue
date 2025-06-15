<template>
	<div>
		<el-table v-loading="loading" element-loading-text="拼命加载中" element-loading-spinner="el-icon-loading" :empty-text="empty_text"
		 element-loading-background="rgba(0, 0, 0, 0.06)" :data="tableData" :height="623" :stripe="true" border>
			<el-table-column prop="id" align="center" label="id" min-width="6%">
			</el-table-column>
			<el-table-column prop="name" :show-overflow-tooltip="true" align="center" label="姓名" min-width="12%">
			</el-table-column>
			<el-table-column label="操作" align="center" min-width="20%">
				<template slot-scope="scope">
					<el-button type="primary" size="small" @click="
	              dialogFormVisible = true;edit(scope.row,false)
	            "
					 plain>编辑</el-button>
					<el-button type="danger" @click="handleClickDel(scope.row)" size="small" plain>删除</el-button>
				</template>
			</el-table-column>
		</el-table>

		<el-dialog z-index="99" title="提示" @close="close" :visible.sync="isShowContent" width="60%">
			<div v-html="content"></div>
			<span slot="footer" class="dialog-footer">
				<el-button type="primary" @click="isShowContent = false">确 定</el-button>
			</span>
		</el-dialog>

		<el-dialog z-index="1" title="教师信息" :visible.sync="dialogFormVisible" :destroy-on-close="false">
			<el-form :model="form" :rules="rules" ref="ruleForm">
				<el-form-item label="教师姓名" :label-width="formLabelWidth" prop="name">
					<el-input v-model="form.name" autocomplete="off"></el-input>
				</el-form-item>

			</el-form>
			<div slot="footer" class="dialog-footer">
				<el-button @click="dialogFormVisible = false">取 消</el-button>
				<el-button v-if="!disabled" type="primary" @click="editNotice()">确定</el-button>
			</div>
		</el-dialog>
	</div>
</template>

<script>
	import axios from 'axios'

	export default {
		name: "NoticeList",
		props: {
			tableData: Array,
			loading: Boolean,
			empty_text: {
				type: String,
				default: " "
			}
		},
		data() {
			return {
				disabled: false,
				content: '',
				isShowContent: false,
				dialogFormVisible: false,
				formLabelWidth: "120px",
				form: {},
				tmpName:"",
				rules: {
					name: [{
						required: true,
						message: '请输入公告标题',
						trigger: "change"
					}],
				}
			}
		},
		methods: {
			yesOrNO(msg, type) {
				this.$message({
					message: msg,
					type: type
				});
			},
			close(){
				this.tmpName = ""
			},
			handleClickDel(row) {
				this.$confirm("是否删除公告", "提示", {
					confirmButtonText: "确定",
					cancelButtonText: "取消",
					type: "warning"
				}).then(() => {
					let id = row.id;
					axios.post(this.$global_msg.adminRoute +"/teacher/delOneTeacher/" + id)
						.then(res => {
							console.log(res)
							if (res.data.code === 200) {
								this.$emit("del");
								this.yesOrNO("删除成功", "success")
							} else {
								this.yesOrNO("删除失败", "error")
							}
						})
						.catch(e => {
							this.yesOrNO("编辑失败", "error")
						})
				})


			},
			openContent(content) {
				this.content = content;
				this.isShowContent = true
			},
			edit(row, flag) {
				this.disabled = flag;
				this.form = {
					id: row.id,
					name: row.name,
				}
				this.tmpName = this.form.name
			},
			editNotice() {
				console.log(this.tmpName)
				console.log(this.form.name)
				if(this.tmpName === this.form.name){
					this.yesOrNO("名字未改动", "success")
					return
				}
				this.$refs['ruleForm'].validate((valid) => {
					if (valid) {
						axios.get(this.$global_msg.adminRoute +"/teacher/showTeacherByName/" + this.form.name, ).then(res => {
							if (res && res.data) {
								const data = res.data;
								console.log(data);
								this.count = data.count;
								if (data.data !== null) {
									this.yesOrNO("编辑失败,姓名存在", "error")
									return
								} else {
									axios.post(this.$global_msg.adminRoute +"/teacher/updateTeacher", this.form)
										.then(res => {
											if (res.data.code === 200) {
												this.$emit("del");
												this.yesOrNO("编辑成功", "success")
											} else {
												this.yesOrNO("编辑失败", "error")
											}
										})
										.catch(e => {
											this.yesOrNO("编辑失败", "error")
										});
									this.dialogFormVisible = false;
								}
							}
							this.empty_text = "暂无数据"

						})


					} else {
						return false;
					}
				})
			}
		},
		components: {}
	}
</script>

<style scoped>
</style>
