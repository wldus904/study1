<template>
    <component :is="resolveLayoutVariant" :class="`skin-variant--${appSkinVariant}`">
        <transition :name="appRouteTransition" mode="out-in" appear>
            <router-view :key="$route.fullPath"></router-view>
        </transition>
        <GlobalSnackbar></GlobalSnackbar>
        <GlobalConfirm></GlobalConfirm>
    </component>
</template>

<script>
// eslint-disable-next-line object-curly-newline
import { computed } from '@vue/composition-api'
// eslint-disable-next-line import/no-unresolved
import useAppConfig from '@core/@app-config/useAppConfig'
import { useLayout } from '@core/layouts/composable/useLayout'
import { useRouter } from '@core/utils'

// Layouts
import LayoutBlank from '@/layouts/variants/blank/LayoutBlank.vue'
import LayoutContentHorizontalNav from '@/layouts/variants/content/horizontal-nav/LayoutContentHorizontalNav.vue'
import LayoutContentVerticalNav from '@/layouts/variants/content/vertical-nav/LayoutContentVerticalNav.vue'

// Dynamic vh
import useDynamicVh from '@core/utils/useDynamicVh'

// Global component
import GlobalConfirm from '@/components/dialog/GlobalConfirm.vue'
import GlobalSnackbar from '@/components/snackbar/GlobalSnackbar.vue'

export default {
    components: {
        LayoutContentVerticalNav,
        LayoutContentHorizontalNav,
        LayoutBlank,
        GlobalSnackbar,
        GlobalConfirm,
    },
    setup() {
        const { route } = useRouter()
        const { appContentLayoutNav, appSkinVariant, appRouteTransition } = useAppConfig()

        const { handleBreakpointLayoutSwitch } = useLayout()
        handleBreakpointLayoutSwitch()

        const resolveLayoutVariant = computed(() => {
            if (route.value.meta.layout === 'blank') return 'layout-blank'
            if (route.value.meta.layout === 'content')
                return `layout-content-${appContentLayoutNav.value}-nav`

            return null
        })

        useDynamicVh()

        return {
            resolveLayoutVariant,
            appSkinVariant,
            appRouteTransition,
        }
    },
}
</script>
