import { isEmpty } from './index'

export const required = value => (value && value.length ? true : '필수 항목입니다.')

export const fileRequired = value => (value && value.size > 0 ? true : '필수 항목입니다.')

export const emailValidator = value => {
    if (isEmpty(value)) {
        return true
    }

    // eslint-disable-next-line
    const re =
        /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/

    if (Array.isArray(value)) {
        return value.every(val => re.test(String(val)))
    }

    return re.test(String(value)) || '이메일 형식이 올바르지 않습니다.'
}

export const passwordValidator = password => {
    /* eslint-disable no-useless-escape */
    const regExp = /(?=.*\d)(?=.*[a-z])(?=.*[!@#$%^&*()]).{8,}/
    /* eslint-enable no-useless-escape */
    const validPassword = regExp.test(password)

    return (
        // eslint-disable-next-line operator-linebreak
        validPassword ||
        '최소 8자의 소문자, 특수 문자(!@#$%^&*()) 및 숫자를 하나 이상 포함해야 합니다.'
    )
}

export const confirmedValidator = (value, target) =>
    // eslint-disable-next-line implicit-arrow-linebreak
    value === target || '비밀번호가 일치하지 않습니다.'

export const phoneNumberValidator = phoneNumber => {
    /* eslint-disable no-useless-escape */
    const regExp = /^[0-9]{3}[-\s\.]{0,1}[0-9]{3,4}[-\s\.]{0,1}[0-9]{4}$/
    /* eslint-disable no-useless-escape */
    const validPhoneNumber = regExp.test(phoneNumber)

    return (
        // eslint-disable-next-line operator-linebreak
        validPhoneNumber || '잘못된 휴대폰 번호입니다.'
    )
}

export const between = (value, min, max) => () => {
    const valueAsNumber = Number(value)

    return (
        (Number(min) <= valueAsNumber && Number(max) >= valueAsNumber) ||
        `Enter number between ${min} and ${max}`
    )
}

export const integerValidator = value => {
    if (isEmpty(value)) {
        return true
    }

    if (Array.isArray(value)) {
        return value.every(val => /^-?[0-9]+$/.test(String(val)))
    }

    return /^-?[0-9]+$/.test(String(value)) || 'This field must be an integer'
}

export const regexValidator = (value, regex) => {
    if (isEmpty(value)) {
        return true
    }

    let regeX = regex
    if (typeof regeX === 'string') {
        regeX = new RegExp(regeX)
    }

    if (Array.isArray(value)) {
        return value.every(val => regexValidator(val, { regeX }))
    }

    return regeX.test(String(value)) || 'The Regex field format is invalid'
}

export const alphaValidator = value => {
    if (isEmpty(value)) {
        return true
    }

    // const valueAsString = String(value)

    return (
        /^[A-Z]*$/i.test(String(value)) || 'The Alpha field may only contain alphabetic characters'
    )
}

export const urlValidator = value => {
    if (value === undefined || value === null || value.length === 0) {
        return true
    }
    /* eslint-disable no-useless-escape */
    const re = /^(http[s]?:\/\/){0,1}(www\.){0,1}[a-zA-Z0-9\.\-]+\.[a-zA-Z]{2,5}[\.]{0,1}/

    return re.test(value) || 'URL is invalid'
}

export const lengthValidator = (value, length) => {
    if (isEmpty(value)) {
        return true
    }

    return (
        value.length === length || `The Min Character field must be at least ${length} characters`
    )
}
export const alphaDashValidator = value => {
    if (isEmpty(value)) {
        return true
    }

    const valueAsString = String(value)

    return /^[0-9A-Z_-]*$/i.test(valueAsString) || 'All Character is not valid'
}
