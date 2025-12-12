<script setup lang="ts">
import { ref, watch, onMounted } from 'vue'
import { debounce } from 'lodash-es'
import itemCard from '~/components/items/itemCard.vue'
import { inventory, clients, invoice, addClient, addInvoice, addItem, removeItem, removeClient, removeInvoice } from '~/composables/composable'

interface Item {
  id: number
  name: string
  price: number
  stock: number
  tags: string[]
  description: string
}

const productSearchBox = ref('')
const fullInventory = ref<Item[]>([])

const loadFullInventory = async () => {
  const results = await $fetch<Item[]>('/api/searchProducts', {
    method: 'POST',
    body: { name: '' }
  })
  fullInventory.value = results
  // Cast to any to bypass type mismatch - fix the composable type definition instead
  inventory.value = results as any
}

onMounted(loadFullInventory)

const searchProducts = debounce(async (query: string) => {
  if (!query) {
    inventory.value = fullInventory.value as any
    return
  }
  const results = await $fetch<Item[]>('/api/searchProducts', {
    method: 'POST',
    body: { name: query }
  })
  inventory.value = results as any
}, 300)

watch(productSearchBox, searchProducts)
</script>

<template>
  <div class="w-full h-full flex flex-col p-2 sm:p-4 gap-2">
    <h1 class="w-full text-center text-2xl mb-2">Invoicing # AAAXXX</h1>

    <div class="flex gap-2">
      <USelectMenu class="flex-1" :items="clients" placeholder="Select client" icon="material-symbols:person"
        size="xl" />
      <UModal>
        <UButton label="Add" color="neutral" variant="subtle" trailing-icon="material-symbols:person-add" />
        <template #content>
          <div class="p-4">
            <p>Add client form goes here</p>
          </div>
        </template>
      </UModal>
    </div>

    <div class="flex gap-2">
      <UInput v-model="productSearchBox" class="flex-5" placeholder="Enter items" size="xl" />
      <UModal>
        <UButton class="flex-2 text-center flex justify-center text-wrap" label="Search" color="neutral"
          variant="subtle" trailing-icon="material-symbols:search-gear" size="xl" />
        <template #content>
          <div class="p-4">
            <p>Advanced search goes here</p>
          </div>
        </template>
      </UModal>
      <UModal>
        <UButton class="flex-1 text-center flex justify-center" label="" color="neutral" variant="subtle"
          trailing-icon="material-symbols:add-shopping-cart" size="xl" />
        <template #content>
          <div class="p-4">
            <p>Add to cart form goes here</p>
          </div>
        </template>
      </UModal>
    </div>

    <div class="flex-1 border border-neutral-700 rounded-lg overflow-y-auto">
      <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 2xl:grid-cols-5 gap-2 p-2">
        <itemCard v-for="item in inventory" :key="item.id + 'ShopCard'" :item="item" />
      </div>
    </div>

    <div class="flex gap-2">
      <UButton class="flex-1 flex justify-center" label="Cancel" color="neutral" variant="subtle" size="xl" />
      <UButton class="flex-3 flex justify-center" label="Save" color="primary" variant="subtle" size="xl" />
    </div>
  </div>
</template>
