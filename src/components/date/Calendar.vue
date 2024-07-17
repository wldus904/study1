<template>
    <v-card class="app-calendar text-sm" v-if="isMounted">
        <div class="h-full">
            <!-- 달력 상단 버튼 -->
            <div
                class="calendar-header mt-0 pt-5 my-5 d-flex align-center justify-space-around flex-wrap"
            >
                <v-btn icon class="me-1" @click="prevCalendar">
                    <v-icon size="30">
                        {{ icons.mdiChevronLeft }}
                    </v-icon>
                </v-btn>
                <p class="font-weight-semibold text-xl text--primary mb-0">
                    <!-- 년 -->
                    <v-menu offset-y ref="yearMenuRef" :close-on-content-click="false">
                        <template #activator="{ on, attrs }">
                            <span
                                v-bind="attrs"
                                v-on="on"
                                class="py-3 pl-3 pr-1 calendar-hover-btn"
                            >
                                {{ calendarDateObj.year }}년
                            </span>
                        </template>

                        <div class="d-flex align-center my-3">
                            <span>
                                <v-btn icon class="me-1" @click="prevYear">
                                    <v-icon size="30"> {{ icons.mdiChevronLeft }} </v-icon>
                                </v-btn>
                            </span>

                            <div class="d-inline-block">
                                <v-row class="pl-3 pr-5 py-5">
                                    <v-col
                                        cols="4"
                                        class="text-center"
                                        v-for="(year, yidx) in dateListObj.year"
                                        :key="yidx"
                                    >
                                        <span
                                            class="calendar-hover-btn"
                                            @click="updateYear(year)"
                                            >{{ year }}</span
                                        >
                                    </v-col>
                                </v-row>
                            </div>

                            <span>
                                <v-btn icon class="me-1" @click="nextYear">
                                    <v-icon size="30"> {{ icons.mdiChevronRight }} </v-icon>
                                </v-btn>
                            </span>
                        </div>
                    </v-menu>

                    <!-- 월 -->
                    <v-menu offset-y ref="monthMenuRef" :close-on-content-click="false">
                        <template #activator="{ on, attrs }">
                            <span v-bind="attrs" v-on="on" class="pa-3 ml-2 calendar-hover-btn">
                                {{ calendarDateObj.month }}월
                            </span>
                        </template>

                        <v-row class="my-5 bb">
                            <v-col
                                cols="4"
                                class="text-center pa-3"
                                v-for="(month, midx) in dateListObj.month"
                                :key="midx"
                            >
                                <span class="calendar-hover-btn pa-3" @click="updateMonth(month)">{{
                                    month
                                }}</span>
                            </v-col>
                        </v-row>
                    </v-menu>
                </p>
                <v-btn icon class="me-3" @click="nextCalendar">
                    <v-icon size="30">
                        {{ icons.mdiChevronRight }}
                    </v-icon>
                </v-btn>
            </div>

            <!-- 달력 -->
            <v-calendar
                ref="refCalendar"
                v-model="calendarDate"
                type="month"
                :event-more="false"
                :events="calendarEvents"
                :event-margin-bottom="5"
                :event-text-color="getEventTextColor"
                @click:event="calendarEventClick"
                @click:date="setDateEventList"
            >
                <template #event="event">
                    <v-tooltip v-if="!isMobile" open-delay="300" color="main" top>
                        <template #activator="{ on, attrs }">
                            <span class="font-weight-black" v-bind="attrs" v-on="on">
                                {{ getEventName(event) }}
                            </span>
                        </template>
                        <span>{{ event.eventParsed.input.tooltip }}</span>
                    </v-tooltip>
                </template>
            </v-calendar>

            <div v-show="isMobile && dateEventList.length > 0" class="px-3">
                <div class="font-weight-black my-3 pb-2">{{ dateEventTitle }}</div>

                <v-row
                    v-for="(event, eidx) in dateEventList"
                    :key="eidx"
                    class="d-flex align-center py-1 date-event"
                    @click="mobileCalendarEventClick(event)"
                >
                    <v-col cols="1">
                        <span
                            :style="{ backgroundColor: event.color }"
                            class="date-event-dot"
                        ></span>
                    </v-col>
                    <v-col cols="3">
                        <span class="pl-1 font-size-8"> {{ getEventTime(event.start) }} </span>
                    </v-col>
                    <v-col cols="5" class="py-0">
                        <div class="font-weight-black pl-2">
                            {{ event.tooltip }}
                        </div>
                    </v-col>
                    <v-col cols="3" class="text-right py-0">
                        {{ event.name }}
                    </v-col>
                </v-row>
            </div>
        </div>

        <CircleLoader v-if="isShowLoader" />
    </v-card>
