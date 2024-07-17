<template>
    <div class="inclusion-wrapper">
        <v-expansion-panel-header>
            <div class="day-box">
                <span class="day">불포함 사항</span>
            </div>
        </v-expansion-panel-header>
        <v-expansion-panel-content eager>
            <ul class="schedule-list">
                <li>
                    <div class="schedule-icon"><img :src="icons.transportation" /></div>
                    <div>
                        <p>교통</p>
                        <span>왕복 항공권 및 유류할증료 등의 제세금</span>
                    </div>
                </li>
                <li>
                    <div class="schedule-icon"><img :src="icons.etc" /></div>
                    <div>
                        <p>기타</p>
                        <span>일정표 상 표시되지 않은 항목</span>
                    </div>
                </li>
                <li>
                    <div class="schedule-icon"><img :src="icons.etc" /></div>
                    <div>
                        <p>기타 개인경비 및 매너팁</p>
                        <span>
                            매너팁은 소비자의 자율적 선택상항으로 지불여부에 따른 불이익은 없습니다.
                        </span>
                    </div>
                </li>
                <li>
                    <span class="etc">
                        ※ 일정 이외 자유일정 시 가이드 및 차량은 제공되지 않습니다.
                    </span>
                </li>
            </ul>
        </v-expansion-panel-content>
    </div>
</template>
<script>
import etc from '@/assets/images/svg/etc.svg'
import transportation from '@/assets/images/svg/transportation.svg'

export default {
    setup() {
        return {
            icons: {
                transportation,
                etc,
            },
        }
    },
}
</script>
<style lang="scss">
@import '@/assets/components/schedule/incentive/incentive.scss';
</style>
