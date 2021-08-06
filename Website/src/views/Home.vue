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
      <Llama :for='lamma in lammas' :id='lamma' :provider='provider' :signer='signer' />
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
      llamaCount: 0,
      llamas: [],
    }
  },
  methods: {
    feedLlama() {
      this.$emit('feedLlama');
    },
  },
  async created() {
    const contractAddress = '0xc2Df94666757bEb8c16385eF0187112395649c9C';
    const contractAbi = ["function tokenOfOwnerByIndex(address owner, uint256 index) external view returns (uint256 tokenId);","function balanceOf(address owner) external view returns (uint256 balance);","function getLlama(uint256 id) external view returns(string memory name, uint256 cooldownHunger, uint256 createdOn, uint256 fatherId, uint256 motherId, uint256 level)"]

    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner()

    const contract = new ethers.Contract(contractAddress, contractAbi, signer);

    const address = await signer.getAddress();
    const balance = JSON.parse(await contract.balanceOf(address));

    console.log(address);
    console.log(balance);

    this.llamaCount = balance;

    for (var i = 0; i < balance; i++) {
      this.llamas.push(await contract.tokenOfOwnerByIndex(address, i));
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
