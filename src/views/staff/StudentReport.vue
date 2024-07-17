<
<template>
    <div class="modify-student-wrapper">
        <div class="mt-10">
            <div class="title">성적 정보</div>
            <div>
                <div class="d-flex justify-end align-center">
                    <v-select
                        v-model="selectedYear"
                        :items="selectItems"
                        @change="getReport"
                        placeholder="전체"
                        outlined
                        hide-details
                        dense
                        clearable
                        class="select-year"
                    ></v-select>
                    <v-btn @click="openAddReport" small color="info" class="ml-2">성적 입력</v-btn>
                </div>
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
                            <td>기능</td>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(item, idx) in reports" :key="`report-${idx}`">
                            <template v-if="modifyRow !== idx">
                                <td>{{ item.year }}</td>
                                <td>{{ item.semester }}</td>
                                <td>{{ item.kor }}</td>
                                <td>{{ item.eng }}</td>
                                <td>{{ item.mat }}</td>
                                <td>{{ item.sci }}</td>
                                <td>{{ item.tot }}</td>
                                <td>{{ item.avg }}</td>
                                <td>{{ item.ranking }}</td>
                                <td>
                                    <v-btn @click="modifyReport(idx)" small color="error"
                                        >수정</v-btn
                                    >
                                </td>
                            </template>
                            <template v-else>
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
                                <td>
                                    <v-btn @click="updateReport(item)" small color="success"
                                        >확인</v-btn
                                    >
                                </td>
                            </template>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <Confirm
            ref="confirmRef"
            :items="confirmItems"
            @confirmClickOutside="addStudentRef.reset()"
        >
            <template v-slot:msg>
                <v-text-field
                    v-model="addReportItems.kor"
                    outlined
                    dense
                    hide-details
                    label="국어"
                />
                <v-text-field
                    v-model="addReportItems.eng"
                    outlined
                    dense
                    hide-details
                    label="영어"
                    class="mt-2"
                />
                <v-text-field
                    v-model="addReportItems.mat"
                    outlined
                    dense
                    hide-details
                    label="수학"
                    class="mt-2"
                />
                <v-text-field
                    v-model="addReportItems.sci"
                    outlined
                    dense
                    hide-details
                    label="과학"
                    class="mt-2"
                />
            </template>
        </Confirm>
    </div>
</template>
<script>
import Confirm from '@/components/dialog/Confirm.vue'
import { reactive, ref } from '@vue/composition-api'
import { mdiMenuUp, mdiMenuDown } from '@mdi/js'

export default {
    components: { Confirm },
    props: {
        items: { type: Object },
    },
    setup(props) {
        // 학생 번호 자동 배정
        const selectedYear = ref(null)
        const selectItems = ref([2024, 2023])
        const addReportItems = reactive({
            kor: null,
            eng: null,
            mat: null,
            sci: null,
        })
        const confirmItems = ref({ msg: null })
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
            {
                year: 2023,
                semester: 3,
                kor: 92,
                eng: 87,
                mat: 85,
                sci: 86,
                tot: 350,
                avg: 87.5,
                ranking: 46,
            },
            {
                year: 2023,
                semester: 2,
                kor: 91,
                eng: 86,
                mat: 84,
                sci: 85,
                tot: 346,
                avg: 86.5,
                ranking: 47,
            },
            {
                year: 2023,
                semester: 1,
                kor: 90,
                eng: 85,
                mat: 83,
                sci: 84,
                tot: 342,
                avg: 85.5,
                ranking: 48,
            },
        ])
        const sortObject = ref(null)
        const sortType = ref(null)
        const modifyRow = ref(null)
        const confirmRef = ref(null)

        const getReport = () => {
            console.log('getReport ::: ', selectedYear)
        }

        const sort = value => {
            if (sortObject.value) return

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

        const modifyReport = idx => {
            modifyRow.value = idx
        }

        const updateReport = item => {
            console.log('item :::: ', item)
            modifyRow.value = null
        }

        const resetConfirm = () => {
            addReportItems.kor = null
            addReportItems.eng = null
            addReportItems.mat = null
            addReportItems.sci = null
        }

        const openAddReport = () => {
            confirmItems.value = {
                closeFunc: () => {
                    resetConfirm()
                    confirmRef.value.isShow = false
                },
                confirmFunc: async () => {
                    console.log('addReportItems ::: ', addReportItems)
                    confirmRef.value.isShow = false
                },
            }

            confirmRef.value.isShow = true
        }

        return {
            selectedYear,
            selectItems,
            confirmItems,
            addReportItems,
            reports,
            sortObject,
            sortType,
            modifyRow,
            confirmRef,

            getReport,
            sort,
            modifyReport,
            updateReport,
            openAddReport,

            icons: {
                mdiMenuUp,
                mdiMenuDown,
            },
        }
    },
}
</script>
<style lang="scss">
.modify-student-wrapper {
    .title {
        font-weight: 700;
        margin-bottom: 12px;
    }

    .select-year {
        max-width: 200px;
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
