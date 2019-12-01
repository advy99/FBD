DESCRIBE proyecto;
DESCRIBE pieza;

SELECT * FROM pieza;

SELECT nompj, ciudad FROM proyecto WHERE ciudad='Londres';

SELECT nomPie, peso FROM pieza WHERE (peso>2 and peso<8) 