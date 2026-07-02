-- ==========================================
-- SEMANA 12: CTE + CASE WHEN
-- DOMINIO: ALQUILER DE VEHICULOS
-- ==========================================

-- ==========================================
-- CONSULTA 1: CTE SIMPLE + CASE WHEN
-- Clasificación de alquileres
-- ==========================================

WITH base_alquileres AS (
    SELECT 
        id_alquiler,
        total_pago
    FROM alquileres
)

SELECT 
    id_alquiler,
    total_pago,
    CASE 
        WHEN total_pago < 300000 THEN 'BAJO'
        WHEN total_pago BETWEEN 300000 AND 700000 THEN 'MEDIO'
        ELSE 'ALTO'
    END AS categoria_pago
FROM base_alquileres;

-- ==========================================
-- CONSULTA 2: DOBLE CTE ENCADENADO
-- Promedio por cliente → filtro
-- ==========================================

WITH promedio_cliente AS (
    SELECT 
        id_cliente,
        AVG(total_pago) AS promedio
    FROM alquileres
    GROUP BY id_cliente
),
clientes_filtrados AS (
    SELECT *
    FROM promedio_cliente
    WHERE promedio > 400000
)

SELECT 
    id_cliente,
    promedio
FROM clientes_filtrados;

-- ==========================================
-- CONSULTA 3: CTE + CASE WHEN + COUNT
-- Clasificación por nivel de gasto
-- ==========================================

WITH clasificacion AS (
    SELECT 
        id_cliente,
        total_pago,
        CASE 
            WHEN total_pago < 300000 THEN 'BAJO'
            WHEN total_pago BETWEEN 300000 AND 700000 THEN 'MEDIO'
            ELSE 'ALTO'
        END AS nivel
    FROM alquileres
)

SELECT 
    nivel,
    COUNT(*) AS total
FROM clasificacion
GROUP BY nivel;