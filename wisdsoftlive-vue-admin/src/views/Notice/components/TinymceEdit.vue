<template>
	<div class="tinymce-editor">
		<editor id="add" v-model="myValue" :init="init" :disabled="disabled"></editor>
	</div>
</template>
<script>
	import axios from 'axios'
	import tinymce from 'tinymce/tinymce'
	import Editor from '@tinymce/tinymce-vue'
	import 'tinymce/themes/silver'
	import 'tinymce/icons/default/icons.min.js'
	// 编辑器插件plugins
	// 更多插件参考：https://www.tiny.cloud/docs/plugins/
	import 'tinymce/plugins/image' // 插入上传图片插件
	import 'tinymce/plugins/media' // 插入视频插件
	import 'tinymce/plugins/table' // 插入表格插件
	import 'tinymce/plugins/lists' // 列表插件
	import 'tinymce/plugins/wordcount' // 字数统计插件
	export default {
		name: 'TinymceEdit',
		components: {
			Editor
		},
		props: {
			value: {
				type: String,
				default: ''
			},
			disabled: {
				type: Boolean,
				default: false
			},
			plugins: {
				type: [String, Array],
				default: 'lists image table wordcount'
			},
			toolbar: {
				type: [String, Array],
				default: 'undo redo |  formatselect | bold italic forecolor backcolor | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | lists image media table | removeformat'
			}
		},
		data() {
			return {
				init: {
					selector: '#add',
					language_url: '/tinymce1/zh_CN.js', //public目录下
					language: 'zh_CN',
					skin_url: '/tinymce1/skins/ui/oxide', //public目录下
					height: 800,
					width:880,
					plugins: this.plugins, // 父组件传入 或者 填写个默认的插件 要选用什么插件都可以 去官网可以查到
					toolbar: this.toolbar, // 工具栏 我用到的也就是lists image media table wordcount 这些 根据需求而定
					images_upload_url: '', //上传路径
					images_upload_base_path: "",
					automatic_uploads: true, //设置为true才能触发回调方法
					inline: false,
					images_upload_handler: (blobInfo, success, failure) => {
						var form = new FormData();
						//  根据自己的需求取值
						form.append('file', blobInfo.blob());
						axios.post(this.$global_msg.adminRoute +'/notice/addImg', form)
							.then(data => {
								console.log(data);
								success(data.data);
							})
							.catch(res => {
								failure("error");
							});
					},
				},
				myValue: this.value
			}
		},
		mounted() {
			tinymce.init({})
		},
		methods: {

		},
		watch: {
			value(newValue) {
				this.myValue = newValue
			},
			myValue(newValue) {
				this.$emit('input', newValue)
			}
		}
	}
</script>
