<template>
    <v-data-table
        :headers="headers"
        :items="items"
        @click:row="rowClickHandler"
        hide-default-footer
        class="simple-header-table"
        no-data-text="검색 결과가 없습니다"
    >
        <template #[`item.actions`]="{ item }">
            <v-btn
                v-for="(action, actionIndex) in item.actions"
                :key="actionIndex"
                @click.stop="action.handler(item)"
                class="action-btn"
                outlined
                color="main"
            >
                {{ action.btnName }}
            </v-btn>
        </template>
    </v-data-table>
</template>
<script>
export default {
    props: {
        headers: {
            type: Array,
        },
        items: {
            type: Array,
        },
    },
    setup(props, { emit }) {
        const rowClickHandler = item => {
            emit('rowClickHandler', item)
        }

        return {
            rowClickHandler,
        }
    },
}
</script>
<style lang="scss" scope>
.simple-header-table {
    .v-data-table-header > tr > th {
        text-align: center !important;
        background-color: #f2f6fe !important;
        border: none !important;
        height: 36px !important;

        span {
            color: #3c4148 !important;
        }
    }

    &.theme--light > div > table > tbody > tr > td {
        color: #3c4148 !important;
        font-size: 13px;
        font-weight: 500;
    }

    tbody > tr {
        cursor: pointer;

        &:hover {
            background-color: #fafafa !important;
        }
        td {
            border-bottom: thin solid #e6e8eb !important;
            padding-top: 10px !important;
            padding-bottom: 10px !important;

            &:has(.action-btn) {
                width: 150px;
            }
        }
    }

    .action-btn {
        border: 1px solid #b3b6bb;
        font-weight: bold;
        padding: 10px 8px !important;
    }
}
</style>
