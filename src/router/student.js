const student = [
    {
        path: '/student/board/notice',
        name: 'studentBoardNotice',
        component: () => import('@/views/student/board/Notice.vue'),
        meta: {
            layout: 'content',
        },
    },
    {
        path: '/student/board/notice/:boardId',
        name: 'studentBoardNoticeDetail',
        component: () => import('@/views/student/board/Detail.vue'),
        meta: {
            layout: 'content',
        },
    },
    // {
    //     path: '/student/board/student-request',
    //     name: 'studentBoardStudentRequest',
    //     component: () => import('@/views/student/board/studentRequest/StudentRequest.vue'),
    //     meta: {
    //         layout: 'content',
    //     },
    // },
    // {
    //     path: '/student/board/student-request/:boardId',
    //     name: 'studentBoardStudentRequestDetail',
    //     component: () => import('@/views/student/board/studentRequest/Detail.vue'),
    //     meta: {
    //         layout: 'content',
    //     },
    // },
    // {
    //     path: '/student/classroom',
    //     name: 'studentClassroom',
    //     component: () => import('@/views/student/classroom/Classroom.vue'),
    //     meta: {
    //         layout: 'content',
    //     },
    // },
    // {
    //     path: '/student/classroom/:classroomId',
    //     name: 'studentClassroomDetail',
    //     component: () => import('@/views/student/classroom/Detail.vue'),
    //     meta: {
    //         layout: 'content',
    //     },
    // },
    // {
    //     path: '/student/:memberId',
    //     name: 'studentExamDetail',
    //     component: () => import('@/views/student/Detail.vue'),
    //     meta: {
    //         layout: 'content',
    //     },
    // },
]

export default student
