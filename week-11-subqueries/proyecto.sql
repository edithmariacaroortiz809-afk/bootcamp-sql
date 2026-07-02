-- ==========================================
-- SEMANA 11: SUBCONSULTAS
-- DOMINIO: ALQUILER DE VEHICULOS
-- ==========================================

-- ==========================================
-- CONSULTA 1: SUBCONSULTA ESCALAR EN WHERE
-- Alquileres mayores al promedio
-- ==========================================

SELECT 
    id_alquiler,
    id_cliente,
    total_pago
FROM alquileres
WHERE total_pago > (
    SELECT AVG(total_pago)
    FROM alquileres
);

-- ==========================================
-- CONSULTA 2: SUBCONSULTA EN SELECT
-- Comparar con promedio general
-- ==========================================

SELECT 
    id_alquiler,
    total_pago,
    (SELECT AVG(total_pago) FROM alquileres) AS promedio_general
FROM alquileres;

-- ==========================================
-- CONSULTA 3: NOT EXISTS
-- Clientes sin alquileres
-- ==========================================

SELECT 
    c.id_cliente,
    c.nombre
FROM clientes c
WHERE NOT EXISTS (
    SELECT 1
    FROM alquileres a
    WHERE a.id_cliente = c.id_cliente
);

-- ==========================================
-- CONSULTA 4: TABLA DERIVADA (FROM)
-- Promedio de alquiler por cliente
-- ==========================================

SELECT 
    t.id_cliente,
    t.promedio_cliente
FROM (
    SELECT 
        id_cliente,
        AVG(total_pago) AS promedio_cliente
    FROM alquileres
    GROUP BY id_cliente
) t
WHERE t.promedio_cliente > 300000;