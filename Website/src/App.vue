<template>
  <div :class='["fullview", darkmode ? "darkmode" : "lightmode"]'>
    <Navbar @connectWallet='connectWallet' :brand='brand' :pages='pages' :buttons='buttons' :darkmode='darkmode'/>
    <router-view @feedLlama='feedLlama' :user = 'user' :darkmode='darkmode' />
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
      user: null,
      brand: 'Llama Game',
      buttons: [{ "name":"Connect Wallet", "function":"connectWallet" }],
      pages: [],
      darkmode: true
    }
  },
  created() {
    if(this.user !== null) {
      this.buttons = []
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
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner()

      console.log(await signer.getAddress());

      this.buttons = [{"name":"Disconnect Wallet", "function":"disconnectWallet"}];
    },
    disconnectWallet() {
      this.buttons = [{"name":"Connect Wallet", "function":"connectWallet"}];
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
  margin: 16px 12px 10px 12px;
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
