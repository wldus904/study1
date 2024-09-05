<template>
    <div>
        <h3>학생 게시판</h3>

        <div class="d-flex align-center">
            <v-text-field
                v-model="title"
                @keydown.enter="getStudentRequest"
                outlined
                hide-details
                dense
                style="background-color: #fff"
                placeholder="제목"
                clearable
            ></v-text-field>

            <v-text-field
                v-model="writerName"
                @keydown.enter="getStudentRequest"
                outlined
                hide-details
                dense
                clearable
                style="background-color: #fff; max-width: 130px"
                class="ml-1"
                placeholder="작성자"
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

import { getStudentRequestApi } from '@/api/board/studentRequest.js'
import moment from 'moment'

import router from '@/router'

export default {
    components: { SimpleHeaderTable, Pagination },
    setup() {
        moment.locale('ko')
        const title = ref('')
        const writerName = ref('')
        const studentRequests = ref([])
        const page = ref(1)
        const totalPages = ref(1)
        const tableHeaders = [
            { text: '등록일', value: 'regDate', sortable: false, align: 'center', width: '200px' },
            {
                text: '종류',
                value: 'requestType',
                sortable: false,
                align: 'center',
                width: '120px',
            },
            {
                text: '제목',
                value: 'title',
                sortable: false,
                align: 'center',
                width: '120px',
            },
            {
                text: '작성자',
                value: 'writerName',
                sortable: false,
                align: 'center',
                width: '150px',
            },
        ]

        const moveDetail = rowItems => {
            router.push(`/admin/board/student-request/${rowItems.boardId}`)
        }

        // 목록 페이지 변경
        const handleChangePage = pageNum => {
            page.value = pageNum
            getStudentRequest()
        }

        const getStudentRequest = async () => {
            const params = {
                title: title.value,
                writerName: writerName.value,
                size: 10,
                page: page.value,
            }
            const response = await getStudentRequestApi(params)
            studentRequests.value = response.data.content
            totalPages.value = response.data.totalPages

            studentRequests.value = studentRequests.value.map(request => {
                request.requestType = request.requestType.title
                request.regDate = moment(request.regDate).format('YYYY-MM-DD HH:mm')
                return request
            })
        }
        getStudentRequest()

        return {
            title,
            writerName,
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
