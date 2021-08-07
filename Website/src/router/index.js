import { createRouter, createWebHistory } from "vue-router";

import Home from '@/views/Home';
import Connect from '@/views/Connect';

const routes = [
    {
        path: '/home',
        name: 'Manage Farm',
        component: Home
    },
    {
      path: '/',
      name: 'Connect Wallet',
      component: Connect
    },
];

const router = createRouter({
    history: createWebHistory(process.env.BASE_URL),
    routes,
})

export default router;
