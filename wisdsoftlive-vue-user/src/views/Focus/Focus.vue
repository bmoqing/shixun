<template>
  <div class="focus-container">
    <a-card title="我的订阅课程">
      <a-list item-layout="horizontal" :data-source="subscribedCourses">
        <a-list-item slot="renderItem" slot-scope="item">
          <a-list-item-meta>
            <a-avatar slot="avatar" :src="item.imageUrl" />
            <a slot="title">{{ item.name }}</a>
            <div slot="description">{{ item.description }}</div>
          </a-list-item-meta>
        </a-list-item>
      </a-list>
    </a-card>
  </div>
</template>

<script>
export default {
  name: 'Focus',
  data() {
    return {
      subscribedCourses: [
        {
          id: 1,
          name: '免费课程1',
          description: '这是您订阅的免费课程1的描述。',
          // 确保图片路径正确，可以根据您的项目实际路径进行调整
          imageUrl: require('@/assets/images/1.jpg') // 假设您有一张名为 1.jpg 的图片
        },
        {
          id: 2,
          name: '免费课程5',
          description: '这是您订阅的免费课程5的描述。',
          // 确保图片路径正确，可以根据您的项目实际路径进行调整
          imageUrl: require('@/assets/images/5.jpg') // 假设您有一张名为 5.jpg 的图片
        }
      ]
    };
  }
};
</script>

<style scoped>
.focus-container {
  padding: 20px;
}
</style>