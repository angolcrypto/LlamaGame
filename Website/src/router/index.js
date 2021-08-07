import { createRouter, createWebHistory } from "vue-router";

import Home from '@/views/Home';
import Redirect from '@/views/Redirect';
import Success from '@/views/Success';

const routes = [
    {
        path: '/farm',
        name: 'Manage Farm',
        component: Home
    },
    {
      path: '/',
      name: 'LlamaFarm',
      component: Redirect
    },
    {
      path: '/adopt/success',
      name: 'Adoption Successful',
      component: Success
    },
    {
      path: '/home',
      name: 'LlamaFarm',
      component: Redirect
    },
];

const router = createRouter({
    history: createWebHistory(process.env.BASE_URL),
    routes,
})

export default router;
