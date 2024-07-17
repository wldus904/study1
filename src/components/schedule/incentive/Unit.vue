<template>
    <div class="unit-wrapper">
        <div class="schedule-title">
            <p>
                {{ item.unitName }}
                <template v-if="item.estimatedTime">
                    ({{ convertTime(item.estimatedTime) }})</template
                >
                <span v-if="item.unitComplement">{{ item.unitComplement }}</span>
            </p>
            <div v-if="item.unitSummary" class="schedule-summary" v-html="item.unitSummary"></div>
        </div>
        <div v-if="item.fileId || item.highlights || item.description" class="schedule-content">
            <v-img v-if="item.imageUrl" :src="item.imageUrl" eager class="schedule-img">
                <template v-slot:placeholder>
                    <v-skeleton-loader type="image" width="100%" class="schedule-img-skeleton" />
                </template>
            </v-img>
            <div v-if="item.highlights || item.description">
                <div v-if="category" class="schedule-content-title">
                    {{ categoryName[category] }} 정보
                </div>
                <div class="highlight" v-html="item.highlights"></div>
                <div class="description" v-html="item.description"></div>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    props: {
        item: { type: Object, default: {} },
        category: { type: String, default: '' },
    },
    setup() {
        const categoryName = {
            accommodation: '숙소',
            golfs: '투어',
            sightseeings: '투어',
            meals: '식사',
        }

        const convertTime = time => {
            return `${Number(time) * 60}분`
        }

        return {
            categoryName,

            convertTime,
        }
    },
}
</script>
<style lang="scss">
@import '@/styles/mixin.scss';

.unit-wrapper {
    width: calc(100% - 30px);

    .schedule-title {
        padding-top: 3px;

        p {
            display: inline-block;
            margin: 0;
            font-size: clamp(14px, 1.3vw, 24px);
            font-weight: 700;
            line-height: clamp(20px, 1.3vw, 32px);
            color: #293c52;

            @include device-desktop {
                display: flex;
            }

            @include device-mobile {
                margin-bottom: 3px;
                font-weight: 600;
            }

            span {
                display: block;
                font-size: clamp(11px, 0.8vw, 14px);
                font-weight: 400;
                line-height: 21px;
                color: #7b848f;

                @include device-desktop {
                    display: flex;
                    margin-left: 8px;
                }
            }
        }

        .schedule-summary {
            margin-top: clamp(3px, 0.4vw, 8px);
            font-size: clamp(12px, 1vw, 16px);
            font-weight: 400;
            line-height: clamp(20px, 0.8vw, 24px);
            color: #293c52;
        }
    }

    .schedule-content {
        width: 100%;
        margin-top: clamp(8px, 1.1vw, 20px);

        @media screen and (min-width: 801px) {
            display: flex;
        }

        .schedule-img,
        .schedule-img-skeleton {
            min-width: calc(50% - 20px);
            max-width: calc(50% - 20px);
            aspect-ratio: 100/66;
            margin-right: 20px;

            @media screen and (max-width: 800px) {
                min-width: 100%;
                max-width: 100%;
            }

            .v-image__image {
                height: auto;
                aspect-ratio: 100/66;
                border-radius: 8px;
            }
        }

        .schedule-content-title {
            margin-bottom: clamp(4px, 1.1vw, 12px);
            font-size: clamp(14px, 1.1vw, 20px);
            font-weight: 600;
            line-height: clamp(20px, 1.3vw, 28px);
            color: #002047;

            @media screen and (max-width: 800px) {
                margin-top: 8px;
            }
        }

        .highlight,
        .description {
            font-size: clamp(13px, 0.9vw, 16px);
            font-weight: 400;
            line-height: clamp(20px, 1.3vw, 24px);

            @include device-mobile {
                font-weight: 500;
            }
        }
    }
}
</style>
