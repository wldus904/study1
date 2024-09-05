import Request from '../../plugins/axios'

export function examScoreApi(params) {
    return Request({
        url: `/exam/score`,
        method: 'get',
        params,
    })
}

export function postExamScoreApi(data) {
    return Request({
        url: `/exam/score`,
        method: 'post',
        data,
    })
}