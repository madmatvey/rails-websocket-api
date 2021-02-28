<template>
  <div id="app">
    <p>{{ message }}</p>
    <p>visitorId: {{ visitorId }}</p>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
export default {
  channels: {
    AppChannel: {
      connected() {},
      rejected() {},
      received(data) {
        console.log("RECEIVED: ", data)
        this.$store.dispatch('handle_ws_message', data)
      },
      disconnected() {}
    },
  },
  computed: {
    ...mapGetters(['visitorId', 'message'])
  },
  methods: {
    unsubscribe() {
      this.$cable.unsubscribe({
        channel: 'AppChannel',
        room: 'public',
        visitor_id: this.visitorId});
    }
  },
  mounted() {
    this.$store.dispatch('authenticate')
  },
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
