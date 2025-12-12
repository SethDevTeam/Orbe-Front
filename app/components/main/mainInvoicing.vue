<script setup lang="ts">
import { ref, watch, onMounted, onUnmounted, computed } from 'vue'
import { debounce } from 'lodash-es'
import itemCard from '~/components/items/itemCard.vue'
import type { InventoryItem } from '~/types/inventory'

// Invoicing data composable
const { inventory, setInventory } = useInvoicingData()

// Client search
const {
        clients,
        isLoadingClients,
        loadAllClients,
        searchClients,
} = useClientSearch()

// Local state for product search
const productSearchBox = ref('')
const fullInventory = ref<InventoryItem[]>([])
const isLoadingProducts = ref(false)

// Client search state
const clientSearchInput = ref('')
const selectedClient = ref<any>(null)
const isClientDropdownOpen = ref(false)
const clientDropdownRef = ref(null)

// Close dropdown when clicking outside
const handleClickOutside = (event: MouseEvent) => {
        if (clientDropdownRef.value && !(clientDropdownRef.value as HTMLElement).contains(event.target as Node)) {
                isClientDropdownOpen.value = false
        }
}

onMounted(() => {
        document.addEventListener('click', handleClickOutside)
})

onUnmounted(() => {
        document.removeEventListener('click', handleClickOutside)
})

// Filter clients based on search
const filteredClients = computed(() => {
        return clients.value.slice(0, 5)
})

// Display text for selected client
const clientDisplayText = computed(() => {
        if (selectedClient.value) {
                return `${selectedClient.value.first_name} ${selectedClient.value.last_name}`
        }
        return ''
})

// Select a client
const selectClient = (client: any) => {
        selectedClient.value = client
        clientSearchInput.value = `${client.first_name} ${client.last_name}`
        isClientDropdownOpen.value = false
}

// Debounced search
const debouncedClientSearch = debounce(async (query: string) => {
        await searchClients(query)
        isClientDropdownOpen.value = true
}, 300)

// Handle input changes
const handleClientInput = (event: Event) => {
        const value = (event.target as HTMLInputElement).value
        clientSearchInput.value = value

        if (value.trim() === '') {
                selectedClient.value = null
                isClientDropdownOpen.value = false
                return
        }

        debouncedClientSearch(value)
}

// Handle input focus
const handleClientFocus = () => {
        isClientDropdownOpen.value = true
        if (clientSearchInput.value === '' || clientSearchInput.value === clientDisplayText.value) {
                searchClients('')
        }
}

// Load full inventory
const loadFullInventory = async () => {
        isLoadingProducts.value = true
        try {
                const results = await $fetch<InventoryItem[]>('/api/searchProducts', {
                        method: 'POST',
                        body: { name: '' }
                })
                fullInventory.value = results
                setInventory(results)
        } catch (error) {
                console.error('Error loading inventory:', error)
                setInventory([])
        } finally {
                isLoadingProducts.value = false
        }
}

// Search products with debounce
const searchProducts = debounce(async (query: string) => {
        isLoadingProducts.value = true
        try {
                if (!query) {
                        setInventory(fullInventory.value)
                        return
                }

                const results = await $fetch<InventoryItem[]>('/api/searchProducts', {
                        method: 'POST',
                        body: { name: query }
                })
                setInventory(results)
        } catch (error) {
                console.error('Error searching products:', error)
        } finally {
                isLoadingProducts.value = false
        }
}, 300)

// Initialize on mount
onMounted(async () => {
        await loadAllClients()
        loadFullInventory()
})

// Watch for product search
watch(productSearchBox, searchProducts)
</script>

<template>
        <div class="w-full h-full flex flex-col p-2 sm:p-4 gap-2">
                <h1 class="w-full text-center text-2xl mb-2">Invoicing # AAAXXX</h1>

                <!-- Client Selection - Custom Dropdown -->
                <div class="flex gap-2">
                        <div ref="clientDropdownRef" class="flex-1 relative">
                                <div class="relative w-full">
                                        <UInput v-model="clientSearchInput" placeholder="Select or search client"
                                                size="xl" icon="material-symbols:person" :loading="isLoadingClients"
                                                class="w-full" @input="handleClientInput" @focus="handleClientFocus"
                                                autocomplete="off" />

                                        <!-- Dropdown List -->
                                        <div v-if="isClientDropdownOpen && filteredClients.length > 0"
                                                class="absolute z-50 w-full mt-1 bg-gray-800 border border-gray-700 rounded-lg shadow-lg max-h-60 overflow-y-auto">
                                                <div v-for="client in filteredClients" :key="client.id"
                                                        class="px-4 py-3 hover:bg-gray-700 cursor-pointer border-b border-gray-700 last:border-b-0"
                                                        @click="selectClient(client)">
                                                        <div class="font-medium text-white">
                                                                {{ client.first_name }} {{ client.last_name }}
                                                        </div>
                                                        <div class="text-sm text-gray-400">
                                                                {{ client.email }}
                                                        </div>
                                                </div>
                                        </div>

                                        <!-- No Results -->
                                        <div v-if="isClientDropdownOpen && filteredClients.length === 0 && !isLoadingClients"
                                                class="absolute z-50 w-full mt-1 bg-gray-800 border border-gray-700 rounded-lg shadow-lg p-4">
                                                <div class="text-gray-400 text-center">No clients found</div>
                                        </div>
                                </div>
                        </div>

                        <UModal>
                                <UButton label="Add" color="neutral" variant="subtle"
                                        trailing-icon="material-symbols:person-add" />
                                <template #content>
                                        <div class="p-4">
                                                <p>Add client form goes here</p>
                                        </div>
                                </template>
                        </UModal>
                </div>

                <!-- Product Search -->
                <div class="flex gap-2">
                        <UInput v-model="productSearchBox" class="flex-5" placeholder="Enter items" size="xl"
                                :loading="isLoadingProducts" />
                        <UModal>
                                <UButton class="flex-2 text-center flex justify-center text-wrap" label="Search"
                                        color="neutral" variant="subtle" trailing-icon="material-symbols:search-gear"
                                        size="xl" />
                                <template #content>
                                        <div class="p-4">
                                                <p>Advanced search goes here</p>
                                        </div>
                                </template>
                        </UModal>
                        <UModal>
                                <UButton class="flex-1 text-center flex justify-center" label="" color="neutral"
                                        variant="subtle" trailing-icon="material-symbols:add-shopping-cart" size="xl" />
                                <template #content>
                                        <div class="p-4">
                                                <p>Add to cart form goes here</p>
                                        </div>
                                </template>
                        </UModal>
                </div>

                <!-- Product Grid -->
                <div class="flex-1 border border-neutral-700 rounded-lg overflow-y-auto">
                        <div v-if="isLoadingProducts" class="flex items-center justify-center h-full">
                                <div class="text-gray-500">Loading products...</div>
                        </div>
                        <div v-else-if="inventory.length === 0" class="flex items-center justify-center h-full">
                                <div class="text-gray-500">No products found</div>
                        </div>
                        <div v-else class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 2xl:grid-cols-5 gap-2 p-2">
                                <itemCard v-for="item in inventory" :key="item.id + 'ShopCard'" :item="item" />
                        </div>
                </div>

                <!-- Action Buttons -->
                <div class="flex gap-2">
                        <UButton class="flex-1 flex justify-center" label="Cancel" color="neutral" variant="subtle"
                                size="xl" />
                        <UButton class="flex-3 flex justify-center" label="Save" color="primary" variant="subtle"
                                size="xl" />
                </div>
        </div>
</template>
