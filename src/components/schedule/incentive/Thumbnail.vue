<template>
    <v-img
        :src="imgPath ? imgPath : require('@/assets/images/no_image.png')"
        width="100%"
        max-height="50vh"
        class="incentive-thumbnail-img"
    >
        <template v-slot:placeholder>
            <v-skeleton-loader type="image" width="100%" class="incentive-thumbnail-img-skeleton" />
        </template>
    </v-img>
</template>
<script>
export default {
    props: {
        imgPath: { type: String, default: 'no_image.png' },
    },
}
</script>
<style lang="scss">
.incentive-thumbnail-img {
    aspect-ratio: 100/54;
    border-radius: 8px;
}

.incentive-thumbnail-img-skeleton {
    aspect-ratio: 100/54;
    border-radius: 8px;

    .v-skeleton-loader__image {
        height: 50vh;
    }
}
</style>
