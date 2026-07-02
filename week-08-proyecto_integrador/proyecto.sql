-- ==========================================
-- SEMANA 8: PROYECTO INTEGRADOR ETAPA 0
-- DOMINIO: ALQUILER DE VEHICULOS
-- ==========================================

PRAGMA foreign_keys = ON;

-- ==========================================
-- TABLA CLIENTES
-- ==========================================
DROP TABLE IF EXISTS clientes;

CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    telefono TEXT UNIQUE,
    estado TEXT DEFAULT 'activo',
    CHECK (estado IN ('activo', 'inactivo'))
);

-- ==========================================
-- TABLA VEHICULOS
-- ==========================================
DROP TABLE IF EXISTS vehiculos;

CREATE TABLE vehiculos (
    id_vehiculo INTEGER PRIMARY KEY,
    marca TEXT NOT NULL,
    modelo TEXT NOT NULL,
    categoria TEXT NOT NULL,
    precio_dia INTEGER NOT NULL CHECK (precio_dia > 0)
);

-- ==========================================
-- TABLA ALQUILERES (TABLA PRINCIPAL)
-- ==========================================
DROP TABLE IF EXISTS alquileres;

CREATE TABLE alquileres (
    id_alquiler INTEGER PRIMARY KEY,
    id_cliente INTEGER,
    id_vehiculo INTEGER,
    dias INTEGER CHECK (dias > 0),
    total_pago INTEGER,
    fecha TEXT,
    observacion TEXT DEFAULT NULL,

    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculos(id_vehiculo)
);

-- ==========================================
-- INSERT CLIENTES (10 registros)
-- ==========================================
INSERT INTO clientes VALUES (1,'Juan Perez','3001111111','activo');
INSERT INTO clientes VALUES (2,'Maria Gomez','3002222222','activo');
INSERT INTO clientes VALUES (3,'Carlos Ruiz','3003333333','inactivo');
INSERT INTO clientes VALUES (4,'Laura Diaz','3004444444','activo');
INSERT INTO clientes VALUES (5,'Andres Lopez','3005555555','activo');
INSERT INTO clientes VALUES (6,'Sofia Martinez','3006666666','activo');
INSERT INTO clientes VALUES (7,'Pedro Sanchez','3007777777','activo');
INSERT INTO clientes VALUES (8,'Luis Torres','3008888888','activo');
INSERT INTO clientes VALUES (9,'Camila Rios','3009999999','inactivo');
INSERT INTO clientes VALUES (10,'Daniela Perez','3010000000','activo');

-- ==========================================
-- INSERT VEHICULOS (10 registros)
-- ==========================================
INSERT INTO vehiculos VALUES (1,'Toyota','Corolla','Sedan',120000);
INSERT INTO vehiculos VALUES (2,'Mazda','3','Sedan',150000);
INSERT INTO vehiculos VALUES (3,'Renault','Duster','SUV',180000);
INSERT INTO vehiculos VALUES (4,'Kia','Sportage','SUV',200000);
INSERT INTO vehiculos VALUES (5,'Chevrolet','Spark','Hatchback',90000);
INSERT INTO vehiculos VALUES (6,'Nissan','Versa','Sedan',110000);
INSERT INTO vehiculos VALUES (7,'Hyundai','Tucson','SUV',210000);
INSERT INTO vehiculos VALUES (8,'Ford','Fiesta','Hatchback',95000);
INSERT INTO vehiculos VALUES (9,'BMW','X1','Premium',350000);
INSERT INTO vehiculos VALUES (10,'Mercedes','GLA','Premium',400000);

-- ==========================================
-- INSERT ALQUILERES (30 registros)
-- ==========================================
INSERT INTO alquileres VALUES (1,1,1,3,360000,'2025-01-01',NULL);
INSERT INTO alquileres VALUES (2,2,2,2,300000,'2025-01-02','sin novedad');
INSERT INTO alquileres VALUES (3,3,3,5,900000,'2025-01-03',NULL);
INSERT INTO alquileres VALUES (4,4,4,1,200000,'2025-01-04','entregado tarde');
INSERT INTO alquileres VALUES (5,5,5,4,360000,'2025-01-05',NULL);
INSERT INTO alquileres VALUES (6,6,6,2,220000,'2025-01-06',NULL);
INSERT INTO alquileres VALUES (7,7,7,3,630000,'2025-01-07','limpio');
INSERT INTO alquileres VALUES (8,8,8,2,190000,'2025-01-08',NULL);
INSERT INTO alquileres VALUES (9,9,9,1,350000,'2025-01-09',NULL);
INSERT INTO alquileres VALUES (10,10,10,3,1200000,'2025-01-10','premium');

-- repetir patrón hasta 30 (simplificado)
INSERT INTO alquileres VALUES (11,1,2,2,300000,'2025-01-11',NULL);
INSERT INTO alquileres VALUES (12,2,3,3,540000,'2025-01-12',NULL);
INSERT INTO alquileres VALUES (13,3,4,1,200000,'2025-01-13','ok');
INSERT INTO alquileres VALUES (14,4,5,2,180000,'2025-01-14',NULL);
INSERT INTO alquileres VALUES (15,5,6,4,440000,'2025-01-15',NULL);
INSERT INTO alquileres VALUES (16,6,7,3,630000,'2025-01-16','ok');
INSERT INTO alquileres VALUES (17,7,8,2,190000,'2025-01-17',NULL);
INSERT INTO alquileres VALUES (18,8,9,1,350000,'2025-01-18',NULL);
INSERT INTO alquileres VALUES (19,9,10,3,1200000,'2025-01-19',NULL);
INSERT INTO alquileres VALUES (20,10,1,2,240000,'2025-01-20','ok');

INSERT INTO alquileres VALUES (21,1,3,3,540000,'2025-01-21',NULL);
INSERT INTO alquileres VALUES (22,2,4,2,400000,'2025-01-22',NULL);
INSERT INTO alquileres VALUES (23,3,5,1,90000,'2025-01-23',NULL);
INSERT INTO alquileres VALUES (24,4,6,3,330000,'2025-01-24','ok');
INSERT INTO alquileres VALUES (25,5,7,2,420000,'2025-01-25',NULL);
INSERT INTO alquileres VALUES (26,6,8,1,95000,'2025-01-26',NULL);
INSERT INTO alquileres VALUES (27,7,9,2,700000,'2025-01-27',NULL);
INSERT INTO alquileres VALUES (28,8,10,3,1200000,'2025-01-28',NULL);
INSERT INTO alquileres VALUES (29,9,1,2,240000,'2025-01-29','revisado');
INSERT INTO alquileres VALUES (30,10,2,1,150000,'2025-01-30',NULL);

-- ==========================================
-- CONSULTAS OBLIGATORIAS
-- ==========================================

-- 1. TOTALES
SELECT COUNT(*) AS total_alquileres,
       SUM(total_pago) AS ingresos_totales
FROM alquileres;

-- 2. POR CLIENTE
SELECT id_cliente, COUNT(*) AS total
FROM alquileres
GROUP BY id_cliente
ORDER BY total DESC;

-- 3. HAVING
SELECT id_cliente, SUM(total_pago) AS total_gastado
FROM alquileres
GROUP BY id_cliente
HAVING total_gastado > 1000000;

-- 4. NULL
SELECT *
FROM alquileres
WHERE observacion IS NULL;

-- 5. FILTRO
SELECT *
FROM alquileres
WHERE dias BETWEEN 2 AND 4;