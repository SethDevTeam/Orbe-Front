export interface InventoryItem {
        id: number;
        name: string;
        price: number;
        stock: number;
        tags: string[];
        description: string;
        picture: string;
        category: string;
        iStatus: string;
}

export interface Client {
        id: number;
        name: string;
        address: string;
        phone: string;
        email: string;
}

export interface ShoppingCartItem {
        itemID: number;
        cuantity: number;
}

// Interfaces for the Invoice object (can be internal or external, keeping them external here)
export interface InvoiceItem {
        id: number;
        cuantity: number;
}

export interface InvoiceClient {
        id: number;
        name: string;
}

export interface Invoice {
        id: number;
        name: string;
        items: InvoiceItem[];
        client: InvoiceClient;
}

export interface Tag {
        tag: string;
}
