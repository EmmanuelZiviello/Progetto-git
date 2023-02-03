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

**Lavora_Su.SQL**
```
CREATE TABLE "Schema_Progetto".Lavora_Su
( CUP "Schema_Progetto"."CodiceP",
Cod_Lab "Schema_Progetto"."CodiceL",
Nome VARCHAR(20) , 
CONSTRAINT Lavora_SuPK PRIMARY KEY(CUP,Nome,Cod_Lab),
CONSTRAINT Lavora_SuFK1 FOREIGN KEY (Cod_Lab) REFERENCES  "Schema_Progetto".Laboratorio(Cod_Lab)  ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT Lavora_SuFK2 FOREIGN KEY (CUP,Nome) REFERENCES  "Schema_Progetto".Progetto(CUP,Nome)  ON UPDATE CASCADE ON DELETE CASCADE
);
```
Questo file ci permette di creare una tabella Lavora_Su nello schema creato in precedenza.La chiave primaria è composta da Cup,Nome e da Cod Lab.Gli attributi che formano la chiave primaria sono anche chiavi esterne delle tabelle Progetto e Laboratorio(infatti questa tabella serve come collegamento tra le due tabelle citate).
Le chiavi esterne hanno azioni ON UPDATE CASCADE e ON DELETE CASCADE.

**LavoroJunior.SQL**
```
CREATE TABLE "Schema_Progetto".LavoroJunior
( Cod_Lab "Schema_Progetto"."CodiceL" ,
Cod_Junior "Schema_Progetto"."CodiceF" ,
CONSTRAINT LavoroJuniorPK PRIMARY KEY(Cod_Lab,Cod_Junior),
CONSTRAINT LavoroJuniorFK1 FOREIGN KEY (Cod_Lab) REFERENCES  "Schema_Progetto".Laboratorio(Cod_Lab)  ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT LavoroJuniorFK2 FOREIGN KEY (Cod_Junior) REFERENCES  "Schema_Progetto".Junior(CF)  ON UPDATE CASCADE ON DELETE CASCADE
);
```
Questo file ci permette di creare una tabella LavoroJunior nello schema creato in precedenza.La chiave primaria è composta da Cod Lab e da Cod Junior,questi attributi sono anche chiavi esterne delle tabelle Laboratorio e Junior(questa tabella fa da collegamento tra le due appena citate).
Le chiavi esterne hanno azioni ON UPDATE CASCADE e ON DELETE CASCADE.

**LavoroMiddle.SQL**
```
CREATE TABLE "Schema_Progetto".LavoroMiddle
( Cod_Lab "Schema_Progetto"."CodiceL",
Cod_Middle "Schema_Progetto"."CodiceF" ,
CONSTRAINT LavoroMiddlePK PRIMARY KEY(Cod_Lab,Cod_Middle),
CONSTRAINT LavoroMiddleFK1 FOREIGN KEY (Cod_Lab) REFERENCES  "Schema_Progetto".Laboratorio(Cod_Lab)  ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT LavoroMiddleFK2 FOREIGN KEY (Cod_Middle) REFERENCES  "Schema_Progetto".Middle(CF)   ON UPDATE CASCADE ON DELETE CASCADE
);
```
Questo file ci permette di creare una tabella LavoroMiddle nello schema creato in precedenza.La chiave primaria è composta da Cod Lab e da Cod Middle,questi attributi sono anche chiavi esterne delle tabelle Laboratorio e Middle(questa tabella fa da collegamento tra le due appena citate).
Le chiavi esterne hanno azioni ON UPDATE CASCADE e ON DELETE CASCADE.

**LavoroSenior.SQL**
```
CREATE TABLE "Schema_Progetto".LavoroSenior
( Cod_Lab "Schema_Progetto"."CodiceL" ,
Cod_Senior "Schema_Progetto"."CodiceF" ,
CONSTRAINT LavoroSeniorPK PRIMARY KEY(Cod_Lab,Cod_Senior),
CONSTRAINT LavoroSeniorFK1 FOREIGN KEY (Cod_Lab) REFERENCES  "Schema_Progetto".Laboratorio(Cod_Lab)  ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT LavoroSeniorFK2 FOREIGN KEY (Cod_Senior) REFERENCES  "Schema_Progetto".Senior(CF)   ON UPDATE CASCADE ON DELETE CASCADE
);
```
Questo file ci permette di creare una tabella LavoroSenior nello schema creato in precedenza.La chiave primaria è composta da Cod Lab e da Cod Senior,questi attributi sono anche chiavi esterne delle tabelle Laboratorio e Senior(questa tabella fa da collegamento tra le due appena citate).
Le chiavi esterne hanno azioni ON UPDATE CASCADE e ON DELETE CASCADE.


