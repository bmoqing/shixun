<template>
	<div class="body">
		<div class="top">
			我的视频
		</div>
		<div v-show="haveData" class="body_02">
			<div class="body_03" v-for="item in purchasedVideoCourses" :key="item.id">
				<a-card hoverable class="myCard">
					<img class="courseImg" alt="example" :src="item.imgTop" />
					<div class="courseName">{{item.cname}}</div>
					<div class="teacher">讲师：{{item.tname}}</div>
					<template slot="actions" class="ant-card-actions">
						<a-tooltip placement="top">
							<template slot="title">
								<span>查看</span>
							</template>
							<a-icon type="search" @click="handleClick(item.cid)" />
						</a-tooltip>
						<a-tooltip placement="top" @click="lookVideo(item.cid)">
							<template slot="title">
								<span>立即观看</span>
							</template>
							<a-icon type="play-circle" />
						</a-tooltip>
						<a-tooltip placement="top">
							<template slot="title">
								<span>详情</span>
							</template>
							<a-icon type="account-book" @click="openOrCloseShowDetails(item)" />
						</a-tooltip>
					</template>
				</a-card>
			</div>
		</div>
		<a-result v-show="!haveData" status="404" title="这里什么都没有" sub-title="快去视频区购买一些视频吧">
			<template #extra>
				<a-button type="primary" @click="go()">
					购买视频
				</a-button>
			</template>
		</a-result>
		<ShowDetails :childData="childData" @onClose="openOrCloseShowDetails" :visible="visible"></ShowDetails>
		<div class="myPage">
			<a-pagination show-quick-jumper :default-current="page" :defaultPageSize="9" :total="total" @change="onChange" />
		</div>
	</div>
</template>

<script>
	//import axios from 'axios'
	import ShowDetails from '../Live/components/ShowDetails.vue'
	import { mapState } from 'vuex';
	export default {
		name: 'Video',
		components: {
			ShowDetails
		},
		data() {
			return {
				visible: false,
				cardData: '',
				page: 1,
				total: 0,
				childData: {},
				haveData: true
			};
		},
		computed: {
		...mapState(['purchasedVideoCourses']),
		total() {
		return this.purchasedVideoCourses.length;
		},
		haveData() {
		return this.purchasedVideoCourses.length > 0;
		}
	},
		methods: {
			// 跳转到观看视频页面
			lookVideo(cid) {
				this.$router.push('/videoPlayer/' + cid)
			},
			// 跳转到购买页面
			handleClick(id) {
				this.$router.push('/buy/video/' + id)
			},
			openOrCloseShowDetails(item) {
				this.visible = !this.visible;
				this.childData = item;
			},
			onChange(pageNumber) {
				this.getData(pageNumber);
			},
			getData(page) {
				axios
					.get(this.$global_msg.userRoute + '/video/selectMyVideo/', {
						params: {
							id: this._local.get("email").id,
							page: page,
							limit: 9
						}
					})
					.then(a => {
						console.log(a)
						this.cardData = a.data.data
						this.total = a.data.count
						if (this.total == 0) {
							this.haveData = false;
						}
					})
					.catch(e => {
						console.log(e);
					});
			},
			go(){
				this.$router.push('/video')
			}
		},
		mounted() {
			this.getData(1)
		}
	};
</script>

<style scoped="scoped">
	.body {
		margin: 24px 0;
		width: 74%;
		background-color: white;
		box-shadow: 0 1px 5px rgba(1, 1, 1, 0.1);
		border-radius: 4px;
	}

	.top {
		width: 100%;
		padding: 0 20px;
		border-bottom: 1px solid #ebebeb;
		height: 48px;
		line-height: 48px;
		font-size: 16px;
		font-weight: bold;
		color: black;
	}

	.myCard {
		width: 230px;
		border-radius: 5px;
		height: 213px;
		background-color: rgb(250, 250, 250);
	}

	.body_02 {
		width: 100%;
		padding: 20px 25px;
		height: 730px;
	}

	.body_02>>>.ant-card-body {
		padding: 0 !important;
	}

	.body_03 {
		width: 230px;
		height: 210px;
		float: left;
		margin-bottom: 20px;
	}

	.body_03:nth-child(3n + 2) {
		margin: 0 46px;
	}

	.courseImg {
		width: 229px;
		height: 128px;
		border-radius: 5px 5px 0 0;
	}

	.courseName {
		width: 100%;
		padding: 3px 5px 0 5px;
		font-weight: 500;
	}

	.teacher {
		width: 100%;
		text-align: right;
		padding-right: 5px;
		padding-bottom: 3px;
		color: #5f5f5f;
	}

	.body_03>>>.ant-card-actions {
		border-radius: 0 0 5px 5px;
	}

	.ant-card-actions>li>span>.anticon {
		font-size: 18px;
	}

	.body_03>>>li {
		margin: 6px 0;
	}

	.myPage {
		text-align: center;
		margin-bottom: 20px;
	}
</style>
