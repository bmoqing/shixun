<template>
	<div>
		<el-menu default-active="1" class="el-menu-vertical-demo" @open="handleOpen" @close="handleClose" :collapse="isOpen"
		 background-color="#304156" text-color="#fff" active-text-color="#386fa8">
			<router-link to="/live/banner">
				<el-menu-item index="1">
					<i class="el-icon-s-order"></i>
					<span slot="title">轮播图</span>
				</el-menu-item>
			</router-link>
			<router-link to="/live/notice">
				<el-menu-item index="2">
					<i class="el-icon-s-order"></i>
					<span slot="title">网站公告</span>
				</el-menu-item>
			</router-link>
			<router-link to="/live/course">
				<el-menu-item index="3">
					<i class="el-icon-document"></i>
					<span slot="title">课程管理</span>
				</el-menu-item>
			</router-link>
			<router-link to="/live/liveCourse">
				<el-menu-item index="4">
					<i class="el-icon-document"></i>
					<span slot="title">直播课程</span>
				</el-menu-item>
			</router-link>
			<router-link to="/live/video">
				<el-menu-item index="5">
					<i class="el-icon-video-camera-solid"></i>
					<span slot="title">视频管理</span>
				</el-menu-item>
			</router-link>
			<el-submenu index="6">
				<template slot="title">
					<i class="el-icon-money"></i>
					<span>财务管理</span>
				</template>
				<el-menu-item-group>
					<router-link to="/money/detailMoney">
						<el-menu-item index="1-1">收支明细</el-menu-item>
					</router-link>
					<router-link to="/money/personal">
						<el-menu-item index="1-2">个人收入</el-menu-item>
					</router-link>
				</el-menu-item-group>
			</el-submenu>
			
			<router-link to="/live/liveDetail">
				<el-menu-item index="7">
					<i class="el-icon-document"></i>
					<span slot="title">直播明细</span>
				</el-menu-item>
			</router-link>

			<router-link to="/live/user">
				<el-menu-item index="8">
					<i class="el-icon-s-custom"></i>
					<span slot="title">用户信息</span>
				</el-menu-item>
			</router-link>

			<router-link to="/live/teacher">
				<el-menu-item index="9">
					<i class="el-icon-s-custom"></i>
					<span slot="title">教师管理</span>
				</el-menu-item>
			</router-link>
			<router-link to="/live/portrait">
				<el-menu-item index="10">
					<i class="el-icon-s-custom"></i>
					<span slot="title">头像管理</span>
				</el-menu-item>
			</router-link>
		</el-menu>
	</div>
</template>

<script>
	export default {
		name: 'Menu',
		props: {
			isOpen: Boolean
		},
		data() {
			return {
				isCollapse: true
			};
		},
		methods: {
			handleOpen(key, keyPath) {
				// console.log(key, keyPath);
			},
			handleClose(key, keyPath) {
				// console.log(key, keyPath);
			}
		}
	};
</script>

<style>
	.el-menu-vertical-demo:not(.el-menu--collapse) {
		width: 175px;
		min-height: 400px;
	}

	.el-aside[data-v-6d720fe5] {
		background-color: #304156 !important;
	}

	.el-menu {
		border: none;
	}

	a {
		text-decoration: none;
	}
</style>
