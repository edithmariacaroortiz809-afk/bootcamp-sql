-- =====================================================
-- SEMANA 6 - FUNCIONES DE AGREGACIÓN
-- DOMINIO: ALQUILER DE VEHÍCULOS
-- =====================================================

-- =========================
-- CREACIÓN DE TABLAS
-- =========================

CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nombre TEXT
);

CREATE TABLE vehiculos (
    id_vehiculo INTEGER PRIMARY KEY,
    marca TEXT,
    modelo TEXT,
    categoria TEXT,
    precio_dia INTEGER
);

CREATE TABLE alquileres (
    id_alquiler INTEGER PRIMARY KEY,
    id_cliente INTEGER,
    id_vehiculo INTEGER,
    dias INTEGER,
    total_pago INTEGER,
    fecha TEXT,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculos(id_vehiculo)
);

-- =========================
-- INSERT CLIENTES
-- =========================

INSERT INTO clientes VALUES (1, 'Juan Perez');
INSERT INTO clientes VALUES (2, 'Maria Gomez');
INSERT INTO clientes VALUES (3, 'Carlos Ruiz');
INSERT INTO clientes VALUES (4, 'Laura Diaz');
INSERT INTO clientes VALUES (5, 'Andres Lopez');

-- =========================
-- INSERT VEHICULOS
-- =========================

INSERT INTO vehiculos VALUES (1, 'Toyota', 'Corolla', 'Sedan', 120000);
INSERT INTO vehiculos VALUES (2, 'Renault', 'Duster', 'SUV', 150000);
INSERT INTO vehiculos VALUES (3, 'Chevrolet', 'Spark', 'Hatchback', 90000);
INSERT INTO vehiculos VALUES (4, 'Kia', 'Sportage', 'SUV', 170000);
INSERT INTO vehiculos VALUES (5, 'Mazda', '3', 'Sedan', 140000);

-- =========================
-- INSERT ALQUILERES (30 REGISTROS)
-- =========================

INSERT INTO alquileres VALUES (1, 1, 1, 3, 360000, '2025-01-01');
INSERT INTO alquileres VALUES (2, 1, 2, 2, 300000, '2025-01-03');
INSERT INTO alquileres VALUES (3, 2, 3, 5, 450000, '2025-01-05');
INSERT INTO alquileres VALUES (4, 2, 4, 1, 170000, '2025-01-06');
INSERT INTO alquileres VALUES (5, 3, 5, 4, 560000, '2025-01-07');

INSERT INTO alquileres VALUES (6, 3, 1, 2, 240000, '2025-01-08');
INSERT INTO alquileres VALUES (7, 4, 2, 3, 450000, '2025-01-09');
INSERT INTO alquileres VALUES (8, 4, 3, 2, 180000, '2025-01-10');
INSERT INTO alquileres VALUES (9, 5, 4, 6, 1020000, '2025-01-11');
INSERT INTO alquileres VALUES (10, 5, 5, 1, 140000, '2025-01-12');

INSERT INTO alquileres VALUES (11, 1, 3, 2, 180000, '2025-01-13');
INSERT INTO alquileres VALUES (12, 2, 1, 4, 480000, '2025-01-14');
INSERT INTO alquileres VALUES (13, 3, 2, 3, 450000, '2025-01-15');
INSERT INTO alquileres VALUES (14, 4, 5, 5, 700000, '2025-01-16');
INSERT INTO alquileres VALUES (15, 5, 1, 2, 240000, '2025-01-17');

INSERT INTO alquileres VALUES (16, 1, 4, 3, 510000, '2025-01-18');
INSERT INTO alquileres VALUES (17, 2, 5, 2, 280000, '2025-01-19');
INSERT INTO alquileres VALUES (18, 3, 3, 1, 90000, '2025-01-20');
INSERT INTO alquileres VALUES (19, 4, 1, 4, 480000, '2025-01-21');
INSERT INTO alquileres VALUES (20, 5, 2, 3, 450000, '2025-01-22');

INSERT INTO alquileres VALUES (21, 1, 2, 1, 150000, '2025-01-23');
INSERT INTO alquileres VALUES (22, 2, 4, 2, 340000, '2025-01-24');
INSERT INTO alquileres VALUES (23, 3, 5, 3, 420000, '2025-01-25');
INSERT INTO alquileres VALUES (24, 4, 2, 2, 300000, '2025-01-26');
INSERT INTO alquileres VALUES (25, 5, 3, 4, 360000, '2025-01-27');

INSERT INTO alquileres VALUES (26, 1, 5, 2, 280000, '2025-01-28');
INSERT INTO alquileres VALUES (27, 2, 3, 3, 270000, '2025-01-29');
INSERT INTO alquileres VALUES (28, 3, 4, 2, 340000, '2025-01-30');
INSERT INTO alquileres VALUES (29, 4, 5, 1, 140000, '2025-01-31');
INSERT INTO alquileres VALUES (30, 5, 1, 3, 360000, '2025-02-01');

-- =========================
-- CONSULTAS OBLIGATORIAS
-- =========================

-- 1. COUNT
SELECT COUNT(*) AS total_alquileres
FROM alquileres;

-- 2. SUM
SELECT SUM(total_pago) AS ingresos_totales
FROM alquileres;

-- 3. AVG
SELECT AVG(total_pago) AS promedio_alquiler
FROM alquileres;

-- 4. GROUP BY por cliente
SELECT id_cliente, SUM(total_pago) AS total_gastado
FROM alquileres
GROUP BY id_cliente;

-- 5. GROUP BY + HAVING
SELECT id_cliente, SUM(total_pago) AS total_gastado
FROM alquileres
GROUP BY id_cliente
HAVING SUM(total_pago) > 1000000;

-- 6. BONUS: alquileres por vehículo
SELECT id_vehiculo, COUNT(*) AS veces_alquilado
FROM alquileres
GROUP BY id_vehiculo;