import Request from '../../plugins/axios'

export function getExamApi() {
    return Request({
        url: `/exam`,
        method: 'get',
    })
}

export function postExamApi(data) {
    return Request({
        url: `/exam`,
        method: 'post',
        data,
    })
}