export interface InventoryItem {
        id: number
        name: string
        price: number
        stock: number
        tags: string[]
        description: string
        picture: string
        category: string
        iStatus: string
}

export interface Client {
        id: number
        first_name: string
        last_name: string
        phone1: string
        phone2: string | null
        email: string
        address: string
}

export interface ShoppingCartItem {
        itemID: number
        cuantity: number
}

export interface InvoiceItem {
        id: number
        cuantity: number
}

export interface InvoiceClient {
        id: number
        name: string
}

export interface Invoice {
        id: number
        name: string
        items: InvoiceItem[]
        client: InvoiceClient
}

export interface Tag {
        tag: string
}
