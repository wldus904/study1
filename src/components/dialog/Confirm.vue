<template>
    <v-dialog
        v-model="isShow"
        :max-width="maxWidth"
        @click:outside="handleClickOutside"
        @keydown.esc="handleClickOutside"
    >
        <v-card>
            <v-card-title class="font-weight-semibold">
                {{ items.title }}
                <slot name="title"></slot>
            </v-card-title>
            <v-card-text>
                <div v-html="items.msg"></div>
                <slot name="msg"></slot>
            </v-card-text>
            <v-card-actions
                class="d-flex"
                :class="{
                    'justify-end': items.isRightActionBtn,
                    'justify-center': !items.isRightActionBtn,
                }"
            >
                <v-btn v-if="items.closeFunc" color="main" outlined @click="handleClose">
                    {{ items.closeBtnTitle ? items.closeBtnTitle : '취소' }}
                </v-btn>
                <v-btn color="main" class="white--text" @click="handleConfirm">
                    {{ items.confirmBtnTitle ? items.confirmBtnTitle : '확인' }}
                </v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>
</template>
<script>
import { ref } from '@vue/composition-api'

export default {
    props: {
        // items = { title: String, msg: String, closeFunc: Function, confirmFunc: Function }
        items: {
            type: Object,
            default: () => {},
        },
    },
    setup(props, { emit }) {
        let isShow = ref(false)
        const maxWidth = ref(props.items.maxWidth ? props.items.maxWidth : '600px')

        const handleClose = () => {
            if (props.items.closeFunc) props.items.closeFunc()
        }

        const handleConfirm = () => {
            if (props.items.confirmFunc) props.items.confirmFunc()
        }

        const handleClickOutside = () => {
            if (isShow.value) emit('confirmClickOutside')
        }

        return { isShow, maxWidth, close, handleClose, handleConfirm, handleClickOutside }
    },
}
</script>

<style lang="scss">
@import '@core/preset/preset/apps/user.scss';
</style>
