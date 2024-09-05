import Request from '../../plugins/axios'

export function getNoticeApi(params) {
    return Request({
        url: `/board/notices`,
        method: 'get',
        params,
    })
}

export function getNoticeByIdApi(boardId) {
    return Request({
        url: `/board/notice/${boardId}`,
        method: 'get',
    })
}

export function putNoticeByIdApi(boardId, data) {
    return Request({
        url: `/board/notice/${boardId}`,
        method: 'put',
        data,
    })
}

export function postNoticeByIdApi(data) {
    return Request({
        url: `/board/notice`,
        method: 'post',
        data,
    })
}
