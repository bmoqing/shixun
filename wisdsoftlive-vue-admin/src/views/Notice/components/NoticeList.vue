<template>
	<div>
		<el-table v-loading="loading" element-loading-text="拼命加载中" element-loading-spinner="el-icon-loading" :empty-text="empty_text"
		 element-loading-background="rgba(0, 0, 0, 0.06)" :data="tableData" :height="623" :stripe="true" border>
			<el-table-column prop="id" align="center" label="id" min-width="6%">
			</el-table-column>
			<el-table-column prop="name" :show-overflow-tooltip="true" align="center" label="标题" min-width="12%">
			</el-table-column>
			<el-table-column prop="time" align="center" label="发布时间" min-width="12%">
			</el-table-column>
			<el-table-column prop="content" align="center" label="内容" min-width="12%" :show-overflow-tooltip="true">
				<template slot-scope="scope">
					<el-button @click="openContent(scope.row)" type="primary" plain size="small">查看</el-button>
				</template>
			</el-table-column>
			<el-table-column prop="state" align="center" label="状态" min-width="12%">
				<template slot-scope="scope">
					<div v-if="scope.row.state == 1">
						<span style="color: #409EFF;">启用中</span>
					</div>
					<div v-if="scope.row.state == 0">
						<span style="color: #F56C6C;">禁用中</span>
					</div>
				</template>
			</el-table-column>
			<el-table-column label="操作" align="center" min-width="20%">
				<template slot-scope="scope">
				<!-- 	<el-button @click="
	              dialogFormVisible = true;
				  edit(scope.row,true)
	            " type="primary"
					 plain size="small">查看</el-button> -->
					<el-button type="primary" size="small" @click="
	              dialogFormVisible = true;edit(scope.row,false)
	            "
					 plain>编辑</el-button>
					<el-button type="danger" @click="handleClickDel(scope.row)" size="small" plain>删除</el-button>
				</template>
			</el-table-column>
		</el-table>

		<el-dialog z-index="99" title="提示" :visible.sync="isShowContent" width="80%">
			<div style="width: 932px;margin: 0px auto;">
				<NoticeShow :notice="notice"></NoticeShow>
			</div>
			<span slot="footer" class="dialog-footer">
				<el-button type="primary" @click="isShowContent = false">确 定</el-button>
			</span>
		</el-dialog>

		<el-dialog z-index="1" title="公告信息" :visible.sync="dialogFormVisible" :fullscreen="true" :destroy-on-close="false">
			<el-form :model="form" :rules="rules" ref="ruleForm">
				<el-form-item label="标题" :label-width="formLabelWidth" prop="name">
					<el-input :disabled="disabled" v-model="form.name" autocomplete="off"></el-input>
				</el-form-item>
				<el-form-item label="发布时间" :label-width="formLabelWidth" prop="time">
					<el-date-picker :disabled="disabled" :picker-options="pickerOptions" v-model="form.time" type="date" format="yyyy 年 MM 月 dd 日"
					 value-format="yyyy-MM-dd" placeholder="选择日期" autocomplete="off">
					</el-date-picker>
				</el-form-item>
				<el-form-item label="状态" :label-width="formLabelWidth" prop="state">
					<el-radio-group :disabled="disabled" v-model="form.state">
						<el-radio :label="1">启用</el-radio>
						<el-radio :label="0">禁用</el-radio>
					</el-radio-group>
				</el-form-item>
				<el-form-item label="内容" :label-width="formLabelWidth" prop="content">
					<template>
						<div class="components-container">
							<tinymce-editor ref="editor" :disabled="disabled" v-model="form.content" />
						</div>
					</template>
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
	import TinymceEditor from './TinymceEdit.vue'
	import NoticeShow from './NoticeShow.vue'
	export default {
		name: "NoticeList",
		props: {
			tableData: Array,
			loading:Boolean,
			empty_text: {
				type:String,
				default:" "
			}
		},
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
				disabled: false,
				notice: '',
				isShowContent: false,
				dialogFormVisible: false,
				formLabelWidth: "120px",
				form: {},
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
		methods: {
			yesOrNO(msg, type) {
				this.$message({
					message: msg,
					type: type
				});
			},
			handleClickDel(row) {
				this.$confirm("是否删除公告", "提示", {
					confirmButtonText: "确定",
					cancelButtonText: "取消",
					type: "warning"
				}).then(() => {
					let id = row.id;
					axios.post(this.$global_msg.adminRoute +"/notice/del/" + id)
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
			openContent(notice) {
				this.notice = notice;
				this.isShowContent = true
			},
			edit(row, flag) {
				this.disabled = flag;
				this.form = {
					id: row.id,
					name: row.name,
					content: row.content,
					time: row.time,
					state: row.state
				}
			},
			editNotice() {
				this.$refs['ruleForm'].validate((valid) => {
					if (valid) {
						axios.post(this.$global_msg.adminRoute +"/notice/update", this.form)
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
					} else {
						return false;
					}
				})
			}
		},
		components: {
			TinymceEditor,NoticeShow
		}
	}
</script>

<style scoped>
</style>