**LavoroDirigente.SQL**
```
CREATE TABLE "Schema_Progetto".LavoroDirigente
( Cod_Lab "Schema_Progetto"."CodiceL" ,
Cod_Dirigente "Schema_Progetto"."CodiceF" ,
CONSTRAINT LavoroDirigentePK PRIMARY KEY(Cod_Lab,Cod_Dirigente),
CONSTRAINT LavoroDirigenteFK1 FOREIGN KEY (Cod_Lab) REFERENCES  "Schema_Progetto".Laboratorio(Cod_Lab)  ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT LavoroDirigenteFK2 FOREIGN KEY (Cod_Dirigente) REFERENCES  "Schema_Progetto".Dirigente(CF)   ON UPDATE CASCADE ON DELETE CASCADE
);
```
Questo file ci permette di creare una tabella LavoroDirigente nello schema creato in precedenza.La chiave primaria è composta da Cod Lab e da Cod Dirigente,questi attributi sono anche chiavi esterne delle tabelle Laboratorio e Dirigente(questa tabella fa da collegamento tra le due appena citate).
Le chiavi esterne hanno azioni ON UPDATE CASCADE e ON DELETE CASCADE.

**DirigenzaJunior.SQL**
```
CREATE TABLE "Schema_Progetto".DirigenzaJunior
( Cod_Dirigente "Schema_Progetto"."CodiceF" ,
Cod_Junior "Schema_Progetto"."CodiceF" ,
CONSTRAINT DirigenzaJuniorPK PRIMARY KEY(Cod_Dirigente,Cod_Junior),
CONSTRAINT DirigenzaJuniorFK1 FOREIGN KEY (Cod_Dirigente) REFERENCES  "Schema_Progetto".Dirigente(CF)  ON UPDATE CASCADE  ON DELETE CASCADE,
CONSTRAINT DirigenzaJuniorFK2 FOREIGN KEY (Cod_Junior) REFERENCES  "Schema_Progetto".Junior(CF)   ON UPDATE CASCADE ON DELETE CASCADE
);
```
Questo file ci permette di creare una tabella DirigenzaJunior nello schema creato in precedenza.La chiave primaria è composta da Cod Dirigente e da Cod Junior,questi attributi sono anche chiavi esterne delle tabelle Dirigente e Junior(questa tabella fa da collegamento tra le due appena citate).
Le chiavi esterne hanno azioni ON UPDATE CASCADE e ON DELETE CASCADE.

**DirigenzaMiddle.SQL**
```
CREATE TABLE "Schema_Progetto".DirigenzaMiddle
( Cod_Dirigente "Schema_Progetto"."CodiceF" ,
Cod_Middle "Schema_Progetto"."CodiceF" ,
CONSTRAINT DirigenzaMiddlePK PRIMARY KEY(Cod_Dirigente,Cod_Middle),
CONSTRAINT DirigenzaMiddleFK1 FOREIGN KEY (Cod_Dirigente) REFERENCES  "Schema_Progetto".Dirigente(CF)  ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT DirigenzaMiddleFK2 FOREIGN KEY (Cod_Middle) REFERENCES  "Schema_Progetto".Middle(CF)   ON UPDATE CASCADE ON DELETE CASCADE
);
```
Questo file ci permette di creare una tabella DirigenzaMiddle nello schema creato in precedenza.La chiave primaria è composta da Cod Dirigente e da Cod Middle,questi attributi sono anche chiavi esterne delle tabelle Dirigente e Middle(questa tabella fa da collegamento tra le due appena citate).
Le chiavi esterne hanno azioni ON UPDATE CASCADE e ON DELETE CASCADE.


