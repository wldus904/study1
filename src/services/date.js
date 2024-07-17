import moment from 'moment'

moment.locale('ko')

export const convertDateFormat = (date, format) => {
    return moment(date).format(format)
}
