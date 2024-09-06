import store from '@/store'
import VueGtm from '@gtm-support/vue2-gtm'
import Vue from 'vue'
import VueRouter from 'vue-router'
import login from '@/router/login'
import admin from '@/router/admin'
import student from '@/router/student'

Vue.use(VueRouter)

const routes = [
    ...login,
    ...admin,
    ...student,
    {
        path: '/',
        redirect: { name: 'StudentLogin' },
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
