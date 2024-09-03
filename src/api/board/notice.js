import Request from '../../plugins/axios'

export function getNoticeApi(params) {
    return Request({
        url: `/board/notices`,
        method: 'get',
        params,
    })
}
