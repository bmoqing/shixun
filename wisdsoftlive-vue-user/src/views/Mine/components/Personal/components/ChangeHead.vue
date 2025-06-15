<template>
	<div>
		<a-drawer title="修改头像" :placement="placement" :closable="false" :visible="visible" @close="onClose">
			<div class="body">
				<div class="head" v-for="item in portraitData" @click="changeThis(item.id, item.img)">
					<input id="id" :value="item.id" hidden="hidden" />
					<a-card hoverable style="width: 100%">
						<img slot="cover" alt="example" :src="item.img" />
					</a-card>
					<a-icon v-if="headId === item.id" type="check" />
				</div>
			</div>
		</a-drawer>
	</div>
</template>

<script>
	import axios from 'axios';
	export default {
		name: 'ChangeHead',
		props: {
			visible: Boolean,
			imgId: Number,
			img: String
		},
		data() {
			return {
				placement: 'top',
				portraitData: '',
				headId: 0,
				headUrl: ''
			};
		},
		methods: {
			onClose() {
				this.$emit('changeHead', this.headId, this.headUrl);
				this.$emit('closeHead');
			},
			changeThis(headId, headUrl) {
				this.headId = headId;
				this.headUrl = headUrl;
			},
		},
		watch: {
			visible() {
				this.headId = this.imgId;
				this.headUrl = this.img;
				if (this.visible === true) {
					axios
						.get(this.$global_msg.userRoute + '/portrait/selectAllPortrait')
						.then(a => {
							this.portraitData = a.data.data
						})
						.catch(e => {
							console.log(e);
						});
				}
			}
		}
	};
</script>

<style scoped="scoped">
	.body {
		width: 100%;
		display: flex;
		flex-wrap: wrap;
		padding-left: 2%;
	}

	.head {
		width: 10%;
		height: 1px;
		margin-right: 1%;
		color: #14a104;
		text-align: center;
		font-size: 16px;
	}

	.head img {
		width: 100%;
	}
</style>
