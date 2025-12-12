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

