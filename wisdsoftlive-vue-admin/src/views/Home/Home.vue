<template>
	<el-container style="height:100%; ">
		<el-aside height="100vh" width="none!important;"><Menu :isOpen="!isOpen"></Menu></el-aside>
		<el-container>
			<el-header>
				<Header @change="openOrClose"></Header>
			</el-header>
			<el-main>
					<transition name="fade-transform" mode="out-in">
						<router-view :key="key"></router-view>
					</transition>
			</el-main>
		</el-container>
	</el-container>
</template>
<script>
import Menu from './components/Menu.vue';
import Header from './components/Header.vue';
export default {
	name: '',
	components: { Menu, Header },
	data() {
		return {
			isOpen: true,
			asideStyle: {
				width: '200px'
			}
		};
	},
	computed: {
		key() {
			return this.$route.path;
		}
	},
	// 监听router-view的切换，切换时将搜索框内容清空
	watch: {
		$route(to, from) {
			var toPath = to.path.toString()
			var fromPath = from.path.toString()
			var admin = sessionStorage.getItem("admin");
			
			var token = sessionStorage.getItem("T-Token");
			if (token == null || token === '' || token === undefined ) {
				this.$router.push('/login')
			}
			
			if ((toPath != "/login" || toPath != "/") && admin == null) {
				this.$router.push('/login')
			}
	
		}
	},
	methods: {
		openOrClose() {
			// if (this.isOpen) {
			// 	this.asideStyle.width = '64px';
			// } else {
			// 	this.asideStyle.width = '200px';
			// }
			this.isOpen = !this.isOpen;
		}
	}
};
</script>

<style scoped>
.el-header {
	background-color: #fff;
	color: #333;
	height: 50px!important;
	line-height: 50px!important;
	padding: 0 !important;
}

.el-aside {
	background-color: #d3dce6;
	color: #333;
	text-align: center;
	line-height: 200px;
}

.el-main {
	background-color: #e9eef3;
	color: #333;
	padding: 0!important;
}

body > .el-container {
	margin-bottom: 40px;
}
</style>
