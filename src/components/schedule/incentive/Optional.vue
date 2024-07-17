<template>
    <div>
        <v-expansion-panel-header>
            <div class="day-box">
                <span class="day">선택사항</span>
            </div>
        </v-expansion-panel-header>
        <v-expansion-panel-content eager>
            <ul class="schedule-list">
                <!-- 선택관광 -->
                <template
                    v-if="item.optionalSightseeingUnits && item.optionalSightseeingUnits.length > 0"
                >
                    <li
                        v-for="(optionalSightseeing, idx) in item.optionalSightseeingUnits"
                        :key="`${item}-optional-sightseeing-${idx}`"
                    >
                        <div v-if="idx === 0" class="schedule-icon">
                            <img :src="icons.optionalSightseeing" />
                        </div>
                        <v-icon v-else class="schedule-icon" size="24" color="#293C52">{{
                            icons.mdiCircleMedium
                        }}</v-icon>

                        <Unit :item="optionalSightseeing"></Unit>
                    </li>
                </template>

                <!-- 쇼핑 -->
                <template v-if="item.shoppingUnits && item.shoppingUnits.length > 0">
                    <li
                        v-for="(shopping, idx) in item.shoppingUnits"
                        :key="`${item}-shopping-${idx}`"
                    >
                        <div v-if="idx === 0" class="schedule-icon">
                            <img :src="icons.shopping" />
                        </div>
                        <v-icon v-else class="schedule-icon" size="24" color="#293C52">{{
                            icons.mdiCircleMedium
                        }}</v-icon>

                        <Unit :item="shopping"></Unit>
                    </li>
                </template>

                <!-- 기타 -->
                <!-- <template v-if="item.etcUnits && item.etcUnits.length > 0">
                    <li v-for="(etc, idx) in item.etcUnits" :key="`${item}-etc-${idx}`">
                        <div v-if="idx === 0" class="schedule-icon">
                            <img :src="icons.etc" />
                        </div>
                        <v-icon v-else class="schedule-icon" size="24" color="#293C52">{{
                            icons.mdiCircleMedium
                        }}</v-icon>

                        <Unit :item="etc"></Unit>
                    </li>
                </template> -->
            </ul>
        </v-expansion-panel-content>
    </div>
</template>
<script>
import { mdiCircleMedium } from '@mdi/js'
import optionalSightseeing from '@/assets/images/svg/optionalSightseeing.svg'
import shopping from '@/assets/images/svg/shopping.svg'
import etc from '@/assets/images/svg/etc.svg'
import Unit from '@/components/schedule/incentive/Unit.vue'

export default {
    components: { Unit },
    props: {
        item: { type: Object, default: {} },
    },
    setup() {
        return {
            icons: {
                mdiCircleMedium,
                optionalSightseeing,
                shopping,
                etc,
            },
        }
    },
}
</script>
<style lang="scss">
@import '@/assets/components/schedule/incentive/incentive.scss';
</style>
