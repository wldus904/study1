<template>
    <v-card class="reports-wrapper">
        <v-row>
            <v-col cols="12" md="3" class="year-list">
                <div
                    v-for="(item, tIdx) in testInfo"
                    @click="getTest(item)"
                    :key="tIdx"
                    class="item"
                >
                    {{ `${item.year}년 ${item.step}학기` }}
                </div>
            </v-col>
            <v-col cols="12" md="9">
                <table>
                    <thead>
                        <tr>
                            <td @click="sort('year')">
                                년도
                                <template v-if="sortObject === 'year'">
                                    <v-icon v-if="sortType === 'asc'">{{ icons.mdiMenuUp }}</v-icon>
                                    <v-icon v-else>{{ icons.mdiMenuDown }}</v-icon>
                                </template>
                            </td>
                            <td @click="sort('semester')">학기</td>
                            <td @click="sort('kor')">
                                국어
                                <template v-if="sortObject === 'kor'">
                                    <v-icon v-if="sortType === 'asc'">{{ icons.mdiMenuUp }}</v-icon>
                                    <v-icon v-else>{{ icons.mdiMenuDown }}</v-icon>
                                </template>
                            </td>
                            <td @click="sort('eng')">
                                영어
                                <template v-if="sortObject === 'eng'">
                                    <v-icon v-if="sortType === 'asc'">{{ icons.mdiMenuUp }}</v-icon>
                                    <v-icon v-else>{{ icons.mdiMenuDown }}</v-icon>
                                </template>
                            </td>
                            <td @click="sort('mat')">
                                수학
                                <template v-if="sortObject === 'mat'">
                                    <v-icon v-if="sortType === 'asc'">{{ icons.mdiMenuUp }}</v-icon>
                                    <v-icon v-else>{{ icons.mdiMenuDown }}</v-icon>
                                </template>
                            </td>
                            <td @click="sort('sci')">
                                과학
                                <template v-if="sortObject === 'sci'">
                                    <v-icon v-if="sortType === 'asc'">{{ icons.mdiMenuUp }}</v-icon>
                                    <v-icon v-else>{{ icons.mdiMenuDown }}</v-icon>
                                </template>
                            </td>
                            <td @click="sort('tot')">
                                총점
                                <template v-if="sortObject === 'tot'">
                                    <v-icon v-if="sortType === 'asc'">{{ icons.mdiMenuUp }}</v-icon>
                                    <v-icon v-else>{{ icons.mdiMenuDown }}</v-icon>
                                </template>
                            </td>
                            <td @click="sort('avg')">
                                평균
                                <template v-if="sortObject === 'avg'">
                                    <v-icon v-if="sortType === 'asc'">{{ icons.mdiMenuUp }}</v-icon>
                                    <v-icon v-else>{{ icons.mdiMenuDown }}</v-icon>
                                </template>
                            </td>
                            <td @click="sort('ranking')">
                                석차
                                <template v-if="sortObject === 'ranking'">
                                    <v-icon v-if="sortType === 'asc'">{{ icons.mdiMenuUp }}</v-icon>
                                    <v-icon v-else>{{ icons.mdiMenuDown }}</v-icon>
                                </template>
                            </td>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(item, idx) in reports" :key="`report-${idx}`">
                            <template v-if="!isModify">
                                <td>{{ item.year }}</td>
                                <td>{{ item.semester }}</td>
                                <td>{{ item.kor }}</td>
                                <td>{{ item.eng }}</td>
                                <td>{{ item.mat }}</td>
                                <td>{{ item.sci }}</td>
                                <td>{{ item.tot }}</td>
                                <td>{{ item.avg }}</td>
                                <td>{{ item.ranking }}</td>
                            </template>
                            <template v-else>
                                <td>{{ item.studentNum }}</td>
                                <td>{{ item.name }}</td>
                                <td>{{ item.year }}</td>
                                <td>{{ item.semester }}</td>
                                <td>
                                    <v-text-field
                                        v-model="item.kor"
                                        outlined
                                        hide-details
                                        dense
                                    ></v-text-field>
                                </td>
                                <td>
                                    <v-text-field
                                        v-model="item.eng"
                                        outlined
                                        hide-details
                                        dense
                                    ></v-text-field>
                                </td>
                                <td>
                                    <v-text-field
                                        v-model="item.mat"
                                        outlined
                                        hide-details
                                        dense
                                    ></v-text-field>
                                </td>
                                <td>
                                    <v-text-field
                                        v-model="item.sci"
                                        outlined
                                        hide-details
                                        dense
                                    ></v-text-field>
                                </td>
                                <td>{{ item.tot }}</td>
                                <td>{{ item.avg }}</td>
                                <td>{{ item.ranking }}</td>
                            </template>
                        </tr>
                    </tbody>
                </table>
            </v-col>
        </v-row>
        <Confirm
            ref="confirmRef"
            :items="confirmItems"
            @confirmClickOutside="addStudentRef.reset()"
        >
            <template v-slot:msg> </template>
        </Confirm>
    </v-card>
