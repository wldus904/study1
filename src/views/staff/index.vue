<template>
    <v-card>
        <v-tabs v-model="tab">
            <v-tab>학생 관리</v-tab>
            <v-tab>성적 관리</v-tab>
        </v-tabs>
        <v-tabs-items v-model="tab" class="mt-5">
            <v-tab-item>
                <v-card-text>
                    <div class="text-right">
                        <v-btn @click="openAddModal" small color="info">학생 등록</v-btn>
                    </div>
                    <Students ref="studentsRef" />
                </v-card-text>
            </v-tab-item>
            <v-tab-item>
                <v-card-text>
                    <Reports />
                </v-card-text>
            </v-tab-item>
        </v-tabs-items>
        <!-- 학생 관리 탭 -->
        <!-- 학번, 학생 이름, 주소, 핸드폰 번호, 이메일 -->
        <!-- 학생 이름순, 학번 순 정렬 가능 -->
        <!-- 행 클릭시 학생 상세 정보로 이동 -->

        <!-- 성적 관리 탭 -->
        <!-- 좌측에 시험 타입, 날짜로 생성 -->
        <!-- 등록된 시험 결과가 없으면 삭제 가능, 있으면 삭제 불가 -->
        <!-- 우측에 시험 정보 -->
        <!-- 행 : 학생 이름, 열: 각 성적, 평균, 석차 -->
        <!-- 학생 이름순, 각 성적순, 평균순 정렬 가능 -->
        <!-- 행 클릭시 학생 상세 정보로 이동 -->
        <Confirm
            ref="confirmRef"
            :items="confirmItems"
            @confirmClickOutside="addStudentRef.reset()"
        >
            <template v-slot:msg>
                <AddStudent ref="addStudentRef" />
            </template>
        </Confirm>
    </v-card>
</template>
<script>
import { ref } from '@vue/composition-api'
import AddStudent from './AddStudent.vue'
import Students from './Students.vue'
import Confirm from '@/components/dialog/Confirm.vue'
import Reports from './Reports.vue'
export default {
    components: { AddStudent, Students, Confirm, Reports },
    setup() {
        const MANAGE = 0
        const REPORT = 1
        const tab = ref(MANAGE)
        const confirmItems = ref({ msg: '' })
        const confirmRef = ref(null)
        const addStudentRef = ref(null)
        const studentsRef = ref(null)

        const openAddModal = () => {
            confirmItems.value = {
                closeFunc: () => {
                    addStudentRef.value.reset()
                    confirmRef.value.isShow = false
                },
                confirmFunc: async () => {
                    if (!addStudentRef.value.checkValid()) return

                    console.log('addStudentRef.value.addItems ::: ', addStudentRef.value.addItems)
                    confirmRef.value.isShow = false
                    studentsRef.value.getStudents()
                    addStudentRef.value.reset()
                },
            }

            confirmRef.value.isShow = true
        }

        return {
            MANAGE,
            REPORT,
            tab,
            confirmItems,
            confirmRef,
            addStudentRef,
            studentsRef,

            openAddModal,
        }
    },
}
</script>
<style lang="scss"></style>
