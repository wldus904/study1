<template>
    <div class="basic-product-card" @click="clickHandler">
        <v-img
            :src="imgPath ? imgPath : require('@/assets/images/no_image.png')"
            width="100%"
            class="card-img"
        >
            <template v-slot:placeholder>
                <v-skeleton-loader type="image" width="100%" class="card-skeleton" />
            </template>
        </v-img>
        <div>
            <div class="title text-ellipsis">{{ title }}</div>
            <div class="tag text-ellipsis">{{ convertTag }}</div>
            <div class="price">{{ convertPrice }}<span>(1인 예상 견적가)</span></div>
        </div>
    </div>
</template>
<script>
import { computed } from '@vue/composition-api'
export default {
    props: {
        title: { type: String, default: 'title' },
        tag: { type: String, default: 'tag' },
        price: { type: Number, default: 9999999 },
        imgPath: { type: String, default: 'no_image.png' },
    },
    setup(props, { emit }) {
        const convertTag = computed(() => {
            if (!props.tag) return ''

            const tags = props.tag.split(',')
            let res = '#' + tags.shift(0)

            tags.forEach(value => {
                res += ' #' + value
            })

            return res
        })

        const convertPrice = computed(() => {
            return props.price ? props.price.toLocaleString() + '원' : '-원'
        })

        const clickHandler = () => {
            emit('clickHandler')
        }

        return {
            convertTag,
            convertPrice,
            clickHandler,
        }
    },
}
</script>
<style lang="scss">
// @import '@core/preset/preset/mixins.scss';

.basic-product-card {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    line-height: 20px;
    width: 315px;
    min-height: 220px;
    text-align: left;
    color: #3c4148;
    font-family: 'Pretendard-regular' !important;

    .card-img {
        height: fit-content !important;
        aspect-ratio: 100/54;
        border-radius: 8px;
    }

    .card-skeleton {
        aspect-ratio: 100/54;
        border-radius: 8px;
    }

    .title {
        margin-top: 12px;
        font-size: 18px !important;
        font-weight: 600;
        line-height: 24px;
        color: #002047;
    }

    .tag {
        display: -webkit-box;
        min-height: 40px;
        white-space: normal;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        margin-top: 4px;
        font-size: 13px !important;
        font-weight: 400;
        color: #293c52;
        line-height: 20px;
    }

    .price {
        margin-top: 8px;
        font-size: 20px;
        font-weight: 700;
        color: #fe3a0f;
        line-height: 28px;

        span {
            margin-left: 4px;
            font-size: 12px;
            font-weight: 400;
            color: #7b848f;
            line-height: 20px;
        }
    }
}
</style>
