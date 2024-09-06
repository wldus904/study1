<!-- <template>
    <layout-content-vertical-nav :nav-menu-items="navMenuItems">
        <slot></slot>
        <template #navbar>
            <div class="navbar-content-container">
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

                <div class="d-flex align-center">
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
</style> -->

<template>
    <layout-content-vertical-nav :nav-menu-items="navMenuItems">
        <slot></slot>

        <!-- Slot: Navbar -->
        <template #navbar="{ isVerticalNavMenuActive, toggleVerticalNavMenuActive }">
            <div
                class="navbar-content-container"
                :class="{ 'expanded-search': shallShowFullSearch }"
            >
                <!-- Left Content: Search -->
                <div class="d-flex align-center">
                    <v-icon
                        v-if="$vuetify.breakpoint.mdAndDown"
                        class="me-3"
                        @click="toggleVerticalNavMenuActive"
                    >
                        {{ icons.mdiMenu }}
                    </v-icon>
                </div>
            </div>
        </template>
    </layout-content-vertical-nav>
</template>

<script>
import LayoutContentVerticalNav from '@/@core/layouts/variants/content/vertical-nav/LayoutContentVerticalNav.vue'
import navMenuItems from '@/navigation/vertical'

// App Bar Components
import AppBarSearch from '@core/layouts/components/app-bar/AppBarSearch.vue'

import { mdiHeartOutline, mdiMenu } from '@mdi/js'

import { getVuetify } from '@core/utils'

// Search Data
import appBarSearchData from '@/assets/app-bar-search-data'

import { ref, watch } from '@vue/composition-api'

export default {
    components: {
        LayoutContentVerticalNav,

        // App Bar Components
        AppBarSearch,
    },
    setup() {
        const $vuetify = getVuetify()

        // Search
        const appBarSearchQuery = ref('')
        const shallShowFullSearch = ref(false)
        const maxItemsInGroup = 5
        const totalItemsInGroup = ref({
            pages: 0,
            files: 0,
            contacts: 0,
        })
        watch(appBarSearchQuery, () => {
            totalItemsInGroup.value = {
                pages: 0,
                files: 0,
                contacts: 0,
            }
        })

        // NOTE: Update search function according to your usage
        const searchFilterFunc = (item, queryText, itemText) => {
            if (item.header || item.divider) return true

            const itemGroup = (() => {
                if (item.to !== undefined) return 'pages'
                if (item.size !== undefined) return 'files'
                if (item.email !== undefined) return 'contacts'

                return null
            })()

            const isMatched =
                itemText.toLocaleLowerCase().indexOf(queryText.toLocaleLowerCase()) > -1

            if (isMatched) {
                if (itemGroup === 'pages') totalItemsInGroup.value.pages += 1
                else if (itemGroup === 'files') totalItemsInGroup.value.files += 1
                else if (itemGroup === 'contacts') totalItemsInGroup.value.contacts += 1
            }

            return (
                appBarSearchQuery.value &&
                isMatched &&
                totalItemsInGroup.value[itemGroup] <= maxItemsInGroup
            )
        }

        // ? Handles case where in <lg vertical nav menu is open and search is triggered using hotkey then searchbox is hidden behind vertical nav menu overlaty
        const handleShallShowFullSearchUpdate = (
            isVerticalNavMenuActive,
            toggleVerticalNavMenuActive,
        ) => {
            if ($vuetify.breakpoint.mdAndDown && isVerticalNavMenuActive) {
                toggleVerticalNavMenuActive()
            }
        }

        return {
            navMenuItems,
            handleShallShowFullSearchUpdate,

            // Search
            appBarSearchQuery,
            shallShowFullSearch,
            appBarSearchData,
            searchFilterFunc,

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

// ? Handle bg of autocomplete for blured appBar
.v-app-bar.bg-blur {
    .expanded-search {
        ::v-deep .app-bar-autocomplete-box div[role='combobox'] {
            background-color: transparent;
        }

        > .d-flex > button.v-icon {
            display: none;
        }

        // ===

        & > .right-row {
            visibility: hidden;
            opacity: 0;
        }

        ::v-deep .app-bar-search-toggler {
            visibility: hidden;
        }
    }
}
</style>
