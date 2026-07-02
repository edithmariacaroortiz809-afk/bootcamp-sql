-- ==========================================
-- SEMANA 10: SELF JOIN
-- DOMINIO: ALQUILER DE VEHICULOS
-- ==========================================

-- ==========================================
-- RELACION JERARQUICA (ID PADRE)
-- ==========================================

-- PADRES (MODELOS BASE)
INSERT INTO vehiculos VALUES (100,'Toyota','Corolla','Sedan',120000,NULL);
INSERT INTO vehiculos VALUES (200,'Mazda','3','Sedan',150000,NULL);
INSERT INTO vehiculos VALUES (300,'Renault','Duster','SUV',180000,NULL);

-- HIJOS
INSERT INTO vehiculos VALUES (101,'Toyota','Corolla Sport','Sedan',130000,100);
INSERT INTO vehiculos VALUES (102,'Toyota','Corolla 2024','Sedan',140000,100);

INSERT INTO vehiculos VALUES (201,'Mazda','3 Turbo','Sedan',170000,200);
INSERT INTO vehiculos VALUES (202,'Mazda','3 Touring','Sedan',160000,200);

INSERT INTO vehiculos VALUES (301,'Renault','Duster 4x4','SUV',200000,300);
INSERT INTO vehiculos VALUES (302,'Renault','Duster Sport','SUV',190000,300);

-- ==========================================
-- CONSULTA 1: SELF JOIN (HIJO Y PADRE)
-- ==========================================
SELECT 
    h.id_vehiculo,
    h.modelo AS modelo_hijo,
    p.modelo AS modelo_padre
FROM vehiculos h
INNER JOIN vehiculos p
ON h.id_padre = p.id_vehiculo;

-- ==========================================
-- CONSULTA 2: LEFT JOIN + COALESCE
-- ==========================================
SELECT 
    v.id_vehiculo,
    v.modelo,
    COALESCE(p.modelo,'SIN PADRE') AS modelo_padre
FROM vehiculos v
LEFT JOIN vehiculos p
ON v.id_padre = p.id_vehiculo;

-- ==========================================
-- CONSULTA 3: CONTAR HIJOS POR PADRE
-- ==========================================
SELECT 
    p.modelo AS padre,
    COUNT(h.id_vehiculo) AS total_hijos
FROM vehiculos p
LEFT JOIN vehiculos h
ON h.id_padre = p.id_vehiculo
GROUP BY p.modelo
HAVING COUNT(h.id_vehiculo) > 0;

-- ==========================================
-- CONSULTA 4: 2 NIVELES (HIJO - PADRE - ABUELO)
-- ==========================================
SELECT 
    h.modelo AS hijo,
    p.modelo AS padre,
    a.modelo AS abuelo
FROM vehiculos h
LEFT JOIN vehiculos p ON h.id_padre = p.id_vehiculo
LEFT JOIN vehiculos a ON p.id_padre = a.id_vehiculo;