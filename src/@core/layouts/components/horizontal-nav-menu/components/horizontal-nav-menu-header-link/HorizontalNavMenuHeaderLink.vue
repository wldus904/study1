<template>
    <v-btn
        v-if="canViewHorizontalNavMenuHeaderLink(item)"
        :color="isActive ? '#E7F3FF' : null"
        depressed
        rounded
        :to="{ name: item.to }"
        large
        class="horizontal-nav-menu-header-link px-6"
        active-class="header-link-active"
    >
        <v-icon dark left :size="item.icon ? 22 : 15">
            {{ item.icon || alternateIcon }}
        </v-icon>
        <span class="menu-bar-title">{{ t(item.title) }}</span>
    </v-btn>
</template>

<script>
import useHorizontalNavMenuHeaderLink from '@core/layouts/composable/horizontal-nav/useHorizontalNavMenuHeaderLink'
import { useUtils as useAclUtils } from '@core/libs/acl'
import { useUtils } from '@core/libs/i18n'
import themeConfig from '@themeConfig'

export default {
    components: {},
    props: {
        item: {
            type: Object,
            required: true,
        },
    },
    setup(props) {
        const { isActive, updateIsActive } = useHorizontalNavMenuHeaderLink(props.item)

        // ACL
        const { canViewHorizontalNavMenuHeaderLink } = useAclUtils()

        // i18n
        const { t } = useUtils()

        return {
            isActive,
            updateIsActive,

            // alternate icons
            alternateIcon: themeConfig.menu.groupChildIcon,

            // i18n
            t,

            // ACL
            canViewHorizontalNavMenuHeaderLink,
        }
    },
}
</script>

<style lang="scss">
@import '~vuetify/src/styles/styles.sass';

.active-menu-icon {
    filter: invert(31%) sepia(79%) saturate(2031%) hue-rotate(201deg) brightness(105%)
        contrast(103%);
}
.horizontal-nav-menu-header-link {
    background-color: none !important;

    &.header-link-active {
        // box-shadow: 0 5px 10px -4px rgba(94, 86, 105, 0.42);
        color: #e7f3ff !important;
        @include elevationTransition();
    }
}
.disabled-menu {
    cursor: default;
    color: #e4e3e3 !important;
}
.menu-bar-title {
    margin-left: 6px;
    color: #333;
    font-size: 16px;
}
</style>
