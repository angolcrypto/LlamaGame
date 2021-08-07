<template>
  <div class='box'>
    <div class='image-side'>
      <img class='image' src='https://d1wo2tfj2enqpq.cloudfront.net/svgs/11.png' />
    </div>
    <div class='stats-side'>
      <h1>Llama #{{llamaId}}</h1>
      <h3>Name: {{llamaName}}</h3>
      <h3>Level: {{llamaLevel}}</h3>
      <br>
      <button :class="llamaOnCooldown ? 'btn btn-secondary' : 'btn btn-primary'" @click='manageButton'>Feed</button>
      <button class='btn btn-primary' style='margin-left: 7px;' @click='sendButton'>Transfer</button>
    </div>
  </div>
</template>

<script>
import { ethers } from "ethers";

export default {
  props: {
    ida: null,
  },
  data() {
    return {
      llamaName: String,
      llamaId: Number,
      llamaLevel: Number,
      llamaOnCooldown: Boolean,
    }
  },
  methods: {
    manageButton() {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner()

      const contractAddress = '0xc2Df94666757bEb8c16385eF0187112395649c9C';
      const contractAbi = ["function feedMyLlama(uint256 _tokenId) external onlyOwnerOf(_tokenId)"];

      const contract = new ethers.Contract(contractAddress, contractAbi, signer);

      const tx = contract.
    }
  },
  async created() {
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

    if(JSON.parse(llamaData.cooldownHunger) > Date.now()) {
      this.llamaOnCooldown = true;
    } else {
      this.llamaOnCooldown = false;
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
