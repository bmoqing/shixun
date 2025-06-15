<template>
  <div>
    <!-- 直播区 -->
    <live :liveCourses="liveCourses" :liveTotal="liveCourses.length"></live>
    <!-- 视频区 -->
    <videoShow style="margin-top: 20px;" :videos="videos" :videoTotal="videos.length"></videoShow>
    <!-- 回到顶部 -->
    <BackTop></BackTop>
  </div>
</template>

<script>
import Live from "./components/Live/Live.vue";
import VideoShow from "./components/Video/Video.vue";
import BackTop from "./components/BackTop/BackTop.vue";
import { mockLiveCourses, mockVideos } from '../../mockData.js'; // 引入模拟数据

export default {
  name: "IndexByCName",
  components: {
    Live,
    VideoShow,
    BackTop
  },
  data() {
    return {
    liveCourses: [],
    videos: [],
	mockLiveCourses: mockLiveCourses, // 使用引入的模拟数据
    mockVideos: mockVideos, // 使用引入的模拟数据
    };
  },
  watch: {
    "$route.params.cName": {
      immediate: true,
      handler(newCName) {
        this.searchCourses(newCName);
      }
    }
  },
  methods: {
    searchCourses(cName) {
      if (cName) {
        this.liveCourses = this.mockLiveCourses.filter(
          (course) => course.cname.includes(cName)
        );
        this.videos = this.mockVideos.filter(
          (video) => video.cname.includes(cName)
        );
      } else {
        this.liveCourses = this.mockLiveCourses;
        this.videos = this.mockVideos;
      }
    }
  }
};
</script>

<style>
div {
  color: black;
}
</style>