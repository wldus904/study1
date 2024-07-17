export default {
    namespaced: true,
    state: {
        title: '',
        msg: '',
        isBack: true,
    },
    mutations: {
        SET_GLOBAL_CONFIRM(state, payload) {
            state.title = payload.title
            state.msg = payload.msg
            state.isBack = payload.isBack
        },
    },
}
