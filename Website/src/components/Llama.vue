<template>
  <div id='box' class='box' style='margin-top: 7px; margin-bottom: 7px;'>
    <div class='image-side'>
      <img class='image' src='https://d1wo2tfj2enqpq.cloudfront.net/svgs/11.png' />
    </div>
    <div class='stats-side'>
      <h1>Llama #{{llamaId}}</h1>
      <h3>Name: {{llamaName}}</h3>
      <h3>Level: {{llamaLevel}}</h3>
      <p style='display: inline-block;'>{{cooldownText}}</p>
      <br>
      <button :class="llamaOnCooldown ? 'btn btn-secondary' : 'btn btn-primary'" :disabled='llamaOnCooldown' @click='feedButton'>Feed</button>
      <button class='btn btn-primary' data-toggle="modal" data-target="#transferModal" style='margin-left: 7px;' @click='sendButton'>Transfer</button>
    </div>
  </div>
  <TransferModal :id='llamaId'/>
</template>

<script>
import TransferModal from '@/components/TransferModal.vue';

import { ethers } from "ethers";

export default {
  props: {
    ida: null,
  },
  components: {
    TransferModal,
  },
  data() {
    return {
      llamaName: String,
      llamaId: Number,
      llamaLevel: Number,
      llamaOnCooldown: Boolean,
      cooldownText: String,
      style: String,
    }
  },
  methods: {
    async feedButton() {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner()

      const contractAddress = '0xc2Df94666757bEb8c16385eF0187112395649c9C';
      const contractAbi = ["function feedMyLlama(uint256 _tokenId) external"];

      const contract = new ethers.Contract(contractAddress, contractAbi, signer);

      const tx = await contract.feedMyLlama(this.llamaId);
      console.log(tx);
      this.cooldownText = '6 hours remaining';
      this.llamaOnCooldown = true;
      this.llamaLevel = this.llamaLevel + 1;
    }
  },
  async mounted() {

    // Unrelated to smart-contracts


    // Smart Contract Stuff

    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner()

    const contractAddress = '0xc2Df94666757bEb8c16385eF0187112395649c9C';
    const contractAbi = ["function getLlama(uint256 id) external view returns(string memory name, uint256 cooldownHunger, uint256 createdOn, uint256 fatherId, uint256 motherId, uint256 level)"];

    const contract = new ethers.Contract(contractAddress, contractAbi, signer);

    console.log(contract);
    console.log(this.ida);
    console.log('ID of Llama Component: '+this.ida)

    this.llamaId = this.ida;

    const llamaData = await contract.getLlama(this.ida);
    console.log(llamaData);

    this.llamaName = llamaData.name;
    this.llamaLevel = JSON.parse(llamaData.level);

    console.log(JSON.parse(llamaData.cooldownHunger));
    console.log(Date.now());

    const now = Date.now() / 1000; // Date.now() returns miliseconds but contract returns seconds, dividing Date.now() by 1,000 gives us the UNIX-time in seconds rather than miliseconds

    if(JSON.parse(llamaData.cooldownHunger) > now) {
      this.llamaOnCooldown = true;
      let remaining = (JSON.parse(llamaData.cooldownHunger) - now)/3600; // Dividing by 3,600 converts the seconds into hours
      let remainingUnit = 'hours';
      if(remaining < 1) {
        if(remaining*60 > 1) {
          remaining = remaining*60; // If the result of the sum converting seconds into hours returns something less than one, that means that the time left is less than an hour. We should show this time as minutes instead.
          remainingUnit = 'minutes';
        } else if(remaining*60 < 1) {
          remaining = (remaining*60)*60; // Converts the minutes into seconds if there's less than a minute left.
          remainingUnit = 'seconds';
        }
      }
      this.cooldownText = Math.round(remaining * 10) / 10+' '+remainingUnit+' remaining';
    } else {
      this.llamaOnCooldown = false;
      this.cooldownText = 'Your llama is hungry.';
    }
  }
}
</script>

<style scoped>
.box {
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: row;
  background: #212529;
  color: white;
  padding: 20px 20px 20px 20px;
  border-radius: 25px;
}

.image-side {

}

.stats-side {
  margin-left: 25px;
  margin-right: 35px;
}

.image {
  height: 200px;
}
</style>
