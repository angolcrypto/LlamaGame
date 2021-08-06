<template>
  <div v-if='!locked' :class="['page', 'flex', 'center', 'height100', 'width100']">
    <div v-if='llamaCount == 0' class='flex center ' id='newPlayers'>
      <h1>Welcome to your llama farm! 🚀</h1>
      <h3>To get started, adopt a llama with the button below.</h3>
      <button class='btn btn-primary mt20 width100' @click='feedLlama'>Adopt My Llama</button>
    </div>
    <div v-if='llamaCount > 0' class='flex center' id='oldPlayers'>
      <h1>Welcome back! 🥳</h1>
      <h3>Your llamas missed you dearly.</h3>
      <Llama :id='0' :provider='provider' :signer='signer' />
    </div>
  </div>
  <div v-if='locked' :class="['page', 'flex', 'center']">
    <h1>Please connect your wallet to continue</h1>
    <button class='btn btn-primary mt20' @click='$emit("connectWallet")'>Connect Wallet</button>
  </div>
</template>

<script>
import Llama from '@/components/Llama.vue';
import { ethers } from "ethers";

export default {
  name: 'Home',
  props: {
    locked: Boolean,
    signer: null,
    provider: null,
  },
  components: {
    Llama,
  },
  data() {
    return {
      llamaCount: 2,
    }
  },
  methods: {
    feedLlama() {
      this.$emit('feedLlama');ßß
    }
  }
}
</script>

<style scoped>
.width80 {
  width: 100%;
}

.mt20 {
  margin-top: 20px;
}

.height100 {
  height: 100%;
}
</style>
