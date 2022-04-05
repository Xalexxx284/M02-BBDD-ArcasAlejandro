-- Ej1 -----------------------------------------------------------------------------------------------------------------
/* Volem crear un trigger que llançarà una excepció cada vegada que  actualitzem la quantitat de residu de la taula residu.
    a) Si la quantitat és més petita que l’actual, haurà de sortir un missatge que indiqui “La quantitat nova
    quantitat_nova no pot ser més petita que la quantitat actual quantitat_actual”. Aquest missatge fa referència a l’excepció.
    b) Has de crear un funció de trigger, que llançarà l’excepció.
    c) Has de crear un trigger de tipus BEFORE i  row-level per l'operació UPDATE.
    d) Has d’aportar les ordres per comprovar el funcionament del disparador. */
-- ---------------------------------------------------------------------------------------------------------------------



-- Ej2 -----------------------------------------------------------------------------------------------------------------
/* Crearem tres triggers, un per automatizar l’actualització d’un registre a la taula residu, un altre que no permet
esborrar cap registre de la taula residu i un altre per enregistrar els canvis.
    a) Aquests triggers estan associats a una taula i amb una funció de trigger.
    b) La funció  trigger update_dades () et permetrà actualitzar el camp toxicitat de la taula residu.
        i) Si la quantitat a actualitzar és més gran que la que hi ha.
    c) La funció no_esborrar_dades() s’encarregarà de no permetre esborrar cap dada d’una taula concreta.
    d) La funció registrar_canvis () de tipus statement-level que s'executarà després de les sentències INSERT, UPDATE i
    DELETE. La funció executada per aquest trigger deixarà dades de l'execució a la taula canvis.*/
-- ---------------------------------------------------------------------------------------------------------------------

