-- Ej1 -----------------------------------------------------------------------------------------------------------------
/* Crea una funció esmentada ciutat_desti que donat un període de temps ens indiqui quina ha sigut la ciutat de destí que
menys residus ha rebut durant aquest període i quin és aquesta quantitat. Aquesta funció és cridarà des de un procediment
emmagatzemat, esmentat printar_ciutat_destí, que haurà de mostrar un missatge indicant “La ciutat de destí que menys
residus ha rebut durant el periode comprés entre a i b, és nom_ciutat i la quantitat és quantitat_total’” 
Aquest procediment el cridarem des de una consola. */
-- ---------------------------------------------------------------------------------------------------------------------



-- Ej2 -----------------------------------------------------------------------------------------------------------------
/* Crea un procediment emmagatzemat esmentat  emp_prod_max que mostri l’empresa productora que genera més residus tòxics.
Aquest procediment haurà de mostrar un missatge indicant “L’empresa productura que més residus genera és nif_empresa, 
nom_empresa, la toxicitat d’aquest productes és toxicitati la quantitat quantitat_total’ 
Aquest procediment el cridarem des de una consola. */
-- ---------------------------------------------------------------------------------------------------------------------



-- Ej3 -----------------------------------------------------------------------------------------------------------------
/* Crea una funció esmentada emp_transportistat que donat un període de temps ens indiqui quina ha sigut l’empresa 
transportista que més Km ha recorregut durant aquest període. Aquesta funció és cridarà des de un procediment emmagatzemat,
esmentat printar_emp_transportista que haurà de mostrar un missatge indicant “L’empresa amb CIF cif_emp_transportista i 
amb nom nom_emp_transportista, ha recorregut quantitat_kms de kms durant el període periode”
Aquest procediment el cridarem des de una consola. */
-- ---------------------------------------------------------------------------------------------------------------------

create or replace function emp_transportistat(fDate trasllat_empresatransport.data_enviament%type, sDate trasllat_empresatransport.data_enviament%type)
returns trasllat_empresatransport.kms%type as $$
declare

begin
    select t.data_enviament, t.data_enviament
    into v_fDate, v_sDate from trasllat t
    join trasllat_empresatransport te on t.nif_empresa = te.nif_empresa and t.cod_residu = te.cod_residu
                                             and t.data_enviament = te.data_enviament and t.cod_desti = te.cod_desti;
    raise notice 'fecha 1 % fecha 2 %', v_fDate, v_sDate;
end; $$ language plpgsql;

drop function emp_transportistat(fDate date, sDate date);

create or replace procedure printar_emp_transportista() language plpgsql as $$
declare
begin
end; $$;

-- Ej4 -----------------------------------------------------------------------------------------------------------------
/* Crea una funció esmentada tract_residu  que donat un tipus de tractament ens indicarà el destí, la ciutat de destí, el
nom de l’empresa productora i el tipus d’envàs que han fet servir les empreses productores que han traslladat la màxima
quantitat de residus fent servir aquest tipus de tractament. Aquesta funció és cridarà des de un procediment emmagatzemat,
esmentat printar_tract_residu que haurà de mostrar un missatge indicant “L’empresa amb CIF cif_emp_productora i amb 
nom nom_emp_productora, ha traslladat al destí nom_desti ubicat en ciutat_desti en l’envàs tipus_envàs, el residu amb
tractament tipus_residu”
Aquest procediment el cridarem des de una consola. */
-- ---------------------------------------------------------------------------------------------------------------------



-- Ej5 -----------------------------------------------------------------------------------------------------------------
/* Crea un procediment esmentat quantitat_residus que li passaràs un codi de destí i un any (sencer, per exemple 2016) i ens
retornarà la quantitat  de residus que s'han traslladat a aquell destí durant aquell any. Per fer aquest exercici et 
proposo realitzar una funció (per calcular l'any) i  un procediment anomenat printar_q_residus  que mostrarà el següent
missatge “La quantitat de residus que s’ha traslladat durant l’any any_introduit és quantitat_residu i el destí ciutat_destí”
Aquest procediment el cridarem des de una consola. */
-- ---------------------------------------------------------------------------------------------------------------------


