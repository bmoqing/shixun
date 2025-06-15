<template>
	<a-drawer :destroyOnClose="true" title="详情" placement="left" :closable="false" :visible="visible" @close="onClose">
		<a-descriptions :column="1" layout="vertical">
			<a-descriptions-item label="课程名称">
				{{childData.cname}}
			</a-descriptions-item>
			<a-descriptions-item label="课程简介">
				{{childData.content}}
			</a-descriptions-item>
			<a-descriptions-item label="讲师">
				{{childData.tname}}
			</a-descriptions-item>
			<a-descriptions-item label="购买时间">
				{{childData.time}}
			</a-descriptions-item>
			<a-descriptions-item label="购买金额">
				{{childData.money}}元
			</a-descriptions-item>
		</a-descriptions>
	</a-drawer>
</template>

<script>
	export default {
		name: 'ShowDetails',
		props: {
			visible: Boolean,
			childData: Object
		},
		data() {
			return {
			};
		},
		methods: {
			onClose() {
				this.$emit('onClose',{})
			},
			onChange(e) {
				this.placement = e.target.value;
			},
		}
	};
</script>

<style>

</style>
