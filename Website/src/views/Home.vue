<template>
  <div v-if='!locked' :class="['page', 'flex', 'center']">
    <h1>Llama Game</h1>
    <button class='btn btn-primary' @click='feedLlama'>Feed My Llama</button>
  </div>
  <div v-if='locked' :class="['page', 'flex', 'center']">
    <h1>Please connect your wallet to continue</h1>
    <button class='btn btn-primary' @click='$emit("connectWallet")'>Connect Wallet</button>
  </div>
</template>

<script>
export default {
  name: 'Home',
  props: {
    locked: Boolean,
  },
  data() {
    return {

    }
  },
  methods: {
    feedLlama() {
      this.$emit('feedLlama');
    }
  }
}
</script>

<style scoped>

</style>
