<template>
	<div>
		<el-table :data="tableData" :height="tableHeight" :stripe="true" border :empty-text="dataText" v-loading="loading"
		 element-loading-text="拼命加载中" element-loading-spinner="el-icon-loading" element-loading-background="rgba(0, 0, 0, 0.06)">
			<el-table-column v-if="show" prop="id" align="center" label="id" min-width="6%"></el-table-column>
			<el-table-column prop="name" align="center" label="头像名称" min-width="7%"></el-table-column>
			<el-table-column prop="img" align="center" label="头像" min-width="12%">
				<template slot-scope="scope">
					<ShowImg :imgTop="scope.row.img"></ShowImg>
				</template>
			</el-table-column>
			<el-table-column label="操作" align="center" min-width="12%">
				<template slot-scope="scope">
					<el-button size="small" type="primary" plain @click="
							dialogFormVisible = true;
							handleEdit(scope.row);
						">
						编辑
					</el-button>
					<el-button size="small" @click="removePortrait(scope.row)" type="danger" plain>删除</el-button>
				</template>
			</el-table-column>
		</el-table>
		<el-dialog title="头像信息" :visible.sync="dialogFormVisible">
			<el-form :model="form" ref="form">
				<el-form-item label="头像名称" :label-width="formLabelWidth" class="widthControl">
					<el-input v-model="form.name" autocomplete="off"></el-input>
				</el-form-item>
				<el-form-item label="头像" :label-width="formLabelWidth">
					<el-upload class="avatar-uploader" ref="upload" :action="uploadUrl" :show-file-list="false" :before-upload="beforeUpload"
					 :on-change="handleChange" :auto-upload="false" :on-success="handleAvatarSuccess" :data="{ id: form.id }">
						<el-image v-if="form.img" :src="form.img" class="avatar"></el-image>
						<i v-else class="el-icon-plus avatar-uploader-icon"></i>
					</el-upload>
				</el-form-item>
			</el-form>
			<div slot="footer" class="dialog-footer">
				<el-button @click="dialogFormVisible = false">取 消</el-button>
				<el-button type="primary" @click="portraitUpload()">确 定</el-button>
			</div>
		</el-dialog>
	</div>
</template>

<script>
	import axios from 'axios';
	import ShowImg from '../../Video/components/ShowImg.vue';
	export default {
		name: 'PortraitList',
		components: {
			ShowImg
		},
		props: {
			tableData: Array,
			total: Number,
			dataText: String,
			loading: Boolean
		},
		data() {
			return {
				show: false,
				tableHeight: 500,
				dialogFormVisible: false,
				form: {},
				formLabelWidth: '120px',
				uploadUrl: this.$global_msg.adminRoute + "/portrait/updateImg"
			};
		},
		methods: {
			myMessage(message, type) {
				this.$message({
					message: message,
					type: type
				});
			},
			beforeUpload(file) {
				return true;
			},
			handleChange(file, fileList, name) {
				this.form.img = URL.createObjectURL(file.raw);
			},
			handleAvatarSuccess() {
				this.myMessage('上传成功', 'success');
				this.$refs.upload.clearFiles();
			},
			//修改
			handleEdit(row) {
				this.form = row;
			},
			submitData() {
				let portraitEntity = {
					id: this.form.id,
					name: this.form.name
				};
				axios
					.post(this.$global_msg.adminRoute + '/portrait/updateData', portraitEntity)
					.then(a => {
						console.log(a);
					})
					.catch(e => {
						console.log(e);
					});
			},
			portraitUpload() {
				this.$refs['form'].validate(valid => {
					if (valid) {
						this.$refs.upload.submit();
						this.submitData();
						this.dialogFormVisible = false;
						this.myMessage('修改成功', 'success');
					} else {
						return false;
					}
				});
			},
			removePortrait(row) {
				this.$confirm('是否删除该头像', '提示', {
						confirmButtonText: '确定',
						cancelButtonText: '取消',
						type: 'warning'
					})
					.then(() => {
						axios
							.post(this.$global_msg.adminRoute + '/portrait/delete/' + row.id)
							.then(res => {
								this.$emit('remove');
								this.myMessage('删除成功', 'success');
							})
							.catch(response => {
								console.log(response);
								this.myMessage('删除失败', 'error');
							});
					})
					.catch(() => {
						this.$message({
							type: 'info',
							message: '已取消删除'
						});
					});
			}
		}
	};
</script>

<style scoped="scoped">
	.avatar-uploader-icon {
		font-size: 28px;
		color: #8c939d;
		width: 178px;
		height: 178px;
		line-height: 178px;
		text-align: center;
		border: 1px #b5b5b5 dashed;
	}

	.avatar {
		width: 250px;
	}

	.widthControl {
		width: 80%;
	}
</style>
