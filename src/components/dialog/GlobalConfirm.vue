<template>
    <v-dialog
    v-model="isShow"
    max-width="400px"
    >
        <v-card>
          <v-card-text class="font-weight-bold">
            {{ confirmData.title }}
            <slot name="title"></slot>
          </v-card-text>
          <v-card-text class="text-center font-weight-black black--text mb-5">
              {{confirmData.msg}}
              <slot name="msg"></slot>
          </v-card-text>
          <v-card-actions class="d-flex justify-center">
            <v-btn
              color="main"
              class="white--text"
              @click="handleConfirm"
            >
              확인
            </v-btn>
          </v-card-actions>
        </v-card>
    </v-dialog>
</template>
<script>
import router from '@/router'
import store from '@/store'
import { reactive, ref } from '@vue/composition-api'

export default {
    setup() {
        let isShow = ref(false)
        let isBack = true
        const confirmData = reactive({
            title: '',
            msg: '',
        })

        store.subscribe((mutation, state) => {
            if (mutation.type === 'globalConfirm/SET_GLOBAL_CONFIRM') {
                confirmData.title = store.state.globalConfirm.title
                confirmData.msg = store.state.globalConfirm.msg
                isBack = store.state.globalConfirm.isBack
                isShow.value = true
            }
        })

        const handleConfirm = () => {
            isShow.value = false
            if (isBack) router.back()
        }

        return { isShow, confirmData, handleConfirm }
    },
}
</script>

<style lang="scss">
@import '@core/preset/preset/apps/user.scss';
</style>
