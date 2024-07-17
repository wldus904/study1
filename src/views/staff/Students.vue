<template>
    <div class="students-wrapper">
        <div class="title">학생 목록</div>
        <div class="d-flex align-center">
            <v-text-field
                v-model="condition.studentNum"
                label="학번"
                hide-details
                dense
                outlined
                class="ml-2"
            />
            <v-text-field
                v-model="condition.name"
                label="이름"
                hide-details
                dense
                outlined
                class="ml-2"
            />
            <v-btn @click="search" small color="info" class="ml-2">검색</v-btn>
        </div>
        <v-data-table
            :headers="headers"
            :items="items"
            @click:row="rowClickHandler"
            hide-default-footer
            class="simple-header-table mt-2"
            no-data-text="검색 결과가 없습니다"
        >
        </v-data-table>
    </div>
</template>
<script>
import { reactive, ref } from '@vue/composition-api'
import router from '@/router'

export default {
    setup() {
        const condition = reactive({
            studentNum: null,
            name: null,
        })
        const headers = [
            { text: '학번', value: 'studentNum', sortable: false, align: 'center' },
            { text: '이름', value: 'name', sortable: false, align: 'center' },
            { text: '주소', value: 'address', sortable: false, align: 'left' },
            { text: '핸도폰 번호', value: 'phone', sortable: false, align: 'center' },
            { text: '이메일', value: 'email', sortable: false, align: 'center' },
        ]
        const items = ref([
            {
                studentNum: 1,
                name: '가나다',
                address: '서울',
                phone: '00011112222',
                email: '이메일',
            },
            {
                studentNum: 2,
                name: '라마바',
                address: '서울',
                phone: '00011112222',
                email: '이메일',
            },
            {
                studentNum: 3,
                name: '사아자',
                address: '서울',
                phone: '00011112222',
                email: '이메일',
            },
        ])

        const rowClickHandler = value => {
            router.push(`/student-management/${value.studentNum}`)
        }

        const getStudents = () => {
            console.log('getStudents')
        }

        const search = () => {
            console.log('condition ::: ', condition)
        }

        return {
            condition,
            headers,
            items,

            rowClickHandler,
            getStudents,
            search,
        }
    },
}
</script>
<style lang="scss">
.students-wrapper {
    .title {
        font-weight: 700;
        margin-bottom: 12px;
    }

    .v-data-table__wrapper {
        tbody tr {
            cursor: pointer;
        }
    }
}
</style>
