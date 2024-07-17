function divideDateString(str) {
    const year = str.slice(0, 4)
    const month = str.slice(4, 6)
    const day = str.slice(6, 8)
    return [year, month, day]
}

function leftPad(value) {
    if (value >= 10) {
        return value
    }
    return `0${value}`
}

export const dateToStringByFormatting = (dateStr, delimiter = '-') => {
    const date = new Date([...divideDateString(dateStr)])
    const year = date.getFullYear()
    const month = leftPad(date.getMonth() + 1)
    const day = leftPad(date.getDate())
    return [year, month, day].join(delimiter)
}

/**
 * 며칠 전 날짜 구하기
 * @param {*} days Number
 */
export const getFewDaysAgo = days => {
    const today = new Date()
    const daysago = parseInt(days)
    const oldday = new Date(today - 1000 * 60 * 60 * 24 * daysago)
    return oldday.toISOString().substring(0, 10)
}

export const getDateDiff = (d1, d2) => {
    const date1 = new Date(d1)
    const date2 = new Date(d2)

    const diffDate = date1.getTime() - date2.getTime()

    return Math.abs(diffDate / (1000 * 60 * 60 * 24)) + 1
}
