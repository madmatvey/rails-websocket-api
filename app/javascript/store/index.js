import Vue from 'vue'
import Vuex from 'vuex'
Vue.use(Vuex)
import FingerprintJS from '@fingerprintjs/fingerprintjs'
/* eslint-disable no-param-reassign */
export default new Vuex.Store({
  state: {
    message: "Hello!",
    visitorId: null
  },
  mutations: {
    login (state, payload) {
      this.$cable.subscribe({
        channel: 'AppChannel',
        room: 'public',
        visitor_id: payload,
      })
      state.visitorId = payload
    },
    setMessage (state, payload) {
      state.message = payload
    },
    update_visitors_count (state, visitors_count) {
      state.message = `Hello! You are one of ${visitors_count} visitors`
    }
  },
  actions: {
    authenticate ({ commit }) {
      (async () => {
        const fp = await FingerprintJS.load()
        const result = await fp.get()
        console.log("visitorId: ", result.visitorId)
        commit('login', result.visitorId)
      })()
    },
    handle_ws_message ({ commit }, { method, content }) {
      console.log("method: ", method)
      console.log("content: ", content)
      commit(method, content)
    }
  },
  getters: {
    visitorId: function (state) {
      return state.visitorId
    },
    message: function (state) {
      return state.message
    }
  }
})
