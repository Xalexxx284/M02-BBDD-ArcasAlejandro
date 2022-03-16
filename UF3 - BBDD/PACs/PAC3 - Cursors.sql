-- Ej1 -----------------------------------------------------------------------------------------------------------------
/* Programar un bloc que ens retorni els empleats on el salari sigui més gran al valor que s’introdueix per teclat. S’ha
de controlar mitjançant una funció anomenada CONTROLAR_NEGATIU, si el salari que s’introdueix per teclat és negatiu o no
En cas de que no sigui negatiu s’ha de mostrar el codi, nom i salari de l’empleat, en cas contrari s’ha d’imprimir
“ERROR: salari negatiu i ha de ser positiu”. */
-- ---------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION controlar_negatiu(salary numeric) RETURNs BOOLEAN language plpgsql as $$
BEGIN
IF salary < 0 THEN
 return (FALSE);
ELSE
 return (TRUE);
END IF;
END;$$;


do $$
declare
    cursor1 cursor for select * from employees where salary > :v_salary;
    empleats employees%rowtype;
begin
    if (select controlar_negatiu(:v_salary)) is true then
        open cursor1;
        loop
            fetch cursor1 into empleats;
            exit when not found;
            raise notice 'El codi d"usuari % amb nom % te un salari de %, que es mes gran que %', empleats.employee_id,
                empleats.first_name, empleats.salary, :v_salary;
        end loop;
        close cursor1;
    else
        raise notice 'El salary no pot ser negatiu';
    end if;
end; $$ language plpgsql;


-- Ej2 -----------------------------------------------------------------------------------------------------------------
/* Programar un bloc que imprimeix els nom i els lloc de tots els departaments. Aquest exercici s’ha de fer amb la clàusula:
OPEN, FETCH, CLOSE
FOR … IN … */
-- ---------------------------------------------------------------------------------------------------------------------

-- a)

do $$
declare
    v_deptname departments.department_name%type;
    v_location locations.city%type;
    cursor1 cursor for select d.department_name, city from departments d
        join locations l on d.location_id = l.location_id;
begin
    open cursor1;
    loop
        fetch cursor1 into v_deptname, v_location;
        exit when not found;
        raise notice 'El departament %, esta situat en %', v_deptname, v_location;
    end loop;
    close cursor1;
end; $$ language plpgsql;

-- b)

do $$
declare
    cursor1 cursor for select d.department_name, city from departments d
        join locations l on d.location_id = l.location_id;
begin
    for v_depts in cursor1
    loop
        raise notice 'El departament %, esta situat en %', v_depts.department_name, v_depts.city;
    end loop;
end; $$ language plpgsql;

-- Ej3 -----------------------------------------------------------------------------------------------------------------
/* Programar un bloc que ens retorni tots els empleats que hi ha a la taula corresponent. S’ha de mostrar les següents
   dades: codi, nom, salari, comissió i data d’alta. */
-- ---------------------------------------------------------------------------------------------------------------------

do $$
declare
    cursor1 cursor for select employee_id, first_name, salary, commission_pct, hire_date from employees;
begin
    for v_emp in cursor1
    loop
        raise notice '%, %, %, %, %', v_emp.employee_id, v_emp.first_name, v_emp.salary, v_emp.commission_pct, v_emp.hire_date;
    end loop;
end; $$ language plpgsql;

-- Ej4 -----------------------------------------------------------------------------------------------------------------
/* Programar un bloc que imprimeix tots els empleats de la taula corresponent, simplement els camps: codi i nom de
l’empleat i codi i nom del departament al que pertany. Aquest exercici s’ha de fer amb la clàusula:
OPEN, FETCH, CLOSE
FOR … IN … */
-- ---------------------------------------------------------------------------------------------------------------------

-- a)

do $$
declare
    empl_id employees.employee_id%type;
    empl_name employees.first_name%type;
    dept_id departments.department_id%type;
    dept_name departments.department_name%type;

    cursor1 cursor for select employee_id, first_name, d.department_id, d.department_name from departments d
        join employees e on d.department_id = e.department_id;
