import '@/assets/views/common.scss'
import '@/plugins/vue-composition-api'
import '@/styles/styles.scss'
import Vue from 'vue'
import VueEditableGrid from 'vue-editable-grid'
import LottieAnimation from 'lottie-web-vue'
import 'vue-editable-grid/dist/VueEditableGrid.css'
import App from './App.vue'
import vuetify from './plugins/vuetify'
import router from './router'
import store from './store'

Vue.config.productionTip = false
Vue.component('vue-editable-grid', VueEditableGrid)
Vue.use(LottieAnimation)

new Vue({
    router,
    store,
    vuetify,
    render: h => h(App),
}).$mount('#app')
