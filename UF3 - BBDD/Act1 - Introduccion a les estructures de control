/*---------------------------------------------------- ACTIVITAT 1 ----------------------------------------------------*/

/* 1. Crea un bloc que mostri el nom del departament al que pertany l’empleada Pat Fay. */

do $$
declare
    nom_dept departments.department_name%type;
begin
    select department_name
    into nom_dept
    from employees e, departments d
    where d.department_id=e.department_id and lower(first_name) like 'pat' and lower(last_name) like 'fay';
    raise notice 'El department és %', nom_dept;
end;$$ language plpgsql;

/* 2. Crea un procediment que introduirem l’id de l’empleat, i que retorni a quina regió pertany. */

do $$
declare
    v_region_name regions.region_name%type;
begin
    select r.region_name
    into v_region_name
    from regions r
    join countries c on r.region_id = c.region_id
    join locations l on c.country_id = l.country_id
    join departments d on l.location_id = d.location_id
    join employees e on d.department_id = e.department_id
    where e.employee_id= :v_employ;
    raise notice 'La region que pertany a empleat es % del id %', v_region_name, :v_employ;
end;    $$ language  plpgsql;

/* 3. Crea un programa que ha de mostrar  per pantalla : HOLA MUNDO  */

do $$
begin
    raise notice 'HOLA MUNDO';
end   $$ language plpgsql;

/* 4. Crea un programa amb dos variables de tipus NUMERIC. Aquestes variables s’ha de tenir un valor inicial de
   10.2 i 20.1 respectivament. El bloc ha de sumar aquestes dues variables i mostrar per pantalla ‘LA SUMA TOTAL ÉS: 30.3’ */

do $$
declare
    v_num1 numeric(3,1) := 10.2;
    v_num2 numeric(3,1) := 20.1;
    v_result numeric(4,2) := v_num1 + v_num2;
begin
    raise notice 'LA SUMA TOTAL ES: %', v_result;
end;    $$ language plpgsql;


/* 5. Crea un programa que ha de llistar tots el noms (FIRST_NAME) dels empleats de la taula (EMPLOYEES) en majúscules,
   on has de declara una variable de tipus first_name.  */

do $$
declare
    v_first_name employees.first_name%type;
begin
    select upper(e.first_name)
    into v_first_name
    from employees e;
    raise notice '%', v_first_name;
end;    $$ language plpgsql;

/* 6. Crea un programa que contingui una variable constant anomenada Percentatge amb  un  valor  de  10  Aquest  valor
   és  un  10%. Aquest  bloc  ha  de  contenir  una variable de tipus rowtype, de la taula employees. Dins aquest
   bloc, augmentaràs el sou a l’empleat que introdueixi un usuari i mostrarà per pantalla el següent:  “ S’ha realitzat
   un augment de sou a: L’usuari amb id: “id_usuari” L’usuari amb Nom: “first_name” i cognom “last_name” que pertany al
   departament  “id_department”” */

do $$
declare
    v_percentatge constant numeric(4,2) := 1.10;
    v_empl employees%rowtype;
    v_dept departments%rowtype;
begin
    select e.employee_id, e.first_name, e.last_name, d.department_id, e.salary
    into v_empl.employee_id, v_empl.first_name, v_empl.last_name, v_dept.department_id, v_empl.salary
    from employees e, departments d
    where d.department_id=e.employee_id and employee_id=:empl_id;
    raise notice ' S’ha realitzat
   un augment de sou a: L’usuari amb id: % L’usuari amb Nom: % i cognom % que pertany al
   departament % i el seu sou es de %', :empl_id, v_empl.first_name, v_empl.last_name, v_dept.department_id, round(v_empl.salary*v_percentatge);
end;    $$ language plpgsql;

/* 7. Realitza un programa que introduirem el nom, cognom i edat d’una persona. Posteriorment s’ha d’imprimir les dades corresponents a la persona.  */

do $$
declare
    v_name varchar(30);
    v_surname varchar(30);
    v_age numeric(2);
