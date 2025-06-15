<template>
	<div>
		<div class="head">

			<div>
				视频区
			</div>
			<router-link to="/video">
			<div class="more">
				<span style="padding-left: 8px;">更多</span>
				<a-icon id="my-icon" type="double-right" />
			</div>
			</router-link>
		</div>
		<a-divider class="xian" />
		<div class="card_box">
			<div style="margin: 0 auto;" v-if="videoTotal == 0">
				<a-empty description="暂无数据" />
			</div>
			<span v-for="(video, index) in videos" :key="video.id">
				<a-card hoverable class="card" @click="handleClick(video.cid)">
					<img slot="cover" alt="example" class="cover_img" :src="video.imgTop" />
					<a-card-meta :title="video.cname" :description="video.ccontent">
					</a-card-meta>
					<!-- 收费直播课程 -->
					<div v-if="video.ctype == '1'" class="jiage_box">
						<div class="tehui">
							限时特惠
						</div>
						<div class="youhuijia">
							¥{{video.cinMoneyShow}}
						</div>
						<div class="oldMoney">
							¥{{video.coldMoneyShow}}
						</div>
					</div>
					<!-- 免费直播课程 -->
					<div v-else-if="video.ctype == '0'">
						<div class="mianfei">
							免费课程
						</div>
					</div>
				</a-card>
			</span>
		</div>
	</div>

</template>

<script>
	export default {
		name: 'VideoShow',
		props: {
			videos: Array,
			videoTotal: Number,
		},
		data() {
			return {
				
			};
		},
		methods: {
			// 跳转到购买页面
			handleClick(id) {
				this.$router.push('/buy/video/' + id)
			}
		},
	}
</script>

<style scoped>
	.head {
		width: 93%;
		margin-left: 3.5%;
		display: flex;
		flex-direction: row;
		justify-content: space-between;
		padding: 0 -20px;
		font-family: cursive;
		font-size: 16px;
	}

	.ant-divider {
		background-color: #848484 !important;
	}

	.ant-divider-horizontal {
		height: 1.5px !important;
		min-width: 95% !important;
		width: 95%;
	}

	/* 下划线样式 */
	.xian {
		margin-top: 3px;
		margin-left: 2.5%;
	}
	
	/* 更多选项的样式 */
	.more:hover {
		color: rgb(64 158 255);
		cursor: pointer;
	}

	/* 卡片样式 */
	.card_box {
		display: flex;
		flex-wrap: wrap;
		width: 98%;
		margin-left: 2%;
	}

	.card {
		position: relative;
		width: 270px;
		height: 250px;
		margin: 0 24px 24px 0;
		background: #FFFFFF;
		box-shadow: 0 6px 10px 0 rgba(95, 101, 105, 0.15);
		border-radius: 8px;
		float: left;
		transition: all .2s;
	}

	.card:hover {
		-webkit-box-shadow: 3px 3px 15px rgba(0, 0, 0, 0.15);
		box-shadow: 3px 3px 15px rgba(0, 0, 0, 0.15);
		-webkit-transform: translate3d(0, -2px, 0);
		transform: translate3d(0, -2px, 0);
	}
	/* 卡片中封面图样式 */
	.cover_img {
		height: 150px;
		width: 100%;
	}
	
	/* 调整卡片中内容的padding内边距 */
	.card_box >>> .ant-card-body {
		padding: 12px 24px 24px 24px!important;
	}
	/* 限制卡片中课程标题盒子的高度 */
	.card_box >>> .ant-card-meta-title {
		margin-bottom: 0px!important;
		height: 24px;
	}
	
	/* 限制卡片中课程描述盒子的高度 */
	.card_box >>> .ant-card-meta-description {
		height: 40px;
		overflow: hidden;
		text-overflow:ellipsis;
		white-space: nowrap;
	}
	
	/* 价格一行的大盒子 */
	.jiage_box {
		display: flex;
	}
	
	/* 显示特惠样式 */
	.tehui {
		color: #fff;
		background-color: rgba(242, 13, 13, 0.6);
		font-style: normal;
		font-size: 12px;
		width: 52px;
		border-radius: 3px;
		text-align: center;
	}
	
	/* 优惠价格样式 */
	.youhuijia {
		margin-left: 10px;
		color: #F01414;
	}
	
	/* 折前价格 */
	.oldMoney {
		color: #6D7278;
		margin-left: 6px;
		text-decoration: line-through;
	}
	
	/* 免费课程 */
	.mianfei {
		color: #fff;
		background-color: rgba(242, 13, 13, 0.6);
		font-style: normal;
		font-size: 12px;
		width: 52px;
		text-align: center;
		border-radius: 3px;
	}
</style>
