<template>
    <div class="header-wrapper" :class="{ 'inquiry-white--bg': isMobile }">
        <a v-if="isMobile" @click="backClickHandler" class="logo">
            <v-icon :color="isAbleBack ? '#002047' : 'A4B0BF'" size="28">
                {{ icons.mdiChevronLeft }}
            </v-icon>
        </a>
        <a v-else href="/" class="logo"> <Logo /> </a>
    </div>
</template>
<script>
import themeConfig from '@themeConfig'
import { mdiChevronLeft } from '@mdi/js'
import Logo from '@/components/icon/Logo.vue'

export default {
    components: { Logo },
    props: {
        isMobile: { type: Boolean },
        isAbleBack: { type: Boolean },
    },
    setup(props, { emit }) {
        const appLogo = themeConfig.app.logo

        const backClickHandler = e => {
            if (!props.isAbleBack) return
            e.preventDefault()
            emit('back')
        }

        return {
            appLogo,

            backClickHandler,

            icons: {
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
