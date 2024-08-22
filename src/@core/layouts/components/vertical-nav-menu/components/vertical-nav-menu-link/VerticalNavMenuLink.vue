<template>
    <v-list-item
        v-if="canViewVerticalNavMenuLink(item)"
        v-bind="linkProps"
        active-class="active-menu-link"
    >
        <v-list-item-icon>
            <v-icon
                :class="{ 'alternate-icon-small': !item.icon }"
                :color="isActive ? 'white' : null"
            >
                {{ item.icon || alternateIcon }}
            </v-icon>
        </v-list-item-icon>

        <v-list-item-title :class="{ 'white--text': isActive }">
            <span class="menu-bar-title">{{ t(item.title) }}</span>
        </v-list-item-title>
        <v-list-item-action v-if="item.badge" class="flex-shrink-0">
            <v-badge :color="item.badgeColor" inline :content="item.badge"> </v-badge>
        </v-list-item-action>
    </v-list-item>
</template>

<script>
import useVerticalNavLink from '@core/layouts/composable/vertical-nav/useVerticalNavLink'
import { useUtils as useAclUtils } from '@core/libs/acl'
import { useUtils } from '@core/libs/i18n'
import themeConfig from '@themeConfig'

export default {
    props: {
        item: {
            type: Object,
            required: true,
        },
    },
    setup(props) {
        const { isActive, linkProps } = useVerticalNavLink(props.item)
        const { t } = useUtils()
        const { canViewVerticalNavMenuLink } = useAclUtils()

        return {
            isActive,
            linkProps,
            alternateIcon: themeConfig.menu.groupChildIcon,

            // i18n
            t,

            // ACL
            canViewVerticalNavMenuLink,
        }
    },
}
</script>

<style lang="scss">
@import '~vuetify/src/styles/styles.sass';

.active-menu-link::before {
    background-color: rgba(13, 131, 255, 0.12) !important;
}
.vertical-nav-menu-link {
    &.v-list-item--active {
        // box-shadow: 0 5px 10px -4px rgba(94, 86, 105, 0.42);
        @include elevationTransition();
    }
}
.disabled-menu {
    cursor: default;
    color: #e4e3e3 !important;
}
.menu-bar-title {
    margin-left: 6px;
    font-size: 16px;
}
</style>
