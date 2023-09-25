USE henry;
-- 1. ¿Cuantas carreas tiene Henry?
SELECT COUNT(*) AS cantidad_carrera
FROM carrera;
-- 2. ¿Cuantos alumnos hay en total?
SELECT COUNT(*) AS cantidadAlumno
FROM alumno;
-- 3. ¿Cuantos alumnos tiene cada cohorte?
SELECT COUNT(idAlumno) AS NºAlumnos, idCohorte AS cohorte
FROM alumno
GROUP BY idCohorte;
-- 4. Confecciona un listado de los alumnos ordenado por los últimos alumnos que ingresaron,
-- con nombre y apellido en un solo campo.
SELECT CONCAT(nombre,' ', apellido) AS NombreApellido, fechaIngreso
FROM alumno
ORDER BY fechaIngreso DESC;
-- 5. ¿Cual es el nombre del primer alumno que ingreso a Henry? Bervely Gardner
-- SELECT concat_ws(' ','hola','mundo');#primero conque queremosconcatenar
SELECT CONCAT(nombre,' ', apellido) AS NombreApellido
FROM alumno
ORDER BY fechaIngreso ASC
LIMIT 1;
-- 6. ¿En que fecha ingreso?04-12-2019
SELECT fechaIngreso
FROM alumno
ORDER BY fechaIngreso ASC
LIMIT 1;
-- 7. ¿Cual es el nombre del ultimo alumno que ingreso a Henry?Jason Harmon
SELECT CONCAT(nombre,' ', apellido) AS NombreApellido
FROM alumno
ORDER BY fechaIngreso DESC
LIMIT 1;
-- 8. La función YEAR le permite extraer el año de un campo date, utilice esta función y especifique cuantos alumnos ingresarona a Henry por año.
SELECT DISTINCT YEAR(fechaIngreso) AS Año, COUNT(idAlumno) AS cant_alumnos
FROM alumno
GROUP BY YEAR(fechaIngreso)
ORDER BY 1;
/* 9. ¿Cuantos alumnos ingresaron por semana a henry?, indique también el año. WEEKOFYEAR() firstdayofweek	
Optional. Specifies what day the week starts on. Can be one of the following:

0 - First day of week is Sunday
1 - First day of week is Monday and the first week of the year has more than 3 days
2 - First day of week is Sunday
3 - First day of week is Monday and the first week of the year has more than 3 days
4 - First day of week is Sunday and the first week of the year has more than 3 days
5 - First day of week is Monday
6 - First day of week is Sunday and the first week of the year has more than 3 days
7 - First day of week is Monday*/

SELECT YEAR(fechaIngreso) AS Año, WEEKOFYEAR(fechaIngreso) AS semana, COUNT(idAlumno) AS cant_alumnos
FROM alumno
GROUP BY Año, semana
ORDER BY  1,2;

-- En que mes se incorporan mas alumnos
SELECT YEAR(fechaIngreso) AS Año, monthname(fechaIngreso) AS mes, COUNT(idAlumno) AS cant_alumnos
FROM alumno
GROUP BY Año, mes
ORDER BY  3 ;
-- 10. ¿En que años ingresaron más de 20 alumnos?
SELECT DISTINCT YEAR(fechaIngreso) AS Año, COUNT(idAlumno) AS cant_alumnos
FROM alumno
WHERE idAlumno > 20
GROUP BY 1;

SELECT YEAR(fechaIngreso) AS año, COUNT(*) AS cantidad_alumno
FROM alumno
GROUP BY año 
HAVING cantidad_alumno > 20
ORDER BY 2;
-- 11. Investigue las funciones TIMESTAMPDIFF() y CURDATE(). ¿Podría utilizarlas para saber cual es la edad de los instructores?. ¿Como podrías verificar
-- si la función cálcula años completos? Utiliza DATE_ADD().   #argumento 1-en que quiero que me lo devuelva, 2- que fecha compara,3- hoy

SELECT CONCAT(nombre,' ',apellido) AS NombreApellido,  TIMESTAMPDIFF (year,fechaNacimiento,curdate()) AS edad,  
date_add(fechaNacimiento,interval TIMESTAMPDIFF (year,fechaNacimiento,curdate()) year)  AS verificacion, fechaNacimiento
FROM instructor
ORDER BY 2;
-- 12. Cálcula:
-- La edad de cada alumno.
SELECT CONCAT(nombre,' ',apellido), TIMESTAMPDIFF (year,fechaNacimiento,curdate()) AS edad 
FROM alumno
ORDER BY 2 DESC;

-- Figura que el alumno Quinlan Gordon tiene 1821, calculosu edad y corrijo
SELECT *
FROM alumno
WHERE apellido like'%Gordon%';

-- Lafecha de nacimiento que figuraes 0202 lo que haría es corroborar fecha. y corregire por 2002
UPDATE alumno
SET fechaNacimiento = '2002-01-19'
WHERE idAlumno = 127;
SELECT *
FROM alumno
WHERE idAlumno = 127;
            
-- La edad promedio de los alumnos de henry.
SELECT AVG(TIMESTAMPDIFF (year,fechaNacimiento,curdate())) AS edad_promedio
FROM alumno;


-- La edad promedio de los alumnos de cada cohorte. y a que carrrera pertenecen

SELECT AVG(TIMESTAMPDIFF (year,a.fechaNacimiento,curdate())) AS edad_promedio, ca.nombre AS nombreCarrera
FROM alumno a
INNER JOIN cohorte c ON c.IdCohorte = a.IdCohorte
INNER JOIN carrera ca ON c.idCarrera = ca.idCarrera
GROUP BY ca.idCarrera;
-- 13. Elabora un listado de los alumnos que superan la edad promedio de Henry.Comparar subquery

SELECT count(idAlumno)
FROM alumno 
WHERE TIMESTAMPDIFF (year,fechaNacimiento,curdate()) >
	(SELECT AVG(TIMESTAMPDIFF (year,fechaNacimiento,curdate()))
     FROM alumno);
-- cuente los alumnos que superan esa edad de cada carrera
SELECT count(a.idAlumno), ca.nombre
FROM alumno a
INNER JOIN cohorte c ON c.IdCohorte = a.IdCohorte
INNER JOIN carrera ca ON c.idCarrera = ca.idCarrera
WHERE TIMESTAMPDIFF (year,fechaNacimiento,curdate())> 22
GROUP BY ca.nombre;

