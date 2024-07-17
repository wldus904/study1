<template>
    <div>
        <v-expansion-panel-header>
            <div class="day-box">
                <span class="day">{{ item.day }}일차</span>
                <span v-if="item.day">{{ getTourDate(item.day) }}</span>
            </div>
        </v-expansion-panel-header>
        <v-expansion-panel-content eager>
            <ul class="schedule-list">
                <template v-if="isShowArrivalFlight">
                    <li>
                        <div class="schedule-icon"><img :src="icons.location" eager /></div>
                        <Unit
                            :item="{
                                unitName: `${cityName} 공항 도착`,
                                unitComplement: '*항공권은 포함되어 있지 않습니다.',
                            }"
                        ></Unit>
                    </li>

                    <li>
                        <v-icon class="schedule-icon" size="24" color="#293C52">{{
                            icons.mdiCircleMedium
                        }}</v-icon>
                        <Unit
                            :item="{
                                unitName: '가이드 미팅',
                                unitSummary: '가이드와 미팅 후 본격적인 일정을 시작합니다.',
                            }"
                        ></Unit>
                    </li>
                </template>

                <!-- 일정 -->
                <template v-if="item.sightseeings && item.sightseeings.length > 0">
                    <li v-for="(golf, idx) in item.golfs" :key="`${item}-golf-${idx}`">
                        <div v-if="idx === 0" class="schedule-icon">
                            <img :src="icons.tour" eager />
                        </div>
                        <v-icon v-else class="schedule-icon" size="24" color="#293C52">{{
                            icons.mdiCircleMedium
                        }}</v-icon>

                        <Unit :item="golf" category="golfs"></Unit>
                    </li>

                    <li
                        v-for="(sightseeing, idx) in item.sightseeings"
                        :key="`${item}-sightseeing-${idx}`"
                    >
                        <div v-if="idx === 0 && item.golfs.length === 0" class="schedule-icon">
                            <img :src="icons.tour" eager />
                        </div>
                        <v-icon v-else class="schedule-icon" size="24" color="#293C52">{{
                            icons.mdiCircleMedium
                        }}</v-icon>

                        <Unit
                            v-if="sightseeing.sightseeingPlanType.code === 'GENERAL'"
                            :item="sightseeing"
                            category="sightseeings"
                        ></Unit>
                        <Unit
                            v-else
                            :item="{
                                unitName: sightseeing.sightseeingPlanType.title,
                                unitSummary:
                                    sightseeing.sightseeingPlanType.code === 'SEPARATE_SCHEDULE'
                                        ? sightseeing.planComment
                                        : '',
                            }"
                            category="sightseeings"
                        ></Unit>
                    </li>
                </template>

                <!-- 호텔 -->
                <li v-if="item.accommodation">
                    <div class="schedule-icon"><img :src="icons.accommodation" eager /></div>
                    <Unit
                        v-if="item.accommodation.accommodationType.code === 'IN_FLIGHT'"
                        :item="{
                            unitName: item.accommodation.accommodationType.title,
                        }"
                        category="accommodation"
                    ></Unit>
                    <Unit :item="item.accommodation" category="accommodation"></Unit>
                </li>

                <!-- 식사 -->
                <template v-if="item.meals && item.meals.length > 0">
                    <li v-for="(meal, mIdx) in item.meals" :key="`${item}-meal-${mIdx}`">
                        <div v-if="mIdx === 0" class="schedule-icon">
                            <img :src="icons.meal" eager />
                        </div>
                        <v-icon v-else class="schedule-icon" size="24" color="#293C52">{{
                            icons.mdiCircleMedium
                        }}</v-icon>
                        <template v-if="isCustomMealOption(meal.mealEnvironmentType.code)">
                            <Unit
                                :item="{
                                    unitName: convertMealUnitName(
                                        meal.mealType.title,
                                        meal.mealEnvironmentType.title,
                                    ),
                                }"
                                category="meals"
                            ></Unit>
                        </template>
                        <Unit
                            v-else
                            :item="{
                                ...meal,
                                unitName: convertMealUnitName(meal.mealType.title, meal.unitName),
                            }"
                            category="meals"
                        ></Unit>
                    </li>
                </template>

                <template v-if="isEmptySchedule()">
                    <li>
                        <v-icon class="schedule-icon" size="24" color="#293C52">{{
                            icons.mdiCircleMedium
                        }}</v-icon>
                        <Unit
                            :item="{
                                unitName: `여행 종료`,
                            }"
                        ></Unit>
                    </li>
                </template>
            </ul>
        </v-expansion-panel-content>
    </div>
</template>
<script>
import { mdiCircleMedium } from '@mdi/js'
import moment from 'moment'

import location from '@/assets/images/svg/location.svg'
import accommodation from '@/assets/images/svg/accommodation.svg'
import tour from '@/assets/images/svg/tour.svg'
import meal from '@/assets/images/svg/meal.svg'

import Unit from '@/components/schedule/incentive/Unit.vue'

export default {
    components: { Unit },
    props: {
        cityName: { type: String, default: '' },
        tourStartDate: { type: String, default: '' },
        item: { type: Object, default: {} },
        isShowArrivalFlight: { type: Boolean, default: false },
    },
    setup(props) {
        moment.locale('ko')

        const getTourDate = day => {
            return moment(props.tourStartDate)
                .add(parseInt(day) - 1, 'd')
                .format('M.DD(ddd)')
        }

        const isCustomMealOption = code => {
            return ['IN_FLIGHT_MEAL', 'FREE_MEAL', 'HOTEL_BREAKFAST'].includes(code)
        }

        const isEmptySchedule = () => {
            const isEmptySightseeings =
                !props.item.sightseeings || props.item.sightseeings.length === 0
            const isEmptyAccommodation = !props.item.accommodation
            const isEmptyMeals = !props.item.meals || props.item.meals.length === 0

            return isEmptySightseeings && isEmptyAccommodation && isEmptyMeals
        }

        const convertMealUnitName = (type, name) => {
            return `${type} - ${name}`
        }

        return {
            getTourDate,
            isCustomMealOption,
            isEmptySchedule,
            convertMealUnitName,

            icons: {
                mdiCircleMedium,
                location,
                accommodation,
                tour,
                meal,
            },
        }
    },
}
</script>
<style lang="scss">
@import '@/assets/components/schedule/incentive/incentive.scss';
</style>
