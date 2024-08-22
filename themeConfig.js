import { mdiCheckboxBlankCircleOutline } from '@mdi/js'

const themeConfig = {
    app: {
        name: 'Study1',
        logo: null,
        isDark: false,
        isRtl: false,
        contentLayoutNav: 'vertical', // vertical, horizontal
        routeTransition: 'scroll-x-transition', // https://vuetifyjs.com/en/styles/transitions/#api
        // ! `semi-dark` isn't available for horizontal nav menu
        skinVariant: 'semi-dark', // default, bordered, semi-dark
        contentWidth: 'boxed',
    },
    menu: {
        isMenuHidden: false,
        isVerticalNavMini: false,
        verticalMenuAccordion: true,
        groupChildIcon: mdiCheckboxBlankCircleOutline,
        horizontalNavMenuGroupOpenOnHover: true,
    },
    appBar: {
        /*
                    ! In Content Layout Horizontal Nav type `hidden` value won't work
                    ! In Content Layout Horizontal Nav type value of `type` will affect both Appbar and Horizontal Navigation Menu
                */
        type: 'fixed', // fixed, static, hidden
        isBlurred: true,
    },
    footer: {
        type: 'static', // fixed, static, hidden
    },
    themes: {
        light: {
            primary: '#0F62FE',
            accent: '#0d6efd',
            secondary: '#8A8D93',
            success: '#56CA00',
            info: '#16B1FF',
            warning: '#FFB400',
            error: '#FF4C51',
            // custom
            main: '#0d83ff',
            sub: '#7a90a8',
            mainFont: '#333',
            subFont: '#9c9c9c',
            negative: '#FF4848',
            disabled: '#F4F4F4',
            cloudy: '#E3E7F1',
        },
        dark: {
            primary: '#9155FD',
            accent: '#0d6efd',
            secondary: '#8A8D93',
            success: '#56CA00',
            info: '#16B1FF',
            warning: '#FFB400',
            error: '#FF4C51',
        },
    },
}

export default themeConfig
