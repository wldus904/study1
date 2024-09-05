const admin = [
    {
        path: '/admin/board/notice',
        name: 'adminBoardNotice',
        component: () => import('@/views/admin/board/notice/Notice.vue'),
        meta: {
            layout: 'content',
        },
    },
    {
        path: '/admin/board/notice/:boardId',
        name: 'adminBoardNoticeDetail',
        component: () => import('@/views/admin/board/notice/Detail.vue'),
        meta: {
            layout: 'content',
        },
    },
    {
        path: '/admin/board/student-request',
        name: 'adminBoardStudentRequest',
        component: () => import('@/views/admin/board/studentRequest/StudentRequest.vue'),
        meta: {
            layout: 'content',
        },
    },
    {
        path: '/admin/board/student-request/:boardId',
        name: 'adminBoardStudentRequestDetail',
        component: () => import('@/views/admin/board/studentRequest/Detail.vue'),
        meta: {
            layout: 'content',
        },
    },
    {
        path: '/admin/classroom',
        name: 'adminClassroom',
        component: () => import('@/views/admin/classroom/Classroom.vue'),
        meta: {
            layout: 'content',
        },
    },
    {
        path: '/admin/classroom/:classroomId',
        name: 'adminClassroomDetail',
        component: () => import('@/views/admin/classroom/Detail.vue'),
        meta: {
            layout: 'content',
        },
    },
    {
        path: '/student/:memberId',
        name: 'studentExamDetail',
        component: () => import('@/views/student/Detail.vue'),
        meta: {
            layout: 'content',
        },
    },
]

export default admin
