import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
	state: {
	user: null,
	purchasedLiveCourses: [],
    purchasedVideoCourses: []
	},
	mutations: {
		setUser(state, userObj) {
			state.user = userObj
		},
		clearUser(state) {
			state.user = null;
		},
		addPurchasedLiveCourse(state, course) {
		state.purchasedLiveCourses.push(course);
		},
		addPurchasedVideoCourse(state, course) {
		state.purchasedVideoCourses.push(course);
		}
	},
	actions: {},
	modules: {}
})
