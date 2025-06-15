<template>
  <div class="source-container">
    <a-row :gutter="16">
      <a-col :span="18">
        <a-card :title="currentText.title" class="text-content-card">
          <div class="text-content" v-html="currentText.content"></div>
        </a-card>
      </a-col>
      <a-col :span="6">
        <a-card title="文本标题列表" class="text-list-card">
          <a-menu mode="inline" @click="handleTitleClick">
            <a-menu-item v-for="text in texts" :key="text.id">
              {{ text.title }}
            </a-menu-item>
          </a-menu>
        </a-card>
      </a-col>
    </a-row>
  </div>
</template>

<script>
export default {
  name: 'Source',
  data() {
    return {
      texts: [
        {
          id: 1,
          title: 'Vue.js 入门指南',
          content: '<h3>Vue.js 是什么？</h3><p>Vue.js 是一套用于构建用户界面的渐进式框架。与其它大型框架不同的是，Vue 被设计为可以自底向上逐层应用。Vue 的核心库只关注视图层，方便与第三方库或既有项目整合。另一方面，当与现代化的工具链以及各种支持类库结合使用时，Vue 也完全能够为复杂的单页应用提供驱动。</p><p>本指南将帮助您快速开始使用 Vue.js。</p>'
        },
        {
          id: 2,
          title: 'JavaScript 基础',
          content: '<h3>JavaScript 简介</h3><p>JavaScript 是一种具有函数优先的轻量级、解释型或即时编译型的编程语言。它是一种基于原型编程、多范式的动态脚本语言，并且支持面向对象、命令式和声明式（如函数式编程）风格。</p><p>本节将涵盖 JavaScript 的基本语法、变量、数据类型、运算符、控制流等。</p>'
        },
        {
          id: 3,
          title: 'CSS 样式设计',
          content: '<h3>CSS 概述</h3><p>层叠样式表 (Cascading Style Sheets，简称 CSS) 是一种样式表语言，用来描述 HTML 或 XML（包括如 SVG、MathML 等各种 XML 方言）文档的呈现。CSS 描述了在屏幕、纸质、音频等其他媒体上元素应该如何被渲染的问题。</p><p>了解如何使用 CSS 美化您的网页。</p>'
        },
        {
          id: 4,
          title: 'Ant Design Vue 使用',
          content: '<h3>Ant Design Vue 简介</h3><p>Ant Design Vue 是一套企业级 UI 组件库，基于 Ant Design 和 Vue。它提供了丰富的组件，帮助开发者快速构建美观且功能强大的应用。</p><p>本指南将向您展示如何集成和使用 Ant Design Vue 组件。</p>'
        },
      ],
      currentText: {}
    };
  },
  created() {
    // 默认显示第一个文本内容
    if (this.texts.length > 0) {
      this.currentText = this.texts[0];
    }
  },
  methods: {
    handleTitleClick(e) {
      const selectedId = parseInt(e.key);
      this.currentText = this.texts.find(text => text.id === selectedId);
    }
  }
};
</script>

<style scoped>
.source-container {
  padding: 20px;
}

.text-content-card {
  min-height: 500px;
}

.text-content {
  font-size: 16px;
  line-height: 1.8;
  white-space: pre-wrap; /* 保留文本中的换行符和空格 */
}

.text-list-card {
  min-height: 500px;
}
</style>