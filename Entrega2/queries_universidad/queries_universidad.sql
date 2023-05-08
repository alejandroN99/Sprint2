-- Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT p.apellido1, p.apellido2, p.nombre FROM persona p ORDER BY p.apellido1 DESC, p.apellido2 DESC , p.nombre DESC;

-- Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT * FROM persona p WHERE  p.telefono IS NULL ;

-- Retorna el llistat dels alumnes que van néixer en 1999.
SELECT * FROM persona p WHERE p.fecha_nacimiento between '1999-01-01' AND '1999-12-31';

-- Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.
SELECT * FROM persona p WHERE p.telefono IS NULL AND p.nif like '%k';

-- Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT * FROM asignatura a JOIN grado g ON a.id_grado = g.id WHERE a.cuatrimestre = 1 AND a.curso = 3 AND g.id = 7;

/* Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. 
El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. 
El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.*/
SELECT p.apellido1, p.apellido2, p.nombre, d.nombre FROM persona p 
JOIN profesor prof ON p.id = prof.id_profesor
JOIN departamento d ON prof.id_departamento = d.id ORDER BY p.apellido1 DESC, p.apellido2 DESC, p.nombre DESC, d.nombre DESC;

-- Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT asig.nombre, c.anyo_inicio, c.anyo_fin FROM persona p 
JOIN alumno_se_matricula_asignatura a ON p.id = a.id_alumno 
JOIN asignatura asig ON asig.id = a.id_asignatura
JOIN curso_escolar c ON a.id_curso_escolar = c.id 
WHERE p.nif = '26902806M';

-- Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
 SELECT p.nombre, d.nombre FROM departamento d 
 JOIN profesor prof ON d.id = prof.id_departamento 
 JOIN persona p ON prof.id_profesor = p.id
 JOIN asignatura a ON prof.id_profesor = a.id_profesor
 JOIN grado g ON a.id_grado = g.id 
 WHERE a.id_grado = 'Grado en Ingeniería Informática (Plan 2015)';
 
-- Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT p.nombre, p.apellido1 FROM persona p JOIN alumno_se_matricula_asignatura alum ON p.id = alum.id_alumno
JOIN asignatura asig ON alum.id_asignatura = asig.id
JOIN curso_escolar c ON c.id = alum.id_curso_escolar
WHERE c.anyo_inicio between '2018-01-01' AND '2019-01-01';

-- Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.

/*Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. 
El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. 
El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. 
El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.*/
SELECT d.nombre, p.nombre, p.apellido1, p.apellido2 FROM persona p 
LEFT JOIN profesor prof ON prof.id_profesor = p.id 
LEFT JOIN departamento d ON d.id = prof.id_departamento
ORDER BY d.nombre DESC, p.nombre DESC, p.apellido1 DESC, p.apellido2 DESC;

-- Retorna un llistat amb els professors/es que no estan associats a un departament.
SELECT d.nombre, p.nombre, p.apellido1, p.apellido2 FROM persona p 
LEFT JOIN profesor prof ON prof.id_profesor = p.id 
LEFT JOIN departamento d ON d.id = prof.id_departamento
WHERE d.nombre IS NULL;

-- Retorna un llistat amb els departaments que no tenen professors/es associats.
SELECT d.nombre, p.nombre, p.apellido1, p.apellido2 FROM persona p 
RIGHT JOIN profesor prof ON prof.id_profesor = p.id 
RIGHT JOIN departamento d ON d.id = prof.id_departamento
WHERE p.nombre IS NULL;

-- Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
SELECT a.nombre AS asignatura, p.nombre, p.apellido1, p.apellido2 FROM persona p 
LEFT JOIN profesor prof ON prof.id_profesor = p.id 
LEFT JOIN asignatura a ON a.id_profesor = prof.id_profesor
WHERE a.id_profesor IS NULL;

-- Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
SELECT a.nombre AS asignatura, p.nombre, p.apellido1, p.apellido2 FROM persona p 
RIGHT JOIN profesor prof ON prof.id_profesor = p.id 
RIGHT JOIN asignatura a ON a.id_profesor = prof.id_profesor
WHERE p.nombre IS NULL;

-- Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
SELECT d.nombre, a.curso FROM departamento d LEFT JOIN profesor p ON p.id_departamento = d.id
LEFT JOIN asignatura a ON p.id_profesor = a.id_profesor
WHERE a.curso IS NULL;

-- Consultes resum:

-- Retorna el nombre total d'alumnes que hi ha.
SELECT * FROM persona p WHERE p.tipo = 'alumno';

-- Calcula quants alumnes van néixer en 1999.
SELECT * FROM persona p WHERE p.tipo = 'alumno' AND p.fecha_nacimiento between '1999-01-01' AND '1999-12-31';

/* Calcula quants professors/es hi ha en cada departament. 
El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament.
 El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.*/
 SELECT d.nombre, COUNT(pers.id) FROM departamento d 
 JOIN profesor p ON d.id = p.id_departamento 
 JOIN persona pers ON pers.id = p.id_profesor
 GROUP BY d.nombre ORDER BY COUNT(PERS.ID) DESC;
 
/* Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. 
Tingui en compte que poden existir departaments que no tenen professors/es associats. 
Aquests departaments també han d'aparèixer en el llistat.*/
 SELECT d.nombre, pers.nombre FROM departamento d 
 LEFT JOIN profesor p ON d.id = p.id_departamento 
LEFT JOIN persona pers ON pers.id = p.id_profesor;

/* Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. 
Tingues en compte que poden existir graus que no tenen assignatures associades. 
Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.*/
SELECT g.nombre, COUNT(a.id) FROM grado g 
LEFT JOIN asignatura a ON g.id = a.id_grado 
GROUP BY g.nombre ORDER BY COUNT(a.id) DESC;

/* Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun,
 dels graus que tinguin més de 40 assignatures associades.*/
SELECT g.nombre, COUNT(a.id) FROM grado g 
LEFT JOIN asignatura a ON g.id = a.id_grado 
GROUP BY g.nombre HAVING COUNT(a.id) > 40  ORDER BY COUNT(a.id) DESC;

/*Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura.
El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.*/
SELECT g.nombre, a.tipo , COUNT(a.creditos) FROM grado g 
LEFT JOIN asignatura a ON g.id = a.id_grado 
GROUP BY g.nombre, a.tipo;

/*Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. 
El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.*/
SELECT c.anyo_inicio, COUNT(p.id)FROM persona p 
JOIN alumno_se_matricula_asignatura a ON p.id = a.id_alumno 
JOIN curso_escolar c ON a.id_curso_escolar = c.id
GROUP BY c.anyo_inicio;

/* Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. 
El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. 
El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures.
 El resultat estarà ordenat de major a menor pel nombre d'assignatures.*/
 SELECT p.id, p.nombre, p.apellido1, p.apellido2, COUNT(a.id) FROM asignatura a 
 RIGHT JOIN profesor prof ON a.id_profesor = prof.id_profesor 
 RIGHT JOIN persona p ON prof.id_profesor = p.id
 GROUP BY p.id, p.nombre, p.apellido1, p.apellido2
 ORDER BY COUNT(a.id) DESC;
 
-- Retorna totes les dades de l'alumne/a més jove.
SELECT * FROM persona p WHERE p.tipo ='alumno' ORDER BY p.fecha_nacimiento DESC LIMIT 1; 

-- Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.
SELECT pers.id, pers.nombre, pers.apellido1, d.nombre, a.nombre FROM departamento d 
left JOIN profesor p ON p.id_departamento = d.id
left JOIN persona pers ON p.id_profesor = pers.id
left JOIN asignatura a ON a.id_profesor = p.id_profesor
WHERE a.id_profesor IS NULL AND d.nombre IS NOT NULL AND pers.id IS NOT NULL;