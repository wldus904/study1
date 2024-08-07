import store from '@/store'
import VueGtm from '@gtm-support/vue2-gtm'
import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const routes = [
    {
        path: '/',
        redirect: { name: 'StudentLogin' },
    },
    {
        path: '/',
        name: 'StudentLogin',
        component: () => import('@/views/home/StudentLogin.vue'),
        meta: {
            layout: 'blank',
        },
    },
    {
        path: '/staff',
        name: 'staff',
        component: () => import('@/views/staff'),
        meta: {
            layout: 'blank',
        },
    },
    {
        path: '/student-management/:code',
        name: 'student-management',
        component: () => import('@/views/staff/StudentManagement.vue'),
        meta: {
            layout: 'blank',
        },
    },
    {
        path: '/student',
        name: 'student',
        component: () => import('@/views/student'),
        meta: {
            layout: 'blank',
        },
    },
]

const router = new VueRouter({
    mode: 'history',
    base: process.env.BASE_URL,
    routes,
    scrollBehavior() {
        return { x: 0, y: 0 }
    },
})

if (process.env.VUE_APP_GOOGLE_TAG_MANAGER_ID) {
    Vue.use(VueGtm, {
        id: process.env.VUE_APP_GOOGLE_TAG_MANAGER_ID,
    })
}

let nextPath

// navigation-guards
router.beforeEach(async (to, from, next) => {
    nextPath = to.fullPath
    return next()
})

router.onError(error => {
    console.error(error)

    if (error.name === 'ChunkLoadError') {
        window.location.href = nextPath || '/'
    }
})

export default router
