// app/composables/useClientSearch.ts
import { ref } from 'vue'
import type { Client } from '~/types/inventory'

export const useClientSearch = () => {
        const clientSearchQuery = ref('')
        const clients = ref<Client[]>([])
        const allClients = ref<Client[]>([])
        const isLoadingClients = ref(false)

        const loadAllClients = async () => {
                console.log('Loading all clients...')
                isLoadingClients.value = true
                try {
                        const results = await $fetch<Client[]>('/api/searchClients', {
                                method: 'POST',
                                body: { query: '' }
                        })

                        console.log('API returned clients:', results)
                        allClients.value = results || []

                        // Show first 5 clients initially
                        clients.value = allClients.value.slice(0, 5)
                        console.log('Set clients to first 5:', clients.value)

                } catch (error) {
                        console.error('Error loading clients:', error)
                        clients.value = []
                        allClients.value = []
                } finally {
                        isLoadingClients.value = false
                }
        }

        const searchClients = async (query: string) => {
                console.log('searchClients called with:', query)

                // If empty query, show first 5 from cache
                if (!query || query.trim() === '') {
                        console.log('Empty query, showing first 5 clients')
                        clients.value = allClients.value.slice(0, 5)
                        return
                }

                isLoadingClients.value = true
                try {
                        const results = await $fetch<Client[]>('/api/searchClients', {
                                method: 'POST',
                                body: { query: query.trim() }
                        })

                        console.log('Search returned:', results?.length, 'clients')
                        // Limit to first 5 results
                        clients.value = (results || []).slice(0, 5)

                } catch (error) {
                        console.error('Error searching clients:', error)
                        clients.value = []
                } finally {
                        isLoadingClients.value = false
                }
        }

        return {
                clientSearchQuery,
                clients,
                allClients,
                isLoadingClients,
                loadAllClients,
                searchClients
        }
}
