<script setup lang="ts">
import itemCard from '~/components/items/itemCard.vue'
import * as billingLogic from '~/composables/billingLogic'
import { inventory, clients, facturas, tags, addClient, addFactura, addItem, removeItem, removeClient, removeFactura } from '~/composables/composable'

const itemSearchBox = ref('');

</script>
<template>
    <div class="w-full h-full flex flex-col p-2 sm:p-4 gap-2">
        <h1 class="w-full text-center text-2xl mb-2">Billing # AAAXXX</h1>
        <div class=" flex gap-2">
            <USelectMenu class="flex-1" :items=clients placeholder="Select client"
                icon="material-symbols:person" size="xl" />
            <UModal>
                <UButton label="Add" color="neutral" variant="subtle" trailing-icon="material-symbols:person-add" />
                <template #content>
                    <UPlaceholder class="h-48 m-4" />
                </template>
            </UModal>
        </div>
        <div class="flex gap-2">
            <UInput v-model="itemSearchBox" class="flex-5" placeholder="Enter items" size="xl" @click="billingLogic.busquedaDinamica(itemSearchBox)" />
            <UModal>
                <UButton class="flex-2 text-center flex justify-center text-wrap" label="Search" color="neutral" variant="subtle" trailing-icon="material-symbols:search-gear" size="xl"/>
                <template #content>
                    <UPlaceholder class="h-48 m-4" />
                </template>
            </UModal>
            <UModal>
                <UButton class="flex-1 text-center flex justify-center" label="" color="neutral" variant="subtle" trailing-icon="material-symbols:add-shopping-cart" size="xl"/>
                <template #content>
                    <UPlaceholder class="h-48 m-4" />
                </template>
            </UModal>
        </div>
        <div class="flex-1 border border-neutral-700 rounded-lg overflow-y-auto">
            <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 2xl:grid-cols-5 gap-2 p-2">
                <itemCard v-for="item in inventory" :key="item.id+'ShopCard'" :item="item" />
            </div>
        </div>
        <div class="flex gap-2">
            <UButton class="flex-1 flex justify-center" label="Cancel" color="neutral" variant="subtle" size="xl" />
            <UButton class="flex-3 flex justify-center" label="Save" color="primary" variant="subtle" size="xl"/>
        </div>
    </div>
</template>