**DirigenzaSenior.SQL**
```
CREATE TABLE "Schema_Progetto".DirigenzaSenior
( Cod_Dirigente "Schema_Progetto"."CodiceF",
Cod_Senior "Schema_Progetto"."CodiceF" ,
CONSTRAINT DirigenzaSeniorPK PRIMARY KEY(Cod_Dirigente,Cod_Senior),
CONSTRAINT DirigenzaSeniorFK1 FOREIGN KEY (Cod_Dirigente) REFERENCES  "Schema_Progetto".Dirigente(CF)  ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT DirigenzaSeniorFK2 FOREIGN KEY (Cod_Senior) REFERENCES  "Schema_Progetto".Senior(CF)   ON UPDATE CASCADE ON DELETE CASCADE
);
```
Questo file ci permette di creare una tabella DirigenzaSenior nello schema creato in precedenza.La chiave primaria è composta da Cod Dirigente e da Cod Senior,questi attributi sono anche chiavi esterne delle tabelle Dirigente e Senior(questa tabella fa da collegamento tra le due appena citate).
Le chiavi esterne hanno azioni ON UPDATE CASCADE e ON DELETE CASCADE.



**DirigenzaDirigente.SQL**
```
CREATE TABLE "Schema_Progetto".DirigenzaDirigente
( Cod_Dirigente "Schema_Progetto"."CodiceF" ,
Cod_Dirigente2 "Schema_Progetto"."CodiceF" ,
CONSTRAINT DirigenzaDirigentePK PRIMARY KEY(Cod_Dirigente,Cod_Dirigente2),
CONSTRAINT DirigenzaDirigenteFK1 FOREIGN KEY (Cod_Dirigente) REFERENCES  "Schema_Progetto".Dirigente(CF)  ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT DirigenzaDirigenteFK2 FOREIGN KEY (Cod_Dirigente2) REFERENCES  "Schema_Progetto".Dirigente(CF)  ON UPDATE CASCADE  ON DELETE CASCADE
);
```
Questo file ci permette di creare una tabella DirigenzaDirigenza nello schema creato in precedenza.La chiave primaria è composta da Cod Dirigente e da Cod Dirigente2,questi attributi sono anche chiavi esterne delle tabelle Dirigente e Dirigente(questa tabella fa da collegamento tra le due appena citate).
Le chiavi esterne hanno azioni ON UPDATE CASCADE e ON DELETE CASCADE.

**InserimentoJunior.SQL**
```
Insert INTO "Schema_Progetto".junior(cf,nome,cognome,anni_servizio)
VALUES ('AAAAAAAA','Pippo','Rosso',2),('BBBBBBBB','Pippo','Blu',1),('CCCCCCCC','Paperino','Verde',2),('BBCDFSHL','Paperoga','Esposito',2),('BZZSDFCB','Mario','Rossi',1),('NDCLJHFS','Luca','Brosio',2);
```
Inserimento valori nella tabella Junior.



**InserimentoMiddle.SQL**
```
Insert INTO "Schema_Progetto".junior(cf,nome,cognome,anni_servizio)
VALUES ('AAAAAAAA','Pippo','Rosso',2),('BBBBBBBB','Pippo','Blu',1),('CCCCCCCC','Paperino','Verde',2),('BBCDFSHL','Paperoga','Esposito',2),('BZZSDFCB','Mario','Rossi',1),('NDCLJHFS','Luca','Brosio',2);
```
Inserimento valori nella tabella Middle.



**InserimentoSenior.SQL**
```
Insert INTO "Schema_Progetto".senior(cf,nome,cognome,anni_servizio)
VALUES ('GGGGGGGG','Pippo','Nero',7),('HHHHHHHH','Pippo','Bianco',9),('IIIIIIII','Paperino','Neri',10),('GABSGGGG','Gabriele','Gambero',10),('HZXDSAHH','Amhed','Blanc',9),('AXLIIXSA','Juan','Fois',10);
```
Inserimento valori nella tabella Senior.



**InserimentoDirigente.SQL**
```
Insert INTO "Schema_Progetto".dirigente(cf,nome,cognome,anni_servizio)
VALUES ('JJJJJJJJ','Minnie','Provola',1),('KKKKKKKK','Minnie','Pizza',2),('LLLLLLLL','Pippo','Pasta',8),('JKRJJJJJ','John','Provolini',8),('KVBNKASD','Luca','Brodini',1),('WLSMT231','Will','Smith',5);
```
Inserimento valori nella tabella Dirigente.


