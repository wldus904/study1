<template>
    <div>
        <h3>{{ className }}</h3>

        <p>학생 목록</p>
        <SimpleHeaderTable
            :headers="studentTableHeaders"
            :items="classStudents"
            @rowClickHandler="moveDetail"
        />

        <p class="mt-5">과목 선생님 목록</p>
        <SimpleHeaderTable :headers="staffTableHeaders" :items="classStaffs" />
    </div>
</template>
<script>
import SimpleHeaderTable from '@/components/table/SimpleHeaderTable.vue'
import { ref } from '@vue/composition-api'

import { getClassroomsByIdApi } from '@/api/classroom/classroom.js'
import moment from 'moment'

import router from '@/router'

export default {
    components: { SimpleHeaderTable },
    setup() {
        moment.locale('ko')
        const classroomId = router.currentRoute.params.classroomId
        const classStudents = ref([])
        const classStaffs = ref([])
        const className = ref('')
        const homeroomTeacher = ref('')
        const studentTableHeaders = [
            { text: '이름', value: 'name', sortable: false, align: 'center', width: '120px' },
            { text: '학번', value: 'memberId', sortable: false, align: 'center', width: '120px' },
            { text: '전화번호', value: 'phone', sortable: false, align: 'center', width: '120px' },
            { text: '주소', value: 'address', sortable: false, align: 'center', width: '120px' },
            { text: '이메일', value: 'email', sortable: false, align: 'center', width: '120px' },
        ]
        const staffTableHeaders = [
            { text: '이름', value: 'name', sortable: false, align: 'center', width: '120px' },
            {
                text: '과목',
                value: 'subjectName',
                sortable: false,
                align: 'center',
                width: '120px',
            },
            { text: '전화번호', value: 'phone', sortable: false, align: 'center', width: '120px' },
            { text: '주소', value: 'address', sortable: false, align: 'center', width: '120px' },
            { text: '이메일', value: 'email', sortable: false, align: 'center', width: '120px' },
        ]

        const moveDetail = item => {
            router.push(`/student/${item.memberId}`)
        }

        const getStudentRequest = async () => {
            const response = await getClassroomsByIdApi(classroomId)
            classStudents.value = response.data.classStudents
            classStaffs.value = response.data.classStaff
            className.value = `${response.data.year}년도 ${response.data.grade}학년 ${response.data.classSection}반`
            homeroomTeacher.value = response.data.homeroomTeacher
            console.log('classStudents.value ::: ', classStudents.value)
            console.log('classStaffs.value ::: ', classStaffs.value)
        }
        getStudentRequest()

        return {
            classStudents,
            classStaffs,
            className,
            homeroomTeacher,
            studentTableHeaders,
            staffTableHeaders,
            moveDetail,
        }
    },
}
</script>
