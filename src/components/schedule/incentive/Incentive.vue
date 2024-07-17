<template>
    <div class="schedule-incentive">
        <!-- 썸네일 -->
        <Thumbnail :imgPath="thumbnailImageUrl" />
        <!-- 일정 정보 -->
        <Info
            :scheduleName="scheduleName"
            :numberOfPeople="numberOfPeople"
            :tourStartDate="tourStartDate"
            :tourEndDate="tourEndDate"
            :priceName="priceName"
            :price="price"
            :showShareBtn="showShareBtn"
        />
        <!-- 일정 -->
        <v-expansion-panels v-model="panels" accordion multiple class="schedule-incentive-content">
            <!-- 일차별 일정 -->
            <v-expansion-panel v-for="(item, idx) in schedules" :key="`day-${idx}`">
                <DayItinerary
                    :item="item"
                    :cityName="cityName"
                    :tourStartDate="tourStartDate"
                    :isShowArrivalFlight="idx === 0"
                ></DayItinerary>
            </v-expansion-panel>

            <!-- 선택 사항 -->
            <v-expansion-panel v-if="isExistOptionals()">
                <Optional :item="optionals" />
            </v-expansion-panel>

            <!-- 포함 사항 -->
            <v-expansion-panel>
                <Inclusion />
            </v-expansion-panel>

            <!-- 불포함 사항 -->
            <v-expansion-panel>
                <NotIncluded />
            </v-expansion-panel>
        </v-expansion-panels>
    </div>
</template>
<script>
import Thumbnail from '@/components/schedule/incentive/Thumbnail.vue'
import Info from '@/components/schedule/incentive/Info.vue'
import DayItinerary from '@/components/schedule/incentive/DayItinerary.vue'
import Optional from '@/components/schedule/incentive/Optional.vue'
import Inclusion from '@/components/schedule/incentive/Inclusion.vue'
import NotIncluded from '@/components/schedule/incentive/NotIncluded.vue'
import { computed, onMounted, ref, watch } from '@vue/composition-api'

export default {
    components: { Thumbnail, Info, DayItinerary, Optional, Inclusion, NotIncluded },
    props: {
        thumbnailImageUrl: { type: String, default: 'no_image.png' },
        scheduleName: { type: String, default: '-' },
        schedules: { type: Array, default: {} },
        priceName: { type: String, default: '' },
        price: { type: Number, default: 0 },
        tourStartDate: { type: String, default: '' },
        tourEndDate: { type: String, default: '' },
        numberOfPeople: { type: String, default: '' },
        cityName: { type: String, default: '' },
        optionals: { type: Object, default: {} },
        showShareBtn: { type: Boolean, default: '' },
    },
    setup(props) {
        const panels = ref(Array.from({ length: props.schedules.length + 3 }, (_, idx) => idx))

        const isExistOptionals = () => {
            return (
                (props.optionals.optionalSightseeingUnits &&
                    props.optionals.optionalSightseeingUnits.length > 0) ||
                (props.optionals.shoppingUnits && props.optionals.shoppingUnits.length > 0)
            )
        }

        watch(
            () => props.schedules,
            () => {
                panels.value = Array.from({ length: props.schedules.length + 3 }, (_, idx) => idx)
            },
        )

        return {
            panels,

            isExistOptionals,
        }
    },
}
</script>
<style lang="scss">
@import '@/styles/mixin.scss';
.schedule-incentive {
    font-family: 'Pretendard-regular' !important;
    color: #002047;

    .schedule-incentive-content {
        margin-top: 40px;

        @include device-mobile {
            margin-top: 20px;
        }

        .v-expansion-panel {
            &::before,
            &.v-expansion-panel--active {
                box-shadow: none !important;
            }

            &::after {
                border: none;
            }
        }
    }
}
</style>
