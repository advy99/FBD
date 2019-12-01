

-- Division : Proveedores que han venddido todas las piezas blancas
-- PI (codpro, codpie) (ventas)  /  PI(codpie) (SIGMA()  )

(SELECT codpie FROM pieza WHERE color='Blanco') MINUS (SELECT codpie FROM ventas v WHERE codpro='S4')

-- Divisor le resto la parte comun del dividendo - Si el divisor se queda vacio es que las ha vendido todas


-- Ahora vamos a hacerlo bien

SELECT codpro FROM ventas v1 WHERE NOT EXISTS ( (SELECT codpie FROM pieza WHERE color='Blanco') MINUS (SELECT codpie FROM ventas v2 WHERE v2.codpro=v1.codpro) )


-- Arreglamos el que muestre 4 veces codpro, dividiendo de los proveedores en lugar de ventas, para no provar varias veces con el mismo proveedor

SELECT codpro FROM proveedor p WHERE NOT EXISTS ( (SELECT codpie FROM pieza WHERE color='Blanco') MINUS (SELECT codpie FROM ventas v2 WHERE v2.codpro=p.codpro) )


-- en general division

-- SELECT attributos FROM tabla_donde_esten WHERE [CONDICIONES AND] NOT EXISTS (  ( divisor )   MINUS   ( dividendo ) )


-- Proveedores que venden la misma pieza a todos los proyectos de Londres

SELECT DISTINCT p.nomPro, p.codpro, codpie FROM ventas v1, proveedor p WHERE v1.codpro=p.codpro AND NOT EXISTS ( (SELECT codpj FROM proyecto WHERE ciudad='Londres')  MINUS  (SELECT codpj FROM ventas v2 WHERE v1.codpro=v2.codpro AND v1.codpie=v2.codpie) );



-- 1.- Proyectos que han usado todas las piezas de más de 5 gramos

SELECT codpj FROM proyecto p WHERE NOT EXISTS ( (SELECT codpie FROM pieza pie WHERE peso>5  )  MINUS (SELECT codpie FROM ventas v WHERE p.codpj=v.codpj)  );

-- Comprobacion
SELECT * FROM pieza;
SELECT * FROM ventas WHERE codpie='P4' OR codpie='P5' ;


SELECT * FROM proyecto

-- 2.- Proveedores que han suministrado todas las piezas grises al mismo proyecto

SELECT DISTINCT v.codpro, v.codpj FROM ventas v WHERE NOT EXISTS ( (SELECT codpie FROM pieza pie WHERE color='Gris' ) MINUS (SELECT codpie FROM ventas v2 WHERE v.codpro=v2.codpro AND v.codpj=v2.codpj) );


-- 3.- Misma que la 2 pero devolviendo además nombre de proveedor y nombre de proyecto

SELECT DISTINCT v.codpro, v.codpj, nompro, nompj FROM ventas v, proveedor p, proyecto j WHERE v.codpro=p.codpro AND v.codpj=j.codpj AND NOT EXISTS ( (SELECT codpie FROM pieza pie WHERE color='Gris' ) MINUS (SELECT codpie FROM ventas v2 WHERE v.codpro=v2.codpro AND v.codpj=v2.codpj) );






-- 3.46 es una division, 3.48 otra division -- 53, 54, 55, 56