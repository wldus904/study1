<template>
    <ul class="incentive-template-header">
        <li>
            <div class="template-title text-ellipsis">
                {{ scheduleName }}
            </div>
            <v-btn v-if="showShareBtn" @click="share" icon>
                <v-icon color="#002047" size="24" class="cursor-pointer">
                    {{ icons.mdiShareVariantOutline }}
                </v-icon>
            </v-btn>
        </li>
        <li>
            <div><span>인원</span>{{ numberOfPeople }}</div>
            <div><span>날짜</span>{{ travelDate }}</div>
        </li>
        <li>
            {{ priceName ? priceName : '1인 예상 견적가' }}
            <p>{{ price ? price.toLocaleString() : '-' }}원</p>
        </li>

        <v-snackbar v-model="snackbar" timeout="5000" class="toast">
            주소가 클립보드에 복사되었습니다
        </v-snackbar>
    </ul>
</template>
<script>
import { mdiShareVariantOutline } from '@mdi/js'
import { computed, ref } from '@vue/composition-api'
import router from '@/router'
import { getDateDiff } from '@/utils/date'

export default {
    props: {
        scheduleName: { type: String, default: '' },
        numberOfPeople: { type: String, default: {} },
        tourStartDate: { type: String, default: '' },
        tourEndDate: { type: String, default: '' },
        priceName: { type: String, default: {} },
        price: { type: Number, default: {} },
        showShareBtn: { type: Boolean, default: {} },
    },
    setup(props) {
        const snackbar = ref(false)
        const travelDate = computed(() => {
            return `${props.tourStartDate}~${props.tourEndDate} (${getDateDiff(
                props.tourStartDate,
                props.tourEndDate,
            )}일)`
        })

        const share = () => {
            const textArea = document.createElement('textarea')
            document.body.appendChild(textArea)
            textArea.value = `https://www.odgano.com${router.history.current.fullPath}`
            textArea.select()
            document.execCommand('copy')
            document.body.removeChild(textArea)
            snackbar.value = true
        }

        return {
            snackbar,
            travelDate,

            share,

            icons: {
                mdiShareVariantOutline,
            },
        }
    },
}
</script>
<style lang="scss">
@import '@/styles/mixin.scss';

ul.incentive-template-header {
    list-style-type: none;
    padding: 0;
    margin-top: 40px;

    @include device-mobile {
        margin-top: 20px;
    }

    li:nth-child(1) {
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-size: clamp(20px, 2vw, 32px);
        font-weight: 800;
        line-height: 40px;
        font-family: 'Pretendard-extrabold' !important;

        @include device-mobile {
            font-weight: 700;
            line-height: 28px;
        }

        .template-title {
            width: calc(100% - 30px);
        }
    }

    li:nth-child(2) {
        margin-top: 8px;
        font-size: clamp(12px, 1.2vw, 16px);
        font-weight: 400;
        line-height: 24px;
        color: #293c52;

        @include device-desktop {
            display: flex;
            margin-top: 12px;

            div {
                &:nth-child(1) {
                    &::after {
                        content: '';
                        display: inline-block;
                        position: relative;
                        top: 1px;
                        border: 1px solid #d6d2da;
                        height: 12px;
                        margin-left: 16px;
                    }
                }

                &:nth-child(2) {
                    margin-left: 16px;
                }
            }
        }

        span {
            margin-right: 4px;
            color: #7b848f;
        }

        // span {
        //     color: #7b848f;

        //     &::after {
        //         content: '';
        //         display: inline-block;
        //         position: relative;
        //         top: 2px;
        //         border: 1px solid #d6d2da;
        //         height: 12px;
        //         margin-left: 4px;
        //     }
        // }
    }

    li:nth-child(3) {
        display: flex;
        align-items: center;
        margin-top: 32px;
        font-size: clamp(13px, 1.2vw, 16px);
        font-weight: 600;
        line-height: 24px;
        color: #ff0000;

        @include device-mobile {
            margin-top: 8px;
            font-weight: 500;
            line-height: 20px;
        }

        p {
            margin-bottom: 0;
            margin-left: 8px;
            font-size: clamp(18px, 1.5vw, 28px);
            font-weight: 700;
            line-height: 24px;
            color: #002047;
        }
    }
}
</style>
