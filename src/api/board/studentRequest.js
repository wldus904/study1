import Request from '../../plugins/axios'

export function getStudentRequestApi(params) {
    return Request({
        url: `/board/student-requests`,
        method: 'get',
        params,
    })
}

export function getStudentRequestByIdApi(boardId) {
    return Request({
        url: `/board/student-request/${boardId}`,
        method: 'get',
    })
}
