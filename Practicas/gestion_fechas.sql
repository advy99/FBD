SELECT codpro, cantidad, to_char(fecha, 'Day, dd "de" Month "de" YYYY ') FROM ventas;

SELECT * FROM ventas;
DESCRIBE ventas;

--Dual es una tabla auxiliar, para que el sistema crea que tiene una tabla
SELECT 2435*3 FROM dual;

--to_date pasar a fecha
SELECT to_char(to_date('15/09/1999', 'DD/MM/YYYY'), 'Day' ) FROM dual;

SELECT to_char(, 'Day') FROM dual;

SELECT codpro, cantidad, to_char(fecha, 'DD/MM/YYYY') FROM ventas WHERE to_char(fecha, 'MM')='04';

SELECT codpro, cantidad, to_char(fecha, 'DD/MM/YYYY') FROM ventas WHERE to_char(fecha, 'YYYY')='2016';

SELECT codpro, cantidad, to_char(fecha, 'DD/MM/YYYY') FROM ventas WHERE fecha >= SYSDATE - 30;

--Esto no funciona, solo con numero
SELECT codpro, cantidad, to_char(fecha, 'DD/MM/YYYY') FROM ventas WHERE to_char(fecha, 'Month')='Abril';


INSERT INTO ventas VALUES ('S4', 'P2', 'J1', 500, to_date('10/04/1999','DD/MM/YYYY') );

rollback;

--Usar IS NULL o IS NOT NULL para preguntar por nulo

--Para usar alias: separar con espacio en blanco
SELECT * FROM proveedor p, ventas v WHERE p.codpro=v.codpro;

SELECT codpro proveedor_id, nombre FROM proveedor;


--Ordenar salida, primero ascendiente, luego descendiente
SELECT * FROM ventas ORDER BY fecha;
SELECT * FROM ventas ORDER BY fecha DESC;

SELECT * FROM ventas ORDER BY fecha, cantidad;

--buscar subcadenas   WHERE ciudad      LIKE '%L%'
--                    WHERE ciuddad NOT LIKE

-- para evitar distincion mayus/minus WHERE UPPER(ciudad) (tambien con LOWER)

--PAG 26 - ej - 2.11, 2.12 y 2.13

-- ej 3.2, 3.3, 3.4, 3.5, 3.11, 3.13, 3.15, 3.16, 3.17, 3.18, 



--ej 2.11

--da un error, ya que esa clave primaria ya existe en la tabla
insert into ventas values ('S3', 'P1', 'J1', 150, '24/12/05');


insert into ventas (codpro, codpj) values ('S4', 'J2');

--no encuentra la clave externa en el codigo de proveedor
insert into ventas values('S5','P3','J6',400,TO_DATE('25/12/00'));
