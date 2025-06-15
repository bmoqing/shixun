<template>
	<div style="display: inline; margin: 0 8px; margin-left: 4px;">
		<el-button size="small" type="primary" plain @click="open">查看</el-button>
		<el-dialog title="封面图预览" :visible.sync="dialogVisible" width="40%">
			<el-tooltip style="max-width: 300px;" v-if="url" content="点击查看大图" placement="right">
				<el-image class="my-image" :src="url" :preview-src-list="imgArray"></el-image>
			</el-tooltip>
			<!-- <el-tooltip v-if="url" content="点击查看大图" placement="right"> -->

			<el-image v-else class="my-image" :src="url" :preview-src-list="imgArray"></el-image>
		</el-dialog>
	</div>
</template>

<script>
	export default {
		name: 'ShowImg',
		props: {
			id: Number,
			url: ""
		},
		data() {
			return {
				dialogVisible: false,
				imgArray: []
			};
		},
		methods: {
			open() {
				this.dialogVisible = true;
				this.imgArray.push(this.url)
			}
		}
	};
</script>

<style scoped="scoped">
	.my-image {
		margin: 20px;
	}
</style>
