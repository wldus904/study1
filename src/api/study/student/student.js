import Request from '../../../plugins/axios'

export function loginApi(data) {
    return Request({
        url: `/students/login`,
        method: 'post',
        withCredentials: true,
        data,
    })
}

export function reissueApi() {
    return Request({
        url: `/students/reissue`,
        method: 'post',
        withCredentials: true,
    })
}

export function studentsApi() {
    return Request({
        url: `/students`,
        method: 'get',
        withCredentials: true,
    })
}
