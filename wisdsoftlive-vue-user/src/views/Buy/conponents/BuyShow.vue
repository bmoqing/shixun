<template>
	<div class="top" :style="{background:img}">
		<div class="content">
			<div class="title">
				<h1>{{buyData.cname}}</h1>
				<h2>{{buyData.ccontent}}</h2>
			</div>
			<div class="msg" :style="flex_img">
				<div class="mgs_in">
					<div v-if="!isVideo" class="">
						<div class="time">截止时间 {{buyData.endTime}}</div>
						<div v-if="!isEnd" style="font-weight: 700;padding: 6px 12px;">
							倒计时:
							<span v-if="show">
								{{day}}天{{hr}}小时{{min}}分{{sec}}秒
							</span>
						</div>
					</div>
					<div class="price out">
						￥{{buyData.cinMoney}}/￥{{buyData.coutMoney}}
					</div>
					<!-- 	<div class="price in">
						￥{{buyData.cinMoney}}
					</div> -->
					<div class="price old">
						原价￥{{buyData.coldMoney}}
					</div>
					<div class="count">
						<div style="font-weight: 700;">
							授课人:{{buyData.tname}}
						</div>
						<span v-if="!isVideo">
							已购人数{{buyData.personNumber}}
						</span>
					</div>
					<div class="tag">
						<span v-if="!isVideo">直播</span>
						<span v-else>视频</span>
					</div>
					<div v-if="isEnd" class="btn-ed">
						已结束
					</div>
					<div v-else-if="!isBuy" class="btn" @click="open">
						立即购买
					</div>
					<div v-else class="btn-ed">
						已购买
					</div>
					<div v-if="!isVideo && !isBuy" class="song">
						(购买即赠送配套视频)
					</div>
				</div>
			</div>

			<div class="buy_box" v-if="isOpen">
				<h1 v-if="!inSchool">
					您是校外人员需要支付
					<span v-text="this.buyData.coutMoney" style="color: #f01414;"></span>
					元<span class="rz" @click="rz">(前往认证)</span>
				</h1>
				<h1 v-else>
					您是校内人员需要支付
					<span v-text="this.buyData.cinMoney" style="color: #f01414;"></span>
					元
				</h1>
				<div class="btn" @click="buyClick">立即支付</div>
			</div>
			<div class="buy_bg" v-if="isOpen" @click="isOpen = false"></div>
		</div>

	</div>
</template>

<script>
	export default {
		props: {
			buyData: Object,
			color_index: {
				type: Number,
				default: 1
			},
			isBuy: {
				type: Boolean,
				default: false
			},
			isEnd: {
				type: Boolean,
				default: false
			},
			isVideo: {
				type: Boolean,
				default: false
			}
		},
		name: "BuyShow",
		data() {
			return {
				background_Img: [{
						imgSrc: "/images/bule.png"
					},
					{
						imgSrc: "/images/zise.png"
					},
					{
						imgSrc: "/images/red.png"
					},
					{
						imgSrc: "/images/green.png"
					}
				],
				flex_img: {
					background: 'url(' + this.$global_msg.adminRoute + '/images/bg.png)',
					'background-repeat': 'no-repeat',
					'background-size': 'cover',
					'background-position': 'center'
				},
				day: '',
				hr: '',
				min: '',
				sec: '',
				show: false,
				isOpen: false,
				inSchool: false,
			}
		},
		computed: {
			img: function() {
				return 'url(' + this.$global_msg.adminRoute + this.background_Img[this.color_index].imgSrc + ')'
			},
		},
		mounted() {
			//直播计时
			if (!this.isVideo) {
				this.countdown()
			}
		},
		methods: {
			open() {
				let user = this._local.get("email");
				if (!user) {
					this.$message.error('请先登录')
					return false
				}
				this.isOpen = true
				if (user.type == 0) {
					console.log("是学生");
					this.inSchool = true;
					money = this.buyData.cinMoney
				}
			},
			rz() {
				this.$router.push('/mine/personal')
			},
			buyClick() {
				this.isOpen = false;
				this.$emit('buyClick', '');
			},
			countdown() {
				const end = new Date(this.buyData.endTime); // 定义开始时间且延长1小时
				const now = Date.parse(new Date()); // 获取本地时间
				const msec = end - now;
				// 将时间戳进行格式化00：00的形式
				let day = parseInt(msec / 1000 / 60 / 60 / 24);
				let hr = parseInt(msec / 1000 / 60 / 60 % 24)
				hr = hr > 9 ? hr : '0' + hr;
				let min = parseInt(msec / 1000 / 60 % 60)
				min = min > 9 ? min : '0' + min;
				let sec = parseInt(msec / 1000 % 60)
				sec = sec > 9 ? sec : '0' + sec;
				this.day = day;
				this.hr = hr
				this.min = min
				this.sec = sec
				if (day > 0 || hr > 0 || min > 0 || sec > 0) {
					this.show = true
				}
				const that = this;
				// 倒计时结束时的操作
				if (hr <= 0 && min <= 0 && sec <= 0) {
					this.isEnd = true
					return
				} else {
					setTimeout(function() {
						that.countdown()
					}, 1000)
				}
			}
		}
	}
</script>

