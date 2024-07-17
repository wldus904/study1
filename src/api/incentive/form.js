import Request from '../../plugins/axios'

export default {
    // 행사 상세 조회
    getFormTourWithCode(code) {
        return Request({
            url: `/incentive/form/${code}/detail`,
            method: 'get',
        })
    },
    // 행사 일정 조회
    getFormTourPlanList(formId) {
        return Request({
            url: `/incentive/form/${formId}/plan/list`,
            method: 'get',
        })
    },
    // 선택 항목 조회
    getFormTourOptional(formId) {
        return Request({
            url: `/incentive/form/${formId}/optional`,
            method: 'get',
        })
    },
    // 견적 계산 조회(요약 정보 포함)
    getFormTourEstimatePrice(formId) {
        return Request({
            url: `/incentive/form/${formId}/estimate/price-summary`,
            method: 'get',
        })
    },
}
