<template>
    <layout-content-horizontal-nav :nav-menu-items="navMenuItems">
        <!-- Default Slot -->
        <slot></slot>

        <!-- Navbar -->
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
                            height="35px"
                            width="170px"
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

        <!-- App Content -->
        <!-- <template #v-app-content>
            <app-customizer class="d-none d-md-block"></app-customizer>
        </template> -->
    </layout-content-horizontal-nav>
</template>

<script>
import navMenuItems from '@/navigation/horizontal'
// App Bar Components
import AppBarThemeSwitcher from '@core/layouts/components/app-bar/AppBarThemeSwitcher.vue'
import AppCustomizer from '@core/layouts/components/app-customizer/AppCustomizer.vue'
import LayoutContentHorizontalNav from '@core/layouts/variants/content/horizontal-nav/LayoutContentHorizontalNav.vue'
import { mdiHeartOutline } from '@mdi/js'
import themeConfig from '@themeConfig'

export default {
    components: {
        LayoutContentHorizontalNav,
        AppCustomizer,

        // App Bar Components
        AppBarThemeSwitcher,
    },
    setup() {
        const moveMain = () => {
            location.href = '/'
        }

        return {
            navMenuItems,

            moveMain,

            // App Config
            appLogo: themeConfig.app.logo,

            // Icons
            icons: {
                mdiHeartOutline,
            },
        }
    },
}
</script>

<style lang="scss" scoped>
.app-title {
    font-size: 1.25rem;
    font-weight: 600;
}

.navbar-content-container {
    height: 100%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-grow: 1;
    position: relative;
}
</style>