**InserimentoLaboratorio.SQL**
```
Insert INTO "Schema_Progetto".laboratorio(cod_lab,cod_senior,topic,afferenti)
VALUES ('AB','GGGGGGGG','Java',15),('AC','GGGGGGGG','C',4),('BD','IIIIIIII','SQL',4),('BB','GGGGGGGG','Ricerche',1),('BS','GGGGGGGG','AI',2),('BE','IIIIIIII','ChatGPT',3);
```
Inserimento valori nella tabella Laboratorio.



**InserimentoProgetto.SQL**
```
Insert INTO "Schema_Progetto".progetto(cup,nome,cod_senior,cod_dirigente)
VALUES ('AAB','Dati_P','HHHHHHHH','JJJJJJJJ'),('AAC','Prog_P','HHHHHHHH','KKKKKKKK'),('AAD','SQL_P','GGGGGGGG','LLLLLLLL'),('ZAZ','AI_P','GGGGGGGG','LLLLLLLL'),('SAC','Lux_P','HHHHHHHH','KKKKKKKK'),('SUS','GPT_P','HHHHHHHH','LLLLLLLL');
```
Inserimento valori nella tabella Progetto.



**InserimentoLavoraSu.SQL**
```
INSERT INTO "Schema_Progetto".lavora_su(cod_lab,cup,nome)
VALUES ('AB','AAB','Dati_P'),('AC','AAB','Dati_P'),('BD','AAD','SQL_P'),('BS','AAB','Dati_P'),('AB','SUS','GPT_P'),('AC','SUS','GPT_P');
```
Inserimento valori nella tabella LavoraSu.



**InserimentoDirigenzaJunior.SQL**
```
Insert INTO "Schema_Progetto".dirigenzajunior(cod_dirigente,cod_junior)
VALUES ('JJJJJJJJ','AAAAAAAA'),('JJJJJJJJ','BBBBBBBB'),('KKKKKKKK','AAAAAAAA');
```
Inserimento valori nella tabella DirigenzaJunior.



**InserimentoDirigenzaMiddle.SQL**
```
Insert INTO "Schema_Progetto".dirigenzamiddle(cod_dirigente,cod_middle)
VALUES ('LLLLLLLL','DDDDDDDD'),('LLLLLLLL','FFFFFFFF'),('JJJJJJJJ','EEEEEEEE');
```
Inserimento valori nella tabella DirigenzaMiddle.



**InserimentoDirigenzaSenior.SQL**
```
Insert INTO "Schema_Progetto".dirigenzasenior(cod_dirigente,cod_senior)
VALUES ('JJJJJJJJ','IIIIIIII'),('JJJJJJJJ','HHHHHHHH'),('KKKKKKKK','GGGGGGGG');
```
Inserimento valori nella tabella DirigenzaSenior.



**InserimentoDirigenzaDirigente.SQL**
```
Insert INTO "Schema_Progetto".dirigenzadirigente(cod_dirigente,cod_dirigente2)
VALUES ('KKKKKKKK','JJJJJJJJ'),('LLLLLLLL','JJJJJJJJ'),('KKKKKKKK','KKKKKKKK');
```
Inserimento valori nella tabella DirigenzaDirigente.



**InserimentoLavoroJunior.SQL**
```
INSERT INTO "Schema_Progetto".lavorojunior(cod_junior,cod_lab)
VALUES ('AAAAAAAA','AB'),('BBBBBBBB','AC'),('AAAAAAAA','BD'),('BZZSDFCB','BB'),('BBCDFSHL','AC'),('NDCLJHFS','AB');
```
Inserimento valori nella tabella LavoroJunior.



**InserimentoLavoroMiddle.SQL**
```
INSERT INTO "Schema_Progetto".lavoromiddle(cod_middle,cod_lab)
VALUES ('DDDDDDDD','AB'),('DDDDDDDD','AC'),('EEEEEEEE','BD'),('DDDDDDDD','BS'),('DDDDDDDD','BE'),('EEEEEEEE','AB');
```
Inserimento valori nella tabella LavoroMiddle.



