<template>
	<div>
		<el-form>
			<!-- 编辑课程信息 -->
			<el-dialog width="40%" title="编辑封面图" :visible.sync="dialogFormVisible" >
				<el-form-item label="id" :label-width="formLabelWidth" prop="content" v-if="false">
					<el-input v-model="form.id" autocomplete="off"></el-input>
				</el-form-item>
				<el-form-item  v-if="this.flag" ref="form" :label-width="formLabelWidth" prop="url">
					<el-upload class="avatar-uploader" ref="upload" 
					 :action = "imgUrl"
					 :show-file-list="false"
					 :before-upload="beforeUpload" 
					 :on-change="handleChange" 
					 :auto-upload="false" 
					 :on-success="handleAvatarSuccess"
					 :data="{ 
						 id: this.$props.id,
					  }">
						<el-tooltip content="上传图片" placement="right">
							<el-image v-if="this.url" :src="this.$props.url" class="avatar"></el-image>
							<i v-else class="el-icon-plus avatar-uploader-icon"></i>
						</el-tooltip>
					</el-upload>
				</el-form-item>
				<el-form-item  v-else-if="!this.flag" ref="form" :label-width="formLabelWidth" prop="this.tempUrl">
					<el-upload class="avatar-uploader" ref="upload" 
					 :action= this.$global_msg.adminRoute + "/liveCourse/EditImg" 
					 :show-file-list="false"
					 :before-upload="beforeUpload" 
					 :on-change="handleChange" 
					 :auto-upload="false" 
					 :on-success="handleAvatarSuccess"
					 :data="{ 
						 id: this.$props.id,
					  }">
						<el-tooltip content="上传图片" placement="right">
							<el-image v-if="this.tempUrl" :src="this.tempUrl" class="avatar"></el-image>
							<i v-else class="el-icon-plus avatar-uploader-icon"></i>
						</el-tooltip>
					</el-upload>
				</el-form-item>
				<div slot="footer" class="dialog-footer">
					<el-button @click="dialogFormVisible = false">取 消</el-button>
					<el-button type="primary" @click="uploadImg()">确 定</el-button>
				</div>
			</el-dialog>

		</el-form>

		<el-button size="small" type="success" plain @click="
		    dialogFormVisible = true;
		  ">编辑</el-button>
	</div>
</template>

<script>
	import axios from 'axios';
	import ShowImg from './ShowImg.vue';
	import EditImg from './EditImg.vue';
	export default {
		name: 'List',
		data() {
			return {
				tempUrl: '',
				formLabelWidth: '120px',
				dialogFormVisible: false,
				flag: true,
				imgUrl: this.$global_msg.adminRoute + "/liveCourse/EditImg"
			};
		},
		components: {
			ShowImg,
			EditImg
		},
		props: {
			id: Number,
			url: String,
			page: Number,
			limit: Number,
			tName: String,
			cName: String
		},
		methods: {
			handleAvatarSuccess() {
				this.$refs.upload.clearFiles();
			},
			beforeUpload(file) {
				return true;
			},
			//上传前，展示图片
			handleChange(file, fileList, name) {
				this.tempUrl = URL.createObjectURL(file.raw);
				this.flag = false
			},
			// 上传图片
			uploadImg() {
				this.$refs.upload.submit()
				this.dialogFormVisible = false;
			},
			// 上传成功后的回调函数
			handleAvatarSuccess(res) {
				if(res.code == 200) {
					this.$message({
						type: "success",
						message: "上传成功!",
					});
				} else {
					this.$message({
						type: "error",
						message: "上传失败!",
					});
				}
				this.$emit('showListCount', this.tName, this.cName, this.page, this.limit)
			},
			// // 销毁方法
			// dialogClose() {
			// 	this.form.url = '';
			// 	this.form.id = ''
			// },
		},
		created() {
			
			// 初始化表单中的id与url封面图
			// this.form.id = this.id
			// this.form.url = this.url
		},
		mounted() {
			
			// this.form.id = this.$props.id
			
			// this.form.url = this.$props.url
			// console.log("图片路径为: " + this.form.url)
		}

	};
</script>

<style scoped="scoped">
	.avatar {
		width: 250px;
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

	.avatar-uploader {
		width: 320px;
	}
</style>
