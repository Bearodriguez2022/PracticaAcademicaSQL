USE henry;
#No se sabe con certeza el lanzamiento de las cohortes N° 1245 y N° 1246, se solicita que las elimine de la tabla.
DELETE FROM cohorte 
WHERE idCohorte IN (1245, 1246);

/*3.Se ha decidido retrasar el comienzo de la cohorte N°1243, por lo que la nueva fecha de inicio será el 16/05.
 Se le solicita modificar la fecha de inicio de esos alumnos.*/
UPDATE cohorte
SET fechaInicio = '2022-05-16'
WHERE idCohorte = 1243;

#El alumno N° 165 solicito el cambio de su Apellido por “Ramirez”.
UPDATE alumno
SET apellido = 'Ramirez'
WHERE idAlumno = 165;
SELECT apellido
FROM alumno
WHERE idAlumno = 165;

#El área de Learning le solicita un listado de alumnos de la Cohorte N°1243 que incluya la fecha de ingreso.
SELECT nombre, apellido, fechaIngreso
FROM alumno
WHERE idCohorte = 1243; 

#Como parte de un programa de actualización, el área de People le solicita un listado de los instructores
# que dictan la carrera de Full Stack Developer. relacionar
SELECT idInstructor #con esto nos da id del 1-5
FROM cohorte
WHERE idCarrera = 1;

SELECT *
FROM instructor
WHERE idInstructor < 5;

-- JOIN
SELECT DISTINCT i.idInstructor, i.nombre, i.apellido
FROM instructor i
INNER JOIN cohorte c ON (c.idInstructor = i.idInstructor)
INNER JOIN carrera ca ON (ca.idCarrera = c.idCarrera)
WHERE c.idCarrera = 1;

/*Se desea saber que alumnos formaron parte de la cohorte N° 1235. Elabore un listado.
Del listado anterior se desea saber quienes ingresaron en el año 2019.*/

SELECT *
FROM alumno
WHERE idCohorte = 1235 
-- AND fechaIngreso BETWEEN ' 2019-01-01' AND '2019-12-31';
AND YEAR(fechaIngreso) = '2019';

/*Coneste la siguientes interrogantes:
  a. ¿Que campos permiten que se puedan acceder al nombre de la carrera?
  carrera --> nombre
  b. ¿Que tienen en comun cohortes y alumnos?
  idCohorte esta en ambas
  c. ¿Proponga dos opciones para filtrar el listado solo por los alumnos que pertenecen
  a 'Full Stack Developer', utilizando LIKE y NOT LIKE?, ¿Cual de las dos opciones es la manera correcta de hacerlo?, ¿Por que?
  
  d. ¿Proponga dos opciones para filtrar el listado solo por los alumnos que pertenecen a 'Full Stack Developer',
  utilizando " = " y " != "?  ¿Cual de las dos opciones es la manera correcta de hacerlo?, ¿Por que?
  e. ¿Como emplearía el filtrado utilizando el campo idCarrera?*/
  
SELECT a.nombre, a.apellido,a.fechaNacimiento, ca.nombre AS nombreCarrera
FROM alumno a
INNER JOIN cohorte c ON c.IdCohorte = a.IdCohorte
INNER JOIN carrera ca ON c.idCarrera = ca.idCarrera;




SELECT a.nombre,a.apellido,ca.nombre AS alumnosFull
FROM alumno a
JOIN cohorte co ON a.idCohorte = co.idCohorte 
JOIN carrera ca ON co.idCarrera = ca.idCarrera
WHERE co.codigo LIKE 'FT%'; # este es el correcto porque pueden haber muchas carreras
-- WHERE ca.nombre NOT LIKE '%DATA%;  not OK
-- WHERE ca.nombre = '%DATA% ok
-- WHERE ca.nombre != 'DATA SCIENCE' NOT OK
-- WHERE ca.idCarrera = 1 ok

