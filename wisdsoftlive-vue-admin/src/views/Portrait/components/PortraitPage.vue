<template>
	<div>
		<el-pagination
			@size-change="handleSizeChange"
			@current-change="handleCurrentChange"
			:current-page="page"
			:page-sizes="[10, 20, 30, 40]"
			layout="total, sizes, prev, pager, next, jumper"
			:total="total"
		></el-pagination>
	</div>
</template>

<script>
export default {
	name: 'PortraitPage',
	props: {
		total: Number,
		page: Number,
		limit: Number
	},
	data() {
		return {
			currPage: this.page,
			currLimit: this.limit,
		};
	},
	methods: {
		//修改每页条数
		handleSizeChange(val) {
			this.currLimit = val;
			this.currPage = 1;
			this.changePOrL();
		},
		//换页
		handleCurrentChange(val) {
			this.currPage = val;
			this.changePOrL();
		},
		//调用父组件，渲染list
		changePOrL() {
			this.$emit('changePOrL', this.currPage, this.currLimit);
		}
	},
	mounted() {
		this.changePOrL();
	}
};
</script>

<style>
	
</style>
