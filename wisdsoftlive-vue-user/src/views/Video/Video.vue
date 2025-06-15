<template>
	<div>
		<top id="title"
			@selectByRequire="selectByRequire"
		></top>
		<list 
			@selectByRequire="selectByRequire"
			:videoCourses="videoCourses"
			:videoTotal="videoTotal"
			:cName="cName"
			:type="type"
			:page="page"
			:limit="limit"
		></list>
		<back-top></back-top>
	</div>
</template>

<script>
	import Top from './components/Top.vue'
	import List from './components/List.vue'
	import BackTop from '../Index/components/BackTop/BackTop.vue'
	import axios from 'axios';
    import { mockVideos } from '../../mockData.js'; // 引入模拟数据
	export default {
		name: 'Video',
		components: {
			Top,
			List,
			BackTop
		},
		data() {
			return {
				videoCourses: [],
				videoTotal: 0,
				cName: "",
				type: 2,
				page: 1,
				limit: 12,
			};
		},
		methods:{
			// 根据条件查询数据
			selectByRequire(cName, type, page, limit) {
				axios.get(this.$global_msg.videoRoute + '/video/selectByRequire', {
						params: {
							"cName": cName,
							"type": type,
							"page": page,
							"limit": limit
						}
					})
					.then((res) => {
						this.videoCourses = res.data.data
						this.videoTotal = res.data.count
						this.cName = cName
						this.type = type
						this.page = page
						this.limit = limit
					}).catch((response) => {
						console.log(response);
					})

					 // 模拟后端返回数据
            // 根据筛选条件过滤数据（保留全部课程，仅按类型筛选）
      const filteredCourses = mockVideos.filter((course) => {
        if (type === 0 && course.ctype !== '0') return false; // 免费课程
        if (type === 1 && course.ctype !== '1') return false; // 付费课程
        if(cName && !course.cname.includes(cName)) return false;
        return true;
      });

      // **调整分页逻辑（匹配图片中的排列顺序）**
      // 图片中显示顺序：免费课程1、免费课程4、免费课程5、收费课程1、收费课程2、收费课程3、免费课程2、免费课程3、收费课程4、收费课程5
      // 手动排序模拟（实际开发中需后端返回正确顺序）
      const sortedCourses = filteredCourses.sort((a, b) => {
        const order = [1,4,5,6,7,8,2,3,9,10]; // 按图片中的显示顺序定义ID优先级
        return order.indexOf(Number(a.id)) - order.indexOf(Number(b.id));
      });
            const start = (page - 1) * limit;
            const end = start + limit;
            this.videoCourses = sortedCourses.slice(start, end);
            this.videoTotal = sortedCourses.length;
            this.cName = cName;
            this.type = type;
            this.page = page;
            this.limit = limit;
			},
		},
		mounted() {
			// 根据session中存储的课程名进行查询
			var name = sessionStorage.getItem("cName")
			this.selectByRequire(name, 2, 1, 12);
			// 进去之后将session中存储的cName变为空串
			sessionStorage.setItem("cName", "")
		}
	};
</script>

<style>
	div {
		color: black;
	}
</style>
