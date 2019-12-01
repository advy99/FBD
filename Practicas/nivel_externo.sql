-- Vistas de usuario

--Se hace dando nombre a una consulta con CREATE VIEW

CREATE VIEW ventas_londres AS

SELECT * FROM ventas WHERE codpro IN (SELECT codpro FROM proveedor WHERE ciudad='Londres');

SELECT * FROM ventas_londres;


-- Eliminar una vista con DROP VIEW

DROP VIEW ventas_londres;

-- No podemos usar vistas con INSERT, DELETE o UPDATE
-- A excepcion de vistas MUY MUY SIMPLES

CREATE VIEW totales AS SELECT codpro, SUM(cantidad) subtotal FROM ventas GROUP BY codpro;


DESCRIBE totales;

SELECT * FROM totales t, proveedor p WHERE t.codpro=p.codpro; 



-- Lista de tablas a consultar 

-- todas tienen como prefijo DBA

-- Almacenan informacion de todas las tablas
-- DBA_TABLES
-- DBA_TAB_COLUMNS


-- Todas las vistas del sistema
-- DBA_VIEWS

-- Todos los indices
-- DBA_INDEXES


-- DBA_CLUSTERS
-- DBA_CONSTRAINTS

-- La mas importante - tabla maestra
-- DBA_OBJECTS



-- Si ponemos el prefijo USER_ vemos nuestras tablas

DESCRIBE USER_OBJECTS;

SELECT object_name, object_type, created FROM user_objects ORDER BY object_type;

DESCRIBE user_tables;

SELECT table_name FROM user_tables;


DESCRIBE user_tab_columns;

SELECT * FROM user_tab_columns WHERE table_name='VENTAS'

SELECT * FROM user_views;

-- Aparte del prfeijo DBA y USER existe el prefijo ALL - Nos muestra lo nuestro, y lo que tenemos permisos para ver

SELECT * FROM all_tab_columns WHERE (owner='OPC' OR owner='X7021623') ORDER BY table_name



-- Como dejar que alguien modifique objetos mios, es decir, dar permisos a externos

-- con la orden GRANT <lista de privilegios> ON tablas TO <a quien>

-- dar permisos a mari
GRANT select, insert ON proveedor TO X5575654;

-- para dar todos los privilegios
-- GRANT ALL PRIVILEGES ON proveedor TO X5575654


-- juan me ha dado permiso
SELECT * FROM X7946143.proveedor;


-- a todo el mundo
GRANT select, insert ON proveedor TO PUBLIC;

-- si usamos WITH GRANT OPTIONS damos permiso para que las otras personas cambien permisos


-- para quitar privilegios REVOKE <lista> 

REVOKE insert ON proveedor FROM X5575654;









-- INDICES

-- indices por defecto - de tipo arbol B+


-- crear indice

CREATE INDEX ventas_fecha_indx ON ventas(fecha);

-- descendente
CREATE INDEX ventas_fecha_indx ON ventas(fecha) DESC;


CREATE INDEX ventas_fecha_pror_indx ON ventas(codpro, fecha);

-- para crear indices invertidos, añadimos REVERSE al final




-- crear un indece de mapa de bits
-- 
-- CREATE BITMAP INDEX nombre ON tabla();




-- Tablas IOT (Index Organized Table)

-- CREATE TABLE proveedor (<attributos>) ORGANIZATION INDEX;


-- Eliminar indice -- si cambia el domio y tengo que reordenarlo, o simplemente veo que es menos eficiente
DROP INDEX <nombre indice>;



-- clusters
-- el atributo comun es la clave del cluster

-- crear el cluster
CREATE CLUSTER cl_vta_prov(codpro char(3));

-- crear las tablas 
CREATE TABLE proveedor2 (
    codPro CHAR(3) PRIMARY KEY,
    nomPro VARCHAR2(30) NOT NULL,
    status NUMBER(2)  CHECK (status BETWEEN 1 AND 10),
    ciudad VARCHAR2(15)
) CLUSTER cl_vta_prov(codPro);

CREATE TABLE ventas2 (
    codPro char(3)  REFERENCES proveedor(codPro),
    codPie  REFERENCES pieza(codPie),
    codPj  REFERENCES proyecto(codPj), 
    cantidad NUMBER(4),
    PRIMARY KEY(codPro, codPie, codPJ) 
) CLUSTER cl_vta_prov(codPro);

-- indexamos el cluster
CREATE INDEX indx_cl ON CLUSTER cl_vta_prov;

--  rellenar las tablas
INSERT INTO proveedor2 (SELECT * FROM proveedor);
COMMIT;

INSERT INTO ventas2 (SELECT codPro, codPie, codPj, cantidad FROM ventas);
COMMIT;

-- proveedor deberia ser mejor, leemos una pagina, en proveedor 2 5
SELECT * FROM proveedor;
SELECT * FROM proveedor2;



-- para eliminar un cluster, primero tenemos que eliminar las tablas del cluster, y luego el cluster
DROP TABLE proveedor2;
DROP TABLE ventas2;
DROP CLUSTER cl_vta_prov;

-- para hacerlo todo en una orden
DROP CLUSTER cl_vta_prov INCLUDING TABLES;

