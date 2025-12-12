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

        // Update item in inventory
        const updateInventoryItem = (id: number, updates: Partial<Omit<InventoryItem, 'id'>>) => {
                const index = inventory.value.findIndex(item => item.id === id)
                if (index !== -1) {
                        inventory.value[index] = {
                                ...inventory.value[index],
                                ...updates
                        } as InventoryItem
                }
        }

        // Remove item from inventory
        const removeInventoryItem = (id: number) => {
                inventory.value = inventory.value.filter(item => item.id !== id)
        }

        // Add client
        const addClient = (client: Client) => {
                clients.value.push(client)
        }

        // Update client
        const updateClient = (id: number, updates: Partial<Omit<Client, 'id'>>) => {
                const index = clients.value.findIndex(client => client.id === id)
                if (index !== -1) {
                        clients.value[index] = {
                                ...clients.value[index],
                                ...updates
                        } as Client
                }
        }

        // Remove client
        const removeClient = (id: number) => {
                clients.value = clients.value.filter(client => client.id !== id)
        }

        // Return all state and functions
        return {
                // Mutable state
                inventory,
                clients,
                invoices,

                // Mutator functions
                setInventory,
                setClients,
                setInvoices,
                addInventoryItem,
                updateInventoryItem,
                removeInventoryItem,
                addClient,
                updateClient,
                removeClient,
        }
}
