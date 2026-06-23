-- ============================================
-- Script de inicialización de datos - Tienda
-- Se ejecuta automáticamente al crear el contenedor MySQL
-- Solo se ejecuta si la DB está vacía (primer inicio)
-- ============================================

USE tienda;

-- Tablas de secuencias (usadas por Hibernate)
CREATE TABLE IF NOT EXISTS venta_seq (next_val BIGINT) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS despacho_seq (next_val BIGINT) ENGINE=InnoDB;

-- Tabla de ventas
CREATE TABLE IF NOT EXISTS venta (
    id_venta BIGINT NOT NULL PRIMARY KEY,
    despacho_generado BIT(1) NOT NULL,
    direccion_compra VARCHAR(255) NOT NULL,
    fecha_compra DATE NOT NULL,
    valor_compra INT NOT NULL
) ENGINE=InnoDB;

-- Tabla de despachos
CREATE TABLE IF NOT EXISTS despacho (
    id_despacho BIGINT NOT NULL PRIMARY KEY,
    despachado BIT(1) NOT NULL,
    direccion_compra VARCHAR(255),
    fecha_despacho DATE,
    id_compra BIGINT,
    intento INT NOT NULL,
    patente_camion VARCHAR(255),
    valor_compra BIGINT
) ENGINE=InnoDB;

-- Insertar datos solo si las tablas están vacías
INSERT INTO venta_seq (next_val)
SELECT 51 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM venta_seq);

INSERT INTO despacho_seq (next_val)
SELECT 51 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM despacho_seq);

INSERT INTO venta (id_venta, despacho_generado, direccion_compra, fecha_compra, valor_compra)
SELECT * FROM (
    SELECT 1,  b'0', 'Av. Providencia 1234, Santiago',     '2026-06-01', 85000 UNION ALL
    SELECT 2,  b'1', 'Calle Maipú 567, Valparaíso',        '2026-06-03', 120000 UNION ALL
    SELECT 3,  b'1', 'Los Leones 890, Las Condes',          '2026-06-05', 47500 UNION ALL
    SELECT 4,  b'0', 'Gran Avenida 321, San Miguel',        '2026-06-07', 210000 UNION ALL
    SELECT 5,  b'1', 'Av. Grecia 456, Ñuñoa',              '2026-06-10', 33900 UNION ALL
    SELECT 6,  b'0', 'Paseo Ahumada 100, Santiago Centro',  '2026-06-12', 98000 UNION ALL
    SELECT 7,  b'1', 'Calle Larga 77, Viña del Mar',       '2026-06-14', 155000 UNION ALL
    SELECT 8,  b'0', 'Pedro de Valdivia 200, Providencia',  '2026-06-16', 67000 UNION ALL
    SELECT 9,  b'1', 'Los Almendros 33, La Florida',        '2026-06-18', 44200 UNION ALL
    SELECT 10, b'0', 'Av. Kennedy 1000, Vitacura',          '2026-06-20', 310000
) AS datos
WHERE NOT EXISTS (SELECT 1 FROM venta LIMIT 1);

INSERT INTO despacho (id_despacho, despachado, direccion_compra, fecha_despacho, id_compra, intento, patente_camion, valor_compra)
SELECT * FROM (
    SELECT 1,  b'1', 'Calle Maipú 567, Valparaíso',    '2026-06-04', 2,  1, 'BCDF12', 120000 UNION ALL
    SELECT 2,  b'1', 'Los Leones 890, Las Condes',      '2026-06-06', 3,  1, 'GHIJ34', 47500 UNION ALL
    SELECT 3,  b'0', 'Av. Grecia 456, Ñuñoa',          '2026-06-11', 5,  1, 'KLMN56', 33900 UNION ALL
    SELECT 4,  b'1', 'Calle Larga 77, Viña del Mar',   '2026-06-15', 7,  1, 'OPQR78', 155000 UNION ALL
    SELECT 5,  b'1', 'Los Almendros 33, La Florida',    '2026-06-19', 9,  1, 'STUV90', 44200 UNION ALL
    SELECT 6,  b'0', 'Av. Grecia 456, Ñuñoa',          '2026-06-22', 5,  2, 'KLMN56', 33900 UNION ALL
    SELECT 7,  b'0', 'Calle Larga 77, Viña del Mar',   '2026-06-23', 7,  2, 'WXYZ11', 155000
) AS datos
WHERE NOT EXISTS (SELECT 1 FROM despacho LIMIT 1);
