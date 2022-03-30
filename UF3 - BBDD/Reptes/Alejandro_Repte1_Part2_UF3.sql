-- Ej1 -----------------------------------------------------------------------------------------------------------------
/* 1. Crea un procediment, que li passaràs com a paràmetre el tipus de transport i un període de temps (imagina data d’
enviament entre el 15/01/2021 i 30/01/2021),  i et retornarà el nom de les empreses transportistes que han fet servir
aquest tipus de transport en el període indicat, la quantitat de Kms recorregut en aquest tipus de transport i  el cost
d’aquest transport. Per fer aquest procediment has de tenir en compte:
  a) Que la data d’inici no pot ser més petita que la data de fi. Per controlar-ho realitzaras una funció que darrerament
     cridaràs des del procediment.
  b) La gestió dels errors amb excepcions, en el cas de que el tipus de transport no existeix.
  c) Quan s’executi el procediment haurà de mostrar un missatge indicant “L’empresa a, amb CIF b, ha realitzat c Kms amb
     un cost d en tipus_transport, en el periode comprés entre e i f”. */
-- ---------------------------------------------------------------------------------------------------------------------

create or replace function comprovarData(fDate trasllat.data_enviament%type, sDate trasllat.data_enviament%type)
                           returns boolean language plpgsql as $$
begin
    if fDate > sDate then
        return true;
    else
        return false;
    end if;
end; $$;

create or replace function comprovarTran(tipTran trasllat_empresatransport.tipus_transport%type) returns boolean language plpgsql as $$
    begin
        select tipus_transport into strict tipTran from trasllat_empresatransport
        where upper(tipus_transport)=upper($1) limit 1;
        return true;
    exception
        when no_data_found then
            return false;
end; $$;

create or replace procedure tipusTransportInDate(tipusTransport trasllat_empresatransport.tipus_transport%type,
                                                 fDate trasllat.data_enviament%type,
                                                 sDate trasllat.data_enviament%type) language plpgsql as $$
declare
    comprovarData boolean := (select comprovarData(fDate, sDate));
    comprovarTran boolean := (select comprovarTran(tipusTransport));
    cursor1 cursor for select nom_emptransport, te.nif_emptransportista, kms, cost, tipusTransport from trasllat_empresatransport te
        join empresatransportista e on te.nif_emptransportista = e.nif_emptransportista
        where data_enviament between fDate and sDate
          and tipus_transport = tipusTransport;
begin
    if comprovarTran = false then
        raise exception 'ERROR: El transport % no existeix', tipusTransport;
    end if;
    if comprovarData = true then
        raise exception 'ERROR: La data d"inici % es major que la data de fi %', fDate, sDate;
    else
        for tipTran in cursor1
        loop
            raise notice 'L’empresa %, amb CIF %, ha realitzat % Kms amb un cost % en %, en el periode comprés entre % i %',
                tipTran.nom_emptransport, tipTran.nif_emptransportista, tipTran.kms, tipTran.cost, tipusTransport, fDate, sDate;
        end loop;
    end if;
    exception
        when no_data_found then
            raise exception 'Alguna dada no existeix';
end; $$;

call tipusTransportInDate(:tipusTransport, :fDate, :sDate);

-- Ej2 -----------------------------------------------------------------------------------------------------------------
/* Crea un procediment emmagatzemat que li passaràs el codi de residu i un període de temps i et retornarà els diferents
destins i les empreses productores que han generat aquest residu durant aquell temps.
Per fer aquest procediment has de tenir en compte:
    a) Que la data d’inici no pot ser més petita que la data de fi. Per controlar-ho realitzarem una funció que
       darrerament cridarem des del procediment.
    b) La gestió dels errors amb excepcions, en el cas de que el residu no existeix.
    c) Quan s’executi el procediment haurà de mostrar un missatge indicant “El redisu amb codi a, i amb nom  b, ha sigut
       generat per l’empresa amb nom  c i transportat al destí d (nom_desti), en el període comprés entre e i f”.
Aquest procediment el cridarem des de una consola. */
-- ---------------------------------------------------------------------------------------------------------------------

