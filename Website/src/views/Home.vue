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
      <Llama v-for='llama in llamasArray' :key='llama' :ida='llama.id' />
    </div>
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
      llamasArray: [],
    }
  },
  methods: {
    feedLlama() {
      this.$emit('feedLlama');
    },
    async getLlamas() {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();

      const contractAddress = '0xc2Df94666757bEb8c16385eF0187112395649c9C';
      const contractAbi = ["function tokenOfOwnerByIndex(address owner, uint256 index) external view returns (uint256 tokenId)","function balanceOf(address owner) external view returns (uint256 balance)","function getLlama(uint256 id) external view returns(string memory name, uint256 cooldownHunger, uint256 createdOn, uint256 fatherId, uint256 motherId, uint256 level)"];

      const contract = new ethers.Contract(contractAddress, contractAbi, signer);

      const address = await signer.getAddress();
      const balance = JSON.parse(await contract.balanceOf(address));

      console.log('Address: '+address);
      console.log('Balance: '+balance);

      this.llamaCount = balance;

      let llamas = [];

      for (var i = 0; i < balance; i++) {
        let llama = JSON.parse(await contract.tokenOfOwnerByIndex(address, i));
        llamas.push({id: llama});
        console.log('Llama ID: '+llama);
      }

      console.log('DEBUGGING!')
      console.log(llamas);
      this.llamasArray = llamas;
      console.log(this.llamasArray);

    }
  },
  mounted() {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner()

    console.log(provider);
    console.log(signer);
    if(provider == null) {
      this.$router.push('/');
    } else {
      this.getLlamas();
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
