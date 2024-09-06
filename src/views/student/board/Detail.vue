<template>
    <v-card class="pa-5">
        <div class="d-flex justify-end">
            <p class="mr-4">{{ board.writerName }}</p>
            <p>{{ moment(board.regDate).format('YYYY-MM-DD HH:DD') }}</p>
        </div>
        <div>{{ board.title }}</div>
        <div style="padding: 20px; border: 1px solid #eee">{{ board.content }}</div>
    </v-card>
</template>
<script>
import { getNoticeByIdApi } from '@/api/board/notice'
import router from '@/router'
import { ref } from '@vue/composition-api'
import moment from 'moment'

export default {
    setup() {
        moment.locale('ko')
        const boardId = router.currentRoute.params.boardId
        const board = ref({})

        const getNoticeById = async () => {
            const response = await getNoticeByIdApi(boardId)
            board.value = response.data
        }

        if (boardId !== 'create') {
            getNoticeById()
        }

        return {
            boardId,
            board,
            moment,
        }
    },
}
</script>
