-- Ej1 -----------------------------------------------------------------------------------------------------------------
/* Crea una funció esmentada ciutat_desti que donat un període de temps ens indiqui quina ha sigut la ciutat de destí que
menys residus ha rebut durant aquest període i quin és aquesta quantitat. Aquesta funció és cridarà des de un procediment
emmagatzemat, esmentat printar_ciutat_destí, que haurà de mostrar un missatge indicant “La ciutat de destí que menys
residus ha rebut durant el periode comprés entre a i b, és nom_ciutat i la quantitat és quantitat_total’”
Aquest procediment el cridarem des de una consola. */
-- ---------------------------------------------------------------------------------------------------------------------

create type dadaResidus as (
    nom_ciutat varchar(50),
    quantitat_total numeric );

create or replace function citutat_desti(fDate date, sDate date) returns dadaResidus language plpgsql as $$
declare
    dadaResidus dadaResidus;
begin
    select d.ciutat_desti, sum(quantitat_trasllat) into dadaResidus from desti d
    join trasllat t on d.cod_desti = t.cod_desti
    where data_enviament between fDate and sDate
    group by d.ciutat_desti
    having sum(quantitat_trasllat) = (select min(a) from (select sum(quantitat_trasllat) as a from desti d
    join trasllat t on d.cod_desti = t.cod_desti
    where t.data_enviament between fDate and sDate
    group by d.ciutat_desti) as b);
    return dadaResidus;
end; $$;

create or replace procedure printar_ciutat_desti(fDate date, sDate date)  language plpgsql as $$
declare
    result dadaResidus := (select citutat_desti(fDate, sDate));
begin
    raise notice 'La ciutat de destí que menys
residus ha rebut durant el periode comprés entre % i %, és % i la quantitat és %', fDate, sDate, result.nom_ciutat,
                                                                                   result.quantitat_total;
end; $$;

call printar_ciutat_desti(:fDate, :sDate);


-- Ej2 -----------------------------------------------------------------------------------------------------------------
/* Crea un procediment emmagatzemat esmentat emp_prod_max que mostri l’empresa productora que genera més residus tòxics.
Aquest procediment haurà de mostrar un missatge indicant “L’empresa productura que més residus genera és nif_empresa,
nom_empresa, la toxicitat d’aquest productes és toxicitat i la quantitat quantitat_total’
Aquest procediment el cridarem des de una consola. */
-- ---------------------------------------------------------------------------------------------------------------------

create or replace procedure emp_prod_max() language plpgsql as $$
declare
    empProd empresaproductora%rowtype;
    idToxicitat residu.toxicitat%type;
    quantitat_total numeric;
begin
    select emp.nif_empresa, emp.nom_empresa, r.toxicitat, sum(quantitat_residu)
    into empProd.nif_empresa, empProd.nom_empresa, idToxicitat, quantitat_total from empresaproductora emp
    join residu r on emp.nif_empresa = r.nif_empresa
    group by emp.nif_empresa, emp.nom_empresa, r.toxicitat
    having sum(quantitat_residu) = (select max(a) from (select sum(quantitat_residu) as a from empresaproductora emp
    join residu r on emp.nif_empresa = r.nif_empresa
    group by emp.nif_empresa, emp.nom_empresa, r.toxicitat) as b);
    raise notice 'La empresa productura que més residus genera és %,
%, la toxicitat d’aquest productes és % i la quantitat %', empProd.nif_empresa, empProd.nom_empresa, idToxicitat, quantitat_total;
end; $$;

call emp_prod_max();


-- Ej3 -----------------------------------------------------------------------------------------------------------------
/* Crea una funció esmentada emp_transportistat que donat un període de temps ens indiqui quina ha sigut l’empresa
transportista que més Km ha recorregut durant aquest període. Aquesta funció és cridarà des de un procediment emmagatzemat,
esmentat printar_emp_transportista que haurà de mostrar un missatge indicant “L’empresa amb CIF cif_emp_transportista i
amb nom nom_emp_transportista, ha recorregut quantitat_kms de kms durant el període periode”
Aquest procediment el cridarem des de una consola. */
-- ---------------------------------------------------------------------------------------------------------------------

create type kmsEmpresa as (
    cif_emp_transportista varchar(50),
    nom_emp_transportista varchar(50),
    quantitat_kms numeric );

create or replace function emp_transportistat(fDate date, sDate date) returns kmsEmpresa language plpgsql as $$
declare
    kmsEmpresa kmsEmpresa;
begin
    select et.nif_emptransportista, nom_emptransport, sum(kms) into kmsEmpresa from empresatransportista et
    join trasllat_empresatransport tet on et.nif_emptransportista = tet.nif_emptransportista
    where data_enviament between fDate and sDate
    group by et.nif_emptransportista, nom_emptransport
    having sum(kms) = (select max(a) from (select sum(kms) as a from empresatransportista et
    join trasllat_empresatransport tet on et.nif_emptransportista = tet.nif_emptransportista
    where tet.data_enviament between fDate and sDate
    group by et.nif_emptransportista) as b);
    return kmsEmpresa;
end; $$;

create or replace procedure printar_emp_transportista(fDate date, sDate date) language plpgsql as $$
declare
    result kmsEmpresa := (select emp_transportistat(fDate, sDate));
begin
    raise notice 'La empresa amb CIF % i
amb nom %, ha recorregut % de kms durant el període % i %', result.cif_emp_transportista, result.nom_emp_transportista,
                                                        result.quantitat_kms, fDate, sDate;
end; $$;

call printar_emp_transportista(:fDate, :sDate);


-- Ej4 -----------------------------------------------------------------------------------------------------------------
/* Crea una funció esmentada tract_residu  que donat un tipus de tractament ens indicarà el destí, la ciutat de destí, el
nom de l’empresa productora i el tipus d’envàs que han fet servir les empreses productores que han traslladat la màxima
quantitat de residus fent servir aquest tipus de tractament. Aquesta funció és cridarà des de un procediment emmagatzemat,
esmentat printar_tract_residu que haurà de mostrar un missatge indicant “L’empresa amb CIF cif_emp_productora i amb
nom nom_emp_productora, ha traslladat al destí nom_desti ubicat en ciutat_desti en l’envàs tipus_envàs, el residu amb
tractament tipus_residu”
Aquest procediment el cridarem des de una consola. */
-- ---------------------------------------------------------------------------------------------------------------------

create type dadaTractament as (
    cif_emp_productora varchar(50),
    nom_emp_productora varchar(50),
    nom_desti varchar(50),
    tipus_envas varchar(50),
    tipus_residu varchar(50) );

create or replace function tract_residu(trasllat.tractament%type) returns dadaTractament language plpgsql as $$
declare
    dadaTractament dadaTractament;
    tractament
begin

end; $$;

-- Ej5 -----------------------------------------------------------------------------------------------------------------
/* Crea un procediment esmentat quantitat_residus que li passaràs un codi de destí i un any (sencer, per exemple 2016) i ens
retornarà la quantitat  de residus que s'han traslladat a aquell destí durant aquell any. Per fer aquest exercici et
proposo realitzar una funció (per calcular l'any) i  un procediment anomenat printar_q_residus  que mostrarà el següent
missatge “La quantitat de residus que s’ha traslladat durant l’any any_introduit és quantitat_residu i el destí ciutat_destí”
Aquest procediment el cridarem des de una consola. */
-- ---------------------------------------------------------------------------------------------------------------------

