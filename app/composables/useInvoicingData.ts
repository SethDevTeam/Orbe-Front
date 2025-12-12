// app/composables/useInvoicingData.ts

import type { InventoryItem, Client, Invoice } from '~/types/inventory'

export const useInvoicingData = () => {
        // Reactive state
        const inventory = useState<InventoryItem[]>('inventory', () => [])
        const clients = useState<Client[]>('clients', () => [])
        const invoices = useState<Invoice[]>('invoices', () => [])

        // Mutator functions for controlled state updates
        const setInventory = (items: InventoryItem[]) => {
                inventory.value = items
        }

        const setClients = (clientList: Client[]) => {
                clients.value = clientList
        }

        const setInvoices = (invoiceList: Invoice[]) => {
                invoices.value = invoiceList
        }

        // Add item to inventory
        const addInventoryItem = (item: InventoryItem) => {
                inventory.value.push(item)
        }

        const updateInventoryItem = (id: number, updates: Partial<InventoryItem>) => {
                const index = inventory.value.findIndex(item => item.id === id)
                if (index !== -1) {
                        // Create a new object with all required properties
                        const currentItem = inventory.value[index]
                        inventory.value[index] = {
                                ...currentItem,
                                ...updates
                        } as InventoryItem // Type assertion after merging ensures all required fields exist
                }
        }

        // Remove item from inventory
        const removeInventoryItem = (id: number) => {
                inventory.value = inventory.value.filter(item => item.id !== id)
        }

        // Return all state and functions
        return {
                // State - Return computed refs instead of readonly for better compatibility
                inventory: computed(() => inventory.value),
                clients: computed(() => clients.value),
                invoices: computed(() => invoices.value),

                // Mutator functions
                setInventory,
                setClients,
                setInvoices,
                addInventoryItem,
                updateInventoryItem,
                removeInventoryItem,
        }
}