begin
    open cursor1;
    loop
        fetch cursor1 into empl_id, empl_name, dept_id, dept_name;
        exit when not found;
        raise notice '%, % del departament %, %', empl_id, empl_name, dept_id, dept_name;
    end loop;
end; $$ language plpgsql;

-- b)

do $$
declare
    cursor1 cursor for select employee_id, first_name, d.department_id, d.department_name from departments d
        join employees e on d.department_id = e.department_id;
begin
    for v_all in cursor1
    loop
        raise notice '%, % del departament %, %', v_all.employee_id, v_all.first_name, v_all.department_id, v_all.department_name;
    end loop;
end; $$ language plpgsql;

-- Ej5 -----------------------------------------------------------------------------------------------------------------
/* Programar un bloc que imprimeix el codi i nom dels empleats d’un departament concret que s’ha d’introduir per teclat
el codi del departament. Aquest exercici s’ha de fer amb CURSORS AMB PARÀMETRES i els paràmetre que s’ha de passar és
el codi de departament que l’usuari introdueixi per teclat. */
-- ---------------------------------------------------------------------------------------------------------------------

do $$
declare
    cursor1 cursor for select e.employee_id, e.first_name from employees e
        join departments d on e.department_id = d.department_id
    where d.department_id = :dept_id;
begin
    for v_all in cursor1
    loop
        raise notice '%, %', v_all.employee_id, v_all.first_name;
    end loop;
end; $$ language plpgsql;

-- Ej6 -----------------------------------------------------------------------------------------------------------------
/* Programar un bloc principal que ens retorni els salaris que hi ha a la taula empleats. Se li ha d’aplicar un 18 % a
cadascun dels salaris d’un departament introduït per pantalla. Els passos a seguir són els següents:
Crear una taula anomenada emp_salari_nou i ha de contenir la mateixa estructura i registre que la taula emp.
Calcular el 18% del salari e imprimir-lo per pantalla, una vegada que ja s’han actualitzat a la taula emp_salari_nou.
Per pantalla ha de sortir de la següent manera:
   El nou salari serà: 5800
    El nou salari serà: 3306
    El nou salari serà: 2842 */
-- ---------------------------------------------------------------------------------------------------------------------



-- Ej7 -----------------------------------------------------------------------------------------------------------------
/* Programar un bloc que ens modifiqui totes les comissions dels empleats sumant 20 als empleats on el codi de
   departament coincideix amb el que s’introdueix per teclat. */
-- ---------------------------------------------------------------------------------------------------------------------

select * into emp_salari_nou from employees;
alter table emp_salari_nou alter column commission_pct type decimal(5, 2);

do $$
declare
    cursor1 cursor(code numeric) for select e.employee_id, e.first_name ,e.commission_pct from emp_salari_nou e
    where department_id = :dept_id;
begin
    for v_all in cursor1(:code)
    loop
        exit when not found;
        update emp_salari_nou set commission_pct = commission_pct+0.2
        where current of cursor1;
        raise notice '%, %, %', v_all.employee_id, v_all.first_name, v_all.commission_pct;
    end loop;
end; $$ language plpgsql;

-- Ej8 -----------------------------------------------------------------------------------------------------------------
/* Programar un bloc que ens actualitza la comissió el 18% de tots els empleats que tingui comissió assignada.
La taula sobre la que hem de realitzar els canvis és una que hem de crear nova. Aquesta taula s’anomenarà emp_salari_nou
i serà de la mateixa estructura i mateixos registres que la taula employees. La idea és tenir una taula PL/SQL per a
emmagatzemar totes les comissions dels empleats que tenen comissió. Per tant, primer emmagatzemarem les comissions a la
taula i després farem les modificacions oportunes, aplicant el 18% sobre les comissions de la taula. A més, ha d’aparèixer
un missatge indicant a l’usuari si a l’empleat X se li ha modificat la comissió correctament o no, tal i com s’indica a
continuació: La comissió de l’empleat PEPE s’ha modificat correctament i és 876 */
-- ---------------------------------------------------------------------------------------------------------------------

do $$
declare

begin

end; $$ language plpgsql;
