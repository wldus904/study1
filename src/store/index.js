import appConfigStoreModule from '@core/@app-config/appConfigStoreModule'
import Vue from 'vue'
import Vuex from 'vuex'
import app from './app'
import globalConfirm from './modules/globalConfirm'
import globalSnackbar from './modules/globalSnackbar'

Vue.use(Vuex)

export default new Vuex.Store({
    state: {},
    mutations: {},
    actions: {},
    modules: {
        appConfig: appConfigStoreModule,
        app,
        globalSnackbar,
        globalConfirm,
    },
})
