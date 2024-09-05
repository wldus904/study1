<template>
    <v-card class="pa-5">
        <div class="d-flex justify-end">
            <p class="mr-4">{{ board.writerName }}</p>
            <p>{{ moment(board.regDate).format('YYYY-MM-DD HH:DD') }}</p>
        </div>
        <v-text-field
            v-model="board.title"
            outlined
            dense
            style="background-color: #fff"
            label="제목"
        ></v-text-field>
        <v-text-field
            v-model="board.content"
            outlined
            dense
            style="background-color: #fff"
            label="내용"
        ></v-text-field>
        <div class="text-right">
            <v-btn @click="saveBoard" color="info">{{
                boardId !== 'create' ? '수정' : '등록'
            }}</v-btn>
        </div>
    </v-card>
</template>
<script>
import { getNoticeByIdApi, postNoticeByIdApi, putNoticeByIdApi } from '@/api/board/notice'
import router from '@/router'
import { ref } from '@vue/composition-api'
import moment from 'moment'

export default {
    setup() {
        moment.locale('ko')
        const boardId = router.currentRoute.params.boardId
        const board = ref({})

        const saveBoard = async () => {
            if (boardId !== 'create') {
                await putNoticeByIdApi(boardId, board.value)
            } else {
                board.value.writerMemberId = localStorage.getItem('memberId')
                await postNoticeByIdApi(board.value)
                router.back()
            }
        }

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
            saveBoard,
        }
    },
}
</script>
