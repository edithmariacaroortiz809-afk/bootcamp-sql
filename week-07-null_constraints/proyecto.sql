-- =========================
-- SEMANA 7: NULL Y CONSTRAINTS
-- DOMINIO: ALQUILER DE VEHICULOS
-- =========================

DROP TABLE IF EXISTS alquileres;

CREATE TABLE alquileres (
    id_alquiler INTEGER PRIMARY KEY,
    cliente TEXT NOT NULL,
    vehiculo TEXT NOT NULL,
    dias INTEGER NOT NULL,
    total_pago INTEGER NOT NULL,
    fecha TEXT
);

-- =========================
-- INSERTS (con algunos NULL controlados donde se permite)
-- =========================

INSERT INTO alquileres VALUES (1, 'Juan Perez', 'Toyota Corolla', 3, 360000, '2025-01-01');
INSERT INTO alquileres VALUES (2, 'Maria Gomez', 'Renault Duster', 2, 300000, '2025-01-02');
INSERT INTO alquileres VALUES (3, 'Carlos Ruiz', 'Mazda 3', 4, 560000, '2025-01-03');
INSERT INTO alquileres VALUES (4, 'Laura Diaz', 'Kia Sportage', 1, 170000, NULL);
INSERT INTO alquileres VALUES (5, 'Andres Lopez', 'Chevrolet Spark', 5, 450000, '2025-01-05');

-- =========================
-- CONSULTAS PARA DEMOSTRAR NULL
-- =========================

-- Registros con fecha NULL
SELECT *
FROM alquileres
WHERE fecha IS NULL;

-- Registros completos (sin NULL en fecha)
SELECT *
FROM alquileres
WHERE fecha IS NOT NULL;

-- Conteo total
SELECT COUNT(*) AS total_alquileres
FROM alquileres;