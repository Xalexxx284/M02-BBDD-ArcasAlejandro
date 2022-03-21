-- Ej1 -----------------------------------------------------------------------------------------------------------------
/* Programar un procediment anomenat insertardept_tran que insereix un nou departament tenint en compte les següents observacions:  
a) L’usuari introduirà el nom del departament, el cap (manager) i el codi de la localitat.
b) El codi del departament serà la desena següent al número més gran de la taula. 
c) S’ha de gestionar possibles errors. 
d) S’ha de gestionar la transacció, desant o desfent els canvis.*/
-- ---------------------------------------------------------------------------------------------------------------------



-- Ej2 -----------------------------------------------------------------------------------------------------------------
/* Programar un procediment anomenat insertaremp_tran que rebi totes les dades d’un nou empleat i processi la transacció
d’alta. S’ha de tenir en compte les següents observacions: 
a) L’usuari introduirà les dades corresponents. En cas de que els camps que són obligatoris no siguin introduïts per 
   l’usuari s’ha de donar el missatge corresponent i aturar la inserció corresponent desfent els canvis. 
b) S’ha de gestionar possibles errors. 
c) S’ha de gestionar la transacció, desant o desfent els canvis. 
d) Programar un script per a comprovar que funciona el procediment.*/
-- ---------------------------------------------------------------------------------------------------------------------



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



-- Ej4 -----------------------------------------------------------------------------------------------------------------
/* Programar un procediment anomenat borraremp_tran que esborri un empleat on el codi de l’empleat se li passarà com a 
paràmetre. Al procediment s’ha de comprovar si existeix o no l’empleat. S’ha de tenir en compte les següents observacions: 
a) L’usuari ha d’introduir el codi de l’empleat. Aquest valor se li passarà com a paràmetre al procediment. 
b) Per a comprovar si existeix o no l’empleat, es farà mitjançant una funció anomenada buscar_emp (que pot ser ja està creada). 
c) S’ha de gestionar possibles errors. A més, si existeix l’empleat esborrar-lo i sinó donar el missatge corresponent. 
d) S’ha de gestionar la transacció, desant o desfent els canvis. 
e) Programar un script per a comprovar que funciona el procediment.*/
-- ---------------------------------------------------------------------------------------------------------------------
