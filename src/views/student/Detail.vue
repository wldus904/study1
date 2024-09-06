<template>
    <div>
        <h3>{{ `${member.name} (${member.memberId})` }}</h3>

        <v-card class="pa-5 mt-2">
            <div>핸드폰: {{ member.phone }}</div>
            <div>이메일: {{ member.email }}</div>
            <div>주소: {{ member.address }}</div>
        </v-card>

        <div class="mt-5 d-flex justify-space-between">
            <h3>시험 정보</h3>
        </div>

        <v-card v-for="item in examGroups" :key="item.year" class="mt-5 pa-5">
            <div class="font-weight-bold">{{ `${item.year}년도 ${item.title}` }}</div>
            <div class="mt-3">
                {{ ` ${item.grade}학년 ${item.classSection}반` }}
            </div>
            <ul style="list-style-type: none; display: flex" class="pa-0 mt-2">
                <li v-for="(exam, idx2) in item.exams" :key="`${item.year}-${idx2}`">
                    <v-text-field
                        v-if="exam.subjectCode === 'KOR'"
                        v-model="exam.score"
                        :readonly="onlyRead"
                        label="국어"
                        outlined
                        dense
                        style="max-width: 110px; background-color: #fff"
                        class="mr-4"
                    ></v-text-field>
                    <v-text-field
                        v-if="exam.subjectCode === 'ENG'"
                        v-model="exam.score"
                        :readonly="onlyRead"
                        label="영어"
                        outlined
                        dense
                        style="max-width: 110px; background-color: #fff"
                        class="mr-4"
                    ></v-text-field>
                    <v-text-field
                        v-if="exam.subjectCode === 'MAT'"
                        v-model="exam.score"
                        :readonly="onlyRead"
                        label="수학"
                        outlined
                        dense
                        style="max-width: 110px; background-color: #fff"
                        class="mr-4"
                    ></v-text-field>
                    <v-text-field
                        v-if="exam.subjectCode === 'PHY'"
                        v-model="exam.score"
                        :readonly="onlyRead"
                        label="물리"
                        outlined
                        dense
                        style="max-width: 110px; background-color: #fff"
                        class="mr-4"
                    ></v-text-field>
                    <v-text-field
                        v-if="exam.subjectCode === 'CHE'"
                        v-model="exam.score"
                        :readonly="onlyRead"
                        label="화학"
                        outlined
                        dense
                        style="max-width: 110px; background-color: #fff"
                        class="mr-4"
                    ></v-text-field>
                    <v-text-field
                        v-if="exam.subjectCode === 'BIO'"
                        v-model="exam.score"
                        :readonly="onlyRead"
                        label="생물"
                        outlined
                        dense
                        style="max-width: 110px; background-color: #fff"
                        class="mr-4"
                    ></v-text-field>
                    <v-text-field
                        v-if="exam.subjectCode === 'ESS'"
                        v-model="exam.score"
                        :readonly="onlyRead"
                        label="지구과학"
                        outlined
                        dense
                        style="max-width: 110px; background-color: #fff"
                        class="mr-4"
                    ></v-text-field>
                </li>
                <li class="mr-4">총점 <br />{{ item.totalScore }}</li>
                <li class="mr-4">
                    평균
                    <br />{{ item.avgScore }}
                </li>
                <v-btn v-if="!onlyRead" @click="putExam(item)" small color="info">등록/수정</v-btn>
            </ul>
        </v-card>
    </div>
</template>
<script>
import { ref } from '@vue/composition-api'
import { membersByIdApi } from '@/api/study/members'
import { examScoreApi, postExamScoreApi } from '@/api/exam/score'
import router from '@/router'

export default {
    props: {
        onlyRead: { type: Boolean },
        memberId: { type: String },
    },
    setup(props) {
        const member = ref({})
        const examGroups = ref([])
        const memberId = props.onlyRead ? props.memberId : router.currentRoute.params.memberId
        const tableHeaders = [
            { text: '년도', value: 'year', sortable: false, align: 'center', width: '120px' },
            { text: '학년', value: 'grade', sortable: false, align: 'center', width: '120px' },
            { text: '반', value: 'classSection', sortable: false, align: 'center', width: '120px' },
            {
                text: '담임',
                value: 'homeroomTeacher',
                sortable: false,
                align: 'center',
                width: '120px',
            },
        ]

        const putExam = async item => {
            item.memberId = memberId
            await postExamScoreApi(item)
            getExamScore()
        }

        const getmember = async () => {
            const response = await membersByIdApi(memberId)
            member.value = response.data
        }

        const getExamScore = async () => {
            const params = { memberId }
            const response = await examScoreApi(params)

            const subjects = {
                KOR: false,
                ENG: false,
                MAT: false,
                PHY: false,
                CHE: false,
                BIO: false,
                ESS: false,
            }

            response.data = response.data.map(item => {
                item.exams.forEach(exam => {
                    subjects[exam.subjectCode] = true
                })

                Object.keys(subjects).forEach(key => {
                    if (!subjects[key])
                        item.exams.push({
                            examId: item.examId,
                            memberId,
                            subjectCode: key,
                            score: null,
                        })
                })

                return item
            })

            examGroups.value = response.data
        }

        getmember()
        getExamScore()

        return {
            tableHeaders,
            member,
            examGroups,

            putExam,
        }
    },
}
</script>
