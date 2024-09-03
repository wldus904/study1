<template>
    <div class="custom-pagination d-flex align-center justify-center font-size-10 pa-1">
        <v-btn class="arrow-box" icon :disabled="pageData.addNum < 1" @click="clickPage(1)">
            <v-icon> {{ icons.mdiChevronDoubleLeft }} </v-icon>
        </v-btn>
        <v-btn
            class="arrow-box"
            icon
            :disabled="pageData.addNum < 1"
            @click="clickPage(pageData.addNum)"
        >
            <v-icon> {{ icons.mdiChevronLeft }} </v-icon>
        </v-btn>

        <div
            class="mx-1 num-box cursor-pointer"
            plain
            :class="{
                active: num + pageData.addNum === currentPage,
                'page-hover': num + pageData.addNum !== currentPage,
            }"
            v-for="num in pageData.visibleLength"
            @click="clickPage(num + pageData.addNum)"
        >
            {{ num + pageData.addNum }}
        </div>

        <v-btn
            class="arrow-box"
            icon
            :disabled="pageData.addNum + pageData.numCnt >= length"
            @click="clickPage(pageData.addNum + pageData.numCnt + 1)"
        >
            <v-icon> {{ icons.mdiChevronRight }} </v-icon>
        </v-btn>
        <v-btn
            class="arrow-box"
            icon
            :disabled="pageData.addNum + pageData.numCnt >= length"
            @click="clickPage(length)"
        >
            <v-icon> {{ icons.mdiChevronDoubleRight }} </v-icon>
        </v-btn>
    </div>
</template>
<script>
import {
    mdiChevronDoubleLeft,
    mdiChevronDoubleRight,
    mdiChevronLeft,
    mdiChevronRight,
} from '@mdi/js'
import { onBeforeUnmount, reactive, watch } from '@vue/composition-api'
export default {
    props: {
        currentPage: {
            type: Number,
        },
        length: {
            type: Number,
        },
    },
    setup(props, { emit }) {
        const pageData = reactive({
            addNum: 0,
            visibleLength: 10,
            numCnt: 10,
        })

        const clickPage = num => {
            emit('clickPage', num)
        }

        const checkMobile = () => {
            const browserWidth = window.innerWidth

            if (browserWidth >= 600) {
                pageData.numCnt = 10
            } else {
                pageData.numCnt = 5
            }

            calcPage()
        }

        const calcPage = () => {
            pageData.addNum = parseInt(props.currentPage / pageData.numCnt) * pageData.numCnt

            if (props.currentPage % pageData.numCnt < 1)
                pageData.addNum = pageData.addNum - pageData.numCnt

            if (props.length - pageData.addNum > pageData.numCnt - 1)
                pageData.visibleLength = pageData.numCnt
            else pageData.visibleLength = props.length - pageData.addNum

            if (pageData.visibleLength < 1) pageData.visibleLength = 1
        }

        const init = () => {
            checkMobile()

            if (!props.currentPage) props.currentPage = 1
            if (!props.length) props.length = 0

            watch(() => props.currentPage, calcPage)
            watch(() => props.length, calcPage)

            onBeforeUnmount(() => {
                window.removeEventListener('resize', checkMobile)
            })
        }

        init()

        return {
            pageData,

            clickPage,

            icons: {
                mdiChevronDoubleLeft,
                mdiChevronDoubleRight,
                mdiChevronLeft,
                mdiChevronRight,
            },
        }
    },
}
</script>
<style lang="scss">
.custom-pagination {
    background-color: #fff;
    border-radius: 6px;

    .arrow-box {
        margin: 0 !important;
        width: 30px !important;
    }

    .num-box {
        border-radius: 60px;
        min-width: 30px !important;
        padding: 0 5px;
        height: 30px !important;
        font-weight: 500;
        display: flex;
        align-items: center;
        justify-content: center;

        &.page-hover:hover {
            background-color: #f9f9f9;
        }

        &.active {
            background-color: #0d83ff;
            color: #fff;
        }
    }
}
</style>
