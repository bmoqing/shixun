<template>
	<div class="top">
		<NoticeShow :notice="notice"></NoticeShow>
	</div>
</template>

<script>
	import NoticeShow from './components/NoticeShow'
	import axios from 'axios'
	export default {
		name: "ShowOne",
		data() {
			return {
				notice: {}
			}
		},
		mounted() {
			this.notice = this.$route.params
			let id = this.$route.params.id;
			if (id <= 0) {
				this.$router.push("/")
			}
			if (this.notice.name == null && id > 0) {
				axios.get(this.$global_msg.userRoute + "/notice/showOne/" + id)
					.then(res => {
						this.notice = res.data.data
					})
			}
			// console.log(this.$route.params.id)
		},
		methods: {

		},
		components:{NoticeShow}
	}
</script>

<style scoped>
	.top {
		height: 100%;
	}

	
</style>
