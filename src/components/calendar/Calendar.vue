<template>
    <div class="calendar">
        <date-picker
            v-model="selectedDate"
            ref="datePickerRef"
            @pick="datePickHandler"
            @calendar-change="monthChangeHandler"
            :disabled-date="disabledBefore"
            :lang="lang"
            range
            open
            inline
        >
        </date-picker>
    </div>
</template>
<script>
import { ref } from '@vue/composition-api'
import moment from 'moment'
import DatePicker from 'vue2-datepicker'
import 'vue2-datepicker/index.css'

export default {
    components: { DatePicker },
    setup(props, { emit }) {
        moment.locale('ko')
        const START = 0
        const END = 1
        const selectedDate = ref(null)
        const datePickerRef = ref(null)
        const lang = {
            days: ['일', '월', '화', '수', '목', '금', '토'],
            months: [
                '1월',
                '2월',
                '3월',
                '4월',
                '5월',
                '6월',
                '7월',
                '8월',
                '9월',
                '10월',
                '11월',
                '12월',
            ],
            yearFormat: 'YYYY년',
            monthFormat: 'MM월',
        }

        const disabledBefore = date => {
            const current = new Date()
            return date < current
        }

        let firstCell = null
        let startDate = null
        let lastCell = null
        let endDate = null

        const datePickHandler = item => {
            setTimeout(() => {
                if (
                    selectedDate.value &&
                    selectedDate.value.length > 1 &&
                    selectedDate.value[0].toString() === selectedDate.value[1].toString()
                )
                    selectedDate.value = null

                const cells = datePickerRef.value.$refs.picker.$el.querySelectorAll('.cell.active')

                if (cells.length === 1 && firstCell) {
                    firstCell.classList.remove('start-date')
                    if (lastCell) lastCell.classList.remove('end-date')
                    startDate = null
                    endDate = null
                }
                const cell = cells[0]
                if (!cell.classList.contains('start-date')) {
                    firstCell = cell
                    firstCell.classList.add('start-date')
                    startDate = firstCell.getAttribute('title')
                }

                if (cells.length > 1) {
                    lastCell = cells[1]
                    lastCell.classList.add('end-date')
                    endDate = lastCell.getAttribute('title')
                }

                emit('setDate', { start: startDate, end: endDate })
            }, 1)
        }

        const monthChangeHandler = () => {
            setTimeout(() => {
                const cells = datePickerRef.value.$refs.picker.$el.querySelectorAll('.cell.active')

                for (let cell of cells) {
                    if (cell.getAttribute('title') === startDate) {
                        firstCell = cell
                        firstCell.classList.add('start-date')
                    } else if (cell.getAttribute('title') === endDate) {
                        lastCell = cell
                        lastCell.classList.add('end-date')
                    }
                }
            }, 1)
        }

        return {
            selectedDate,
            datePickerRef,
            lang,

            disabledBefore,
            datePickHandler,
            monthChangeHandler,
        }
    },
}
</script>
<style lang="scss">
.calendar {
    width: 100%;
    font-family: 'Pretendard-regular' !important;

    .mx-calendar {
        width: 50% !important;
        padding: 22px;

        @media (max-width: 750px) {
            width: 100% !important;
        }
    }

    .mx-datepicker-main {
        border: 1px solid #c6d5e8;
        border-radius: 10px;
    }

    .mx-btn-icon-double-left,
    .mx-btn-icon-double-right,
    .mx-btn-current-year {
        display: none;
    }

    .mx-btn-icon-left,
    .mx-btn-icon-right {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 28px;
        height: 28px;
        padding: 6px;
        background-color: #f3f8fe;

        .mx-icon-left,
        .mx-icon-right {
            &::before {
                border-width: 4px 0 0 4px;
            }
        }
    }

    .mx-calendar {
        min-height: 350px;

        @media (max-width: 750px) {
            border-top: 1px solid #c6d5e8;
        }
    }

    .mx-calendar-header-label {
        font-family: 'Pretendard-regular' !important;
        pointer-events: none;

        .mx-btn-current-month {
            font-size: 20px;
            font-weight: 600;
            color: #002047;
        }
    }

    .mx-calendar-content {
        margin-top: 16px;
        font-family: 'Pretendard-regular' !important;

        .mx-table-date {
            thead tr th {
                font-size: 13px;
                font-weight: 500;
                color: #7b848f;
            }

            tbody tr td {
                vertical-align: top;
                width: 38px;
                height: 38px;
                padding: 2px;
                font-size: 13px;
                font-weight: 500;
                color: #002047;

                &.start-date::after {
                    display: block;
                    content: '출발일';
                    font-size: 9px;
                }

                &.end-date::after {
                    display: block;
                    content: '도착일';
                    font-size: 9px;
                }

                &.cell {
                    &.disabled {
                        cursor: default;
                        color: #ccc;
                        background-color: #fff !important;
                    }
                    &.active {
                        border-radius: 4px;
                        color: #fff;
                        background-color: #0f62fe;
                    }
                    &.in-range {
                        color: #0f62fe;
                        background-color: #c7e2ff;
                    }
                }

                &.not-current-month {
                    pointer-events: none;
                    background-color: #fff !important;

                    &::before {
                        content: '';
                    }

                    div {
                        display: none;
                    }
                }
            }
        }
    }
}
</style>
