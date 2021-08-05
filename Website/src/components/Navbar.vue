<template>
  <nav :class="['navbar navbar-expand-lg', darkmode ? 'navbar-dark bg-dark' : 'navbar-light bg-light']">
    <div class="container-fluid">
      <a class="navbar-brand" @click="redirect('/')">{{brand}}</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li v-for='item in pages' :key='item' class="nav-item">
            <a :class="['nav-link', isActive(item)]" @click="redirect(item.link)">{{item.name}}</a>
          </li>
        </ul>
        <form class="d-flex">
          <button v-for='item in buttons' :key='item' class="btn btn-outline-primary" @click='redirect(item.link)' type="button">{{item.name}}</button>
        </form>
      </div>
    </div>
  </nav>
</template>

<script>
export default {
  props: {
    brand: String,
    buttons: Array,
    pages: Array,
    user: null,
    darkmode: Boolean
  },
  methods: {
    redirect(destination) {
      this.$router.push(destination)
    },
    isActive(item) {
      if(this.$route.path == item.link) {
        return "active"
      } else {
        return
      }
    }
  },
  created() {

  }
}
</script>
