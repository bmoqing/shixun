// src/mockData.js

// 模拟直播课程数据
export const mockLiveCourses = [
  // 免费课程（ctype: 0）
  {
    id: 1,
    url: require('@/assets/images/5.jpg'),
    cname: '免费课程1',
    ccontent: 'Linux',
    ctype: '0'
  },
  {
    id: 2,
    url: require('@/assets/images/6.jpg'),
    cname: '免费课程2',
    ccontent: 'Nginx',
    ctype: '0'
  },
  {
    id: 3,
    url: require('@/assets/images/12.jpg'),
    cname: '免费课程3',
    ccontent: 'Docker',
    ctype: '0'
  },
  {
    id: 4,
    url: require('@/assets/images/11.jpg'),
    cname: '免费课程4',
    ccontent: 'Vue',
    ctype: '0'
  },
  {
    id: 5,
    url: require('@/assets/images/10.jpg'),
    cname: '免费课程5',
    ccontent: 'Spring Boot',
    ctype: '0'
  },
  // 付费课程（ctype: 1）
  {
    id: 6,
    url: require('@/assets/images/9.jpg'),
    cname: '收费课程1',
    ccontent: '云计算',
    ctype: '1',
    cinMoney: 99,
    coldMoney: 199
  },
  {
    id: 7,
    url: require('@/assets/images/8.jpg'),
    cname: '收费课程2',
    ccontent: 'JS框架技术',
    ctype: '1',
    cinMoney: 199,
    coldMoney: 299
  },
  {
    id: 8,
    url: require('@/assets/images/7.jpg'),
    cname: '收费课程3',
    ccontent: '响应式框架',
    ctype: '1',
    cinMoney: 299,
    coldMoney: 399
  },
  {
    id: 9,
    url: require('@/assets/images/6.jpg'),
    cname: '收费课程4',
    ccontent: 'MySQL',
    ctype: '1',
    cinMoney: 399,
    coldMoney: 499
  },
  {
    id: 10,
    url: require('@/assets/images/5.jpg'),
    cname: '收费课程5',
    ccontent: 'Apache',
    ctype: '1',
    cinMoney: 499,
    coldMoney: 599
  }
];

// 模拟视频课程数据
export const mockVideos = [
  // 5 个免费课程
  {
    id: 1,
    cid: 1,
    imgTop: require('@/assets/images/1.jpg'),
    cname: '免费课程 1',
    ccontent: '免费课程 1 的描述',
    ctype: '0',
    cinMoneyShow: '0',
    coldMoneyShow: '0'
  },
  {
    id: 2,
    cid: 2,
    imgTop: require('@/assets/images/4.jpg'),
    cname: '免费课程 2',
    ccontent: '免费课程 2 的描述',
    ctype: '0',
    cinMoneyShow: '0',
    coldMoneyShow: '0'
  },
  {
    id: 3,
    cid: 3,
    imgTop: require('@/assets/images/5.jpg'),
    cname: '免费课程 3',
    ccontent: '免费课程 3 的描述',
    ctype: '0',
    cinMoneyShow: '0',
    coldMoneyShow: '0'
  },
  {
    id: 4,
    cid: 4,
    imgTop: require('@/assets/images/6.jpg'),
    cname: '免费课程 4',
    ccontent: '免费课程 4 的描述',
    ctype: '0',
    cinMoneyShow: '0',
    coldMoneyShow: '0'
  },
  {
    id: 5,
    cid: 5,
    imgTop: require('@/assets/images/7.jpg'),
    cname: '免费课程 5',
    ccontent: '免费课程 5 的描述',
    ctype: '0',
    cinMoneyShow: '0',
    coldMoneyShow: '0'
  },
  // 5 个收费课程
  {
    id: 6,
    cid: 6,
    imgTop: require('@/assets/images/8.jpg'),
    cname: '收费课程 1',
    ccontent: '收费课程 1 的描述',
    ctype: '1',
    cinMoneyShow: '99',
    coldMoneyShow: '199'
  },
  {
    id: 7,
    cid: 7,
    imgTop: require('@/assets/images/8.jpg'),
    cname: '收费课程 2',
    ccontent: '收费课程 2 的描述',
    ctype: '1',
    cinMoneyShow: '199',
    coldMoneyShow: '299'
  },
  {
    id: 8,
    cid: 8,
    imgTop: require('@/assets/images/7.jpg'),
    cname: '收费课程 3',
    ccontent: '收费课程 3 的描述',
    ctype: '1',
    cinMoneyShow: '299',
    coldMoneyShow: '399'
  },
  {
    id: 9,
    cid: 9,
    imgTop: require('@/assets/images/6.jpg'),
    cname: '收费课程 4',
    ccontent: '收费课程 4 的描述',
    ctype: '1',
    cinMoneyShow: '399',
    coldMoneyShow: '499'
  },
  {
    id: 10,
    cid: 10,
    imgTop: require('@/assets/images/6.jpg'),
    cname: '收费课程 5',
    ccontent: '收费课程 5 的描述',
    ctype: '1',
    cinMoneyShow: '499',
    coldMoneyShow: '599'
  }
];