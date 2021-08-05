import { createRouter, createWebHistory } from "vue-router"

import Home from '@/views/Home'
import Threads from '@/views/Threads'
import Login from '@/views/Login'

const routes = [
    {
        path: '/',
        name: 'Home',
        component: Home
    },
    {
      path: '/threads',
      name: 'Threads',
      component: Threads
  },
  {
    path: '/login',
    name: 'Login',
    component: Login
},
]

const router = createRouter({
    history: createWebHistory(process.env.BASE_URL),
    routes,
})

export default router