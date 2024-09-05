<template>
    <v-card class="pa-5">
        <div class="d-flex justify-end align-center">
            <v-chip class="mr-4" color="info">{{
                board.requestType ? board.requestType.title : '-'
            }}</v-chip>
            <p class="ma-0 mr-4">{{ board.writerName }}</p>
            <p class="ma-0">{{ moment(board.regDate).format('YYYY-MM-DD HH:DD') }}</p>
        </div>
        <div class="mt-5">
            <h3>제목</h3>
            <div class="mt-2">{{ board.title }}</div>
        </div>
        <div class="mt-5">
            <h3>내용</h3>
            <div class="mt-2">{{ board.content }}</div>
        </div>
    </v-card>
</template>
<script>
import { getStudentRequestByIdApi } from '@/api/board/studentRequest'
import router from '@/router'
import { ref } from '@vue/composition-api'
import moment from 'moment'

export default {
    setup() {
        moment.locale('ko')
        const boardId = router.currentRoute.params.boardId
        console.log('boardId :: :', boardId)
        const board = ref({})

        const getStudentRequestById = async () => {
            const response = await getStudentRequestByIdApi(boardId)
            board.value = response.data
            console.log('response :: ', response)
        }

        getStudentRequestById()

        return {
            board,
            moment,
        }
    },
}
</script>
