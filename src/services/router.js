import router from '@/router'
export const pushRouter = url => {
    return router.push(url)
}

export const setWindowLocation = url => {
    window.location = url
}
