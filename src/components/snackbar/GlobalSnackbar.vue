<template>
    <div>
        <v-snackbar
            class="text-center global-snackbar"
            v-model="snackbarData.isShow"
            :color="snackbarData.color"
            :timeout="snackbarData.timeout"
            top right
        >
            {{ snackbarData.msg }}
        </v-snackbar>
    </div>
</template>
<script>
import store from '@/store'
import { reactive } from '@vue/composition-api'

export default {
    setup() {
        const snackbarData = reactive({
            isShow: false,
            color: 'main',
            timeout: 2000,
            msg: '',
        })

        store.subscribe((mutation, state) => {
            if (mutation.type === 'globalSnackbar/SET_GLOBAL_SNACKBAR') {
                snackbarData.color = store.state.globalSnackbar.color
                snackbarData.msg = store.state.globalSnackbar.msg
                snackbarData.timeout = store.state.globalSnackbar.timeout
                snackbarData.isShow = true
            }
        })

        return {
            snackbarData,
        }
    },
}
</script>
<style scope lang="scss">
.global-snackbar {
    .v-snack__wrapper {
        min-height: 40px !important;
        min-width: 200px !important;
    }

    .v-snack__content {
        font-size: 1rem;
        font-weight: lighter;
        padding: 5px 20px !important;
    }
}
</style>
