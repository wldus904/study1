<template>
    <div class="inclusion-wrapper">
        <v-expansion-panel-header>
            <div class="day-box">
                <span class="day">포함 사항</span>
            </div>
        </v-expansion-panel-header>
        <v-expansion-panel-content eager>
            <ul class="schedule-list">
                <li>
                    <div class="schedule-icon"><img :src="icons.accommodation" /></div>
                    <div>
                        <p>숙소</p>
                        <span>일정표 상 숙소(2인 1실 기준)</span>
                    </div>
                </li>
                <li>
                    <div class="schedule-icon"><img :src="icons.tour" /></div>
                    <div>
                        <p>관광</p>
                        <span>일정표 상 관광지 입장료</span>
                    </div>
                </li>
                <li>
                    <div class="schedule-icon"><img :src="icons.transportation" /></div>
                    <div>
                        <p>교통</p>
                        <span>일정표 상 전용 차량비</span>
                    </div>
                </li>
                <li>
                    <div class="schedule-icon"><img :src="icons.meal" /></div>
                    <div>
                        <p>식사</p>
                        <span>일정표에 기재된 식사</span>
                    </div>
                </li>
                <li>
                    <div class="schedule-icon"><img :src="icons.guide" /></div>
                    <p>가이드/기사 경비</p>
                </li>
            </ul>
        </v-expansion-panel-content>
    </div>
</template>
<script>
import accommodation from '@/assets/images/svg/accommodation.svg'
import tour from '@/assets/images/svg/tour.svg'
import transportation from '@/assets/images/svg/transportation.svg'
import meal from '@/assets/images/svg/meal.svg'
import guide from '@/assets/images/svg/guide.svg'

export default {
    setup() {
        return {
            icons: {
                accommodation,
                tour,
                transportation,
                meal,
                guide,
            },
        }
    },
}
</script>
<style lang="scss">
@import '@/assets/components/schedule/incentive/incentive.scss';
</style>
