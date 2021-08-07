<template>
  <div :class="['page', 'flex', 'center', 'height100', 'width100']">
    <h1>Your adoption was successful! 🥳</h1>
    <p>You have adopted your llama.</p>
    <button class='btn btn-primary' @click="$router.push('/home')">View Llamas</button>
  </div>
</template>
