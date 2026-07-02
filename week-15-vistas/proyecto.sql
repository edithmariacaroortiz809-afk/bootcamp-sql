-- ==========================================
-- SEMANA 15: WINDOW FUNCTIONS + VISTAS
-- DOMINIO: ALQUILER DE VEHICULOS
-- ==========================================

-- ==========================================
-- CONSULTA 1: LAG / LEAD (COMPARACION TEMPORAL)
-- ==========================================

SELECT 
    id_cliente,
    fecha,
    total_pago,

    LAG(total_pago) OVER (
        PARTITION BY id_cliente
        ORDER BY fecha
    ) AS pago_anterior,

    LEAD(total_pago) OVER (
        PARTITION BY id_cliente
        ORDER BY fecha
    ) AS pago_siguiente

FROM alquileres;

-- ==========================================
-- CONSULTA 2: FIRST_VALUE / LAST_VALUE
-- ==========================================

SELECT 
    id_cliente,
    fecha,
    total_pago,

    FIRST_VALUE(total_pago) OVER (
        PARTITION BY id_cliente
        ORDER BY fecha
    ) AS primer_pago,

    LAST_VALUE(total_pago) OVER (
        PARTITION BY id_cliente
        ORDER BY fecha
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS ultimo_pago

FROM alquileres;

-- ==========================================
-- VISTA: ANALISIS TEMPORAL
-- ==========================================

CREATE VIEW vista_analisis_alquileres AS
SELECT 
    id_cliente,
    fecha,
    total_pago,

    LAG(total_pago) OVER (
        PARTITION BY id_cliente
        ORDER BY fecha
    ) AS pago_anterior,

    (total_pago - LAG(total_pago) OVER (
        PARTITION BY id_cliente
        ORDER BY fecha
    )) AS variacion_pago

FROM alquileres;

-- ==========================================
-- CONSULTA FINAL SOBRE LA VISTA
-- ==========================================

SELECT 
    id_cliente,
    fecha,
    total_pago,
    variacion_pago
FROM vista_analisis_alquileres
WHERE variacion_pago IS NOT NULL;