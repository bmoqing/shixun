<template>
	<div class="con">
		<div class="top">
			<div class="top-search">
				<span>老师</span>
				<el-input class="el-input" v-model="tValue" prefix-icon="el-icon-search" type="text" placeholder="老师名称"></el-input>
			</div>
			<div class="top-search">
				<span>课程</span>
				<el-input class="el-input" v-model="cValue" prefix-icon="el-icon-search" type="text" placeholder="所属课程"></el-input>
			</div>
			<el-button class="searchBtn" @click="search()" type="primary" size="medium" plain>查询</el-button>
			<el-button type="primary" @click="addVideo()" size="medium" plain>添加</el-button>
		</div>
		<el-dialog title="视频信息" :visible.sync="dialogFormVisible" @close="dialogClose" @open="dialogOpen">
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
					 :on-change="handleChange" :auto-upload="false" :on-success="handleAvatarSuccess" :data="{ videoVoJson: JSON.stringify(form) }">
						<el-tooltip content="上传图片" placement="right">
							<el-image v-if="form.imgTop" :src="form.imgTop" class="avatar"></el-image>
							<i v-else class="el-icon-plus avatar-uploader-icon"></i>
						</el-tooltip>
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
	export default {
		name: 'VideoTop',
		data() {
			return {
				tValue: '',
				cValue: '',
				dialogFormVisible: false,
				form: {
					tName: '',
					cName: '',
					imgTop: '',
					courseNumber: '',
					url: ''
				},
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
				uploadUrl: this.$global_msg.adminRoute + "/video/add"
			};
		},
		methods: {
			myMessage(message, type) {
				this.$message({
					message: message,
					type: type
				});
			},
			//调用父组件查询
			search() {
				this.$emit('search', this.tValue, this.cValue);
			},
			addVideo() {
				this.dialogFormVisible = true;
			},
			//上传前，展示图片
			handleChange(file, fileList, name) {
				this.form.imgTop = URL.createObjectURL(file.raw);
			},
			beforeUpload(file) {
				return true;
			},
			handleAvatarSuccess() {
				this.$refs.upload.clearFiles();
				this.$emit('reload');
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
			dialogOpen() {
				this.findTeacher();
				this.findCourse();
			},
			dialogClose() {
				this.form.tName = '';
				this.form.cName = '';
				this.form.imgTop = '';
				this.form.courseNumber = '';
				this.form.url = '';
				this.$refs['form'].clearValidate();
			},
			videoUpload() {
				this.$refs['form'].validate(valid => {
					if (valid) {
						this.$refs.upload.submit();
						this.dialogFormVisible = false;
						this.myMessage('添加成功', 'success');
					} else {
						return false;
					}
				});
			},
			changeTOrC() {
				this.$emit('changeTOrC', this.tValue, this.cValue);
			}
		},
		watch: {
			tValue: function() {
				this.changeTOrC();
			},
			cValue: function() {
				this.changeTOrC();
			}
		}
	};
</script>

<style scoped="scoped">
	.con {
		padding: 10px;
	}

	.top {
		display: flex;
		margin-bottom: 10px;
		height: 40px;
	}

	.top .top-search {
		margin-right: 20px;
	}

	.top-search>.el-input {
		width: 220px;
	}

	.top span {
		color: rgb(102, 102, 102);
		margin-right: 10px;
	}

	.top .searchBtn {
		margin-right: 30px;
	}

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
