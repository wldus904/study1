<template>
    <div class="student-info-wrapper">
        <div>
            <div class="title">학생 기본 정보</div>
            <v-row>
                <v-col cols="12" class="pa-2">
                    {{ studentInfo.name }} ({{ studentInfo.studentNum }})
                </v-col>
                <v-col cols="12" class="d-flex align-center pa-2">
                    <v-text-field
                        v-model="studentInfo.phone"
                        label="핸드폰"
                        hide-details
                        dense
                        outlined
                    ></v-text-field>
                    <v-text-field
                        v-model="studentInfo.email"
                        label="이메일"
                        hide-details
                        dense
                        outlined
                    ></v-text-field>
                </v-col>
            </v-row>
            <div>{{ msg }}</div>
            <v-btn @click="modify" block color="info" class="mt-6">수정</v-btn>
        </div>
    </div>
</template>
<script>
import { onMounted, reactive, ref } from '@vue/composition-api'

export default {
    props: {
        items: { type: Object },
    },
    setup(props) {
        // 학생 번호 자동 배정
        const studentInfo = reactive({
            studentNum: null,
            name: null,
            address: null,
            phone: null,
            email: null,
        })
        const msg = ref(null)

        const modify = () => {
            let res = false

            if (!studentInfo.name) msg.value = '이름을 입력해주세요'
            else if (!studentInfo.address) msg.value = '주소를 입력해주세요'
            else if (!studentInfo.phone) msg.value = '핸드폰 번호를 입력해주세요'
            else if (!studentInfo.email) msg.value = '이메일을 입력해주세요'
            else res = true

            if (!res) return

            console.log('studentInfo ::: ', studentInfo)
        }

        onMounted(() => {
            Object.assign(studentInfo, props.items)
        })

        return {
            studentInfo,
            msg,

            modify,
        }
    },
}
</script>
<style lang="scss">
.student-info-wrapper {
    .title {
        font-weight: 700;
        margin-bottom: 12px;
    }
}
</style>
