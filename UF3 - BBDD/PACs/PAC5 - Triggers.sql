-- Ej1 -----------------------------------------------------------------------------------------------------------------
/* Programar un trigger esmentat nom_departament_notnull que s’activarà quan no s’especifiqui el nom del departament al
donar d’alta un departament nou a la taula departments. */
-- ---------------------------------------------------------------------------------------------------------------------



-- Ej2 -----------------------------------------------------------------------------------------------------------------
/* Programar un trigger associat a la taula Employees. El trigger s’anomenarà restriccions_emp i ha de controlar les 
següents situacions:
a) Quan inserim un nou empleat no pot tenir un salari negatiu.
b) Quan modifiquem les dades d’un empleat, si es modifica el camp salari, només es podrà incrementar i només si té 
   comissió al camp commission_pct. */
-- ---------------------------------------------------------------------------------------------------------------------



-- Ej3 -----------------------------------------------------------------------------------------------------------------
/* Programar un trigger que comprovi que la comissió mai sigui més gran que el salari a l’hora d’inserir un empleat. El 
disparador s’anomenarà comissio i s’ha de comprovar que funciona fent una inserció. */
-- ---------------------------------------------------------------------------------------------------------------------



-- Ej4 -----------------------------------------------------------------------------------------------------------------
/* Programar un trigger que faci fallar qualsevol operació de modificació del first_name o del codi de l’empleat o que 
suposi una pujada de sou superior al 10%. El disparador s’anomenarà errada_modificacio. */
-- ---------------------------------------------------------------------------------------------------------------------



-- Ej5 -----------------------------------------------------------------------------------------------------------------
/* Programar un trigger anomenat auditartaulaemp i que permeti auditar les operacions d’inserció o d’esborrat dades que 
es realitzaran a la taula employees. El resultat de l’auditoria es guardarà a una nova taula de la base de dades anomenada 
resauditaremp. Les especificacions que s’han de tenir en compte són les següents: 
a) Crear la taula resauditaremp amb un únic camp anomenat resultat VARCHAR(200). 
b) Quan es produeixi qualsevol operació (inserció, esborrat i/o actualitzar) sobre la taula employees, s’inserirà una 
   fila en la taula resauditaremp. El contingut d’aquesta fila serà la data i hora que s’ha fet l’operació sobre la taula 
   i el codi i cognom de l’empleat. */
-- ---------------------------------------------------------------------------------------------------------------------

