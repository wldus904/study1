<template>
    <v-card>
        <div class="pa-5">
            <Notice />
        </div>
        <div class="pa-5">
            <Detail :memberId="memberId" :onlyRead="true" />
        </div>
    </v-card>
</template>
<script>
import Notice from '@/views/student/board/Notice.vue'
import Detail from '@/views/student/Detail.vue'

export default {
    components: { Notice, Detail },
    setup() {
        const memberId = localStorage.getItem('memberId')

        return {
            memberId,
        }
    },
}
</script>
