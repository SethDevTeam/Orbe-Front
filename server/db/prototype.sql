CREATE TABLE IF NOT EXISTS "categories" (
	"id" INTEGER,
	"name" TEXT NOT NULL UNIQUE,
	"description" TEXT,
	PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "tags" (
	"id" INTEGER,
	"name" TEXT NOT NULL UNIQUE,
	PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "branches" (
	"id" INTEGER,
	"name" TEXT NOT NULL,
	"location" TEXT,
	PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "warehouses" (
	"id" INTEGER,
	"name" TEXT NOT NULL,
	"location" TEXT,
	"branch_id" INTEGER NOT NULL,
	PRIMARY KEY("id"),
	FOREIGN KEY ("branch_id") REFERENCES "branches"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "products" (
	"id" INTEGER,
	"name" TEXT NOT NULL,
	"sku" TEXT NOT NULL UNIQUE,
	"description" TEXT,
	"category_id" INTEGER,
	"quantity" INTEGER DEFAULT 0,
	"price" REAL DEFAULT 0,
	"created_at" TEXT DEFAULT CURRENT_TIMESTAMP,
	"updated_at" TEXT DEFAULT CURRENT_TIMESTAMP,
	"image_url" TEXT,
	PRIMARY KEY("id"),
	FOREIGN KEY ("category_id") REFERENCES "categories"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "product_tags" (
	"product_id" INTEGER NOT NULL,
	"tag_id" INTEGER NOT NULL,
	PRIMARY KEY("product_id", "tag_id"),
	FOREIGN KEY ("product_id") REFERENCES "products"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("tag_id") REFERENCES "tags"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "product_warehouses" (
	"product_id" INTEGER NOT NULL,
	"warehouse_id" INTEGER NOT NULL,
	"stock" INTEGER DEFAULT 0,
	PRIMARY KEY("product_id", "warehouse_id"),
	FOREIGN KEY ("product_id") REFERENCES "products"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("warehouse_id") REFERENCES "warehouses"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "services" (
	"id" INTEGER,
	"name" TEXT NOT NULL,
	"description" TEXT,
	"price" REAL NOT NULL,
	"duration_minutes" INTEGER NOT NULL,
	"category_id" INTEGER,
	PRIMARY KEY("id"),
	FOREIGN KEY ("category_id") REFERENCES "categories"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "service_tags" (
	"service_id" INTEGER NOT NULL,
	"tag_id" INTEGER NOT NULL,
	PRIMARY KEY("service_id", "tag_id"),
	FOREIGN KEY ("service_id") REFERENCES "services"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("tag_id") REFERENCES "tags"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "service_branches" (
	"service_id" INTEGER NOT NULL,
	"branch_id" INTEGER NOT NULL,
	PRIMARY KEY("service_id", "branch_id"),
	FOREIGN KEY ("service_id") REFERENCES "services"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("branch_id") REFERENCES "branches"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

-- =========================
-- CLIENTES
-- =========================
CREATE TABLE customers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    phone1 TEXT,
    phone2 TEXT,
    email TEXT UNIQUE,
    address TEXT,
    authorize_communication INTEGER DEFAULT 0,  -- 0 = No, 1 = Sí
    deleted INTEGER DEFAULT 0,                  -- 0 = Activo, 1 = Eliminado
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO customers (first_name, last_name, phone1, phone2, email, address, authorize_communication, deleted) VALUES
('Andrés', 'Leguizamón', '+573001234567', '+573002345678', 'andres.leguizamon@example.com', 'Calle 123 #45-67, Bogotá, Colombia', 1, 0),
('María', 'Gómez', '+573003456789', NULL, 'maria.gomez@example.com', 'Carrera 89 #12-34, Medellín, Colombia', 1, 0),
('Juan', 'Pérez', '+573004567890', '+573005678901', 'juan.perez@example.com', 'Av. Principal 100, Cali, Colombia', 0, 1),
('Laura', 'Martínez', '+573006789012', NULL, 'laura.martinez@example.com', 'Calle 50 #10-20, Barranquilla, Colombia', 1, 0),
('Carlos', 'Ramírez', '+573007890123', '+573008901234', 'carlos.ramirez@example.com', 'Cra. 7 #30-40, Bucaramanga, Colombia', 1, 0);

-- DATA --

-- =========================
-- SEDES
-- =========================
INSERT INTO branches (name, location) VALUES 
('Sede Central', 'Ciudad Principal'),
('Sede Norte', 'Ciudad Norte');

-- =========================
-- BODEGAS
-- =========================
-- Sede Central: 1 bodega
INSERT INTO warehouses (name, location, branch_id) VALUES
('Almacén Central', 'Ciudad Principal', 1);

-- Sede Norte: 2 bodegas
INSERT INTO warehouses (name, location, branch_id) VALUES
('Almacén Norte 1', 'Ciudad Norte', 2),
('Almacén Norte 2', 'Ciudad Norte', 2);

-- =========================
-- CATEGORÍAS
-- =========================
INSERT INTO categories (name, description) VALUES
('Procesador', 'CPU para computadoras de escritorio y servidores'),
('RAM', 'Memoria de acceso aleatorio para PCs'),
('SSD', 'Unidades de estado sólido para almacenamiento rápido'),
('HDD', 'Discos duros tradicionales para almacenamiento masivo'),
('GPU', 'Tarjetas gráficas para renderizado y juegos');

-- =========================
-- TAGS
-- =========================
INSERT INTO tags (name) VALUES
('Intel'),
('AMD'),
('RGB'),
('Alta velocidad'),
('Económico');

-- =========================
-- PRODUCTOS
-- =========================
-- Procesadores
INSERT INTO products (name, sku, category_id, quantity, price, image_url) VALUES
('Intel Core i9-13900K','CPU-INTEL-001',1,20,699.99,'https://m.media-amazon.com/images/I/71bM7N7W3ML._AC_SL1500_.jpg'),
('Intel Core i7-13700K','CPU-INTEL-002',1,15,399.99,'https://m.media-amazon.com/images/I/61ct2gOb4XL._AC_SL1500_.jpg'),
('AMD Ryzen 9 7950X','CPU-AMD-001',1,10,699.99,'https://m.media-amazon.com/images/I/71UBXKXkhZL._AC_SL1500_.jpg'),
('AMD Ryzen 7 7700X','CPU-AMD-002',1,25,329.99,'https://m.media-amazon.com/images/I/71ueOLRZr3L._AC_SL1500_.jpg'),
('Intel Core i5-13600K','CPU-INTEL-003',1,30,289.99,'https://m.media-amazon.com/images/I/61hVnvnX+BL._AC_SL1500_.jpg');

-- RAM
INSERT INTO products (name, sku, category_id, quantity, price, image_url) VALUES
('Corsair Vengeance 16GB DDR5','RAM-COR-001',2,50,89.99,'https://m.media-amazon.com/images/I/81f2uPPrQ9L._AC_SL1500_.jpg'),
('G.Skill Trident Z 32GB DDR4 RGB','RAM-GSK-001',2,40,159.99,'https://m.media-amazon.com/images/I/81oGgIBkRFL._AC_SL1500_.jpg'),
('Kingston Fury Beast 16GB DDR5','RAM-KIN-001',2,35,79.99,'https://m.media-amazon.com/images/I/71pKK8VgQkL._AC_SL1500_.jpg'),
('Crucial Ballistix 32GB DDR4','RAM-CRU-001',2,20,149.99,'https://m.media-amazon.com/images/I/81e1yhK0VbL._AC_SL1500_.jpg'),
('Patriot Viper Steel 16GB DDR5','RAM-PAT-001',2,30,84.99,'https://m.media-amazon.com/images/I/81ydk1kqg0L._AC_SL1500_.jpg');

-- SSD
INSERT INTO products (name, sku, category_id, quantity, price, image_url) VALUES
('Samsung 980 PRO 1TB','SSD-SAM-001',3,25,149.99,'https://m.media-amazon.com/images/I/71gBKl58J6L._AC_SL1500_.jpg'),
('Western Digital Black SN850 1TB','SSD-WD-001',3,20,139.99,'https://m.media-amazon.com/images/I/71bZBpmRvwL._AC_SL1500_.jpg'),
('Crucial P5 Plus 1TB','SSD-CRU-002',3,30,129.99,'https://m.media-amazon.com/images/I/71NQxJZrCML._AC_SL1500_.jpg'),
('Kingston KC3000 1TB','SSD-KIN-002',3,15,159.99,'https://m.media-amazon.com/images/I/71hC2OHsXlL._AC_SL1500_.jpg'),
('Sabrent Rocket 1TB','SSD-SAB-001',3,10,144.99,'https://m.media-amazon.com/images/I/71gYwz2w5hL._AC_SL1500_.jpg');

-- HDD
INSERT INTO products (name, sku, category_id, quantity, price, image_url) VALUES
('Seagate Barracuda 2TB','HDD-SEA-001',4,40,59.99,'https://m.media-amazon.com/images/I/81gY6mVdTCL._AC_SL1500_.jpg'),
('Western Digital Blue 2TB','HDD-WD-002',4,35,54.99,'https://m.media-amazon.com/images/I/81sS3e0qJ2L._AC_SL1500_.jpg'),
('Toshiba P300 2TB','HDD-TOS-001',4,30,52.99,'https://m.media-amazon.com/images/I/71ZvZbk2k9L._AC_SL1500_.jpg'),
('Seagate IronWolf 4TB','HDD-SEA-002',4,15,99.99,'https://m.media-amazon.com/images/I/81O+T1l4eBL._AC_SL1500_.jpg'),
('WD Black 4TB','HDD-WD-001',4,20,109.99,'https://m.media-amazon.com/images/I/81LO1jMF2LL._AC_SL1500_.jpg');

-- GPU
INSERT INTO products (name, sku, category_id, quantity, price, image_url) VALUES
('NVIDIA RTX 4090','GPU-NVD-001',5,5,1999.99,'https://m.media-amazon.com/images/I/71j8X2RguJL._AC_SL1500_.jpg'),
('NVIDIA RTX 4080','GPU-NVD-002',5,8,1199.99,'https://m.media-amazon.com/images/I/71TRI2bV0EL._AC_SL1500_.jpg'),
('AMD Radeon RX 7900 XT','GPU-AMD-001',5,6,999.99,'https://m.media-amazon.com/images/I/71mE3qPNlNL._AC_SL1500_.jpg'),
('AMD Radeon RX 7800 XT','GPU-AMD-002',5,10,899.99,'https://m.media-amazon.com/images/I/71nJZK7PZ1L._AC_SL1500_.jpg'),
('NVIDIA RTX 4070 Ti','GPU-NVD-003',5,12,799.99,'https://m.media-amazon.com/images/I/71s1xD8rVnL._AC_SL1500_.jpg');


-- =========================
-- RELACIÓN PRODUCTO ↔ TAGS
-- =========================
-- Ejemplo: Intel Core i9-13900K → Intel, Alta velocidad
INSERT INTO product_tags (product_id, tag_id) VALUES
(1,1),(1,4),
(2,1),(2,4),
(3,2),(3,4),
(4,2),(4,4),
(5,1),(5,4),
(6,3),(6,4),
(7,3),(7,4),
(8,3),(8,5),
(9,3),(9,4),
(10,3),(10,4),
(11,1),(11,4),
(12,1),(12,4),
(13,2),(13,4),
(14,2),(14,4),
(15,1),(15,5),
(16,1),(16,4),
(17,1),(17,4),
(18,2),(18,4),
(19,2),(19,4),
(20,1),(20,4),
(21,1),(21,4),
(22,1),(22,4),
(23,2),(23,4),
(24,2),(24,4),
(25,1),(25,5);

-- =========================
-- SERVICIOS
-- =========================
-- Asumimos que comparten las mismas categorías y tags que los productos
-- Creamos 3 servicios: Básico, Pro, Ultra

INSERT INTO services (name, description, price, duration_minutes, category_id) VALUES
('Plan Mantenimiento Básico', 'Revisión y limpieza general de hardware', 50.00, 60, 1),
('Plan Mantenimiento Pro', 'Revisión avanzada con actualización de drivers y optimización', 120.00, 120, 2),
('Plan Mantenimiento Ultra', 'Mantenimiento completo, optimización y soporte extendido', 200.00, 180, 3);

-- =========================
-- RELACIÓN SERVICIO ↔ TAGS
-- =========================
-- Asignamos algunos tags a cada servicio
-- Tag IDs: 1=Intel, 2=AMD, 3=RGB, 4=Alta velocidad, 5=Económico

INSERT INTO service_tags (service_id, tag_id) VALUES
(1,5),(1,4), -- Básico: Económico y Alta velocidad
(2,4),(2,3), -- Pro: Alta velocidad y RGB
(3,1),(3,2),(3,4); -- Ultra: Intel, AMD y Alta velocidad

-- =========================
-- RELACIÓN SERVICIO ↔ SEDES
-- =========================
-- Asignamos servicios a sedes
-- Branch IDs: 1=Sede Central, 2=Sede Norte

INSERT INTO service_branches (service_id, branch_id) VALUES
(1,1),(1,2), -- Básico disponible en ambas sedes
(2,1),(2,2), -- Pro disponible en ambas sedes
(3,1);       -- Ultra solo en Sede Central

CREATE TABLE payment_methods (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE invoices (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    customers_id INTEGER NOT NULL,
    branch_id INTEGER NOT NULL,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
    status TEXT DEFAULT 'vigente', -- vigente o anulada
    net_total REAL NOT NULL DEFAULT 0,
    discount REAL DEFAULT 0,
    surcharge REAL DEFAULT 0,
    notes TEXT,  -- campo opcional para observaciones

    FOREIGN KEY (customers_id) REFERENCES customers(id),
    FOREIGN KEY (branch_id) REFERENCES branches(id)
);

CREATE TABLE invoice_products (
    invoice_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL DEFAULT 1,
    price REAL NOT NULL, -- precio unitario al momento de la factura
    PRIMARY KEY (invoice_id, product_id),
    FOREIGN KEY (invoice_id) REFERENCES invoices(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE invoice_services (
    invoice_id INTEGER NOT NULL,
    service_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL DEFAULT 1,
    price REAL NOT NULL, -- precio unitario al momento de la factura
    PRIMARY KEY (invoice_id, service_id),
    FOREIGN KEY (invoice_id) REFERENCES invoices(id),
    FOREIGN KEY (service_id) REFERENCES services(id)
);

CREATE TABLE invoice_payments (
    invoice_id INTEGER NOT NULL,
    payment_method_id INTEGER NOT NULL,
    amount REAL NOT NULL,
    PRIMARY KEY (invoice_id, payment_method_id),
    FOREIGN KEY (invoice_id) REFERENCES invoices(id),
    FOREIGN KEY (payment_method_id) REFERENCES payment_methods(id)
);
