<template>
  <div class='box'>
    <div class='image-side'>
      <img class='image' src='https://d1wo2tfj2enqpq.cloudfront.net/svgs/11.png' />
    </div>
    <div class='stats-side'>
      <h1>Llama #{{llamaId}}</h1>
      <h3>Name: {{llamaName}}</h3>
      <h3>Level: {{llamaLevel}}</h3>
    </div>
  </div>
</template>

<script>
import { ethers } from "ethers";

export default {
  props: {
    id: Number,
    signer: null,
    provider: null,
  },
  data() {
    return {
      llamaName: String,
      llamaId: Number,
      llamaLevel: Number,
    }
  },
  async created() {
    const contractAddress = '0xc2Df94666757bEb8c16385eF0187112395649c9C';
    const contractAbi = ["function getLlama(uint256 id) external view returns(string memory name, uint256 cooldownHunger, uint256 createdOn, uint256 fatherId, uint256 motherId, uint256 level)"]

    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner()

    const contract = new ethers.Contract(contractAddress, contractAbi, signer);

    console.log(contract);

    this.llamaId = this.id;

    const llamaData = await contract.getLlama(this.id);
    console.log(llamaData);

    this.llamaName = llamaData.name;
    this.llamaLevel = JSON.parse(llamaData.level);
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
