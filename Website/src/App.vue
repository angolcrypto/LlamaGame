<template>
  <div :class='["fullview", darkmode ? "darkmode" : "lightmode"]'>
    <Navbar @disconnectWallet='disconnectWallet' @connectWallet='connectWallet' :brand='brand' :pages='pages' :buttons='buttons' :darkmode='darkmode'/>
    <router-view @connectWallet='connectWallet' :locked='locked' @feedLlama='feedLlama' :signer = 'signer' :provider='provider' :darkmode='darkmode' />
  </div>
</template>

<script>
import Navbar from '@/components/Navbar'
import { ethers } from "ethers";

export default {
  components: {
    Navbar,
  },
  data() {
    return {
      provider: null,
      signer: null,
      brand: 'Llama Farm 🦙',
      buttons: [{ "name":"Connect Wallet", "function":"connectWallet" }],
      pages: [],
      darkmode: true,
      locked: true
    }
  },
  methods: {
    feedLlama() {
      console.log('Fed Llama!');
    },
    async connectWallet() {
      // const accounts = await ethereum.request({ method: 'eth_requestAccounts' });
      // this.user = accounts[0];
      // this.buttons= [{ "name":"Disconnect Wallet", "function":"disconnectWallet" }];

      await window.ethereum.send('eth_requestAccounts');
      this.provider = new ethers.providers.Web3Provider(window.ethereum);
      this.signer = this.provider.getSigner()

      console.log(await this.signer.getAddress());

      this.buttons = [{"name":"Disconnect Wallet", "function":"disconnectWallet"}];
      this.locked = false;
    },
    disconnectWallet() {
      this.buttons = [{"name":"Connect Wallet", "function":"connectWallet"}];
      this.locked = true;
    }
  }
}
</script>

<style>

.darkmode {
  background: #2b2f33!important;
  color: white;
}

a {
  cursor: pointer;
}

.fullview {
  min-height: 100vh;
  width: 100%;
}

.page {
  margin: 20px 20px 20px 20px;
}

.flex {
  display: flex;
  flex-direction: column;
}

.row {
  flex-direction: row;
}

.center {
  justify-content: center;
  align-items: center;
}
</style>
