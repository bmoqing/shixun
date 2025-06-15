<template>
	<div>
		<el-button size="small" type="primary" plain @click="open">查看</el-button>
		<el-dialog title="封面图预览" :visible.sync="dialogVisible" width="40%">
			<el-tooltip v-if="imgTop" content="点击查看大图" placement="right">
			  <el-image class="my-image" :src="imgTop" :preview-src-list="imgArray"></el-image>
			</el-tooltip>
			<el-image v-else class="my-image" :src="imgTop" :preview-src-list="imgArray"></el-image>
		</el-dialog>
	</div>
</template>

<script>
export default {
	name: 'ShowImg',
	props: {
		imgTop: String
	},
	data() {
		return {
			dialogVisible: false,
			imgArray:[]
		};
	},
	methods: {
		open() {
			this.dialogVisible = true;
			this.imgArray.push(this.imgTop)
		}
	}
};
</script>

<style scoped="scoped">
	.my-image{
		margin: 20px;
	}
</style>
