<template>
    <div class="header-wrapper" :class="{ 'inquiry-white--bg': isMobile }">
        <a v-if="isMobile" @click="backClickHandler" class="logo">
            <v-icon color="#002047" size="28">
                {{ icons.mdiChevronLeft }}
            </v-icon>
        </a>
        <a v-else href="/" class="logo"> <Logo /> </a>
        <div class="inquiry-header-btn-group">
            <v-btn @click="openSideMenu" icon class="default-mobile-btn ml-3">
                <v-icon color="#002047" size="24">
                    {{ icons.mdiMenu }}
                </v-icon>
            </v-btn>
        </div>

        <v-snackbar v-model="snackbar" timeout="5000" class="toast">
            주소가 클립보드에 복사되었습니다
        </v-snackbar>
    </div>
</template>
<script>
import themeConfig from '@themeConfig'
import { mdiShareVariantOutline, mdiMenu, mdiChevronLeft } from '@mdi/js'
import { ref } from '@vue/composition-api'
import Logo from '@/components/icon/Logo.vue'

export default {
    components: { Logo },
    props: { isMobile: { type: Boolean } },
    setup(props, { emit }) {
        const appLogo = themeConfig.app.logo
        const snackbar = ref(false)

        const openSideMenu = () => {
            emit('openSideMenu')
        }

        const share = () => {
            const textArea = document.createElement('textarea')
            document.body.appendChild(textArea)
            textArea.value = 'https://www.odgano.com'
            textArea.select()
            document.execCommand('copy')
            document.body.removeChild(textArea)
            snackbar.value = true
        }

        const backClickHandler = e => {
            e.preventDefault()
            emit('back')
        }

        return {
            snackbar,
            appLogo,

            openSideMenu,
            share,
            backClickHandler,

            icons: {
                mdiShareVariantOutline,
                mdiMenu,
                mdiChevronLeft,
            },
        }
    },
}
</script>
<style lang="scss">
@import '@/styles/mixin.scss';

.header-wrapper {
    position: sticky;
    display: flex;
    align-items: center;
    justify-content: space-between;
    top: 0;
    width: 100vw;
    z-index: 2;
    transition: all ease 0.4s;

    @include dynamic-header-height;
    @include dynamic-header-padding;

    @include device-desktop {
        .default-desktop-btn {
            display: inline-block;
        }
        .default-mobile-btn {
            display: none;
        }
    }

    @include device-mobile {
        .default-desktop-btn {
            display: none;
        }
        .default-mobile-btn {
            display: inline-block;
        }
    }

    &.white--bg {
        background-color: #fff;
        box-shadow: none;
    }

    .logo {
        cursor: pointer;
        svg {
            width: clamp(115px, 11vw, 170px);
            height: auto;
        }
    }

    .v-btn {
        width: fit-content !important;
        height: fit-content !important;
    }

    .inquiry-header-btn-group {
        display: flex;
        align-items: center;

        .default-desktop-btn {
            padding: 10px 20px !important;
            font-size: 16px !important;
            font-weight: 600;
            line-height: 24px !important;
            font-family: 'Pretendard-regular' !important;

            &.indigo--text {
                color: #002047 !important;
            }

            &.share {
                margin-left: 12px;
                cursor: pointer;
            }
        }
    }

    .toast {
        bottom: 50px;
        opacity: 0.8;

        .v-snack__wrapper {
            min-width: fit-content;
            min-height: fit-content;
            border-radius: 30px;
        }

        .v-snack__content {
            position: relative;
            left: 4px;
            padding: 6px 10px;
            font-size: 12px;
            font-weight: 500;
        }
    }
}
</style>