create or replace function comprovarResi(codRes residu.cod_residu%type) returns boolean language plpgsql as $$
    begin
        select cod_residu into strict codRes from residu
        where cod_residu=$1 limit 1;
        return true;
    exception
        when no_data_found then
            return false;
end; $$;

create or replace procedure codResiduInDate(codResidu residu.cod_residu%type,
                                            fDate trasllat.data_enviament%type,
                                            sDate trasllat.data_enviament%type) language plpgsql as $$
declare
    comprovarData boolean := (select comprovarData(fDate, sDate));
    comprovarResi boolean := (select comprovarResi(codResidu));
    cursor1 cursor for select distinct rc.cod_residu, nom_constituent, nom_empresa, nom_desti from trasllat_empresatransport tet
        join residu_constituent rc on tet.cod_residu = rc.cod_residu
        join constituent c on rc.cod_constituent = c.cod_constituent
        join empresaproductora ep on tet.nif_empresa = ep.nif_empresa
        join desti d on tet.cod_desti = d.cod_desti
        where data_enviament between fDate and sDate
          and rc.cod_residu = codResidu;
begin
    if comprovarResi = false then
        raise exception 'ERROR: El cod_residu % no existeix', codResidu;
    end if;
    if comprovarData = true then
        raise exception 'ERROR: La data d"inici % es major que la data de fi %', fDate, sDate;
    else
        for codRes in cursor1
            loop
                raise notice 'El redisu amb codi %, i amb nom %, ha sigutgenerat per l’empresa amb nom % i transportat al destí (%), en el període comprés entre % i %',
                    codRes.cod_residu, codRes.nom_constituent ,codRes.nom_empresa, codRes.nom_desti, fDate, sDate;
            end loop;
    end if;
    exception
        when no_data_found then
            raise exception 'Alguna dada no existeix';
end; $$;

call codResiduInDate(:codResidu, :fDate, :sDate);

-- Ej3 -----------------------------------------------------------------------------------------------------------------
/* Realitza un procediment que li passaràs per paràmetre un període de temps (data inici i data fi) i que et retornarà
les empreses transportistes que més vegades ha realitzat transports durant aquest període, és a dir les que han sigut
més vegades contractades. D’aquests trasllats, realitzats per les empreses transportistes transportistes  volem
actualitzar un 10% el valor del seu cost. Per fer aquest procediment has de tenir en compte:
    a) Que la data d’inici no pot ser més petita que la data de fi. Per controlar-ho realitzarem una funció que d
       arrerament cridarem des del procediment.
    b) La gestió dels errors amb excepcions.
    c) Has de fer un cursor d’atualització.
    d) Quan s’executi el procediment haurà de mostrar un missatge indicant quin són el transports i els imports actualitzats.*/
-- ---------------------------------------------------------------------------------------------------------------------



-- Ej4 -----------------------------------------------------------------------------------------------------------------
/* Volem crear un procediment per inserir registres a la taula residu. Per fer aquest exercici has de tenir en compte:
    a) Has de controlar que abans d’inserir un nou registre, no existeix. Has de fer una funció per comprovar-ho que
       després cridaràs des del procediment.
    b) Has de controlar els possibles errors, amb les excepcions que consideris.
    c) En el cas que tot sigui correcte, realitzaràs un commit, en cas contrari la transacció no es podrà dur a terme i
       donaràs un missatge d’error o bé d'èxit.
    d) Has de tenir en compte les foreign key i els not null. */
-- ---------------------------------------------------------------------------------------------------------------------

create or replace function comprovarRegistreResiduCreat() returns boolean language plpgsql as $$
declare
begin

end; $$;

create or replace procedure insertarDades() language plpgsql as $$
declare
begin

end; $$;
