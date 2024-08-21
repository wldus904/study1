const login = [
    {
        path: '/',
        name: 'studentLogin',
        component: () => import('@/views/home/StudentLogin.vue'),
        meta: {
            layout: 'blank',
        },
    },
    {
        path: '/admin/login',
        name: 'adminLogin',
        component: () => import('@/views/home/AdminLogin.vue'),
        meta: {
            layout: 'blank',
        },
    },
]

export default login
