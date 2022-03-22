-- Ej1 -----------------------------------------------------------------------------------------------------------------
/* Programar un procediment anomenat insertardept_tran que insereix un nou departament tenint en compte les següents observacions:
a) L’usuari introduirà el nom del departament, el cap (manager) i el codi de la localitat.
b) El codi del departament serà la desena següent al número més gran de la taula.
c) S’ha de gestionar possibles errors.
d) S’ha de gestionar la transacció, desant o desfent els canvis.*/
-- ---------------------------------------------------------------------------------------------------------------------

create or replace function insertardept_tran(
    v_deptName departments.department_name%type,
    v_managerId departments.manager_id%type,
    v_locationId departments.location_id%type) returns boolean language plpgsql as $$
declare
    v_deptId departments.department_id%type := (select max(department_id)+10 from departments);
begin
    if v_deptName in (select department_name from departments) then
        raise notice 'El departament %, ja existeix', v_deptName;
        return false;
    else
        insert into departments values (v_deptId, v_deptName, v_managerId, v_locationId);
        return true;
    end if;
    exception
        when foreign_key_violation then
            raise exception 'El valor indicat en manager_id o location_id, no correspon a cap valor a la taula deparments';
end; $$;

do $$
declare
    v_validate boolean = (select insertardept_tran(:v_deptName, :v_manager_id, :v_locationId));
begin
    if v_validate = true then
        COMMIT;
    else
        raise notice 'Problema amb les dades!';
        ROLLBACK;
    end if;
end; $$ language plpgsql;

-- Proves

delete from departments where department_id = 280;

select * from departments where department_id = 280;

-- Ej2 -----------------------------------------------------------------------------------------------------------------
/* Programar un procediment anomenat insertaremp_tran que rebi totes les dades d’un nou empleat i processi la transacció
d’alta. S’ha de tenir en compte les següents observacions:
a) L’usuari introduirà les dades corresponents. En cas de que els camps que són obligatoris no siguin introduïts per
   l’usuari s’ha de donar el missatge corresponent i aturar la inserció corresponent desfent els canvis.
b) S’ha de gestionar possibles errors.
c) S’ha de gestionar la transacció, desant o desfent els canvis.
d) Programar un script per a comprovar que funciona el procediment.*/
-- ---------------------------------------------------------------------------------------------------------------------

create or replace function insertaremp_tran(dades employees%rowtype) returns boolean language plpgsql as $$
declare
    dades employees%rowtype;
begin
    if dades.employee_id in (select employee_id from employees) then
        raise notice 'hola no puedes %', dades.employee_id;
        return false;
    end if;
end; $$;

do $$
declare
    dades employees%rowtype = (select insertaremp_tran());
begin

end; $$ language plpgsql;

-- Ej3 -----------------------------------------------------------------------------------------------------------------
/* Programar un procediment anomenat modifremp_tran que rebi com a paràmetre el codi del departament i modifiqui el
salari de tots els empleats que pertanyen a aquest departament. S’ha de tenir en compte les següents observacions:
a) L’usuari ha d’introduir un import i un percentatge per aplicar-li al càlcul del salari. Aquest dos valors se li passarà
   com a paràmetre al procediment. L’augment del salari anirà en funció del percentatge o de l’import indicat i s’aplicarà
   el que sigui més beneficiós per a l’empleat.
b) Les quantitats no poden ser negatius.
c) S’ha de gestionar possibles errors.
d) S’ha de gestionar la transacció, desant o desfent els canvis.
e) Programar un script per a comprovar que funciona el procediment.*/
-- ---------------------------------------------------------------------------------------------------------------------

create or replace function modifremp_tran(deptId departments.department_id%type, v_import numeric, v_percentatge numeric) returns numeric as $$
declare
    deptId departments.department_id%type;
    v_salary employees.salary%type;
    v_import numeric;
    v_percentatge numeric;
begin
    if v_import < 0 or v_percentatge < 0 then
        raise notice 'Error el import i el percentatge ha de ser major que 1';
        return false;
    else
        if (v_salary+(v_percentatge/100)*v_salary) = v_salary + v_import then
            v_salary = v_salary + v_import;
            return true;
        elseif (v_salary+(v_percentatge/100)*v_salary) > v_salary + v_import then
            v_salary = (v_salary+(v_percentatge/100)*v_salary);
            return true;
        else
            v_salary = v_salary + v_import;
            return true;
        end if;
    end if;
end; $$ language plpgsql;

drop function modifremp_tran(deptId departments.department_id%type, v_import numeric, v_percentatge numeric)

do $$
declare
    v_validate boolean := (select modifremp_tran(:deptId, :v_import, :v_percentatge));
begin
    if v_validate = true then
        COMMIT;
    else
        raise notice 'Problema amb la insersio de dades!';
        ROLLBACK;
    end if;
end; $$ language plpgsql;

-- Ej4 -----------------------------------------------------------------------------------------------------------------
/* Programar un procediment anomenat borraremp_tran que esborri un empleat on el codi de l’empleat se li passarà com a
paràmetre. Al procediment s’ha de comprovar si existeix o no l’empleat. S’ha de tenir en compte les següents observacions:
a) L’usuari ha d’introduir el codi de l’empleat. Aquest valor se li passarà com a paràmetre al procediment.
b) Per a comprovar si existeix o no l’empleat, es farà mitjançant una funció anomenada buscar_emp (que pot ser ja està creada).
c) S’ha de gestionar possibles errors. A més, si existeix l’empleat esborrar-lo i sinó donar el missatge corresponent.
d) S’ha de gestionar la transacció, desant o desfent els canvis.
e) Programar un script per a comprovar que funciona el procediment.*/
-- ---------------------------------------------------------------------------------------------------------------------

