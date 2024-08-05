<template>
    <div class="main-wrapper">
        <div class="login-contents">
            <v-text-field
                v-model="id"
                :placeholder="type === STUDENT ? '학번' : '아이디'"
                hide-details
                outlined
            ></v-text-field>
            <v-text-field
                v-model="pwd"
                placeholder="비밀번호"
                type="password"
                hide-details
                outlined
                class="mt-1"
            ></v-text-field>
            <v-radio-group v-model="type" hide-details>
                <v-radio label="학생" :value="STUDENT"></v-radio>
                <v-radio label="교직원" :value="STAFF"></v-radio>
            </v-radio-group>
            <div class="msg mt-4">{{ msg }}</div>
            <v-btn @click="loginHandler" block color="info" class="mt-4">로그인</v-btn>
            <v-btn @click="test" block color="info" class="mt-4">테스트</v-btn>
        </div>
    </div>
</template>
<script>
import { ref } from '@vue/composition-api'
// import router from '@/router'
import { loginApi, studentsApi } from '@/api/study/student/student.js'

export default {
    setup() {
        const STUDENT = 1
        const STAFF = 2
        const id = ref('24080504')
        const pwd = ref('ddd444$$$')
        const type = ref(STUDENT)
        const msg = ref(null)

        const loginHandler = async () => {
            if (!checkValid()) return
            await login()

            console.log('login success')
            // msg.value = null
            // if (type.value == STAFF) router.push('/staff')
            // else router.push('/student')
        }

        const checkValid = () => {
            let res = false

            if (!id.value || !pwd.value) msg.value = '아이디, 비밀번호를 입력해주세요'
            else res = true

            return res
            // else if (id.value == 1234 && pwd.value == 1234) {
            //     msg.value = null
            //     if (type.value == STAFF) router.push('/staff')
            //     else router.push('/student')
            // } else msg.value = '아이디, 비밀번호를 확인해주세요'
        }

        const login = async () => {
            try {
                const params = { studentId: id.value, password: pwd.value }
                const response = await loginApi(params)
                localStorage.setItem('accessToken', response.data.accessToken)
            } catch (error) {
                console.warn(error)
            }
        }

        const test = async () => {
            try {
                const response = await studentsApi()
                console.log('response ::: ', response)
            } catch (error) {
                console.warn(error)
            }
        }

        return {
            STUDENT,
            STAFF,
            id,
            pwd,
            type,
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
