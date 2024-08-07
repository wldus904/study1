<template>
    <div class="main-wrapper">
        <div class="login-contents">
            <v-text-field v-model="id" placeholder="학번" hide-details outlined></v-text-field>
            <v-text-field
                v-model="pwd"
                placeholder="비밀번호"
                type="password"
                hide-details
                outlined
                class="mt-1"
            ></v-text-field>
            <div class="msg mt-4">{{ msg }}</div>
            <v-btn @click="loginHandler" block color="info" class="mt-4">로그인</v-btn>
            <v-btn @click="test" block color="info" class="mt-4">test</v-btn>
        </div>
    </div>
</template>
<script>
import { ref } from '@vue/composition-api'
import router from '@/router'
import { loginApi, membersApi, reissueApi } from '@/api/study/members.js'

export default {
    setup() {
        const id = ref('24080704')
        const pwd = ref('ddd444$$$')
        const msg = ref(null)

        const loginHandler = async () => {
            if (!checkValid()) return

            try {
                await login()
                msg.value = null
                // router.push('/student')
            } catch (error) {
                msg.value = error.message
            }
        }

        const checkValid = () => {
            let res = false

            if (!id.value || !pwd.value) msg.value = '아이디, 비밀번호를 입력해주세요'
            else res = true

            return res
        }

        const login = async () => {
            const params = { memberId: id.value, password: pwd.value }
            await loginApi(params)
        }

        const test = async () => {
            try {
                const response = await membersApi()
                console.log('response ::: ', response)
            } catch (error) {
                if (error.retry) test()
                else console.warn(error)
            }
        }

        return {
            id,
            pwd,
            msg,

            loginHandler,
            login,
            test,
        }
    },
}
</script>
<style lang="scss">
.main-wrapper {
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: #fff;
    height: 100%;

    .login-contents {
        width: 250px;

        .v-input--radio-group__input {
            flex-direction: row;
            justify-content: center;
        }

        .v-radio {
            margin: 0 10px;
        }

        .v-radio:not(:last-child):not(:only-child) {
            margin: 0;
        }

        .msg {
            color: red;
        }
    }
}
</style>
