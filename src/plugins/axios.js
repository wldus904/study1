import router from '@/router'
import store from '@/store'
import axios from 'axios'
import Vue from 'vue'

const axiosIns = axios.create({
    baseURL: process.env.VUE_APP_API_URI,
})

const callGlobalSnackBar = ({ msg = '', color = '', timeout = 200000 }) => {
    store.commit('globalSnackbar/SET_GLOBAL_SNACKBAR', {
        msg: msg,
        color: color,
        timeout: timeout,
    })
}

const callGlobalConfirm = ({ title = '', msg = '', isBack = true }) => {
    store.commit('globalConfirm/SET_GLOBAL_CONFIRM', {
        title: title,
        msg: msg,
        isBack: isBack,
    })
}

const isSuccess = response => {
    if (response.status == 200) {
        if (response.data && response.data.status) {
            if (response.data.status == 200 || response.data.result === 'SUCCESS') {
                return true
            } else {
                return false
            }
        }

        // 로그 아웃, 엑셀 다운로드는 예외 {data: Blob, ...}
        return true
    }

    return false
}

axiosIns.interceptors.request.use(
    config => {
        const accessToken = localStorage.getItem('accessToken')
        config.headers.Authorization = `Bearer ${accessToken}`
        return config
    },
    error => {
        Promise.reject(error)
    },
)

axiosIns.interceptors.response.use(
    response => {
        // 내부 error check
        if (isSuccess(response) === false) {
            return Promise.reject(response.data)
        }

        return response.data
    },
    error => {
        console.log(error)
        const errorStatusList = [400, 401, 403, 404, 409]

        if (error.response.status === 404) {
            callGlobalConfirm({ msg: '컨텐츠가 없습니다.' })
        } else if (error.response.status === 409) {
            callGlobalConfirm({ msg: '중복된 컨텐츠 입니다.' })
        } else if (!errorStatusList.includes(error.response.status)) {
            callGlobalConfirm({
                title: 'SERVER ERROR',
                msg: '오류가 발생했습니다. 관리자에게 문의해주세요.',
                isBack: false,
            })
        }

        return Promise.reject(error)
    },
)

Vue.prototype.$http = axiosIns

export default axiosIns
