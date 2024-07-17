<template>
  <div>
    <v-btn
      icon
      small
      class="app-bar-search-toggler"
      @click="openSearchBox"
    >
      <template>
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
            <rect x="14.3633" y="12.95" width="9.48512" height="2" transform="rotate(45 14.3633 12.95)" fill="black"/>
            <path d="M10 3H17L15.5 5H10V3Z" fill="black"/>
            <path fill-rule="evenodd" clip-rule="evenodd" d="M17 10C17 13.866 13.866 17 10 17C6.13401 17 3 13.866 3 10C3 6.13401 6.13401 3 10 3C11.9073 3 13.6364 3.76281 14.899 5H10C7.23858 5 5 7.23858 5 10C5 12.7614 7.23858 15 10 15C12.7614 15 15 12.7614 15 10C15 8.3644 14.2147 6.91223 13.0005 6H15.7453C16.5362 7.13383 17 8.51275 17 10Z" fill="black"/>
        </svg>
      </template>
    </v-btn>
    <v-expand-transition>
      <v-autocomplete
        v-show="shallShowFullSearchLocal"
        return-object
        ref="refAutocomplete"
        hide-no-data
        class="app-bar-autocomplete-box"
        rounded
        hide-details
        @keyup.enter="moveSearchPage"
        @keyup.esc="closeSearchBox"
        @blur="closeSearchBox"
        placeholder="상품명 또는 검색 키워드를 입력하세요."
      >
        <template #append>
            <v-icon @click="closeSearchBox">
            {{ icons.mdiClose }}
            </v-icon>
            <v-icon @click="moveSearchPage">
            {{ icons.mdiMagnify }}
            </v-icon>
        </template>
      </v-autocomplete>
    </v-expand-transition>
  </div>
</template>

<script>
import router from '@/router'
import store from '@/store'
import { mdiClose, mdiMagnify } from '@mdi/js'
import { ref, watch } from '@vue/composition-api'
import { useMagicKeys, useVModel, whenever } from '@vueuse/core'

export default {
    props: {
        shallShowFullSearch: {
            type: Boolean,
            default: false,
        },
    },
    setup(props, { emit }) {
        const shallShowFullSearchLocal = useVModel(props, 'shallShowFullSearch', emit)
        const refAutocomplete = ref(null)

        const openSearchBox = () => {
            shallShowFullSearchLocal.value = true
        }

        const closeSearchBox = () => {
            shallShowFullSearchLocal.value = false
        }

        const moveSearchPage = () => {
            const searchWord = refAutocomplete.value.internalSearch
            router.push(`/product/ticket?searchWord=${searchWord}`)
            closeSearchBox()
        }

        // 검색창 뒷배경
        watch(shallShowFullSearchLocal, value => {
            store.commit('app/TOGGLE_CONTENT_OVERLAY', value)

            if (value) {
                setTimeout(() => {
                    refAutocomplete.value.focus()
                }, 150)
            }
        })

        // Hotkey
        // eslint-disable-next-line camelcase
        const { ctrl_shift_slash } = useMagicKeys()
        whenever(ctrl_shift_slash, () => {
            openSearchBox()
        })

        return {
            shallShowFullSearchLocal,
            refAutocomplete,

            openSearchBox,
            closeSearchBox,
            moveSearchPage,

            icons: {
                mdiMagnify,
                mdiClose,
            },
        }
    },
}
</script>

<style lang="scss">
@import '~@core/preset/preset/mixins.scss';

@include theme(app-bar-autocomplete-box) using ($material) {
    div[role='combobox'] {
        background-color: map-deep-get($material, 'cards');
    }
}

.app-bar-autocomplete-box {
    position: absolute !important;
    width: 100%;
    top: 0;
    left: 0;
    height: 100%;
    border-radius: 14px !important;
    border-top-left-radius: 0 !important;
    border-top-right-radius: 0 !important;

    .v-input__control {
        height: 100%;
    }

    div[role='combobox'] {
        height: 100%;
        z-index: 10;
        padding: 0 20px !important;

        .v-input__prepend-inner,
        .v-input__append-inner {
            align-self: center;
            margin-top: -2px;
            svg {
                font-size: 24px;
                height: 24px;
                width: 24px;
            }
        }

        .v-input__prepend-inner {
            @include ltr() {
                margin-left: 4px;
            }
            @include rtl() {
                margin-right: 4px;
            }
        }
    }
}

// ————————————————————————————————————
//* ——— Horizontal Nav
// ————————————————————————————————————

.content-layout.horizontal-nav {
    .app-system-bar {
        // Assigning 7 z-index so that search result can be seen on top of navigation menu
        z-index: 7;

        .v-text-field {
            margin-top: 0;
            padding-top: 0;
        }

        // Remove 3rem padding from both side.
        // ? 3rem is applied to navbar-content-container
        .app-bar-autocomplete-box {
            max-width: calc(100% - 3rem * 2);
            @include ltr() {
                margin-left: 3rem;
            }
            @include rtl() {
                margin-right: 3rem;
            }
        }

        // ? In Full content contet have padding of 1.5rem
        &:not(.app-system-bar-boxed) {
            .app-bar-autocomplete-box {
                max-width: calc(100% - 1.5rem * 2);
                @include ltr() {
                    margin-left: 1.5rem;
                }
                @include rtl() {
                    margin-right: 1.5rem;
                }
            }
        }
    }
}
</style>
