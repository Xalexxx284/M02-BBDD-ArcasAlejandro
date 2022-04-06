-- Ej1 -----------------------------------------------------------------------------------------------------------------
/* Volem crear un trigger que llançarà una excepció cada vegada que  actualitzem la quantitat de residu de la taula residu.
    a) Si la quantitat és més petita que l’actual, haurà de sortir un missatge que indiqui “La quantitat nova
    quantitat_nova no pot ser més petita que la quantitat actual quantitat_actual”. Aquest missatge fa referència a l’excepció.
    b) Has de crear un funció de trigger, que llançarà l’excepció.
    c) Has de crear un trigger de tipus BEFORE i  row-level per l'operació UPDATE.
    d) Has d’aportar les ordres per comprovar el funcionament del disparador. */
-- ---------------------------------------------------------------------------------------------------------------------

create or replace function triggerExercise1() returns trigger language plpgsql as $$
declare
begin
    if NEW.quantitat_residu < OLD.quantitat_residu then
        raise exception 'La quantitat nova % no pot ser més petita que la quantitat actual %', NEW.quantitat_residu, OLD.quantitat_residu;
    end if;
    return new;
end; $$;

create trigger updateQuantitat before update
    on residu for each row
    execute procedure triggerExercise1();

------------------------------------ ORDRES PER COMPROVAR EL FUNCIONAMENT ----------------------------------------------

-- Quantitat mes gran:
update residu set quantitat_residu = 27 where nif_empresa = 'A-12000035';

-- Quantitat mes petita:
update residu set quantitat_residu = 25 where nif_empresa = 'A-12000035';

-- Projectar resultats:
select * from residu where nif_empresa = 'A-12000035';

-- Ej2 -----------------------------------------------------------------------------------------------------------------
/* Crearem tres triggers, un per automatizar l’actualització d’un registre a la taula residu, un altre que no permet
esborrar cap registre de la taula residu i un altre per enregistrar els canvis.
    a) Aquests triggers estan associats a una taula i amb una funció de trigger.
    b) La funció  trigger update_dades () et permetrà actualitzar el camp toxicitat de la taula residu.
        i. Si la quantitat a actualitzar és més gran que la que hi ha.
    c) La funció no_esborrar_dades() s’encarregarà de no permetre esborrar cap dada d’una taula concreta.
    d) La funció registrar_canvis () de tipus statement-level que s'executarà després de les sentències INSERT, UPDATE i
    DELETE. La funció executada per aquest trigger deixarà dades de l'execució a la taula canvis.
    e) Has d’aportar les ordres per comprovar el funcionament dels disparadors. */
-- ---------------------------------------------------------------------------------------------------------------------

-- Create table

CREATE TABLE canvis (
  timestamp_ TIMESTAMP WITH TIME ZONE default NOW(),
  nom_trigger text,
  tipus_trigger text,
  nivell_trigger text,
  ordre text
);

-- Apartat update_dades()

create or replace function update_dades() returns trigger language plpgsql as $$
declare
begin
    if NEW.toxicitat < OLD.toxicitat then
        raise exception 'La quantitat de toxicitat nova % no pot ser més petita que la quantitat de toxicitat actual %',
            NEW.toxicitat, OLD.toxicitat;
    end if;
    return new;
end; $$;

create trigger trigger_update_dades before update
    on residu for each row
    execute procedure update_dades();

-- Apartat no_esborrar_dades()

create or replace function no_esborrar_dades() returns trigger language plpgsql as $$
declare
begin
    raise exception 'No es pot esborrar cap dada de la taula residu';
    return null;
end; $$;

create trigger trigger_no_esborrar_dades before delete
    on residu for each row
    execute procedure no_esborrar_dades();

-- Apartat registrar_canvis()

create or replace function registrar_canvis() returns trigger language plpgsql as $$
declare
begin
    insert into canvis (nom_trigger, tipus_trigger, nivell_trigger, ordre)
                values (tg_name, tg_when, tg_level, tg_op);
    return null;
end; $$;

create trigger trigger_registrar_canvis after insert or update or delete
    on residu for each statement
    execute procedure registrar_canvis();



------------------------------------ ORDRES PER COMPROVAR EL FUNCIONAMENT ----------------------------------------------

-- update_dades() ------------------------------------------------------------------------------------------------------
update residu set toxicitat = 9001 where nif_empresa = 'A-12000022';
update residu set toxicitat = 8000 where nif_empresa = 'A-12000022';

select * from residu where nif_empresa = 'A-12000022';

-- no_esborrar_dades() -------------------------------------------------------------------------------------------------
delete from residu where nif_empresa = 'A-12000022';

select * from residu where nif_empresa = 'A-12000022';

-- registrar_canvis() --------------------------------------------------------------------------------------------------

-- He creat un nou registre a la taula empresaproductora per despres poder fer el insert del trigger i no repetir el
-- nif_empresa perque si no, no deixa fer-ho.

insert into empresaproductora (nif_empresa, nom_empresa, ciutat_empresa, activitat)
            values ('A-12100022', 'TRIGGERS Y FUNCIONS', 'SEVILLA', 'Biocidas i productes fitofarmacéuticos');

select * from empresaproductora where nif_empresa = 'A-12100022';

-- INSERT
insert into residu (nif_empresa, cod_residu, toxicitat, quantitat_residu)
            values ('A-12100022', 108, 539, 24);

select * from residu where nif_empresa = 'A-12100022';
select * from canvis;

-- UPDATE
update residu set toxicitat = 540 where nif_empresa = 'A-12100022';

select * from residu where nif_empresa = 'A-12100022';
select * from canvis;

-- DELETE
delete from residu where nif_empresa = 'A-12100022';

select * from residu where nif_empresa = 'A-12100022';
select * from canvis;

