<template>
    <v-dialog
        v-model="isShow"
        :max-width="items.maxWidth ? items.maxWidth : '600px'"
        :fullscreen="items.isMobile"
        :hide-overlay="items.isMobile"
        :transition="null"
        @click:outside="handleClickOutside"
        @keydown.esc="handleClickOutside('ESC')"
        scrollable
    >
        <v-card class="blank-confirm">
            <div v-if="!items.hideClose" class="pa-2 text-right">
                <v-btn right icon @click="close"
                    ><v-icon>{{ icons.mdiClose }}</v-icon></v-btn
                >
            </div>
            <v-card-text class="dialog-content">
                <slot name="msg"></slot>
            </v-card-text>
        </v-card>
    </v-dialog>
</template>
<script>
import { mdiClose } from '@mdi/js'
import { ref } from '@vue/composition-api'

export default {
    props: {
        items: {
            type: Object,
            default: () => {},
        },
    },
    setup(props, { emit }) {
        let isShow = ref(false)

        const close = () => {
            isShow.value = false
        }

        const handleClickOutside = (type = null) => {
            if (isShow.value) emit('confirmClickOutside', type)
        }

        return { isShow, close, handleClickOutside, icons: { mdiClose } }
    },
}
</script>

<style lang="scss">
@import '@/styles/mixin.scss';

@include device-desktop {
    .v-dialog {
        margin-right: 10px;
    }
    .blank-confirm.v-sheet.v-card {
        border-radius: 40px;
    }
}

.blank-confirm {
    ::-webkit-scrollbar {
        width: 5px; /* 스크롤바의 너비 */
    }

    ::-webkit-scrollbar-thumb {
        height: 20%; /* 스크롤바의 길이 */
        background: #8a8d93; /* 스크롤바의 색상 */
        border-radius: 10px;
    }

    ::-webkit-scrollbar-track {
        background: rgba(33, 122, 244, 0.2); /*스크롤바 뒷 배경 색상*/
    }
}

// .dialog-content {
//     overflow: hidden !important;
// }
</style>
