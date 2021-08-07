<template>
  <div v-if='locked' :class="['page', 'flex', 'center']">
    <h1>Please connect your wallet to continue</h1>
    <button class='btn btn-primary mt20' @click='$emit("connectWallet")'>Connect Wallet</button>
  </div>
</template>

<script>
import { ethers } from "ethers";

export default {
  name: 'Connect Wallet',
  props: {
    locked: Boolean,
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
