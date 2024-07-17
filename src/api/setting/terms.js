import Request from '../../plugins/axios'

export default {
    /**
     * 약관 도메인 조회(리셀러, 머천트, 투어킷)
     */
    getDomainType() {
        return Request({
            url: `/terms/domain-type`,
            method: 'get',
        })
    },

    /**
     * 약관 타입 조회(이용약관, 개인정보처리방침, 개인정보 수집 및 이용 동의)
     */
    getTermsType() {
        return Request({
            url: `/terms/type`,
            method: 'get',
        })
    },

    /**
     * 특정 약관 조회
     * @param {*} params {termsType: String}
     */
    getTermsByTermsType(params) {
        return Request({
            url: `/terms`,
            method: 'get',
            params,
        })
    },

    /**
     * 약관 조회
     * @param {*} params
     */
    getTerms(params) {
        return Request({
            url: `/terms/list`,
            method: 'get',
            params,
        })
    },

    /**
     * 약관 상세조회
     * @param {*} termsId
     */
    getTermsDetail(termsId) {
        return Request({
            url: `/terms/${termsId}`,
            method: 'get',
        })
    },

    /**
     * 모든 약관 조회
     */
    getAllTerms() {
        return Request({
            url: `/all-terms`,
            method: 'get',
        })
    },

    /**
     * 맞춤여행 여행계약서 약관 조회
     * @param {*} termsId 
     * @param {*} params {tourId: Number}
     */
    getIncentiveTermsById(termsId, params){
        return Request({
            url: `/terms/${termsId}/incentive`,
            method: 'get',
            params
        })
    }
}
