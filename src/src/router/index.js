import { createWebHistory, createRouter } from "vue-router"
import PageNotFound from '../components/PageNotFound.vue'
import portfolio from '../components/portfolio.vue'
import about from '../components/about.vue'
import contact from '../components/contact.vue'
import polaroids from '../components/polaroids.vue'

/* Define routes and rendering in order of priority */
const routes = [
  {  
    path: '/',
    name: 'home',
    component: portfolio
  },
  {  
    path: '/portfolio',
    name: 'portfolio',
    component: portfolio
  },
  {  
    path: '/polaroids',
    name: 'polaroids',
    component: polaroids
  },
  {  
    path: '/contact',
    name: 'contact',
    component: contact
  },
  { 
    path: '/:pathMatch(.*)*',
    name: 'PageNotFound',
    component: PageNotFound
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes,
});

/* Hacky way to add titles from the matched component properties */
router.beforeEach((to, from, next) => {
  if (to.matched.at(-1)){
    const title = to.matched.at(-1).components.default.title
    document.title = title +  ' - Casey\'s Portfolio'
  }
  next()
})

export default router;
