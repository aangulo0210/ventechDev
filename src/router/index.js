import { createRouter, createWebHistory } from 'vue-router';

const routes = [
  {
    path: '/',
    name: 'home',
    component: () => import('@/views/public/home.vue'),
  },
  {
    path: '/catalogo',
    name: 'catalog',
    component: () => import('@/views/public/catalog.vue'),
  },
  {
    path: '/auth',
    name: 'auth',
    component: () => import('@/views/public/auth.vue'),
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
  scrollBehavior(to, from, savedPosition) {
    if (savedPosition) return savedPosition;
    if (to.hash) return { el: to.hash, behavior: 'smooth' };
    return { top: 0 };
  },
});

export default router;
