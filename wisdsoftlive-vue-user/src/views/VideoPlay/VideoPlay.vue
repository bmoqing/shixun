<template>
	<div class="box">
		<video-player style="margin-right: 20px;" :currentNum="currentNum" :cName="cName" :url="url" :imgTop="imgTop"></video-player>
		<video-content @videoChange="videoChange"></video-content>
	</div>


</template>

<script>
	import VideoPlayer from './components/VideoPlayer.vue'
	import VideoContent from './components/VideoContent.vue'
	export default {
		// 不要忘记注册
		components: {
			VideoPlayer,
			VideoContent
		},
		data() {
			return {
				currentNum: "",
				cName: "",
				url: "",
				imgTop: "",
				isShow: "true"
			}
		},
		methods: {
			prohibit() { // 禁用鼠标右击、F12
				// if (this.isShow == "true") {
				document.oncontextmenu = function() {
					return false;
				}
				document.onkeydown = function(e) {
					if (e.ctrlKey && (e.keyCode === 65 || e.keyCode === 67 || e.keyCode === 73 || e.keyCode === 74 || e.keyCode ===
							80 || e.keyCode === 83 || e.keyCode === 85 || e.keyCode === 86 || e.keyCode === 117)) {
						return false;
					}
					if (e.keyCode == 18 || e.keyCode == 123) {
						return false
					}
				};
				// }

			},
			openF12() {
				document.oncontextmenu = function() {
					return true;
				}
				document.onkeydown = function(e) {
					if (e.ctrlKey && (e.keyCode === 65 || e.keyCode === 67 || e.keyCode === 73 || e.keyCode === 74 || e.keyCode ===
							80 || e.keyCode === 83 || e.keyCode === 85 || e.keyCode === 86 || e.keyCode === 117)) {
						return true;
					}
					if (e.keyCode == 18 || e.keyCode == 123) {
						return true
					}
				};
			},
			videoChange(currentNum, cName, url, imgTop) {
				this.currentNum = currentNum
				this.cName = cName
				this.url = url
				this.imgTop = imgTop
			}
		},
		mounted() {
			// 禁止使用F12
			// this.prohibit()
		},
		destroyed() {
			// this.openF12()
		}
	}
</script>

<style scoped="scoped">
	.box {
		max-width: 1984px;
		min-width: 988px;
		margin: 0 auto;
		display: -ms-flexbox;
		display: flex;
		-ms-flex-pack: center;
		justify-content: center;
		margin-top: 50px;
	}
</style>