begin
    v_name= :v_name;
    v_surname= :v_surname;
    v_age= :v_age;
    raise notice 'Les dades corresponents a la persona es: % % %', :v_name, :v_surname, :v_age;
end     $$ language plpgsql;

/* 8. Realitza un programa que calculi el 18% d’un preu que introdueix. S’ha de mostrar l’augment d’aquest preu. */

do $$
declare
    v_price numeric(4,2);
begin
    v_price= :v_price;
    raise notice 'El preu aumentat es de: %', :v_price*0.18;
end     $$ language plpgsql;

/* 9. Realitza un programa que calculi el 18% d’un preu que introdueix. S’ha de mostrar l’augment d’aquest preu arrodonit. */

do $$
declare
    v_price numeric(10,2);
begin
    v_price= :v_price;
    raise notice 'El preu aumentat es de: %', round(:v_price*0.18);
end     $$ language plpgsql;

/* 10. Realitzar un programa que introduirem un salari i la comissió que guanya. I si salari:
          és menor que 100 ? la comissió serà el salari aplicant un 10%
          està entre 100 i 500 ? la comissió serà el salari aplicant un 15%.
          és major que 1000 ? la comissió serà el salari aplicant un 20%.
       Al  final mostrar el resultat. */

do $$
declare
    v_salary numeric(10,2);
    v_porcentaje numeric(4,2);
    v_result numeric(10,2) := v_salary*v_porcentaje;
begin
    v_result= :v_salary*v_porcentaje;
    v_salary= :v_salary;

    if :v_salary<100 then
        v_result=:v_salary*1.10;
    elseif :v_salary between 100 and 500 then
        v_result=:v_salary*1.15;
    elseif :v_salary>1000 then
        v_result=:v_salary*1.20;
    end if;
    raise notice 'El resultat es: %', v_result;
end;     $$ language plpgsql;

/* 11. Preguntar a l’usuari la seva edat i donar el missatge corresponent, si:
         Menor de 18 ? ets menor de edat!
         = 18 ? casi ets major de edat!
         >18 ?ja ets major de edat!
         >40 ? ja ets més major …
       Si és negatiu => error edat no pot ser negativa. */

do $$
declare
    v_age numeric(2);
begin
v_age= :v_age;
    if :v_age < 18 then
        raise notice 'ets menor de edat!';
elseif :v_age = 18 then
        raise notice 'casi ets major de edat!';
elseif :v_age between 19 and 40 then
        raise notice 'ja ets major de edat!';
elseif :v_age > 40 then
        raise notice 'ja ets més major...';
    end if;
end;    $$ language plpgsql;

/* 12. Realitzar un programa que demani un número i el programa ha de realitzar les següents operacions amb aquest número.
       Les operacions han de ser independents i són:
            sumar-li 4.
            Restar-li 3.
            Multiplicar-li 8.
       S’ha de tenir en compte que per a programar aquest exercici:
       utilitzar una constant i assignar-li el número introduït.
       fer ús d’una variable per a cada operació
       imprimir per pantalla els resultats corresponents a cada operació, posant el literal al davant de Suma, Resta i Multiplicació respectivament. */

do $$
declare
    val_num constant numeric(10,2):= :v_num;
    val_suma numeric(10,2):= val_num + 4;
    val_resta numeric(10,2):= val_num - 3;
    val_mult numeric(10,2):= val_num * 8;
begin
    raise notice 'El num % + 4 es: %', val_num, val_suma;
    raise notice 'El num % - 3 es: %', val_num, val_resta;
    raise notice 'El num % * 8 es: %', val_num, val_mult;
end;    $$ language plpgsql;

/* 13. Realitzar un programa que introduirem un valor de dos números. Aquest dos números se li assigna dos variables
   (en el moment de la declaració). Els dos números han de ser positius, en cas contrari s’ha de donar a l’usuari el
   missatge corresponent. S’ha de realitzar una operació amb aquest números: dividir entre ells i sumar-li el segon.*/

