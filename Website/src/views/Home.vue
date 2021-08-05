<template>
  <div :class="['page', 'flex', 'center', colormode]">
    <h1>Llama Game</h1>
    <button class='btn btn-primary' @click='feedLlama'>Feed My Llama</button>
  </div>
</template>

<script>
export default {
  name: 'Home',
  props: {

  },
  data() {
    return {

    }
  },
  created() {

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