</template>

<script>
// eslint-disable-next-line object-curly-newline
import CircleLoader from '@/components/loader/CircleLoader.vue'
import { mdiChevronLeft, mdiChevronRight, mdiMenu } from '@mdi/js'
import { onBeforeUnmount, onMounted, reactive, ref } from '@vue/composition-api'
import { getDate } from '@/@core/utils/date'

export default {
    components: { CircleLoader },
    props: {
        items: {
            type: Object,
            default: () => {},
        },
    },
    setup(props, { emit }) {
        const refCalendar = ref(null)
        const calendarDate = ref()
        let calendarDateObj = reactive({})
        let isMounted = ref(false)
        let isMobile = ref(true)
        let isShowLoader = ref(false)
        const yearMenuRef = ref(null)
        const monthMenuRef = ref(null)
        const dateListObj = reactive({
            year: [],
            month: [],
        })
        const calendarEvents = ref(props.items.eventList)
        const groupList = ref(props.items.groupList)
        const blankEvent = {
            id: '',
            name: '',
            start: '',
            end: '',
            tooltip: '',
            timed: false,
            extendedProps: {
                calendar: '',
                guests: [],
                location: '',
                description: '',
            },
        }
        const dateEventList = ref([])
        const dateEventTitle = ref('')
        const event = ref(JSON.parse(JSON.stringify(blankEvent)))

        const setCalendar = () => {
            const dateObj = getDate()

            // calendar 날짜 셋팅
            calendarDate.value = `${dateObj.year}-${dateObj.month}-${dateObj.day}`
            calendarDateObj = dateObj

            // calendar header의 '달' 셋팅
            dateListObj.nowMonth = dateObj.month
            dateListObj.nowYear = dateObj.year

            for (let num = 1; num <= 12; num++) {
                dateListObj.month.push(num.toString().padStart(2, '0'))
            }

            // calendar header의 '년' 셋팅
            let startYear = calendarDateObj.year - (calendarDateObj.year % 12)

            for (let num = 1; num <= 12; num++) {
                dateListObj.year.push(startYear)
                startYear++
            }
        }

        const getEventTextColor = e => e.eventTextColor

        const getTimeTxt = startTime => {
            const time = startTime.split(':')

            let meridiem = '오전'
            let hour = time[0]
            const minute = time[1]

            if (hour > 11) {
                hour = parseInt(hour)
                meridiem = '오후'
                hour = hour - 12

                if (hour === 0 && time[0] === '12') hour = 12
                else if (hour === 12) {
                    meridiem = '오전'
                    hour = 0
                }

                hour = hour.toString().padStart(2, '0')
            }

            return `${meridiem} ${hour}:${minute}`
        }

        const getEventName = eventObj => {
            return `${getTimeTxt(eventObj.eventParsed.start.time)} (${
                eventObj.eventParsed.input.name
            })`
        }

        const prevCalendar = () => {
            let month = parseInt(calendarDateObj.month)
            let oriYear = parseInt(calendarDateObj.year)
            let year = parseInt(calendarDateObj.year)

            month = month - 1

            if (month < 1) {
                month = 12
                year = year - 1
            }

            calendarDateObj.month = month
            calendarDateObj.year = year

            refCalendar.value.prev()
        }

        const nextCalendar = () => {
            let month = parseInt(calendarDateObj.month)
            let oriYear = parseInt(calendarDateObj.year)
            let year = parseInt(calendarDateObj.year)

            month = month + 1

            if (month > 12) {
                month = 1
                year = year + 1
            }

            calendarDateObj.month = month
            calendarDateObj.year = year

            refCalendar.value.next()
        }

        const prevYear = () => {
            let startYear = dateListObj.year[0] - 12

            dateListObj.year = []

            for (let num = 1; num <= 12; num++) {
                dateListObj.year.push(startYear)
                startYear++
            }
        }

        const nextYear = () => {
            let startYear = dateListObj.year[0] + 12

            dateListObj.year = []

            for (let num = 1; num <= 12; num++) {
                dateListObj.year.push(startYear)
                startYear++
            }
        }

        const updateMonth = month => {
            const minusMonthValue = month - parseInt(calendarDateObj.month)
            const date = getDate({
                date: calendarDate.value,
                month: minusMonthValue,
            })

            calendarDate.value = `${date.year}-${date.month}-01`
            calendarDateObj.month = date.month
            monthMenuRef.value.save()
        }

        const updateYear = year => {
            const oriYear = parseInt(calendarDateObj.year)
            const minusYearValue = year - parseInt(calendarDateObj.year)
            const date = getDate({
                date: calendarDate.value,
                year: minusYearValue,
            })

            calendarDate.value = `${date.year}-${date.month}-01`
            calendarDateObj.year = date.year

            yearMenuRef.value.save()
        }

        const calendarEventClick = eventObj => {
            if (isMobile.value) return

            const dateTimeTxt = `${eventObj.eventParsed.start.date} ${getTimeTxt(
                eventObj.eventParsed.start.time,
            )}`

            const params = {
                ticketType: props.items.ticketType,
                id: eventObj.event.id,
                visitDate: eventObj.eventParsed.start.date,
                eventTime: eventObj.eventParsed.start.time,
                dateTimeTxt: dateTimeTxt,
                available: eventObj.event.available,
            }

            setCalendarData(params)
        }

        const mobileCalendarEventClick = eventObj => {
            const [date, time] = eventObj.start.split(' ')
            const dateTimeTxt = `${date} ${getTimeTxt(time)}`

            const params = {
                ticketType: props.items.ticketType,
                id: eventObj.id,
                visitDate: date,
                eventTime: time,
                dateTimeTxt: dateTimeTxt,
                available: eventObj.available,
            }

            setCalendarData(params)
        }

        const setCalendarData = params => {
            emit('setCalendarData', params)
        }

        const checkMobile = () => {
            const browserWidth = window.innerWidth
            isMobile.value = browserWidth < 960
        }

        const setDateEventList = dateObj => {
            dateEventList.value = calendarEvents.value.filter(event => {
                const eventDate = event.start.split(' ')[0]
                return eventDate === dateObj.date
            })

            dateEventTitle.value = `${dateObj.date} 이벤트 선택`

            const year = dateObj.year.toString()
            const month = dateObj.month.toString().padStart('0', 2)

            calendarDateObj.year = year
            calendarDateObj.month = month
            calendarDate.value = `${year}-${month}-01`
        }

        const getEventTime = startDateTxt => {
            const timeTxt = startDateTxt.split(' ')[1]
            const timeList = timeTxt.split(':')

            return `${timeList[0]}시 ${timeList[1]}분`
        }

        const init = () => {
            setCalendar()
            checkMobile()

            // 960 기준

            onMounted(() => {
                isMounted.value = true
                window.addEventListener('resize', checkMobile)
            })

            onBeforeUnmount(() => {
                window.removeEventListener('resize', checkMobile)
            })
        }

        init()

        return {
            refCalendar,
            calendarDate,
            calendarDateObj,
            calendarEvents,
            groupList,
            isMounted,
            isMobile,
            isShowLoader,
            yearMenuRef,
            monthMenuRef,
            dateListObj,
            event,
            dateEventList,
            dateEventTitle,

            prevCalendar,
            nextCalendar,
            prevYear,
            nextYear,
            getEventTextColor,
            getEventName,
            updateMonth,
            updateYear,
            calendarEventClick,
            mobileCalendarEventClick,
            setDateEventList,
            getEventTime,

            // Icons
            icons: {
                mdiChevronLeft,
                mdiChevronRight,
                mdiMenu,
            },
        }
    },
}
</script>
<style lang="scss" scoped>
@import '../../assets/components/date/calendar-scope.scss';
</style>
<style lang="scss">
@import '../../assets/components/date/calendar.scss';
</style>
