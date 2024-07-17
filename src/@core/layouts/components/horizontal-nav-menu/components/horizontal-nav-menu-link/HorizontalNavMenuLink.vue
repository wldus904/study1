<template>
    <v-list-item
        v-if="canViewHorizontalNavMenuLink(item)"
        v-bind="linkProps"
        :class="{ 'v-item--active v-list-item--active': isActive }"
        class="menu-list-item"
    >
        <!-- <v-list-item-icon>
      <v-icon :size="item.icon ? 22 : 15" :class="{'disabled-menu': !menuService.isAvailableMenu(item.to)}">
        {{ item.icon || alternateIcon }}
      </v-icon>
    </v-list-item-icon> -->
        <v-list-item-content>
            <v-list-item-title class="link-menu-title">
                <span>{{ t(item.title) }}</span>
            </v-list-item-title>
        </v-list-item-content>
    </v-list-item>
</template>

<script>
import useHorizontalNavMenuLink from '@core/layouts/composable/horizontal-nav/useHorizontalNavMenuLink'
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
        const { isActive, linkProps } = useHorizontalNavMenuLink(props.item)

        // i18n
        const { t } = useUtils()

        // ACL
        const { canViewHorizontalNavMenuLink } = useAclUtils()

        return {
            isActive,
            linkProps,

            // alternate icons
            alternateIcon: themeConfig.menu.groupChildIcon,

            // i18n
            t,

            // ACL
            canViewHorizontalNavMenuLink,
        }
    },
}
</script>
<style lang="scss">
.menu-list-item {
    padding: 23px;
}
.disabled-menu {
    cursor: default;
    color: #e4e3e3 !important;
}
.link-menu-title {
    color: #595959;
    font-size: 16px;
}
</style>
