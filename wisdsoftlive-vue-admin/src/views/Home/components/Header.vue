<template>
	<div>
		<div class="icon-div" @click="change1()">
			<i class="el-icon-s-fold icon" v-if="isIcon"></i>
			<i class="el-icon-s-unfold icon" v-else></i>
		</div>
		<div>
		<span style="color: #97a8be;">{{ cur.meta.title }}</span>
		</div>
	</div>
</template>

<script>
export default {
	data() {
		return {
			isIcon: true
		};
	},
	computed: {
		cur() {
			return this.$route;
		}
	},
	methods: {
		change1() {
			this.isIcon = !this.isIcon;
			this.$emit('change');
		}
	}
};
</script>

<style>
.icon-div {
	height: 50px;
	width: 50px;
	float: left;
	line-height: 55px;
	cursor: pointer;
	text-align: center;
}
.icon-div:hover {
	background-color: rgba(0, 0, 0, 0.025);
}
.icon {
	font-size: 26px;
	line-height: 50px;
}
</style>
