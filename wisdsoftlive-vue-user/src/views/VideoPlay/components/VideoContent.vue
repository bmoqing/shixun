<template>
	<div>
		<div class="c_jishu">
			<span style="margin-left: 7px;">视频选集:</span>
			<span style="margin-left: 210px;"><span>{{currentNum}}</span> / {{count}}</span>
		</div>
		<div class="box" ref="menu">

			<ul id="ul" v-for="(data, index) in datas" :key="data.id">
				<!-- 将当前集数传递给方法 -->
				<li :class="[curStyle == index ? 'my-menu-child-change' : 'li-box' ]" @click="changeNum(index + 1, cName, data.url, data.imgTop)">
					<span class="ziti">
						<span>
							P{{index + 1}}
						</span>
						<span style="margin-left: 6px;">
							{{data.name}}
						</span>
						<span style="float: right; margin-right: 8px;">
							{{data.time}}
						</span>
					</span>
				</li>
			</ul>
		</div>

	</div>
</template>
<script>
	import axios from 'axios';
	import videoTime from '../../../js/getVideoTime.js'
	export default {
		name: 'VideoContent',
		data() {
			return {
				currentNum: 1,
				currentUrl: "",
				currentImgTop: "",
				currentName: "",
				cName: "",
				time: '',
				count: 0,
				datas: [],
				curStyle: 0
			}
		},
		methods: {
			// 监听路由方法
			isRouteChange() {
				var path = this.$route.path
				let id = this.$route.params.id
				if (path.indexOf("/videoPlayer/") != -1) {
					this.currentNum = localStorage.getItem("currentNum/" + id)
				}

				var obj = this.$refs.menu.children;
				console.log(obj)
				// 原地刷新页面时记住上次的集数
				var index = this.currentNum - 1;
				this.curStyle = index
				this.currentUrl = this.datas[index].url
				this.currentImgTop = this.datas[index].imgTop
				this.$emit('videoChange', index, this.cName, this.currentUrl, this.currentImgTop)

			},
			prohibit() { // 禁用鼠标右击、F12
				var path = this.$route.path
				if (path.indexOf("/videoPlayer/") != -1) {
					document.onkeydown = function(e) {
						if (e.keyCode == 123) {
							alert("视频播放页面请不要偷看源码哦")
							return false
						}
					};
				}

			},
			isFirstVisit() {
				// 将localStorage集数重置为第一集
				// 获取课程id
				let id = this.$route.params.id
				localStorage.setItem("currentNum/" + id, "1")
				// 将currentNum集数变为第一集
				this.currentNum = 1
				var obj = this.$refs.menu.children;
				// 原地刷新页面时记住上次的集数
				var index = this.currentNum - 1
				// this.curStyle = index
				this.currentUrl = this.datas[index].url
				this.currentImgTop = this.datas[index].imgTop
				this.$emit('videoChange', index, this.cName, this.currentUrl, this.currentImgTop)
			},
			getVideoDuration(index, url) {
				var audioElement = new Audio(url);
				var self = this;
				var result;
				var res;
				audioElement.addEventListener("loadedmetadata", () => {
					// 视频时长值的获取要等到这个匿名函数执行完毕才产生
					result = audioElement.duration; //得到时长为秒，小数，182.36
					// console.log(result)
					// 获取视频分钟数
					var min = parseInt(result / 60)
					if (min < 10) {
						min = "0" + min
					}
					// 获取保留两位小数后的视频秒数
					var sec = result % 60
					sec = sec.toFixed(sec / 60)
					if (sec < 10 && sec > 0) {
						sec = sec + "0"
					}
					if (sec == 0) {
						sec = "00"
					}
					// 获取当前的视频时间
					res = min + ":" + sec
					this.datas[index].time = res
				})
			},
			changeNum(index, name, url, imgTop) {
				this.curStyle = index - 1;
				this.currentNum = index
				let id = this.$route.params.id
				localStorage.setItem("currentNum/" + id, index)
				this.$emit('videoChange', index, name, url, imgTop)
			},
		},
		async mounted() {
			// 禁止使用F12
			this.prohibit()
		},
		async created() {
			let id = this.$route.params.id

			axios.get(this.$global_msg.videoRoute + '/video/selectVideoForCourse/' + id, {

				})
				.then((res) => {
					this.cName = res.data.data.name
					this.count = res.data.data.number
					this.datas = res.data.data.videos
					for (let i = 0; i < this.datas.length; i++) {
						var url = this.datas[i].url
						if (url != null && url != '' && url != 'null') {
							this.getVideoDuration(i, this.datas[i].url)
						}
					}

					if (!localStorage.getItem("currentNum/" + id)) {
						localStorage.setItem("currentNum/" + id, "-1")
					}
					if (localStorage.getItem("currentNum/" + id) != "-1") {
						// 当播放页面刷新时，记住上次的集数
						this.isRouteChange()
					} else {
						// 若为第一次打开该视频页，则默认从第一集开始播放视频
						this.isFirstVisit()
					}

				}).catch((response) => {
					console.log(response);
				})

		},
	}
</script>

<style scoped="scoped">
	* {
		padding: 0;
		/* margin: 0 auto; */
	}

	.c_jishu {
		margin-top: 33px;
		width: 100%;
		background: #dedede7a;
		height: 30px;
		line-height: 30px;
		border-radius: 5px;
	}

	.ziti {
		margin-left: 8px;
	}

	ul {
		margin: 0 auto;
		padding-top: 3px;
		padding-bottom: 3px;
	}

	li {
		list-style: none;
		width: 96%;
		margin-left: 2%;
		margin-bottom: 40;
		border-radius: 5px;
	}

	.box {
		position: relative;
		background: #dedede7a;
		max-height: 21rem;
		z-index: 1;
		width: 20rem;
		border-radius: 5px;
		overflow-y: scroll;
		margin-top: 5px;
	}

	.li-box {
		height: 1.875rem;
		width: 96%;
		margin-left: 2%;
		line-height: 1.875rem;
		border-radius: 5px;
	}

	.li-box:hover {
		cursor: pointer;
		background-color: rgb(255, 255, 255);
		border-radius: 5px;
	}

	.my-menu-child-change:hover {
		cursor: pointer;
		border-radius: 5px;
		background-color: rgb(255, 255, 255);
	}

	.my-menu-child-change {
		width: 96%;
		margin-left: 2%;
		height: 1.875rem;
		line-height: 1.875rem;
		background-color: white;
		border-radius: 5px;
		color: rgb(24, 144, 255);
	}
</style>
