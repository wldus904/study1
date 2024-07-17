<template>
    <v-navigation-drawer v-model="isShow" temporary right fixed touchless>
        <div class="text-right pa-2">
            <v-btn right icon @click="close">
                <v-icon color="#002047">{{ icons.mdiClose }}</v-icon>
            </v-btn>
        </div>
        <div class="text-left px-8 pt-3">
            <a href="https://biz.odgano.com/" target="_blank" class="login-btn"
                >파트너 로그인/등록</a
            >
        </div>
    </v-navigation-drawer>
</template>
<script>
import { ref } from '@vue/composition-api'
import { mdiClose } from '@mdi/js'

export default {
    setup() {
        const isShow = ref(false)

        const openOdgano = () => {
            window.open('https://biz.odgano.com/')
        }

        const open = () => {
            isShow.value = true
        }

        const close = () => {
            isShow.value = false
        }

        return {
            isShow,

            openOdgano,
            open,
            close,

            icons: {
                mdiClose,
            },
        }
    },
}
</script>
<style lang="scss">
.login-btn {
    display: inline-block;
    font-size: 16px;
    font-weight: 500;
    color: #002047 !important;
    font-family: 'Pretendard-regular' !important;
    text-decoration: none;
}

.v-overlay--active .v-overlay__scrim {
    opacity: 0.6 !important;
}
</style>
