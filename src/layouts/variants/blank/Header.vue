<template>
    <div class="header-wrapper" :class="{ 'white--bg': !isTop }">
        <a href="/" class="logo"> <Logo /> </a>
        <div v-if="!hiddenBtnGroup" class="header-btn-group">
            <a
                href="https://biz.odgano.com/"
                target="_blank"
                class="partner-btn"
                :class="isTop ? 'white-btn' : 'blue-btn'"
            >
                파트너 로그인/등록
            </a>
            <div @click="share" :class="isTop ? 'white--text' : 'indigo--text'" class="share-btn">
                <v-icon :color="isTop ? '#fff' : '#002047'" size="24">
                    {{ icons.mdiShareVariantOutline }}
                </v-icon>
                공유하기
            </div>
            <v-btn @click="share" icon class="default-mobile-btn">
                <v-icon color="#002047" size="24">
                    {{ icons.mdiShareVariantOutline }}
                </v-icon>
            </v-btn>
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
import { mdiShareVariantOutline, mdiMenu } from '@mdi/js'
import { ref } from '@vue/composition-api'
import Logo from '@/components/icon/Logo.vue'

export default {
    components: { Logo },
    props: { isTop: { type: Boolean }, hiddenBtnGroup: { type: Boolean } },
    setup(props, { emit }) {
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

        return {
            snackbar,

            openSideMenu,
            share,

            icons: {
                mdiShareVariantOutline,
                mdiMenu,
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
    justify-content: space-between;
    top: 0;
    width: 100vw;
    z-index: 2;
    transition: all ease 0.4s;

    @include dynamic-header-height;
    @include dynamic-header-padding;

    @include device-desktop {
        .partner-btn,
        .share-btn {
            display: inline-block;
        }
        .default-mobile-btn {
            display: none;
        }
    }

    @include device-mobile {
        .partner-btn,
        .share-btn {
            display: none;
        }
        .default-mobile-btn {
            display: inline-block;
        }
    }

    &.white--bg {
        background-color: #fff;
        box-shadow: 0 0px 8px #eaf0f8;
    }

    .logo {
        cursor: pointer;
        svg {
            width: clamp(115px, 11vw, 170px);
            height: auto;
        }
    }

    .header-btn-group {
        display: flex;
        align-items: center;

        @mixin default-btn {
            font-size: 16px !important;
            font-weight: 600;
            line-height: 24px !important;
            border-radius: 8px;
            font-family: 'Pretendard-regular' !important;
            text-decoration: none;
            transition: all ease 0.2s;

            &.indigo--text {
                color: #002047 !important;
            }
        }

        .partner-btn {
            padding: 10px 20px !important;

            @include default-btn;

            &.white-btn {
                background-color: #fff;
                color: #002047;

                &:hover {
                    background-color: #ebeef1;
                }
                &:active {
                    background-color: #a4afbe;
                }
            }

            &.blue-btn {
                background-color: #0f62fe;
                color: #fff;

                &:hover {
                    background-color: #226efe;
                }
                &:active {
                    background-color: #659afe;
                }
            }
        }

        .share-btn {
            @include default-btn;
            margin-left: 32px;
            cursor: pointer;
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
