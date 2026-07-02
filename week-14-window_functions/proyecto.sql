-- ==========================================
-- SEMANA 14: WINDOW FUNCTIONS
-- DOMINIO: ALQUILER DE VEHICULOS
-- ==========================================

-- ==========================================
-- CONSULTA 1: ROW_NUMBER (ranking único)
-- ==========================================

SELECT 
    id_cliente,
    id_alquiler,
    total_pago,
    ROW_NUMBER() OVER (
        PARTITION BY id_cliente
        ORDER BY total_pago DESC
    ) AS ranking_cliente
FROM alquileres;

-- ==========================================
-- CONSULTA 2: RANK vs DENSE_RANK
-- ==========================================

SELECT 
    id_cliente,
    total_pago,

    RANK() OVER (
        ORDER BY total_pago DESC
    ) AS rank_global,

    DENSE_RANK() OVER (
        ORDER BY total_pago DESC
    ) AS dense_rank_global
FROM alquileres;

-- ==========================================
-- CONSULTA 3: TOP 3 POR CLIENTE (CTE + WINDOW)
-- ==========================================

WITH ranking AS (
    SELECT 
        id_cliente,
        id_alquiler,
        total_pago,
        ROW_NUMBER() OVER (
            PARTITION BY id_cliente
            ORDER BY total_pago DESC
        ) AS rn
    FROM alquileres
)

SELECT 
    id_cliente,
    id_alquiler,
    total_pago
FROM ranking
WHERE rn <= 3;

-- ==========================================
-- CONSULTA 4: RANKING DE CLIENTES POR GASTO TOTAL
-- ==========================================

WITH total_clientes AS (
    SELECT 
        id_cliente,
        SUM(total_pago) AS total_gastado
    FROM alquileres
    GROUP BY id_cliente
)

SELECT 
    id_cliente,
    total_gastado,
    RANK() OVER (
        ORDER BY total_gastado DESC
    ) AS ranking_global
FROM total_clientes;