<template>
	<div>
		<top @showList="showList" :name="name" :page="page" :limit="limit"></top>
		<list @showList="showList" :total="total" :tableData="tableData" :name="name" :page="page" :limit="limit"
			:dataText="dataText">
			<edit @showList="showList" :name="name" :page="page" :limit="limit"></edit>
		</list>
	</div>
</template>

<script>
import Top from './components/Top.vue';
import List from './components/List.vue';
import Edit from './components/Edit.vue';
import Add from './components/Add.vue';
import axios from 'axios';
export default {
	name: '',
	data() {
		return {
			tableData: [],
			total: 0,
			name: "",
			page: 1,
			limit: 10,
			loading: true,
			dataText: "  "
		}
	},
	components: {
		Top,
		List,
		Edit,
		Add
	},
	methods: {
		// 查询分页数据
		showList(name, page, limit) {
			this.name = name
			this.page = page
			this.limit = limit
			this.loading = true
			this.dataText = "  "
			// axios.get(this.$global_msg.adminRoute + '/course/selectCourseByName', {
			// 		params: {
			// 			name: name,
			// 			page: page,
			// 			limit: limit
			// 		}
			// 	})
			// 	.then((res) => {
			// 		this.tableData = res.data.data;
			// 		this.total = res.data.count;
			// 		this.changeLoadingType();
			// 	}).catch((response) => {
			// 		console.log(response);
			// 		this.changeLoadingType();
			// 	})
			// 模拟数据 - 替代真实的axios请求
			const mockData = {
				data: [
					{ id: 1, name: '课程1', content: '这是第一个模拟课程', teacher: '张老师',sectionNumber:'10-12',type:'1' },
					{ id: 2, name: '课程2', content: '这是第二个模拟课程', teacher: '李老师',sectionNumber:'1-12' },
					{ id: 1, name: '课程1', description: '这是第一个模拟课程', teacher: '张老师' },
					{ id: 2, name: '课程2', description: '这是第二个模拟课程', teacher: '李老师' },
					{ id: 1, name: '课程1', description: '这是第一个模拟课程', teacher: '张老师' },
					{ id: 2, name: '课程2', description: '这是第二个模拟课程', teacher: '李老师' },
					{ id: 1, name: '课程1', description: '这是第一个模拟课程', teacher: '张老师' },
					{ id: 2, name: '课程2', description: '这是第二个模拟课程', teacher: '李老师' },	
					{ id: 2, name: '课程2', description: '这是第二个模拟课程', teacher: '李老师' },
					{ id: 1, name: '课程1', description: '这是第一个模拟课程', teacher: '张老师' },
					{ id: 2, name: '课程2', description: '这是第二个模拟课程', teacher: '李老师' }
					
					// 可以添加更多模拟数据...
				],
				count: 2 // 模拟总数据量
			};

			// 模拟网络请求延迟
			setTimeout(() => {
				this.tableData = mockData.data;
				this.total = mockData.count;
				if(this.total==0){
					this.changeLoadingType();
				}
			}, 500); // 500毫秒延迟模拟网络请求

		},
		changeLoadingType() {
			this.dataText = "暂无数据"
			this.loading = false
		}


	}
}
</script>

<style></style>
