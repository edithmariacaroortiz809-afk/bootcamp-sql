-- ==========================================
-- SEMANA 13: CTE RECURSIVO
-- DOMINIO: VEHICULOS JERARQUICOS
-- ==========================================

PRAGMA foreign_keys = ON;

-- =========================
-- TABLA JERÁRQUICA
-- =========================
DROP TABLE IF EXISTS vehiculos_tree;

CREATE TABLE vehiculos_tree (
    id INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    parent_id INTEGER,
    FOREIGN KEY (parent_id) REFERENCES vehiculos_tree(id)
);

-- =========================
-- DATOS (3 niveles mínimo)
-- =========================

INSERT INTO vehiculos_tree VALUES (1,'Toyota',NULL);
INSERT INTO vehiculos_tree VALUES (2,'Corolla',1);
INSERT INTO vehiculos_tree VALUES (3,'Corolla Sport',2);
INSERT INTO vehiculos_tree VALUES (4,'Corolla 2024',2);

INSERT INTO vehiculos_tree VALUES (5,'Mazda',NULL);
INSERT INTO vehiculos_tree VALUES (6,'Mazda 3',5);
INSERT INTO vehiculos_tree VALUES (7,'Mazda Turbo',6);

INSERT INTO vehiculos_tree VALUES (8,'Renault',NULL);
INSERT INTO vehiculos_tree VALUES (9,'Duster',8);
INSERT INTO vehiculos_tree VALUES (10,'Duster 4x4',9);

-- ==========================================
-- CONSULTA 1: ARBOL COMPLETO + PROFUNDIDAD
-- ==========================================

WITH RECURSIVE arbol AS (

    -- CASO BASE
    SELECT 
        id,
        nombre,
        parent_id,
        0 AS depth,
        nombre AS ruta
    FROM vehiculos_tree
    WHERE parent_id IS NULL

    UNION ALL

    -- CASO RECURSIVO
    SELECT 
        v.id,
        v.nombre,
        v.parent_id,
        a.depth + 1,
        a.ruta || ' -> ' || v.nombre
    FROM vehiculos_tree v
    INNER JOIN arbol a ON v.parent_id = a.id
)

SELECT 
    id,
    nombre,
    parent_id,
    depth,
    ruta
FROM arbol;

-- ==========================================
-- CONSULTA 2: SOLO NIVEL ESPECÍFICO
-- ==========================================

WITH RECURSIVE arbol AS (
    SELECT id, nombre, parent_id, 0 AS depth
    FROM vehiculos_tree
    WHERE parent_id IS NULL

    UNION ALL

    SELECT v.id, v.nombre, v.parent_id, a.depth + 1
    FROM vehiculos_tree v
    INNER JOIN arbol a ON v.parent_id = a.id
)

SELECT 
    id,
    nombre,
    depth
FROM arbol
WHERE depth = 2;

-- ==========================================
-- CONSULTA 3: HOJAS DEL ÁRBOL
-- ==========================================

SELECT 
    v.id,
    v.nombre
FROM vehiculos_tree v
WHERE NOT EXISTS (
    SELECT 1
    FROM vehiculos_tree h
    WHERE h.parent_id = v.id
);