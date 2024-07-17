<template>
    <a @click="clickHandler" class="inquiry-btn">{{ title }}</a>
</template>

<script>
export default {
    props: { title: { type: String } },
    setup(props, { emit }) {
        const clickHandler = e => {
            e.preventDefault()
            emit('click')
        }

        return {
            clickHandler,
        }
    },
}
</script>
<style lang="scss">
@import '@/styles/mixin.scss';

.inquiry-btn {
    display: inline-block;
    padding-top: clamp(16px, 3vw, 24px);
    padding-bottom: clamp(16px, 3vw, 24px);
    padding-right: clamp(26px, 3vw, 56px);
    padding-left: clamp(26px, 3vw, 56px);
    margin-top: clamp(24px, 2vh, 40px);
    border-radius: 80px;
    font-size: clamp(14px, 1vw, 20px);
    font-weight: 600;
    line-height: clamp(20px, 3vw, 28px);
    color: #fff !important;
    background-color: #0f62fe;
    font-family: 'Pretendard-semibold' !important;
    z-index: 1;
    transition: all ease 0.2s;
    text-decoration: none;

    &:hover {
        background-color: #1a6eff;
    }
    &:active {
        background-color: #045bf0;
    }
}
</style>
