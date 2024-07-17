import Request from '../plugins/axios'

export default {
    // 고객 문의 목록 조회
    getInquiries(params) {
        return Request({
            url: `/customer/estimate/inqueries`,
            method: 'get',
            params,
        })
    },
    // 고객 문의 상세 조회
    getInquery(params) {
        return Request({
            url: `/customer/estimate/inquery`,
            method: 'get',
            params,
        })
    },
    // 고객 문의 등록
    postInquiry(data) {
        return Request({
            url: `/customer/estimate/inquery`,
            method: 'post',
            data,
        })
    },
    // 고객 문의 수정
    putInquiry(id, data) {
        return Request({
            url: `/customer/estimate/inquery/${id}`,
            method: 'put',
            data,
        })
    },
}
