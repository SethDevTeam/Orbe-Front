//Temporal data to be used in multiple components
var clients = ref([
    { id: 1, name: "client 1" , address: "address 1", phone: "phone 1", email: "email 1"},
    { id: 2, name: "client 2" , address: "address 2", phone: "phone 2", email: "email 2"},
    { id: 3, name: "client 3" , address: "address 3", phone: "phone 3", email: "email 3"},
    { id: 4, name: "client 4" , address: "address 4", phone: "phone 4", email: "email 4"},
    { id: 5, name: "client 5" , address: "address 5", phone: "phone 5", email: "email 5"},
    { id: 6, name: "client 6" , address: "address 6", phone: "phone 6", email: "email 6"},
    { id: 7, name: "client 7" , address: "address 7", phone: "phone 7", email: "email 7"},
    { id: 8, name: "client 8" , address: "address 8", phone: "phone 8", email: "email 8"},
])

var inventory = ref([
    { id: 1, name: "Intel core i5 9700kf", price: 100, stock: 10, tags: ["tag 1", "tag 2"], description: "description 1", picture: "https://picsum.dev/image/1275/view" , category: "category 1", iStatus: "" },
    { id: 2, name: "item 2", price: 200, stock: 20, tags: ["tag 3", "tag 4"], description: "description 2", picture: "https://picsum.dev/image/1276/view" , category: "category 1", iStatus: "BlackFriday" },
    { id: 3, name: "item 3", price: 300, stock: 30, tags: ["tag 5", "tag 6"], description: "description 3", picture: "https://picsum.dev/image/1277/view" , category: "category 2", iStatus: "" },
    { id: 4, name: "item 4", price: 400, stock: 40, tags: ["tag 7", "tag 8"], description: "description 4", picture: "" , category: "category 3", iStatus: "" },
    { id: 5, name: "item 5", price: 500, stock: 0, tags: ["tag 9", "tag 10"], description: "description 5", picture: "" , category: "category 4", iStatus: "no longer available" },
    { id: 6, name: "item 6", price: 600, stock: 60, tags: ["tag 11", "tag 12"], description: "description 6", picture: "" , category: "category 5", iStatus: "" },
    { id: 7, name: "item 7", price: 700, stock: 70, tags: ["tag 13", "tag 14"], description: "description 7", picture: "" , category: "category 6", iStatus: "" },
    { id: 8, name: "item 8", price: 800, stock: 80, tags: ["tag 15", "tag 16"], description: "description 8", picture: "" , category: "category 7", iStatus: "" },
    { id: 9, name: "item 9", price: 900, stock: 90, tags: ["tag 17", "tag 18", "tag 19", "tag 20", ], description: "description 9", picture: "" , category: "category 8", iStatus: "" },
    { id: 10, name: "item 10", price: 10000000, stock: 100, tags: ["tag 19", "tag 20"], description: "description 10", picture: "" , category: "category 9", iStatus: "" },
  ]);

var shoppingCart = ref([
    { itemID: 1, cuantity: 2 },
    { itemID: 3, cuantity: 3 },
    { itemID: 5, cuantity: 4 },
    { itemID: 7, cuantity: 5 },
    { itemID: 9, cuantity: 6 },
])

var facturas = ref([
    { id: 1, name: "factura 1", items: [{id: 1, cuantity: 2}, {id: 2, cuantity: 3}], client: {id: 1, name: "client 1" }},
    { id: 2, name: "factura 2", items: [{id: 3, cuantity: 4}, {id: 4, cuantity: 5}], client: {id: 2, name: "client 2" }},
    { id: 3, name: "factura 3", items: [{id: 5, cuantity: 6}, {id: 6, cuantity: 7}], client: {id: 3, name: "client 3" }},
    { id: 4, name: "factura 4", items: [{id: 7, cuantity: 8}, {id: 8, cuantity: 9}], client: {id: 4, name: "client 4" }},
    { id: 5, name: "factura 5", items: [{id: 9, cuantity: 10}, {id: 10, cuantity: 11}], client: {id: 5, name: "client 5" }},
])

var tags = ref([
    { tag: "tag 1" },
    { tag: "tag 2" },
    { tag: "tag 3" },
    { tag: "tag 4" },
    { tag: "tag 5" },
    { tag: "tag 6" },
    { tag: "tag 7" },
    { tag: "tag 8" },
    { tag: "tag 9" },
    { tag: "tag 10" },
])

function addClient(client: any) {
    clients.value.push(client)
}

function addFactura(factura: any) {
    facturas.value.push(factura)
}

function addItem(item: any) {
    inventory.value.push(item)
}

function removeItem(id: number) {
    inventory.value = inventory.value.filter(item => item.id !== id)
}

function removeClient(id: number) {
    clients.value = clients.value.filter(client => client.id !== id)
}

function removeFactura(id: number) {
    facturas.value = facturas.value.filter(factura => factura.id !== id)
}

export { inventory, clients, facturas, tags, addClient, addFactura, addItem, removeItem, removeClient, removeFactura }