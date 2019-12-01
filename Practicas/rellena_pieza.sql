
INSERT INTO pieza VALUES ('P1', 'Tuerca', 2.5, 'Gris', 'Madrid');
INSERT INTO pieza VALUES ('P2', 'Tornillo', 1.25, 'Rojo',  'Paris');
INSERT INTO pieza VALUES ('P3', 'Arandela',  3, 'Blanco', 'Londres');
INSERT INTO pieza VALUES ('P4', 'Clavo', 5.5, 'Gris', 'Lisboa');
INSERT INTO pieza VALUES ('P5', 'Alcayata', 10, 'Blanco',  'Roma');


COMMIT;

SELECT * FROM pieza;

DELETE FROM pieza WHERE ciudad='Londes';