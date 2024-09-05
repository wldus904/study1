<template>
    <div>
        <h3>학급</h3>

        <div class="d-flex align-center">
            <v-text-field
                v-model="year"
                @keydown.enter="getStudentRequest"
                outlined
                hide-details
                dense
                style="background-color: #fff"
                placeholder="년도"
                clearable
            ></v-text-field>
            <v-text-field
                v-model="grade"
                @keydown.enter="getStudentRequest"
                outlined
                hide-details
                dense
                clearable
                style="background-color: #fff; max-width: 130px"
                class="ml-1"
                placeholder="학년"
            ></v-text-field>
            <v-text-field
                v-model="classSection"
                @keydown.enter="getStudentRequest"
                outlined
                hide-details
                dense
                clearable
                style="background-color: #fff; max-width: 130px"
                class="ml-1"
                placeholder="학년"
            ></v-text-field>
            <v-btn @click="getStudentRequest" color="info" class="ml-2">검색</v-btn>
        </div>

        <SimpleHeaderTable
            :headers="tableHeaders"
            :items="studentRequests"
            @rowClickHandler="moveDetail"
        />

        <Pagination
            :currentPage="page"
            :length="totalPages"
            @clickPage="handleChangePage"
            class="mt-6 mb-3"
        ></Pagination>
    </div>
</template>
<script>
import SimpleHeaderTable from '@/components/table/SimpleHeaderTable.vue'
import Pagination from '@/components/pagination/Pagination.vue'
import { ref } from '@vue/composition-api'

import { getClassroomsApi } from '@/api/classroom/classroom.js'
import moment from 'moment'

import router from '@/router'

export default {
    components: { SimpleHeaderTable, Pagination },
    setup() {
        moment.locale('ko')
        const year = ref(null)
        const grade = ref(null)
        const classSection = ref(null)
        const studentName = ref(null)
        const homeroomTeacherName = ref(null)
        const studentRequests = ref([])
        const page = ref(1)
        const totalPages = ref(1)
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

        const moveDetail = rowItems => {
            router.push(`/admin/classroom/${rowItems.classroomId}`)
        }

        // 목록 페이지 변경
        const handleChangePage = pageNum => {
            page.value = pageNum
            getStudentRequest()
        }

        const getStudentRequest = async () => {
            const params = {
                year: year.value,
                grade: grade.value,
                classSection: classSection.value,
                studentName: studentName.value,
                homeroomTeacherName: homeroomTeacherName.value,
                size: 10,
                page: page.value,
            }
            const response = await getClassroomsApi(params)
            studentRequests.value = response.data.content
            totalPages.value = response.data.totalPages

            studentRequests.value = studentRequests.value.map(request => {
                request.regDate = moment(request.regDate).format('YYYY-MM-DD HH:mm')
                return request
            })
        }
        getStudentRequest()

        return {
            year,
            grade,
            classSection,
            studentName,
            homeroomTeacherName,
            tableHeaders,
            studentRequests,
            page,
            totalPages,

            moveDetail,
            handleChangePage,
            getStudentRequest,
        }
    },
}
</script>
