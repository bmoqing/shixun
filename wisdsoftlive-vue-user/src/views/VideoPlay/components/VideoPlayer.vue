<template>
	<div>
		<div class="c_name">{{cName}}</div>
		<div @contextmenu.prevent="menuPlayer()" width="638" height="400" style="width: 638px; height: 447px">
			<video-player class="video-player vjs-custom-skin" ref="videoPlayer" :playsinline="true" :options="playerOptions">

			</video-player>
		</div>
	</div>

</template>
<script>
	// Similarly, you can also introduce the plugin resource pack you want to use within the component
	// import 'some-videojs-plugin'
	// <vueVideoPlayer :src="data.url" :cover_url="data.cover_url" />
	import {
		videoPlayer
	} from 'vue-video-player'

	export default {
		// 不要忘记注册
		components: {
			videoPlayer
		},
		props: {
			cName: String,
			imgTop: String,
			url: String
		},
		data() {
			return {
				// url: "https://cdn.theguardian.tv/webM/2015/07/20/150716YesMen_synd_768k_vp8.webm",
				// imgTop: "",
				playerOptions: {
					// data-setup: {
					// 	videoWidth: 667,
					// 	videoHeight: 447
					// },
					playbackRates: [0.5, 1.0, 1.5, 2.0], // 可选的播放速度
					autoplay: false, // 如果为true,浏览器准备好时开始回放。
					muted: false, // 默认情况下将会消除任何音频。
					loop: false, // 是否视频一结束就重新开始。
					preload: 'auto', // 建议浏览器在<video>加载元素后是否应该开始下载视频数据。auto浏览器选择最佳行为,立即开始加载视频（如果浏览器支持）
					language: 'zh-CN',
					aspectRatio: '16:9', // 将播放器置于流畅模式，并在计算播放器的动态大小时使用该值。值应该代表一个比例 - 用冒号分隔的两个数字（例如"16:9"或"4:3"）
					fluid: true, // 当true时，Video.js player将拥有流体大小。换句话说，它将按比例缩放以适应其容器。
					sources: [{
						// type: "video/mp4", // 类型
						src: "" // url地址
					}],
					poster: '', // 封面地址
					notSupportedMessage: '此视频暂无法播放，请稍后再试', // 允许覆盖Video.js无法播放媒体源时显示的默认信息。
					controlBar: {
						timeDivider: true, // 当前时间和持续时间的分隔符
						durationDisplay: true, // 显示持续时间
						remainingTimeDisplay: false, // 是否显示剩余时间功能
						fullscreenToggle: true // 是否显示全屏按钮
					}
				},

			}
		},
		methods: {
			menuPlayer() {
				$('#video').bind('contextmenu', function() {
					return false;
				});
			},
		},
		watch: {
			url: function(n, o) {
				this.playerOptions.sources[0].src = n
			}
		},
		created() {
			if(this.currentNum == "-1") {
				this.playerOptions.sources[0].src = this.url
				// this.playerOptions.poster = this.imgTop
			}
		}

	}
</script>

<style scoped="scoped">
	.vjs-menu-item {
		border-radius: 1.5px;
	}

	video {
		width: 100% !important;
		height: calc(100vh - 95px) !important;
		object-fit: fill;
	}

	.c_name {
		font-size: 18px;
		height: 27px;
		margin-top: -5px;
		margin-bottom: 5px;
		margin-left: 10px;
	}

	video::-internal-media-controls-download-button {
		display: none;
	}

	video::-webkit-media-controls-enclosure {
		overflow: hidden;
	}

	video::-webkit-media-controls-panel {
		width: calc(100% + 30px);
	}
</style>
