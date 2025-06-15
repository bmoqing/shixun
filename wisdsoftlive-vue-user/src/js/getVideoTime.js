export default {
	getVideoTime
}
 function getVideoTime(index, url) {
	var audioElement = new Audio(url);
	var self = this;
	var result;
	var res;
	audioElement.addEventListener("loadedmetadata", function() {
		// 视频时长值的获取要等到这个匿名函数执行完毕才产生
		result = audioElement.duration; //得到时长为秒，小数，182.36
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
		var res = min + ":" + sec
		// 存入localStorage
		console.log(res)
		localStorage.setItem("currentTime", res)
	});
	
}



