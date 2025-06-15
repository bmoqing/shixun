<template>
	<div class="con">
		<div class="top">
			<div class="top-search">
				<span>名称</span>
				<el-input class="el-input" v-model="name" prefix-icon="el-icon-search" type="text" placeholder="头像名称"></el-input>
			</div>
			<el-button class="searchBtn" @click="search()" type="primary" size="medium" plain>查询</el-button>
			<el-button type="primary" @click="addPortrait()" size="medium" plain>添加</el-button>
		</div>
		<el-dialog title="头像信息" :visible.sync="dialogFormVisible" @close="dialogClose">
			<el-form :model="form" ref="form">
				<el-form-item label="头像名称" :label-width="formLabelWidth" class="widthControl">
					<el-input v-model="form.name" autocomplete="off"></el-input>
				</el-form-item>
				<el-form-item label="头像" :label-width="formLabelWidth">
					<el-upload class="avatar-uploader" ref="upload" :action="uploadUrl" :show-file-list="false" :before-upload="beforeUpload"
					 :on-change="handleChange" :auto-upload="false" :on-success="handleAvatarSuccess" :data="{ portraitJson: JSON.stringify(form) }">
						<el-tooltip content="上传头像" placement="right">
							<el-image v-if="form.img" :src="form.img" class="avatar"></el-image>
							<i v-else class="el-icon-plus avatar-uploader-icon"></i>
						</el-tooltip>
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
	export default {
		name: 'PortraitTop',
		data() {
			return {
				name: '',
				dialogFormVisible: false,
				form: {
					name: '',
					img: ''
				},
				formLabelWidth: '120px',
				uploadUrl: this.$global_msg.adminRoute + "/portrait/add"
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
				this.$emit('search', this.name);
			},
			addPortrait() {
				this.dialogFormVisible = true;
			},
			//上传前，展示图片
			handleChange(file, fileList, name) {
				this.form.img = URL.createObjectURL(file.raw);
			},
			beforeUpload(file) {
				return true;
			},
			handleAvatarSuccess() {
				this.$refs.upload.clearFiles();
				this.$emit('reload');
			},
			dialogClose() {
				this.form.name = '';
				this.form.img = '';
				this.$refs['form'].clearValidate();
			},
			portraitUpload() {
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
			changeName() {
				this.$emit('changeName', this.name);
			}
		},
		watch: {
			name: function() {
				this.$emit('changeName', this.name);
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
