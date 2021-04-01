/* eslint no-console: 0 */
import Vue from 'vue'
import TurbolinksAdapter from 'vue-turbolinks'
import ActionCableVue from 'actioncable-vue'
import App from '../app.vue'
import store from '../store'

Vue.use(TurbolinksAdapter)
Vue.use(ActionCableVue, {
  debug: true,
  debugLevel: 'all',
  connectionUrl: 'wss://foot.vote/api/websocket', // process.env.WEBSOCKET_HOST,
  connectImmediately: true,
  store
});

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    component: App,
    store,
    render: h => h(App)
  }).$mount('#hello')
})
