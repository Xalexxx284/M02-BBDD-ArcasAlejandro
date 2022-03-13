-- Ej1 -----------------------------------------------------------------------------------------------------------------
/* Programar un bloc principal i un procediment per a consultar les dades de l’empleat. El codi de l’empleat s’introduirà
per teclat. El bloc anònim preguntarà a l’usuari i cridarà al procediment passant al paràmetre 	corresponent. El procediment
consultaràla taula empleat i recuperarà les següents dades: nom, salari, comissió, ofici i cap. En cas de que la comissió
sigui nul·la, ha d’aparèixer 0 i no en blanc. El procediment s’anomenarà imprimir_dades. A més, s’ha de controlar si existeix
o no l’empleat a la base de dades. */
-- ---------------------------------------------------------------------------------------------------------------------



-- Ej2 -----------------------------------------------------------------------------------------------------------------
/* Programar el mateix exercici que l’anterior  però ara el subprograma serà una funció anomenarà retornar_dades. La funció
no imprimirà cap dada, sinó que retornarà una variable de tipus registre.S’ha de controlar els possibles errors (com abans) 
però ara a la funció. */
-- ---------------------------------------------------------------------------------------------------------------------



-- Ej3 -----------------------------------------------------------------------------------------------------------------
/* Realitzar un programa que ens indiqui si existeix o no el departament a la nostra base de dades. S’ha de tenir en compte
els següents aspectes: el codi del departament ho introduirà l’usuari per teclat. per comprovar si existeix o no el 
departament, s’ha de programar una funció anomenada COMPROVAR_DEPT. A aquesta funció se li passarà per paràmetre des del 
bloc principal el codi del departament a comprovar. el missatge que s’ha de mostrar és el següent: “EXISTEIX DEPARTAMENT”
o “NO EXISTEIX DEPARTAMENT”. */
-- ---------------------------------------------------------------------------------------------------------------------



-- Ej4 -----------------------------------------------------------------------------------------------------------------
/* Realitzar un programa que insereixi les dades d’un departament a la taula corresponent. Aquestes dades les ha d’intr
oduir l’usuari per teclat. Abans d’inserir el departament, s’ha de comprovar si existeix o no el departament a la base de
dades (per fer aquesta comprovació ens ajudarem de la funció que s’ha creat a l’exercici anterior, COMPROVAR_DEPT).*/
-- ---------------------------------------------------------------------------------------------------------------------



-- Ej5 -----------------------------------------------------------------------------------------------------------------
/* Realitzar un programa  que modifiqui la taula DEPT on el codi del departament coincideixi amb el que s’introdueixi per
teclat i desar els canvis. Controlar les excepcions corresponents, és a dir, si no existeix el departament o qualsevol
altre error. */
------------------------------------------------------------------------------------------------------------------------



-- Ej6 -----------------------------------------------------------------------------------------------------------------
/* Realitzar un programa  que pregunti a l’usuari el codi de l’empleat per tal de retornar el nom de l’empleat. El nom 
de l’empleat ho retornarà una funció que es crearà anomenada NOM. A aquesta funció se li passarà per paràmetre el codi de
l’empleat que l’usuari ha introduït per teclat. A més, s’ha de controlar els errors al bloc anònim. */
------------------------------------------------------------------------------------------------------------------------



-- Ej7 -----------------------------------------------------------------------------------------------------------------
/* Realitzar un programa  que ens comprovi si un departament existeix o no a la taula corresponent, consultant pel codi 
del departament. En cas d’existir el departament s’ha d’imprimir per pantalla i s’ha de comprovar si comença o no per la 
lletra A. Si comença per la lletra A, després d’imprimir el nom del departament, ha de dir, COMENÇA PER LA LLETRA A.
S’ha de programar les següents excepcions:
· Si no hi ha dades, s’ha de retornar: “ERROR: no dades”.
· Si retorna més d’una fila: “ERROR: retorna més files”
· Qualsevol altre error: “ERROR (sense definir)”.*/
------------------------------------------------------------------------------------------------------------------------
