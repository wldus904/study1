<template>
    <layout-content-vertical-nav :nav-menu-items="navMenuItems">
        <slot></slot>
        <template #navbar>
            <div class="navbar-content-container">
                <!-- Left Content: Search -->
                <div class="d-flex align-center">
                    <div
                        class="d-flex align-center text-decoration-none cursor-pointer"
                        @click="moveMain"
                    >
                        <v-img
                            :src="appLogo"
                            max-height="23px"
                            max-width="115px"
                            alt="logo"
                            contain
                            class="me-1"
                        ></v-img>
                    </div>
                </div>

                <!-- Right Content: I18n, Light/Dark, Notification & User Dropdown -->
                <div class="d-flex align-center">
                    <!-- 검색, 다크모드 삭제 START -->
                    <!--<app-bar-theme-switcher></app-bar-theme-switcher> -->
                    <!-- 검색, 다크모드 삭제  END -->
                    <!-- <app-bar-cart></app-bar-cart> -->
                    <!-- <app-bookmark class="mr-1"></app-bookmark> -->
                    <!-- <app-bar-user-credit></app-bar-user-credit> -->
                    <v-app-bar-nav-icon v-if="$vuetify.breakpoint.mdAndDown"></v-app-bar-nav-icon>
                </div>
            </div>
            <v-overlay
                :value="$store.state.app.shallContentShowOverlay"
                z-index="5"
                absolute
                class="system-bar-overlay"
            ></v-overlay>
        </template>
    </layout-content-vertical-nav>
</template>

<script>
import LayoutContentVerticalNav from '@/@core/layouts/variants/content/vertical-nav/LayoutContentVerticalNav.vue'
import navMenuItems from '@/navigation/vertical'
import { mdiHeartOutline, mdiMenu } from '@mdi/js'
import themeConfig from '@themeConfig'

export default {
    components: {
        LayoutContentVerticalNav,

        // App Bar Components
    },
    setup() {
        const moveMain = () => {
            location.href = '/'
        }

        return {
            navMenuItems,
            moveMain,

            appLogo: themeConfig.app.logo,

            icons: {
                mdiMenu,
                mdiHeartOutline,
            },
        }
    },
}
</script>

<style lang="scss" scoped>
.navbar-content-container {
    height: 100%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-grow: 1;
    position: relative;
}
</style>
