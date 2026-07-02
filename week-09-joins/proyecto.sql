-- ==========================================
-- SEMANA 09: JOINS
-- DOMINIO: ALQUILER DE VEHICULOS
-- ==========================================

-- =========================
-- CONSULTA 1: INNER JOIN
-- =========================
-- Muestra solo alquileres con cliente y vehículo

SELECT 
    a.id_alquiler,
    c.nombre AS cliente,
    v.marca,
    v.modelo,
    a.dias,
    a.total_pago
FROM alquileres a
INNER JOIN clientes c ON a.id_cliente = c.id_cliente
INNER JOIN vehiculos v ON a.id_vehiculo = v.id_vehiculo;

-- =========================
-- CONSULTA 2: JOIN 3 TABLAS
-- =========================
-- Informe enriquecido de alquileres

SELECT 
    a.id_alquiler,
    c.nombre,
    c.estado,
    v.marca,
    v.categoria,
    a.dias,
    a.total_pago,
    a.fecha
FROM alquileres a
INNER JOIN clientes c ON a.id_cliente = c.id_cliente
INNER JOIN vehiculos v ON a.id_vehiculo = v.id_vehiculo;

-- =========================
-- CONSULTA 3: LEFT JOIN (todos los clientes)
-- =========================

SELECT 
    c.id_cliente,
    c.nombre,
    a.id_alquiler,
    a.total_pago
FROM clientes c
LEFT JOIN alquileres a ON c.id_cliente = a.id_cliente;

-- =========================
-- CONSULTA 4: HUÉRFANOS (clientes sin alquiler)
-- =========================

SELECT 
    c.id_cliente,
    c.nombre
FROM clientes c
LEFT JOIN alquileres a ON c.id_cliente = a.id_cliente
WHERE a.id_alquiler IS NULL;

-- =========================
-- CONSULTA 5: AGREGADO CON JOIN
-- =========================

SELECT 
    c.nombre,
    COUNT(a.id_alquiler) AS total_alquileres
FROM clientes c
LEFT JOIN alquileres a ON c.id_cliente = a.id_cliente
GROUP BY c.nombre
ORDER BY total_alquileres DESC;
