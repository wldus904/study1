import Request from '../../plugins/axios'

export default {
    // 템플릿 목록 조회
    postTemplate({ page, size, sort, data }) {
        let url = `/incentive/templates?page=${page}&size=${size}`
        if (sort) url += `&sort=${sort}`
        return Request({
            url,
            method: 'post',
            data,
        })
    },
    // 템플릿 상세 조회
    getTemplateTour(templateId) {
        return Request({
            url: `/incentive/template/tour/${templateId}`,
            method: 'get',
        })
    },
    // 템플릿 일정 조회
    getTemplateTourPlanList(templateId) {
        return Request({
            url: `/incentive/template/tour/${templateId}/plan/list`,
            method: 'get',
        })
    },
}
