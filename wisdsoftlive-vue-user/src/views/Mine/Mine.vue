<template>
	<div class="page">
		<Menu></Menu>
		<router-view></router-view>
	</div>
</template>

<script>
	import Menu from './components/Menu.vue'
	export default {
		name: 'Mine',
		components: {
			Menu
		},
		data() {
			return {};
		},
		mounted() {
			
			if (!this._local.get("email")) {
				this.$router.push('/')
				return;
			} else {
				var user = this._local.get("email")
				this.$store.commit('setUser', user)
			}
		}
	};
</script>

<style>
	body {
		background: rgb(247, 247, 247);
	}

	.page {
		padding: 0 36px;
		display: flex;
	}
</style>
