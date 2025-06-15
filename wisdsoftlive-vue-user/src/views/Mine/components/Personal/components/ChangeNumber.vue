<template>
	<a-modal :destroyOnClose="true" :visible="visibleNumber" title="校内人员认证" @cancel="close()" ok-text="认证" cancel-text="取消"
	 @ok="authentication()">
		<a-input v-model="number" placeholder="请输入您要认证的学号" />
	</a-modal>
</template>

<script>
	import axios from 'axios'
	export default {
		name: 'ChangeNumber',
		props: {
			visibleNumber: Boolean
		},
		data() {
			return {
				number: ''
			};
		},
		methods: {
			close() {
				this.$emit('closeNumber')
			},
			authentication() {
				let data = new FormData();
				data.append("id", 2);
				data.append("number", this.number);
				axios
					.post(this.$global_msg.userRoute + '/user/certifiedAsSchoolStaff', data)
					.then(a => {
						var type = a.data.data
						if (type == 0) {
							this.$message.error('该学号不存在');
						} else if (type == 1) {
							this.$message.error('该学号已经被认证');
						} else if (type == 2) {
							this.$message.success('认证成功');
							this.$emit('changeAuthenticationType', this.number)
							this.close()
						} else if (type == 3) {
							this.$message.error('认证失败');
						}
					})
					.catch(e => {
						this.$message.error('修改失败');
					});
			},
		},
	};
</script>

<style>

</style>