**InserimentoLavoroSenior.SQL**
```
INSERT INTO "Schema_Progetto".lavorosenior(cod_senior,cod_lab)
VALUES ('GGGGGGGG','AB'),('HHHHHHHH','AB'),('GGGGGGGG','BD'),('AXLIIXSA','AB'),('HZXDSAHH','AB'),('GABSGGGG','AB');
```
Inserimento valori nella tabella LavoroSenior.


**InserimentoLavoroDirigente.SQL**
```
INSERT INTO "Schema_Progetto".lavorodirigente(cod_dirigente,cod_lab)
VALUES ('JJJJJJJJ','AB'),('JJJJJJJJ','AC'),('LLLLLLLL','BD'),('WLSMT231','AB'),('KVBNKASD','AB'),('JKRJJJJJ','AB');
```
Inserimento valori nella tabella LavoroDirigente.


**SPIEGAZIONE TRIGGER  E PROCEDURE ANNESSE PRESENTE ANCHE NELLA DOCUMENTAZIONE ALLEGATA:**

**ControlloJunior.SQL**
```
CREATE TRIGGER "ControlloJunior"
    BEFORE INSERT ON "Schema_Progetto".junior
    FOR EACH ROW
    EXECUTE FUNCTION "Schema_Progetto"."ProControlloJunior"();
```
    
   Questo trigger viene eseguito prima dell'inserimento su Junior ed esegue la procedura ProControlloJunior.
   
   **ProControlloJunior.SQL**


```
   CREATE FUNCTION "Schema_Progetto"."ProControlloJunior"()
    RETURNS trigger
    LANGUAGE 'plpgsql'
     NOT LEAKPROOF
AS 
$$
DECLARE  
sql_smt VARCHAR(200);
cf_trovato "Schema_Progetto"."junior".cf%TYPE;

BEGIN
sql_smt:='SELECT cf FROM "Schema_Progetto".middle WHERE cf=$1';
EXECUTE sql_smt INTO cf_trovato USING NEW.cf;
IF cf_trovato=NEW.cf THEN 
RAISE EXCEPTION 'Codice Fiscale già presente 'USING ERRCODE='unique_violation';
END IF;

sql_smt:='SELECT cf FROM "Schema_Progetto".senior WHERE cf=$1';
EXECUTE sql_smt INTO cf_trovato USING NEW.cf;
IF cf_trovato=NEW.cf THEN 
RAISE EXCEPTION 'Codice Fiscale già presente ' USING ERRCODE='unique_violation';
END IF;

sql_smt:='SELECT cf FROM "Schema_Progetto".dirigente WHERE cf=$1';
EXECUTE sql_smt INTO cf_trovato USING NEW.cf;
IF cf_trovato=NEW.cf THEN 
RAISE EXCEPTION 'Codice Fiscale già presente 'USING ERRCODE='unique_violation';
END IF;

RETURN NEW;
END;
$$;

ALTER FUNCTION "Schema_Progetto"."ProControlloJunior"()
    OWNER TO postgres;
   ```
   Questa procedura verifica tramite delle semplici query se esiste un impiegato di una categoria diversa da Junior ma con lo stesso codice fiscale.
Se viene trovato un'impiegato di un altra categoria ma con lo stesso cf che si vorrebbe inserire in Junior(il trigger è before insert quindi per ora non c'è ancora una tupla in Junior con il NEW.cf)allora avviene un eccezione che stampa il messaggio:Codice Fiscale già presente.
Quindi lo scopo di questo trigger è di verificare l'unicità del codice fiscale che si vuole inserire in Junior.


**InsJ.SQL**
```
CREATE TRIGGER "InsJunior"
    AFTER INSERT ON "Schema_Progetto".junior
    FOR EACH ROW
	WHEN(NEW.anni_servizio>=3)
    EXECUTE FUNCTION "Schema_Progetto"."ProInsJunior"();
```
Questo trigger viene eseguito dopo l'inserimento su Junior con la condizione che gli anni inseriti siano >= 3(quindi quando gli anni di servizio del impiegato Junior sono diversi da quelli richiesti per essere nella sua categoria) ed esegue la procedura ProInsJunior.
