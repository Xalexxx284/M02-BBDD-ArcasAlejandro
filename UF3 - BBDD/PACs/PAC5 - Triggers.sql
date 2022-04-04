-- Ej1 -----------------------------------------------------------------------------------------------------------------
/* Programar un trigger esmentat nom_departament_notnull que s’activarà quan no s’especifiqui el nom del departament al
donar d’alta un departament nou a la taula departments. */
-- ---------------------------------------------------------------------------------------------------------------------

SELECT column_name, data_type, is_nullable FROM information_schema.columns WHERE table_name = 'departments';

create or replace function triggerExercise1() returns trigger language plpgsql as $$
declare
begin

end; $$;

create trigger nom_departament_notnull before insert
    on emp_salari_nou for each row
    execute procedure triggerExercise1();


-- Ej2 -----------------------------------------------------------------------------------------------------------------
/* Programar un trigger associat a la taula Employees. El trigger s’anomenarà restriccions_emp i ha de controlar les
següents situacions:
a) Quan inserim un nou empleat no pot tenir un salari negatiu.
b) Quan modifiquem les dades d’un empleat, si es modifica el camp salari, només es podrà incrementar i només si té
   comissió al camp commission_pct. */
-- ---------------------------------------------------------------------------------------------------------------------

create or replace function triggerExercise2() returns trigger language plpgsql as $$
declare
begin
    if NEW.salary < 0 then
      raise exception 'El salari no pot ser negatiu';
   end if;
   if NEW.salary <= OLD.salary then
      raise exception 'El salari nou no pot ser mes petit que l"antic';
   end if;
   return new;
end; $$;

create trigger restriccions_emp before insert or update
   on emp_salari_nou for each row
   execute procedure triggerExercise2();

-- Comprovacio a): Inserir dades

insert into emp_salari_nou (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
            values (150, 'Nombre1', 'Apellido2', 'NombreApellido@gmail.com', '665835923', '27/03/2003', 210, 1500, 0.5, 2, 80);

-- Comprovacio b): Actualitzar dades

update emp_salari_nou set salary = 1400 where employee_id = 150;

-- Vista:

select * from emp_salari_nou where employee_id = 150;
delete from emp_salari_nou where employee_id = 150;

-- Ej3 -----------------------------------------------------------------------------------------------------------------
/* Programar un trigger que comprovi que la comissió mai sigui més gran que el salari a l’hora d’inserir un empleat. El
disparador s’anomenarà comissio i s’ha de comprovar que funciona fent una inserció. */
-- ---------------------------------------------------------------------------------------------------------------------

create or replace function triggerExercise3() returns trigger language plpgsql as $$
declare
begin
    if NEW.commission_pct > NEW.salary then
        raise exception 'La comissio no pot ser mes gran que el salari';
    end if;
    return new;
end; $$;

create trigger comissio before insert
    on emp_salari_nou for each row
    execute procedure triggerExercise3();

-- Comprovacio: Amb la comissio mes gran que el salari - (FUNCIONA!!!!!!!!!!)

insert into emp_salari_nou (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
            values (150, 'Nombre1', 'Apellido2', 'NombreApellido@gmail.com', '665835923', '27/03/2003', 210, 1500, 0.5, 2, 80);

-- Comprovacio: Amb la comissio mes petita que el salari - (NO FUNCIONA!!!!!)

insert into emp_salari_nou (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
            values (150, 'Nombre1', 'Apellido2', 'NombreApellido@gmail.com', '665835923', '27/03/2003', 210, 0.2, 0.5, 2, 80);

-- Vista:

select * from emp_salari_nou where employee_id = 150;
delete from emp_salari_nou where employee_id = 150;

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

