import Request from '../../plugins/axios'

export function getStudentRequestApi(params) {
    return Request({
        url: `/board/student-requests`,
        method: 'get',
        params,
    })
}
