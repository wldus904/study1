const admin = [
    {
        path: '/admin/board',
        name: 'adminBoard',
        component: () => import('@/views/admin/board'),
        meta: {
            layout: 'content',
            auth: ['ROLE_INCENTIVE_TOUR'],
        },
    },
]

export default admin
