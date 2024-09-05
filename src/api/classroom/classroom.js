import Request from '../../plugins/axios'

export function getClassroomsApi(params) {
    return Request({
        url: `/classrooms`,
        method: 'get',
        params,
    })
}

export function getGradeClassSctionApi() {
    return Request({
        url: `/classrooms/grade-section`,
        method: 'get',
    })
}

export function getClassroomsByIdApi(classroomId) {
    return Request({
        url: `/classrooms/${classroomId}`,
        method: 'get',
    })
}