</template>
<script>
import Confirm from '@/components/dialog/Confirm.vue'
import { reactive, ref } from '@vue/composition-api'
import { mdiMenuUp, mdiMenuDown } from '@mdi/js'

export default {
    components: { Confirm },
    setup(props) {
        const confirmItems = ref({ msg: null })
        const testInfo = ref([
            { year: 2024, step: 2 },
            { year: 2024, step: 1 },
            { year: 2023, step: 1 },
            { year: 2023, step: 2 },
            { year: 2023, step: 3 },
            { year: 2023, step: 4 },
        ])
        const reports = ref([
            {
                year: 2024,
                semester: 2,
                kor: 95,
                eng: 90,
                mat: 88,
                sci: 89,
                tot: 362,
                avg: 90.5,
                ranking: 43,
            },
            {
                year: 2024,
                semester: 1,
                kor: 94,
                eng: 89,
                mat: 87,
                sci: 88,
                tot: 358,
                avg: 89.5,
                ranking: 44,
            },
            {
                year: 2023,
                semester: 4,
                kor: 93,
                eng: 88,
                mat: 86,
                sci: 87,
                tot: 354,
                avg: 88.5,
                ranking: 45,
            },
        ])
        const sortObject = ref(null)
        const sortType = ref(null)
        const confirmRef = ref(null)
        const isModify = ref(false)

        const getTest = item => {
            console.log('getTest ::: ', item)
        }

        const sort = value => {
            if (isModify.value) return

            if (value !== sortObject.value) {
                sortObject.value = value
                sortType.value = 'desc'
            } else {
                if (sortType.value === 'desc') {
                    sortType.value = 'asc'
                } else {
                    sortObject.value = null
                    sortType.value = null
                }
            }
        }

        const modifyReport = () => {
            isModify.value = true
        }

        const updateReport = () => {
            console.log('updateReport')
            isModify.value = false
        }

        const openConfirm = () => {
            confirmItems.value = {
                closeFunc: () => {
                    resetConfirm()
                    confirmRef.value.isShow = false
                },
                confirmFunc: async () => {
                    confirmRef.value.isShow = false
                },
            }

            confirmRef.value.isShow = true
        }

        return {
            confirmItems,
            reports,
            sortObject,
            sortType,
            confirmRef,
            isModify,
            testInfo,

            getTest,
            sort,
            modifyReport,
            updateReport,
            openConfirm,

            icons: {
                mdiMenuUp,
                mdiMenuDown,
            },
        }
    },
}
</script>
<style lang="scss">
.reports-wrapper {
    .title {
        font-weight: 700;
        margin-bottom: 12px;
    }

    .year-list {
        height: 100%;
        overflow: auto;
        border-right: 1px solid;

        .item {
            margin: 4px 0;
            color: blue;
            cursor: pointer;
        }
    }

    table {
        width: 100%;
        margin-top: 12px;

        thead tr td {
            border-bottom: 1px solid;
            text-align: center;
        }

        tbody {
            text-align: center;

            td {
                padding: 10px;
            }
        }
    }
}
</style>
