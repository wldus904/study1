export default {
    namespaced: true,
    state: {
        msg: '',
        color: '',
        timeout: 2000,
    },
    mutations: {
        SET_GLOBAL_SNACKBAR(state, payload) {
            state.msg = payload.msg
            state.color = payload.color
            state.timeout = payload.timeout
        },
    },
}
