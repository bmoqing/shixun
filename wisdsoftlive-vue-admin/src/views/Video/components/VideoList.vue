<template>
	<div>
		<el-table :data="tableData" :height="tableHeight" :stripe="true" border :empty-text="dataText" v-loading="loading"
		 element-loading-text="拼命加载中" element-loading-spinner="el-icon-loading" element-loading-background="rgba(0, 0, 0, 0.06)">
			<el-table-column v-if="show" prop="id" align="center" label="id" min-width="6%"></el-table-column>
			<el-table-column v-if="show" prop="tId" align="center" label="老师id" min-width="12%"></el-table-column>
			<el-table-column prop="tName" align="center" label="老师" min-width="7%"></el-table-column>
			<el-table-column prop="courseNumber" align="center" label="视频编号" min-width="12%"></el-table-column>
			<el-table-column prop="imgTop" align="center" label="封面图" min-width="12%">
				<template slot-scope="scope">
					<ShowImg :imgTop="scope.row.imgTop"></ShowImg>
				</template>
			</el-table-column>
			<el-table-column prop="url" align="center" :show-overflow-tooltip="true" label="视频链接" min-width="18%"></el-table-column>
			<el-table-column v-if="show" prop="cId" align="center" label="所属课程id" min-width="12%"></el-table-column>
			<el-table-column prop="cName" align="center" label="所属课程" min-width="10%"></el-table-column>
			<el-table-column label="操作" align="center" min-width="12%">
				<template slot-scope="scope">
					<el-button size="small" type="primary" plain @click="
							dialogFormVisible = true;
							handleEdit(scope.row);
						">
						编辑
					</el-button>
					<el-button size="small" @click="removeVideo(scope.row)" type="danger" plain>删除</el-button>
				</template>
			</el-table-column>
		</el-table>
		<el-dialog title="视频信息" :visible.sync="dialogFormVisible" @open="dialogOpen">
			<el-form :model="form" :rules="rules" ref="form">
				<el-form-item label="老师" :label-width="formLabelWidth" prop="tName">
					<el-select ref="tSelect" v-model="form.tName">
						<el-option v-for="item in teachers" :key="item.id" :label="item.name" :value="item.name"></el-option>
					</el-select>
				</el-form-item>
				<el-form-item label="所属课程" :label-width="formLabelWidth" prop="cName">
					<el-select ref="cSelect" v-model="form.cName">
						<el-option v-for="item in courses" :key="item.id" :label="item.name" :value="item.name"></el-option>
					</el-select>
				</el-form-item>
				<el-form-item label="封面图" :label-width="formLabelWidth" prop="imgTop">
					<el-upload class="avatar-uploader" ref="upload" :action="uploadUrl" :show-file-list="false" :before-upload="beforeUpload"
					 :on-change="handleChange" :auto-upload="false" :on-success="handleAvatarSuccess" :data="{ id: form.id }">
						<el-image v-if="form.imgTop" :src="form.imgTop" class="avatar"></el-image>
						<i v-else class="el-icon-plus avatar-uploader-icon"></i>
					</el-upload>
				</el-form-item>
				<el-form-item label="视频编号" :label-width="formLabelWidth" class="widthControl" prop="courseNumber">
					<el-input v-model="form.courseNumber" autocomplete="off"></el-input>
				</el-form-item>

				<el-form-item label="视频链接" :label-width="formLabelWidth" class="widthControl" prop="url">
					<el-input v-model="form.url" autocomplete="off"></el-input>
				</el-form-item>
			</el-form>
			<div slot="footer" class="dialog-footer">
				<el-button @click="dialogFormVisible = false">取 消</el-button>
				<el-button type="primary" @click="videoUpload()">确 定</el-button>
			</div>
		</el-dialog>
	</div>
</template>

<script>
	import axios from 'axios';
	import ShowImg from './ShowImg.vue';
	export default {
		name: 'VideoList',
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
				teachers: {},
				courses: {},
				formLabelWidth: '120px',
				rules: {
					tName: [{
						required: true,
						message: '请选择老师',
						trigger: 'change'
					}],
					cName: [{
						required: true,
						message: '请选择课程',
						trigger: 'change'
					}],
					imgTop: [{
						required: true,
						message: '请上传图片',
						trigger: 'change'
					}],
					courseNumber: [{
						required: true,
						message: '请填入地址',
						trigger: 'change'
					}],
					url: [{
						required: true,
						message: '请输入活动名称',
						trigger: 'change'
					}]
				},
				uploadUrl: this.$global_msg.adminRoute + "/video/updateImg"
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
				this.form.imgTop = URL.createObjectURL(file.raw);
			},
			handleAvatarSuccess() {
				this.myMessage('上传成功', 'success');
				this.$refs.upload.clearFiles();
			},
			//修改
			handleEdit(row) {
				this.form = row;
			},
			dialogOpen() {
				this.findTeacher();
				this.findCourse();
			},
			findTeacher() {
				axios
					.get(this.$global_msg.adminRoute + '/teacher/select')
					.then(res => {
						this.teachers = res.data.data;
					})
					.catch(response => {
						console.log(response);
					});
			},
			findCourse() {
				axios
					.get(this.$global_msg.adminRoute + '/course/select')
					.then(res => {
						this.courses = res.data.data;
					})
					.catch(response => {
						console.log(response);
					});
			},
			submitData() {
				let videoVo = {
					id: this.form.id,
					tName: this.$refs.tSelect.selectedLabel,
					cName: this.$refs.cSelect.selectedLabel,
					courseNumber: this.form.courseNumber,
					url: this.form.url
				};
				axios
					.post(this.$global_msg.adminRoute + '/video/updateData', videoVo)
					.then(a => {
						console.log(a);
					})
					.catch(e => {
						console.log(e);
					});
			},
			videoUpload() {
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
			removeVideo(row) {
				this.$confirm('是否删除该视频信息', '提示', {
						confirmButtonText: '确定',
						cancelButtonText: '取消',
						type: 'warning'
					})
					.then(() => {
						axios
							.post(this.$global_msg.adminRoute + '/video/delete/' + row.id)
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
