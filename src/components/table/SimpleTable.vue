<template>
    <table class="simple-table">
        <thead v-if="headers.length > 0">
            <tr>
                <td
                    v-for="(header, idx) in headers"
                    :key="`hd-${idx}`"
                    :style="{ width: header.width }"
                >
                    {{ header.title }}
                </td>
            </tr>
        </thead>
        <tbody v-if="items.length > 0">
            <tr v-for="(item, trIdx) in items" :key="`item-tr-${trIdx}`">
                <td v-for="(header, tdIdx) in headers" :key="`item-td-${tdIdx}`">
                    <slot :name="header.key" :item="item"> {{ item[header.key] }} </slot>
                </td>
            </tr>
        </tbody>
    </table>
</template>
<script>
export default {
    props: {
        items: { type: Array, default: [] },
        headers: { type: Array, default: [] },
    },
    setup() {},
}
</script>
<style lang="scss">
.simple-table {
    border-collapse: collapse;
    border-radius: 10px;
    border-style: hidden;
    box-shadow: 0 0 0 1px #eaf0f8;
    text-align: center;

    thead {
        background-color: #f3f8fe;
    }

    tr:not(:last-child) {
        border-bottom: 1px #eaf0f8 solid;
    }

    td {
        padding: 12px;
    }
}
</style>
