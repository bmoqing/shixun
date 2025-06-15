<template>
	<div class="about">
		<a-carousel autoplay>
		    <div v-for="item in listData" :key="item.id">
		    	<img style="width: 100%;height: 100%;" :src="item.img" />
		    </div>
		</a-carousel>
	</div>
</template>

<script>
	// import Swiper from 'swiper'
	export default {
		props: {
			listData: {
				type: Array,
				required: true,
				default: ""
			}
		},
		name: 'Banner',
		data() {
			return {}
		},
		mounted() {
		}
	}
</script>

<style scoped>
	.about {
		height: 100%;
	}
	.ant-carousel{
		height: 100%;
		width:100%;
	}
	.ant-carousel >>> .slick-slide {
	  height: 100%;
	  background: #364d79;
	  overflow: hidden;
	}
	.ant-carousel >>> div{
		height: 100%;
		width: 100%;
	}
	.ant-carousel >>> .slick-initialized{
		height: 100%!important;
	}
	.ant-carousel >>> .slick-list{
		height: 100%;
		/* border-radius: 10px 0 0 10px; */
		border-radius: 10px;
	}
	.ant-carousel >>> .slick-slide h3 {
	  color: #fff;
	}
	
</style>