<style scoped>
	.top {
		position: absolute;
		left: 0;
		width: 100%;
		height: 300px;
		z-index: 0;
	}

	.content {
		width: 1200px;
		height: 100%;
		padding-top: 70px;
		margin: 0 auto;
	}

	.title {
		width: 1000px;
		margin: 0 auto;
		margin-bottom: 70px;
	}

	.title h1 {
		text-align: center;
		font-size: 40px;
		color: #fff;
		line-height: 48px;
		text-shadow: 0 2px 4px rgba(28, 31, 33, .6);
	}

	.title h2 {
		text-align: center;
		font-size: 16px;
		color: #fff;
		line-height: 24px;
		text-shadow: 0 2px 4px rgba(28, 31, 33, .6);
		margin-top: 8px;
	}

	.msg {
		width: 100%;
		min-height: 128px;
		background-repeat: no-repeat;
		background-size: cover;
		background-position: center;
		border-radius: 18px;
		box-shadow: 0 8px 16px 0 rgba(28, 31, 33, .1);
		position: relative;
	}

	.msg .mgs_in {
		width: 100%;
		min-height: 128px;
		height: 100%;
		padding: 32px 40px;
		box-sizing: border-box;
		display: flex;
		flex-direction: row;
		align-items: center;
	}

	.time {
		color: #fff;
		padding: 6px 12px;
		background-image: linear-gradient(90deg, rgba(255, 0, 105, .99) 0, #ff7a00 99%);
		border-radius: 16px;
		font-weight: 700;
		text-align: center;
	}

	.price {
		margin-left: 10px;
	}

	.out {
		font-size: 32px;
		color: #f01414;
		font-weight: 700;
	}

	.in {
		font-size: 32px;
		color: #f01414;
		font-weight: 700;
	}

	.old {
		font-size: 14px;
		color: #93999f;
		font-weight: 700;
		margin-right: 2px;
		text-decoration: line-through;
	}

	.count {
		font-size: 12px;
		color: #545c63;
		font-weight: 700;
		margin-left: 10px;
	}

	.btn {
		width: 160px;
		text-align: center;
		position: absolute;
		right: 50px;
		background: #f01414;
		border-radius: 24px;
		font-size: 16px;
		color: #fff;
		letter-spacing: 0;
		line-height: 24px;
		font-weight: 700;
		padding: 12px 48px;
		cursor: pointer;
		transition: all .3s;
		-moz-transition: all .3s;
		-webkit-transition: all .3s;
		-o-transition: all .3s;
	}

	.btn-ed {
		width: 160px;
		text-align: center;
		position: absolute;
		right: 50px;
		background: #9e9e9e;
		border-radius: 24px;
		font-size: 16px;
		color: #fff;
		letter-spacing: 0;
		line-height: 24px;
		font-weight: 700;
		padding: 12px 48px;
		cursor: pointer;
		transition: all .3s;
		-moz-transition: all .3s;
		-webkit-transition: all .3s;
		-o-transition: all .3s;
	}

	.btn:hover {
		background-color: #f04646;
	}

	.tag {
		margin-left: 12px;
		line-height: 12px;
		padding: 6px 10px;
		background-color: #6c61d390;
		background-image: linear-gradient(90deg, #6c61d3 0, #53a0fd 100%);
		border-radius: 12px;
		color: #fff;
	}

	.buy_box {
		position: fixed;
		background: #fff;
		z-index: 100000;
		align-items: center;
		width: 800px;
		height: 150px;
		padding-top: 25px;
		padding-bottom: 15px;
		left: 50%;
		top: 50%;
		-webkit-transform: translate(-50%, -50%);
		-moz-transform: translate(-50%, -50%);
		-ms-transform: translate(-50%, -50%);
		transform: translate(-50%, -50%);
		box-shadow: 0 12px 24px 0 rgba(28, 31, 33, .1);
		border-radius: 12px;
		transition: all .2s;
		-webkit-transition: all .2s;
		-moz-transition: all .2s;
		-o-transition: all .2s;
		padding: 30px 32px;
		display: flex;

	}

	.buy_box h1 {
		width: 520px;
		height: 50px;
		line-height: 50px;
	}

	.buy_box .btn {
		flex: 1;
		height: 50px;
		background: #f01414;
		border-radius: 24px;
		font-size: 16px;
		color: #fff;
		letter-spacing: 0;
		line-height: 24px;
		font-weight: 700;
		padding: 12px 48px;
		cursor: pointer;
	}

	.buy_box .rz {
		color: #9a9898;
		margin-left: 5px;
		font-size: 16px;
		cursor: pointer;
	}

	.buy_box .rz:hover {
		color: #adabab;
	}

	.buy_bg {
		position: fixed;
		top: 0;
		right: 0;
		bottom: 0;
		left: 0;
		z-index: 99;
		background-color: #000;
		opacity: .75;
	}

	.song {
		position: absolute;
		top: 94px;
		width: 160px;
		text-align: center;
		right: 50px;
		font-size: 12px;
		color: #f01414;
		letter-spacing: 0;
		line-height: 24px;
		font-weight: 700;
		transition: all .3s;
		-moz-transition: all .3s;
		-webkit-transition: all .3s;
		-o-transition: all .3s;
	}
</style>
