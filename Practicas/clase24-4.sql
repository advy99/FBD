-- Operador UNION - une dos tablas

-- Operador INTERSECT - interseccion de tablas

-- Operador MINUS - diferencia de dos tablas

-- Se comportan como las operaciones del algebra


-- Proveedores que no han vendido nada
SELECT codpro FROM proveedor MINUS SELECT codpro FROM ventas




--Proveedores que NO han vendido la pieza P2

SELECT codpro FROM proveedor MINUS SELECT codpro FROM ventas WHERE codpie='P3';




-- Proveedores que venden P2 y P3

SELECT codpro FROM ventas WHERE codpie='P3'

INTERSECT

SELECT codpro FROM ventas WHERE codpie='P2';



-- Operador IN -> podemos usar una select, para la lista de valores

-- Lista de proveedores que venden piezas blancas 

SELECT * FROM ventas WHERE codpie IN (SELECT codpie FROM pieza WHERE color='Blanco');


-- Datod de piezas que  no sean blancas

SELECT * FROM ventas WHERE codpie NOT IN (SELECT codpie FROM pieza WHERE color='Blanco');

SELECT * FROM ventas WHERE codpie IN (SELECT codpie FROM pieza WHERE NOT color='Blanco');

SELECT * FROM ventas WHERE codpie IN (SELECT codpie FROM pieza WHERE color<>'Blanco');


-- Operador [NOT] EXISTS (consulta) - devuelve verdadero si la consulta devuelve alguna fila es decir, si el conjunto no esta vacio
-- WHERE [NOT] EXISTS (consulta)

-- Datos completos de proveedores que han hecho alguna venta

SELECT * FROM proveedor p WHERE EXISTS (SELECT * FROM ventas v WHERE v.codpro=p.codpro );



-- Operador : WHERE atributo {>=, >, <=, <, <>, ==} {ANY, ALL} (SELECT atributo ...)
--           donde  atributo sea operador que {cualquiera, todos} de ..

--Ventas con mas cantidad que las ventas de S1

SELECT * from ventas WHERE cantidad >= ANY (SELECT cantidad FROM ventas WHERE codpro='S1');


-- Ventas superiores a todas las hechas por S1

SELECT * from ventas WHERE cantidad >= ALL (SELECT cantidad FROM ventas WHERE codpro='S1');


-- La venta mas grande

SELECT * from ventas WHERE cantidad >= ALL (SELECT cantidad FROM ventas);


-- equivalente al NOT IN
SELECT * from ventas WHERE cantidad <> ALL (SELECT cantidad FROM ventas);



SELECT * from ventas WHERE cantidad == ALL (SELECT cantidad FROM ventas);