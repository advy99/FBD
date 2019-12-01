

-- SUM(atributo)   SUma los valores de la columna atributo
-- MIN(atributo)   Minimo valor de la columna cantidad
-- MAX(atributo)   Maximo   "    "  "  "         "
-- AVG(atributo)   Media del "   "  "  "         "
-- STDDEV(atributo)Desviación tipica de la columna atributo
-- COUNT(atributo) Contar


SELECT SUM(cantidad), AVG(cantidad), COUNT(cantidad) FROM ventas;


--Cuenta las filas de ventas
SELECT COUNT(*) FROM ventas;


--Cuenta los valores NO NULOS de cantidad
SELECT COUNT(cantidad) FROM ventas;


--Contar valores diferentes
SELECT COUNT(DISTINCT color) FROM pieza;


-- Pedido con mayor numero de unidades
SELECT * FROM ventas WHERE cantidad=(SELECT MAX(cantidad) FROM ventas);



-- Numero de pedidos de cada proveedor  -> El GROUP BY agrupa por lo que le pasemos
SELECT codpro, COUNT(*) FROM ventas GROUP BY codpro;


-- Numero de pedidos de cada proveedor cuyo estatus sea > 2
SELECT codpro, COUNT(*) FROM ventas WHERE codpro in (SELECT codpro FROM proveedor WHERE status>2) GROUP BY codpro;


SELECT p.codpro, p.nompro, ped.n_ventas FROM proveedor p, (SELECT codpro, COUNT(*) n_ventas FROM ventas WHERE codpro in (SELECT codpro FROM proveedor WHERE status>2) GROUP BY codpro) ped WHERE p.codpro=ped.codpro;


-- Ventas totales de cada pieza
SELECT codpie, SUM(cantidad) FROM ventas GROUP BY codpie ORDER BY codpie, SUM(cantidad) DESC;

-- HAVING poner condiciones a tablas de group by
SELECT codpie, SUM(cantidad) FROM ventas GROUP BY codpie HAVING SUM(cantidad) > 2500;



-- P1 en madrid
SELECT codpie, SUM(cantidad) FROM ventas WHERE codpie in (SELECT codpie FROM pieza WHERE ciudad='Madrid') GROUP BY codpie ORDER BY codpie, SUM(cantidad) DESC;


--piezas que se hayan vendido más que la pieza P1
SELECT codpie, SUM(cantidad) FROM ventas GROUP BY codpie HAVING SUM(cantidad) > (SELECT SUM(cantidad) FROM ventas WHERE codpie='P1');


DESCRIBE ventas;
-- total de piezas por año
SELECT to_char(fecha, 'YYYY'), SUM(cantidad), COUNT(*) FROM ventas GROUP BY to_char(fecha, 'YYYY');

SELECT to_char(fecha, 'YYYY'), SUM(cantidad), COUNT(*) FROM ventas GROUP BY to_char(fecha, 'YYYY') HAVING (to_char(fecha, 'YYYY')>'2016' AND SUM(cantidad)>1100);


--total de piezas por año y proveedor
SELECT to_char(fecha, 'YYYY'), codpro, SUM(cantidad), COUNT(*) FROM ventas GROUP BY to_char(fecha, 'YYYY'), codpro ORDER BY to_char(fecha, 'YYYY'), codpro desc;



-- PREGUNTA DE EXAMEN
-- Encontrar el proveedor que más ha vendido

SELECT codpro, SUM(cantidad) FROM ventas GROUP BY codpro HAVING SUM(cantidad)>=ALL(SELECT SUM(cantidad) FROM ventas GROUP BY codpro);
SELECT codpro, SUM(cantidad) FROM ventas GROUP BY codpro HAVING SUM(cantidad)=(SELECT MAX(SUM(cantidad)) FROM ventas GROUP BY codpro);