import Request from '../../plugins/axios'

export function loginApi(data) {
    return Request({
        url: `/members/login`,
        method: 'post',
        data,
    })
}

export function reissueApi() {
    return Request({
        url: `/members/reissue`,
        method: 'post',
    })
}

export function membersApi() {
    return Request({
        url: `/members`,
        method: 'get',
    })
}
