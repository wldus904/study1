export const getDate = (
    baseDay = { date: null, year: null, month: null, day: null },
    type = null,
) => {
    let date = new Date()

    if (baseDay.date) date = new Date(baseDay.date)
    if (baseDay.year) date.setFullYear(date.getFullYear() + parseInt(baseDay.year))
    if (baseDay.month) date.setMonth(date.getMonth() + parseInt(baseDay.month))
    if (baseDay.day) date.setDate(date.getDate() + parseInt(baseDay.day))

    const year = date.getFullYear()
    const month = (1 + date.getMonth()).toString().padStart(2, '0')
    const day = date.getDate().toString().padStart(2, '0')
    const hour = date.getHours().toString().padStart(2, '0')
    const minute = date.getMinutes().toString().padStart(2, '0')
    const second = date.getSeconds().toString().padStart(2, '0')

    return { year, month, day, hour, minute, second, date }
}
