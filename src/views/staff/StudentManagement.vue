<template>
    <v-card>
        <v-card-text>
            <StudentInfo :items="items" />
            <StudentReport :items="items" />
        </v-card-text>
    </v-card>
</template>
<script>
import router from '@/router'
import StudentReport from './StudentReport.vue'
import { ref } from '@vue/composition-api'
import StudentInfo from './StudentInfo.vue'

export default {
    components: { StudentReport, StudentInfo },
    setup() {
        const studentNum = router.currentRoute.params.studentNum
        const items = ref({
            studentNum: 1,
            name: '가나다',
            address: '서울',
            phone: '00011112222',
            email: '이메일',
        })

        return {
            items,
        }
    },
}
</script>
