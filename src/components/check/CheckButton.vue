<template>
    <div @click="clickHandler" :class="{ active: isCheck.value }" class="check-button">
        {{ item.title }}
        <img v-if="isCheck.value" :src="images.activeCheck" />
    </div>
</template>
<script>
import activeCheck from '@/assets/images/svg/active_check.svg'

export default {
    props: { item: { type: Object }, isCheck: { type: Object } },
    setup(props, { emit }) {
        const clickHandler = () => {
            props.isCheck.value = !props.isCheck.value
            emit('click', props.isCheck.value, props.item)
        }

        return {
            clickHandler,

            images: {
                activeCheck,
            },
        }
    },
}
</script>
<style lang="scss">
@import '@/styles/mixin.scss';
.check-button {
    display: inline-flex;
    align-items: center;
    justify-content: space-between;
    border-radius: 8px;
    background-color: #f3f8fe;
    font-size: clamp(14px, 1.5vw, 18px);
    font-family: 'Pretendard-regular' !important;
    color: #293c52;
    transition: all ease 0.1s;
    cursor: pointer;

    @include none-user-select;
    @include device-desktop {
        font-weight: 600;
        padding: 16px;
    }
    @include device-mobile {
        font-weight: 500;
        padding: 14px;
    }

    &:hover {
        background-color: #ecf5ff;
    }

    &.active {
        background-color: #c7e2ff;
        color: #0f62fe;

        &:hover {
            background-color: #c1dfff;
        }
    }

    img {
        width: clamp(16px, 1vw, 20px);
        height: 20px;

        @include device-mobile {
            position: relative;
            top: -1px;
        }
    }
}
</style>
