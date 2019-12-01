
DESCRIBE opc.ventas;

INSERT INTO ventas (SELECT codpro, codpie,codpj, cantidad FROM opc.ventas);

DESCRIBE ventas;

SELECT * FROM ventas;

COMMIT;

ALTER TABLE ventas ADD (fecha DATE DEFAULT SYSDATE );

UPDATE ventas SET fecha=fecha-30 WHERE codpro='S2';

UPDATE ventas SET fecha=fecha-935 WHERE (cantidad>300 and cantidad<900);

UPDATE ventas SET fecha=fecha-95*7 WHERE codpro='S1';

UPDATE ventas SET fecha=fecha-229 WHERE fecha='07/06/2017';

SELECT to_char(fecha, 'dd/mm/yyyy') FROM ventas;


SELECT codpro, codpie, codpj, cantidad, fecha FROM ventas WHERE cantidad>100;

SELECT ciudad FROM pieza WHERE color='Blanco';

SELECT codpro, codpie, pieza.ciudad FROM pieza, proveedor WHERE pieza.ciudad=proveedor.ciudad;

SELECT proveedor.codpro, nompro, codpie  FROM ventas, proveedor WHERE (codpie='P1' and ventas.codpro=proveedor.codpro);
