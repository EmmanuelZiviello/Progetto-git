# Progetto-Base di dati
Progetto per l'esame base di dati


In questa repository sono presenti diversi file SQL per creare e popolare una base di dati seguendo  i requisiti richiesti dalla traccia d'esame

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
