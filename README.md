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
Questo file  permette di creare una tabella Junior nello schema creato in precedenza.CF è la chiave primaria e rappresenta un codice fiscale.Inoltre ogni attributo è NOT NULL perchè non si vuole avere un impiegato senza questi valori(es:avere un impiegato senza nome e cognome oppure senza anni di servizio non sarebbe adatto per ciò che la base di dati deve svolgere).

**Middle.SQL**
```
CREATE TABLE "Schema_Progetto".Middle
( CF "Schema_Progetto"."CodiceF",
Nome VARCHAR(8) NOT NULL,
Cognome VARCHAR(14) NOT NULL,
Anni_Servizio INTEGER NOT NULL,
CONSTRAINT MiddlePK PRIMARY KEY(CF)
);
```
Questo file  permette di creare una tabella Middle nello schema creato in precedenza.CF è la chiave primaria e rappresenta un codice fiscale.Inoltre ogni attributo è NOT NULL perchè non si vuole avere un impiegato senza questi valori(es:avere un impiegato senza nome e cognome oppure senza anni di servizio non sarebbe adatto per ciò che la base di dati deve svolgere).

**Senior.SQL**:
```
CREATE TABLE "Schema_Progetto".Senior
( CF "Schema_Progetto"."CodiceF",
Nome VARCHAR(8) NOT NULL,
Cognome VARCHAR(14) NOT NULL,
Anni_Servizio INTEGER NOT NULL,
CONSTRAINT SeniorPK PRIMARY KEY(CF)
);
```
Questo file  permette di creare una tabella Senior nello schema creato in precedenza.CF è la chiave primaria e rappresenta un codice fiscale.Inoltre ogni attributo è NOT NULL perchè non si vuole avere un impiegato senza questi valori(es:avere un impiegato senza nome e cognome oppure senza anni di servizio non sarebbe adatto per ciò che la base di dati deve svolgere).



**Dirigente.SQL**:
```
CREATE TABLE "Schema_Progetto".Dirigente
( CF "Schema_Progetto"."CodiceF",
Nome VARCHAR(8) NOT NULL,
Cognome VARCHAR(14) NOT NULL,
Anni_Servizio INTEGER NOT NULL,
CONSTRAINT DirigentePK PRIMARY KEY(CF)
);
```
Questo file  permette di creare una tabella Dirigente nello schema creato in precedenza.CF è la chiave primaria e rappresenta un codice fiscale.Inoltre ogni attributo è NOT NULL perchè non si vuole avere un impiegato senza questi valori(es:avere un impiegato senza nome e cognome oppure senza anni di servizio non sarebbe adatto per ciò che la base di dati deve svolgere).

**Laboratorio.SQL**

```
CREATE TABLE "Schema_Progetto".Laboratorio
( Cod_Lab "Schema_Progetto"."CodiceL",
Cod_Senior "Schema_Progetto"."CodiceF" NOT NULL,
Topic VARCHAR(18) NOT NULL, 
Afferenti INTEGER NOT NULL,
CONSTRAINT LabPK PRIMARY KEY(Cod_Lab),
CONSTRAINT LabFK FOREIGN KEY (Cod_Senior) REFERENCES  "Schema_Progetto".Senior(CF)  ON UPDATE CASCADE ON DELETE CASCADE
);
```
Questo file permette di creare una tabella Laboratorio nello schema creato in precedenza.Cod lab è la chiave primaria e rappresenta un codice di laboratorio.Inoltre ogni attributo è NOT NULL perchè non si vuole avere un laboratorio senza questi valori(un laboratorio DEVE avere un topic,un referente scientifico e degli afferenti).
Cod Senior è una chiave esterna che lega questa tabella a Senior con azioni ON UPDATE CASCADE e ON DELETE CASCADE.

**Progetto.SQL**
```
CREATE TABLE "Schema_Progetto".Progetto
( CUP "Schema_Progetto"."CodiceP" ,
Cod_Senior "Schema_Progetto"."CodiceF" NOT NULL,
Cod_Dirigente "Schema_Progetto"."CodiceF" NOT NULL, 
Nome VARCHAR(20) , 
CONSTRAINT ProPK PRIMARY KEY(CUP,Nome),
CONSTRAINT nome_unico UNIQUE(Nome),--la chiave primaria è composta quindi senza questo vincolo sarebbe possibile avere progetti con cup diverso ma con il nome uguale -ma è richiesto che ogni nome sia presente solo una volta nel database
CONSTRAINT ProFK1 FOREIGN KEY (Cod_Senior) REFERENCES  "Schema_Progetto".Senior(CF)  ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT ProFK2 FOREIGN KEY (Cod_Dirigente) REFERENCES  "Schema_Progetto".Dirigente(CF)  ON UPDATE CASCADE ON DELETE CASCADE
);
```
Questo file ci permette di creare una tabella Progetto nello schema creato in precedenza.La chiave primaria è composta da CUP e da Nome.Nome ha un vincolo di unicità perchè la chiave è composta(quindi senza questo vincolo di unicità ci potevano essere progetti con CUP diverso ma con lo stesso nome ma i requisiti specificano che ogni nome dev'essere presente solo una volta nel sistema).Cod Senior e Cod Dirigente sono chiavi esterne che legano questa tabella a Senior e a Dirigente con azioni ON UPDATE CASCADE e ON DELETE CASCADE.Ogni attributo è NOT NULL perchè le chiavi esterne devono essere avere un valore in ogni tupla della tabella.

