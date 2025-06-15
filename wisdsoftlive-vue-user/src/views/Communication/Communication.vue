<template>
  <div class="communication-container">
    <h1>交流区</h1>
    <a-card :bordered="false">
      <a-textarea
        v-model="newMessage"
        placeholder="发表你的看法..."
        :rows="4"
      />
      <a-button type="primary" @click="postMessage" :disabled="!newMessage.trim()">
        发表
      </a-button>
    </a-card>

    <a-list
      item-layout="vertical"
      size="large"
      :data-source="messages"
      class="message-list"
    >
      <a-list-item slot="renderItem" key="item.id" slot-scope="item">
        <a-list-item-meta>
          <a-avatar slot="avatar" icon="user" />
          <a slot="title">{{ item.author }}</a>
          <div slot="description">{{ item.timestamp }}</div>
        </a-list-item-meta>
        <p>{{ item.content }}</p>
      </a-list-item>
    </a-list>
  </div>
</template>

<script>
import moment from 'moment'; // For timestamp formatting

export default {
  name: 'Communication',
  data() {
    return {
      newMessage: '',
      messages: [
        // Initial mock messages
        {
          id: 1,
          author: '用户A',
          content: '欢迎大家来到交流区，有什么技术问题可以在这里讨论！',
          timestamp: '2023-01-01 10:00:00',
        },
        {
          id: 2,
          author: '用户B',
          content: '请问有没有关于Vue 3 Composition API的教程推荐？',
          timestamp: '2023-01-01 10:15:00',
        },
      ],
    };
  },
  methods: {
    postMessage() {
      if (this.newMessage.trim()) {
        const newId = this.messages.length > 0 ? Math.max(...this.messages.map(m => m.id)) + 1 : 1;
        this.messages.unshift({ // Add to the beginning of the array
          id: newId,
          author: this.$store.state.user ? this.$store.state.user.username : '匿名用户', // Use actual username if logged in
          content: this.newMessage.trim(),
          timestamp: moment().format('YYYY-MM-DD HH:mm:ss'),
        });
        this.newMessage = ''; // Clear the input field
      }
    },
  },
  // 您可能希望在此处从后端 API 获取消息
  // created() {
  //   this.fetchMessages();
  // },
  // methods: {
  //   async fetchMessages() {
  //     try {
  //       const response = await this.$axios.get(this.$global_msg.communicationRoute + '/messages'); // Assuming a communicationRoute in global_msg
  //       this.messages = response.data;
  //     } catch (error) {
  //       console.error('Error fetching messages:', error);
  //     }
  //   },
  //   async postMessage() {
  //     if (this.newMessage.trim()) {
  //       try {
  //         const response = await this.$axios.post(this.$global_msg.communicationRoute + '/messages', {
  //           author: this.$store.state.user ? this.$store.state.user.username : '匿名用户',
  //           content: this.newMessage.trim(),
  //         });
  //         this.messages.unshift(response.data); // Add the new message to the list
  //         this.newMessage = '';
  //       } catch (error) {
  //         console.error('Error posting message:', error);
  //       }
  //     }
  //   },
  // },
};
</script>

<style scoped>
.communication-container {
  padding: 20px;
}

.ant-card {
  margin-bottom: 20px;
}

.ant-textarea {
  margin-bottom: 10px;
}

.message-list {
  background-color: #fff;
  padding: 20px;
  border-radius: 8px;
}

.ant-list-item-meta-title a {
  font-size: 16px;
  font-weight: bold;
}

.ant-list-item-meta-description {
  color: rgba(0, 0, 0, 0.45);
}

.ant-list-item p {
  margin-top: 10px;
  font-size: 15px;
  line-height: 1.6;
}
</style>