# Progetto-Base di dati
Progetto per l'esame base di dati


In questa repository sono presenti diversi file SQL per creare e popolare una base di dati seguendo  i requisiti richiesti dalla traccia d'esame

**Schema_Progetto.SQL**:
```
CREATE SCHEMA "Schema_Progetto"
    AUTHORIZATION postgres;
```
Questo file serve per la creazione dello schema del database che verrà utilizzato. 


**CodiceF.SQL**:
```
CREATE DOMAIN "Schema_Progetto"."CodiceF"
    AS character(8);

ALTER DOMAIN "Schema_Progetto"."CodiceF" OWNER TO postgres;
```
Questo file serve per creare il dominio per il tipo del codice fiscale degli impiegati.


**CodiceP.SQL**:
```
CREATE DOMAIN "Schema_Progetto"."CodiceP"
    AS character(3);

ALTER DOMAIN "Schema_Progetto"."CodiceP" OWNER TO postgres;
```
Questo file serve per creare il dominio per il tipo del CUP dei progetti.

**CodiceL.SQL**
```
CREATE DOMAIN "Schema_Progetto"."CodiceL"
    AS character(2);

ALTER DOMAIN "Schema_Progetto"."CodiceL" OWNER TO postgres;
```
Questo file serve per creare il dominio per il tipo del codice dei laboratori.


**Junior.SQL**:
```
CREATE TABLE "Schema_Progetto".Junior
( CF "Schema_Progetto"."CodiceF",
Nome VARCHAR(8) NOT NULL,
Cognome VARCHAR(14) NOT NULL,
Anni_Servizio INTEGER NOT NULL,
CONSTRAINT JuniorPK PRIMARY KEY(CF)
);
```
Questo file  permette di creare una tabella Junior nello schema creato in precedenza.CF è la chiave primaria e rappresenta un codice fiscale ed inoltre ogni attributo è NOT NULL perchè non si vuole avere un impiegato senza questi valori(es:avere un impiegato senza nome e cognome oppure senza anni di servizio non sarebbe adatto per ciò che la base di dati deve svolgere)
