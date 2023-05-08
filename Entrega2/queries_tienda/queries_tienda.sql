-- Llista el nom de tots els productes que hi ha en la taula producto.
SELECT nombre FROM producto;

-- Llista els noms i els preus de tots els productes de la taula producto.
SELECT p.nombre , p.precio FROM producto p;

-- Llista totes les columnes de la taula producto.
SELECT * FROM producto;

-- Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD).
SELECT p.nombre, CONCAT(p.precio, '€') AS precio_en_€, CONCAT(p.precio, '$') AS precio_en_$ FROM producto p;

-- Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD). Utilitza els següents àlies per a les columnes: nom de producto, euros, dòlars.
SELECT  p.nombre, CONCAT(p.precio, '€') AS euros, CONCAT(p.precio, '$') AS dolares FROM producto p;

-- Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a majúscula.
SELECT UPPER(p.nombre) , p.precio FROM producto p;

-- Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a minúscula.
SELECT LOWER(p.nombre) , p.precio FROM producto p;

-- Llista el nom de tots els fabricants en una columna, i en una altra columna obtingui en majúscules els dos primers caràcters del nom del fabricant.
SELECT f.nombre, SUBSTRING(f.nombre,1,2) FROM fabricante f;

-- Llista els noms i els preus de tots els productes de la taula producto, arrodonint el valor del preu.
SELECT p.nombre , ROUND(p.precio) FROM producto p;

-- Llista els noms i els preus de tots els productes de la taula producto, truncant el valor del preu per a mostrar-lo sense cap xifra decimal.
SELECT p.nombre, TRUNCATE(p.precio,0) FROM producto p ;

-- Llista el codi dels fabricants que tenen productes en la taula producto.
SELECT f.codigo, f.nombre  FROM fabricante f INNER JOIN producto p ON p.codigo_fabricante = f.codigo;

-- Llista el codi dels fabricants que tenen productes en la taula producto, eliminant els codis que apareixen repetits.
SELECT DISTINCT f.codigo, f.nombre FROM fabricante f INNER JOIN producto p ON p.codigo_fabricante = f.codigo ;

-- Llista els noms dels fabricants ordenats de manera ascendent.
SELECT * FROM fabricante f ORDER BY f.nombre ASC;

-- Llista els noms dels fabricants ordenats de manera descendent.
SELECT * FROM fabricante f ORDER BY f.nombre DESC;

-- Llista els noms dels productes ordenats, en primer lloc, pel nom de manera ascendent i, en segon lloc, pel preu de manera descendent.
SELECT * FROM producto p ORDER BY p.nombre ASC;
SELECT * FROM producto p ORDER BY p.precio DESC;

-- Retorna una llista amb les 5 primeres files de la taula fabricante.
SELECT * FROM fabricante LIMIT 0,5;

-- Retorna una llista amb 2 files a partir de la quarta fila de la taula fabricante. La quarta fila també s'ha d'incloure en la resposta.
SELECT * FROM fabricante LIMIT 3,3;

-- Llista el nom i el preu del producte més barat. (Utilitza solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MIN(preu), necessitaria GROUP BY.
SELECT * FROM producto ORDER BY  precio LIMIT 1;

-- Llista el nom i el preu del producte més car. (Utilitza solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MAX(preu), necessitaria GROUP BY.
SELECT *  FROM producto ORDER BY precio DESC LIMIT 1;

-- Llista el nom de tots els productes del fabricant el codi de fabricant del qual és igual a 2.
SELECT f.nombre FROM fabricante f WHERE f.codigo = 2;

-- Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades.
SELECT p.nombre, p.precio, f.nombre FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo;

-- Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades. Ordena el resultat pel nom del fabricant, per ordre alfabètic.
SELECT  f.nombre, p.nombre, p.precio  FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY f.nombre;

-- Retorna una llista amb el codi del producte, nom del producte, codi del fabricador i nom del fabricador, de tots els productes de la base de dades.
SELECT p.codigo, p.nombre , f.codigo, f.nombre FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo;

-- Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més barat.
SELECT p.nombre,p.precio, f.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY p.precio LIMIT 1;

-- Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més car.
SELECT p.nombre,p.precio, f.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY p.precio DESC LIMIT 1;

-- Retorna una llista de tots els productes del fabricant Lenovo.
SELECT * FROM producto JOIN fabricante f ON producto.codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo';

-- Retorna una llista de tots els productes del fabricant Crucial que tinguin un preu major que 200 €.
SELECT * FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE p.precio > 200;

-- Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packard y Seagate. Sense utilitzar l'operador IN.
SELECT * FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo 
 WHERE f.nombre = 'Asus' || f.nombre = 'Seagate' || f.nombre = 'Hewlett-Packard';
 
-- Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packard y Seagate. Fent servir l'operador IN.
SELECT * FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre IN ('Asus','Seagate','Hewlett-Packard');

-- Retorna un llistat amb el nom i el preu de tots els productes dels fabricants el nom dels quals acabi per la vocal e.
SELECT  p.nombre , p.precio, f.nombre  FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre LIKE('%e');

-- Retorna un llistat amb el nom i el preu de tots els productes el nom de fabricant dels quals contingui el caràcter w en el seu nom.
SELECT p.nombre , p.precio, f.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre LIKE('%w%');

-- Retorna un llistat amb el nom de producte, preu i nom de fabricant, de tots els productes que tinguin un preu major o igual a 180 €. Ordena el resultat, en primer lloc, pel preu (en ordre descendent) i, en segon lloc, pel nom (en ordre ascendent).
SELECT p.nombre, p.precio, f.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE p.precio >= 180 ORDER BY p.precio DESC;
SELECT p.nombre, p.precio, f.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE p.precio >= 180 ORDER BY f.nombre;

-- Retorna un llistat amb el codi i el nom de fabricant, solament d'aquells fabricants que tenen productes associats en la base de dades.
SELECT * FROM fabricante f INNER JOIN producto p ON p.codigo_fabricante = f.codigo;

-- Retorna un llistat de tots els fabricants que existeixen en la base de dades, juntament amb els productes que té cadascun d'ells. El llistat haurà de mostrar també aquells fabricants que no tenen productes associats.
SELECT * FROM fabricante f LEFT JOIN producto p ON p.codigo_fabricante = f.codigo;

-- Retorna un llistat on només apareguin aquells fabricants que no tenen cap producte associat.
SELECT * FROM fabricante f LEFT JOIN producto p ON p.codigo_fabricante = f.codigo WHERE p.codigo is null ;

-- Retorna tots els productes del fabricador Lenovo. (Sense utilitzar INNER JOIN).
SELECT * FROM producto p RIGHT JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo';

-- Retorna totes les dades dels productes que tenen el mateix preu que el producte més car del fabricant Lenovo. (Sense usar INNER JOIN).
SELECT * FROM producto p LEFT JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE p.precio = 559;

-- Llista el nom del producte més car del fabricant Lenovo.
SELECT  p.nombre, p.precio FROM producto p RIGHT JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo' ORDER BY p.precio DESC LIMIT 1;

-- Llista el nom del producte més barat del fabricant Hewlett-Packard.
SELECT  p.nombre, p.precio FROM producto p RIGHT JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Hewlett-Packard' ORDER BY p.precio LIMIT 1;

-- Retorna tots els productes de la base de dades que tenen un preu major o igual al producte més car del fabricant Lenovo.
SELECT * FROM producto p LEFT JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE p.precio >= 559;

-- Llesta tots els productes del fabricant Asus que tenen un preu superior al preu mitjà de tots els seus productes.
SELECT SUM(p.precio)/2 FROM producto p LEFT JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Asus' ;

