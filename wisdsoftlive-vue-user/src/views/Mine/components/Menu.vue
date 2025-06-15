<template>
	<div class="my-menu" ref="menu">
		<router-link to="/mine/personal">
			<div :class="this.path === '/mine/personal' ? this.change : this.nochange">
				<a-icon type="user" />
				个人资料
			</div>
		</router-link>
		<router-link to="/mine/live">
			<div :class="this.path === '/mine/live' ? this.change : this.nochange">
				<a-icon type="book" />
				我的课程
			</div>
		</router-link>
		<router-link to="/mine/video">
			<div :class="this.path === '/mine/video' ? this.change : this.nochange">
				<a-icon type="video-camera" />
				我的视频
			</div>
		</router-link>
		<div :class="this.nochange" style="cursor: pointer;" @click="exit">
			<a-icon type="redo" />
			退出
		</div>
	</div>
</template>

<script>
	// import cookie from '@/src/js/cookie.js'
	import cookie from '../../../js/cookie.js'
	import Bus from '../../../js/bus.js'
	export default {
		name: 'Menu',
		data() {
			return {
				change: "my-menu-child-change",
				nochange: "my-menu-child"
			}
		},
		computed: {
			path: function() {
				return this.$route.path
			}
		},
		methods:{
			exit(){
				// cookie.removeCookie('email');
				this._local.remove("email")
				this.$store.commit('clearUser')
				Bus.$emit('exit', false)
				this.$router.push('/');
				this.$message.success("退出成功")
			}
		}
	};
</script>

<style scoped="scoped">
	.my-menu {
		margin-top: 24px;
		width: 240px;
		margin-right: 24px;
	}

	i {
		font-size: 18px;
		margin-right: 5px;
	}

	.my-menu-child {
		width: 240px;
		height: 48px;
		padding: 14px 18px;
		font-size: 14px;
		color: rgb(146, 146, 146);
		border-radius: 5px;
	}

	.my-menu-child-change {
		width: 240px;
		height: 48px;
		padding: 14px 18px;
		font-size: 14px;
		color: #2db55d;
		background-color: #ededed;
		border-radius: 5px;
	}

	.my-menu-child:hover {
		background-color: #ededed;
	}
</style>
