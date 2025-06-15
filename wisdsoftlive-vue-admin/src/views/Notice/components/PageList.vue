<template>
	<el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="currentPage"
	 :page-sizes="[10, 20, 30, 40]" :page-size="100" layout="total, sizes, prev, pager, next, jumper" :total="count">
	</el-pagination>

</template>

<script>
	export default {
		name: "PageList",
		props: {
			currentPage: {
				type: Number,
				default: 1
			},
			count: {
				type: Number,
				default: 10
			}
		},
		data() {
			return {
			}
		},
		methods: {
			handleSizeChange(val) {
				this.$emit('changePage', this.currentPage, val);
				console.log(`每页 ${val} 条`);
			},
			handleCurrentChange(val) {
				this.$emit('changePage', val, this.page_size);
				console.log(`当前页: ${val}`);
			},
		}
	}
</script>

<style scoped>
</style>
