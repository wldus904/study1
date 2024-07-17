<
<template>
    <div class="add-student-wrapper">
        <div class="title">학생 등록</div>
        <v-row>
            <v-col cols="12" class="d-flex align-center pa-2">
                <v-text-field
                    v-model="addItems.name"
                    label="이름"
                    hide-details
                    dense
                    outlined
                ></v-text-field>
                <v-text-field
                    v-model="addItems.address"
                    label="주소"
                    hide-details
                    dense
                    outlined
                ></v-text-field>
            </v-col>
            <v-col cols="12" class="d-flex align-center pa-2">
                <v-text-field
                    v-model="addItems.phone"
                    label="핸드폰"
                    hide-details
                    dense
                    outlined
                ></v-text-field>
                <v-text-field
                    v-model="addItems.email"
                    label="이메일"
                    hide-details
                    dense
                    outlined
                ></v-text-field>
            </v-col>
        </v-row>
        <div class="msg">{{ msg }}</div>
    </div>
</template>
<script>
import { reactive, ref } from '@vue/composition-api'
export default {
    setup() {
        // 학생 번호 자동 배정
        const addItems = reactive({
            name: null,
            address: null,
            phone: null,
            email: null,
        })
        const msg = ref(null)

        const checkValid = () => {
            let res = false

            if (!addItems.name) msg.value = '이름을 입력해주세요'
            else if (!addItems.address) msg.value = '주소를 입력해주세요'
            else if (!addItems.phone) msg.value = '핸드폰 번호를 입력해주세요'
            else if (!addItems.email) msg.value = '이메일을 입력해주세요'
            else res = true

            return res
        }

        const reset = () => {
            addItems.name = null
            addItems.address = null
            addItems.phone = null
            addItems.email = null
        }

        return {
            addItems,
            msg,

            checkValid,
            reset,
        }
    },
}
</script>
<style lang="scss">
.add-student-wrapper {
    .title {
        font-weight: 700;
        margin-bottom: 12px;
    }
    .msg {
        margin-top: 12px;
        text-align: center;
        color: red;
    }
}
</style>
