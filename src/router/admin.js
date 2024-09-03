const admin = [
    {
        path: '/admin/board/notice',
        name: 'adminBoardNotice',
        component: () => import('@/views/admin/board/Notice.vue'),
        meta: {
            layout: 'content',
            auth: ['ROLE_INCENTIVE_TOUR'],
        },
    },
]

export default admin
