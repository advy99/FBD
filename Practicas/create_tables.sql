CREATE TABLE proveedor (
    codPro CHAR(3) CONSTRAINT codPro_primary_key PRIMARY KEY,
    nomPro VARCHAR2(30) CONSTRAINT nomPro_no_nulo NOT NULL,
    status NUMBER(2) CONSTRAINT status_entre_1_10 CHECK (status BETWEEN 1 AND 10),
    ciudad VARCHAR2(15)
);

DROP TABLE proveedor;


CREATE TABLE pieza (
    codPie CHAR(3) CONSTRAINT codPie_primary_key PRIMARY KEY,
    nomPie VARCHAR2(10) CONSTRAINT nomPie_not_null NOT NULL,
    peso NUMBER(5,2) CONSTRAINT peso_entre_1_100 CHECK (peso>0 AND peso<=100),
    color VARCHAR2(10),
    ciudad VARCHAR2(15)
);

DROP TABLE pieza;

CREATE TABLE proyecto (
    codPj CHAR(3) CONSTRAINT codPj_primary_key PRIMARY KEY,
    nomPj VARCHAR2(10) CONSTRAINT nomPj_not_null NOT NULL,
    ciudad VARCHAR2(15)
);

DROP TABLE proyectos;


CREATE TABLE ventas (
    codPro CONSTRAINT codPro_clave_externa REFERENCES proveedor(codPro),
    codPie CONSTRAINT codPie_clave_externa REFERENCES pieza(codPie),
    codPj  CONSTRAINT codPj_clave_externa  REFERENCES proyecto(codPj),
    cantidad NUMBER(4),
    CONSTRAINT clave_primaria PRIMARY KEY(codPro, codPie, codPJ)
);

DROP TABLE ventas;


DESCRIBE proveedor;
DESCRIBE piezas;
DESCRIBE proyectos;
DESCRIBE ventas;
