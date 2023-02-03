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



**ProInsJ.SQL**
```
CREATE FUNCTION "Schema_Progetto"."ProInsJunior"()
    RETURNS trigger
    LANGUAGE 'plpgsql'
     NOT LEAKPROOF
AS 
$$
BEGIN
DELETE FROM "Schema_Progetto".junior WHERE cf=NEW.cf;
IF (NEW.anni_servizio<7) THEN 
INSERT INTO "Schema_Progetto".middle(cf,nome,cognome,anni_servizio) VALUES(NEW.cf,NEW.nome,NEW.cognome,NEW.anni_servizio);
END IF;
IF (NEW.anni_servizio>=7) THEN 
INSERT INTO "Schema_Progetto".senior(cf,nome,cognome,anni_servizio) VALUES(NEW.cf,NEW.nome,NEW.cognome,NEW.anni_servizio);
END IF;
RETURN NEW;
END;
$$;

ALTER FUNCTION "Schema_Progetto"."ProInsJunior"()
    OWNER TO postgres;
```
Questa procedura cancella la tupla appena inserita su Junior(in PostgreSQL non è possibile creare una procedura che gestisca anche l'andamento delle transazioni del database con commit e rollback manuali quindi si è optato per realizzare quest'azione manualmente con un trigger AFTER INSERT ed un'operazione DELETE)e verifica quanti sono gli anni di servizio dell'impiegato.
Se l'impiegato lavorava da meno di 7 anni allora i suoi dati vengono inseriti come tupla di Middle mentre se gli anni sono almeno 7 allora i dati sono vengono inseriti come tupla di Senior.
Lo scopo di questo trigger è quello di gestire gli inserimenti in Junior con anni diversi da quelli richiesti per essere in questa categoria ed effettuare l'inserimento nella categoria corretta.

**ScattiCarrieraJ.SQL**

```
CREATE TRIGGER "ScattiCarrieraJ"
    AFTER UPDATE OF anni_servizio
    ON "Schema_Progetto".junior
    FOR EACH ROW
    WHEN (NEW.anni_servizio>=3)
    EXECUTE FUNCTION "Schema_Progetto"."ProScattiJ"();
```


Questo trigger viene eseguito dopo aver aggiornato il valore degli anni su Junior con la condizione che il nuovo valore degli anni sia >=3(quindi diversi da quelli richiesti per essere nella categoria Junior)ed esegue la procedura ProScattiJ.

**ProScattiJ.SQL**

```
CREATE FUNCTION "Schema_Progetto"."ProScattiJ"()
    RETURNS trigger
    LANGUAGE 'plpgsql'
     NOT LEAKPROOF
AS 
$$
DECLARE
sql_smt VARCHAR(200);
cursore1 refcursor;
dirigente_trovato "Schema_Progetto"."dirigente".cf%TYPE;
lab_trovato "Schema_Progetto"."laboratorio".cod_lab%TYPE;
tmp_trovato "Schema_Progetto"."dirigente".cf%TYPE;
tmp2_trovato "Schema_Progetto"."laboratorio".cod_lab%TYPE;

BEGIN
sql_smt:='CREATE TABLE "Schema_Progetto".TMP
( Cod_Dirigente "Schema_Progetto"."CodiceF",
CONSTRAINT TMP_PK PRIMARY KEY(Cod_Dirigente)
) ';
EXECUTE sql_smt;
sql_smt:='CREATE TABLE "Schema_Progetto".TMP2
( Cod_Lab "Schema_Progetto"."CodiceL",
CONSTRAINT TMP2_PK PRIMARY KEY(Cod_Lab)
) ';
EXECUTE sql_smt;
IF(NEW.Anni_Servizio<7) THEN 

--prima di cancellare salvare i suoi dirigenti e i suoi laboratori

sql_smt='SELECT cod_dirigente FROM "Schema_Progetto".dirigenzajunior WHERE cod_junior=$1';
OPEN cursore1 FOR  EXECUTE sql_smt USING NEW.cf;--tutti i dirigenti dell'impiegato
LOOP
FETCH cursore1 INTO dirigente_trovato;
EXIT WHEN NOT FOUND;
sql_smt='INSERT INTO "Schema_Progetto".TMP(Cod_Dirigente) VALUES($1)';
EXECUTE sql_smt USING dirigente_trovato;
END LOOP;
CLOSE cursore1;


sql_smt='SELECT cod_lab FROM "Schema_Progetto".lavorojunior WHERE cod_junior=$1';
OPEN cursore1 FOR  EXECUTE sql_smt USING NEW.cf;--tutti i laboratori dell'impiegato
LOOP
FETCH cursore1 INTO lab_trovato;
EXIT WHEN NOT FOUND;
sql_smt='INSERT INTO "Schema_Progetto".TMP2(Cod_Lab) VALUES($1)';
EXECUTE sql_smt USING lab_trovato;
END LOOP;
CLOSE cursore1;


DELETE FROM "Schema_Progetto".junior WHERE junior.cf=NEW.cf; 

INSERT INTO "Schema_Progetto".middle(nome,cognome,cf,anni_servizio)
VALUES(NEW.nome,NEW.cognome,NEW.cf,NEW.anni_servizio);


sql_smt:='SELECT Cod_Dirigente FROM "Schema_Progetto".TMP';
OPEN cursore1 FOR  EXECUTE sql_smt;
LOOP
FETCH cursore1 INTO tmp_trovato;
EXIT WHEN NOT FOUND;
sql_smt:='INSERT INTO "Schema_Progetto".dirigenzamiddle(cod_dirigente,cod_middle) 
VALUES($1,$2)';
EXECUTE sql_smt USING tmp_trovato,NEW.cf;

END LOOP;
CLOSE cursore1;
sql_smt:='SELECT Cod_Lab FROM "Schema_Progetto".TMP2';
OPEN cursore1 FOR  EXECUTE sql_smt;
LOOP
FETCH cursore1 INTO tmp2_trovato;
EXIT WHEN NOT FOUND;
sql_smt:='INSERT INTO "Schema_Progetto".lavoromiddle(cod_lab,cod_middle) 
VALUES($1,$2)';
EXECUTE sql_smt USING tmp2_trovato,NEW.cf;

END LOOP;
CLOSE cursore1;




END IF;

IF(NEW.Anni_Servizio>=7) THEN

--prima di cancellare salvare i suoi dirigenti e i suoi laboratori

sql_smt='SELECT cod_dirigente FROM "Schema_Progetto".dirigenzajunior WHERE cod_junior=$1';
OPEN cursore1 FOR  EXECUTE sql_smt USING NEW.cf;--tutti i dirigenti dell'impiegato
LOOP
FETCH cursore1 INTO dirigente_trovato;
EXIT WHEN NOT FOUND;
sql_smt='INSERT INTO "Schema_Progetto".TMP(Cod_Dirigente) VALUES($1)';
EXECUTE sql_smt USING dirigente_trovato;
END LOOP;
CLOSE cursore1;


sql_smt='SELECT cod_lab FROM "Schema_Progetto".lavorojunior WHERE cod_junior=$1';
OPEN cursore1 FOR  EXECUTE sql_smt USING NEW.cf;--tutti i laboratori dell'impiegato
LOOP
FETCH cursore1 INTO lab_trovato;
EXIT WHEN NOT FOUND;
sql_smt='INSERT INTO "Schema_Progetto".TMP2(Cod_Lab) VALUES($1)';
EXECUTE sql_smt USING lab_trovato;
END LOOP;
CLOSE cursore1;


DELETE FROM "Schema_Progetto".junior WHERE junior.cf=NEW.cf; 

INSERT INTO "Schema_Progetto".senior(nome,cognome,cf,anni_servizio)
VALUES(NEW.nome,NEW.cognome,NEW.cf,NEW.anni_servizio);


sql_smt:='SELECT Cod_Dirigente FROM "Schema_Progetto".TMP';
OPEN cursore1 FOR  EXECUTE sql_smt;
LOOP
FETCH cursore1 INTO tmp_trovato;
EXIT WHEN NOT FOUND;
sql_smt:='INSERT INTO "Schema_Progetto".dirigenzasenior(cod_dirigente,cod_senior) 
VALUES($1,$2)';
EXECUTE sql_smt USING tmp_trovato,NEW.cf;

END LOOP;
CLOSE cursore1;
sql_smt:='SELECT Cod_Lab FROM "Schema_Progetto".TMP2';
OPEN cursore1 FOR  EXECUTE sql_smt;
LOOP
FETCH cursore1 INTO tmp2_trovato;
EXIT WHEN NOT FOUND;
sql_smt:='INSERT INTO "Schema_Progetto".lavorosenior(cod_lab,cod_senior) 
VALUES($1,$2)';
EXECUTE sql_smt USING tmp2_trovato,NEW.cf;

END LOOP;
CLOSE cursore1;


END IF;


sql_smt:='DROP TABLE "Schema_Progetto".TMP,"Schema_Progetto".TMP2';
EXECUTE sql_smt;


RETURN NEW;
END;

ALTER FUNCTION "Schema_Progetto"."ProScattiJ"()
    OWNER TO postgres;
```
Questa procedura funziona nel seguente modo:
Vengono create due tabelle temporanee chiamate TMP(la quale conterrà i codici dei dirigenti che dirigono l'impiegato in questione) e TMP2(la quale conterrà i codici dei laboratori dove l'impiegato lavora).Queste tabelle sono fondamentali per ciò che deve fare la procedura perchè si dovrà cancellare dalla tabella Junior la tupla dell'impiegato che effettua uno scatto di carriera per crearne una nuova nella categoria dove è stato inserito dopo lo scatto di carriera.Senza le tabelle TMP e TMP2 si andrebbero a perdere i valori contenuti nelle tuple delle tabelle dirigenzajunior e lavorojunior legate all'impiegato che effettua lo scatto.
Verrà poi controllato il nuovo valore degli anni e se sono meno di 7 lo scatto sarà effettuato verso la categoria middle mentre se sono almeno 7 lo scatto sarà effettuato verso la categoria senior(non è possibile avere scatti verso dirigente perchè è l'unica categoria senza un obbligo temporale).
Dopo aver controllato gli anni si effettueranno le stesse operazioni(cambierà solo la categoria di tabelle dove inserire nuove tuple)si effettua una query che seleziona i dirigenti dell'impiegato che ha attivato il trigger e tramite un loop vengono inseriti nella tabella TMP.La stessa operazione viene effettuata per i laboratori dove l'impiegato lavora e sono inseriti nella tabella TMP2.
Ora viene effettuata la cancellazione della tupla di Junior che contiene i dati dell'impiegato che ha attivato il trigger(le tabelle dirigenzajunior e lavorojunior hanno chiavi esterne con azione ON UPDATE CASCADE  e ON DELETE CASCADE quindi vengono cancellate delle tuple anche in queste due tabelle).
In base al valore degli anni di servizio dell'impiegato quest'ultima parte di codice andrà ad inserire valori nelle tabelle legate a Middle o Senior.\newline(per comodità viene indicato con Categoria ogni categoria diversa da quella di partenza dell'impiegato per evitare ridondanza nella descrizione di questa parte di codice)
Quindi verranno inserite tramite delle query (ed anche  dei loop nel caso delle tabelle dirigenzaCategoria e lavoroCategoria visto che potrebbero esserci multipli inserimenti)nuove tuple in Categoria,dirigenzaCategoria e lavoroCategoria, le quali conterranno esattamente gli stessi valori che erano presenti in Junior,dirigenzajunior e lavorojunior prima che veniva eliminato l'impiegato Junior che ha attivato il trigger.
Dopo aver inserito questi nuovi dati  si effettuerà come ultima operazione la cancellazione delle due tabelle temporanee TMP e TMP2.
Quindi lo scopo di questo trigger è gestire la variazione di categoria di un impiegato Junior dovuta all'aggiornamento del valore degli anni di servizio tramite l'inserimento di dati legati ad esso nelle tabelle legate alla sua nuova categoria.


**ControlloMiddle.SQL**
```
CREATE TRIGGER "ControlloMiddle"
    BEFORE INSERT ON "Schema_Progetto".middle
    FOR EACH ROW
    EXECUTE FUNCTION "Schema_Progetto"."ProControlloMiddle"();
```

Questo trigger viene eseguito prima dell'inserimento su Middle ed esegue la procedura ProControlloMiddle.

**ProControlloMiddle.SQL**

```
CREATE FUNCTION "Schema_Progetto"."ProControlloMiddle"()
    RETURNS trigger
    LANGUAGE 'plpgsql'
     NOT LEAKPROOF
AS 
$$
DECLARE  
sql_smt VARCHAR(200);
cf_trovato "Schema_Progetto"."middle".cf%TYPE;

BEGIN
sql_smt:='SELECT cf FROM "Schema_Progetto".junior WHERE cf=$1';
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

ALTER FUNCTION "Schema_Progetto"."ProControlloMiddle"()
    OWNER TO postgres;
```

Questa procedura verifica tramite delle semplici query se esiste un impiegato di una categoria diversa da Middle ma con lo stesso codice fiscale.
Se viene trovato un'impiegato di un altra categoria ma con lo stesso cf che si vorrebbe inserire in Middle(il trigger è before insert quindi per ora non c'è ancora una tupla in Middle con il NEW.cf)allora avviene un eccezione che stampa il messaggio:Codice Fiscale già presente.
Quindi lo scopo di questo trigger è di verificare l'unicità del codice fiscale che si vuole inserire in Middle.

**InsMiddle.SQL**

```
CREATE TRIGGER "InsMiddle"
    AFTER INSERT ON "Schema_Progetto".middle
    FOR EACH ROW
	WHEN(NEW.anni_servizio>=7 OR NEW.anni_servizio <3)
    EXECUTE FUNCTION "Schema_Progetto"."ProInsMiddle"();
```


Questo trigger viene eseguito dopo l'inserimento su Middle con la condizione che gli anni inseriti siano >= 7 o siano <3(quindi quando gli anni di servizio del impiegato Middle sono diversi da quelli richiesti per essere nella sua categoria) ed esegue la procedura ProInsMiddle.


**ProInsMiddle.SQL**

```
CREATE FUNCTION "Schema_Progetto"."ProInsMiddle"()
    RETURNS trigger
    LANGUAGE 'plpgsql'
     NOT LEAKPROOF
AS 
$$
BEGIN
DELETE FROM "Schema_Progetto".middle WHERE cf=NEW.cf;
IF (NEW.anni_servizio<3) THEN 
INSERT INTO "Schema_Progetto".junior(cf,nome,cognome,anni_servizio) VALUES(NEW.cf,NEW.nome,NEW.cognome,NEW.anni_servizio);
END IF;
IF (NEW.anni_servizio>=7) THEN 
INSERT INTO "Schema_Progetto".senior(cf,nome,cognome,anni_servizio) VALUES(NEW.cf,NEW.nome,NEW.cognome,NEW.anni_servizio);
END IF;
RETURN NEW;
END;
$$;

ALTER FUNCTION "Schema_Progetto"."ProInsMiddle"()
    OWNER TO postgres;
```

Questa procedura cancella la tupla appena inserita su Middle(in PostgreSQL non è possibile creare una procedura che gestisca anche l'andamento delle transazioni del database con commit e rollback manuali quindi si è optato per realizzare quest'azione manualmente con un trigger AFTER INSERT ed un'operazione DELETE)e verifica quanti sono gli anni di servizio dell'impiegato.
Se l'impiegato lavorava da meno di 3 anni allora i suoi dati vengono inseriti come tupla di Junior mentre se gli anni sono almeno 7 allora i dati sono vengono inseriti come tupla di Senior.

Lo scopo di questo trigger è quello di gestire gli inserimenti in Middle con anni diversi da quelli richiesti per essere in questa categoria ed effettuare l'inserimento nella categoria corretta.

**ScattiCarrieraM.SQL**

```
CREATE TRIGGER "ScattiCarrieraM"
    AFTER UPDATE OF anni_servizio
    ON "Schema_Progetto".middle
    FOR EACH ROW
    WHEN (NEW.anni_servizio<3 OR NEW.anni_servizio>=7)
    EXECUTE FUNCTION "Schema_Progetto"."ProScattiM"();
```

Questo trigger viene eseguito dopo aver aggiornato il valore degli anni su Middle con la condizione che il nuovo valore degli anni sia >=7 o  <3 (quindi diversi da quelli richiesti per essere nella categoria Midde)ed esegue la procedura ProScattiM.

**ProScattiM.SQL**

```
DECLARE
sql_smt VARCHAR(200);
cursore1 refcursor;
dirigente_trovato "Schema_Progetto"."dirigente".cf%TYPE;
lab_trovato "Schema_Progetto"."laboratorio".cod_lab%TYPE;
tmp_trovato "Schema_Progetto"."dirigente".cf%TYPE;
tmp2_trovato "Schema_Progetto"."laboratorio".cod_lab%TYPE;

BEGIN
sql_smt:='CREATE TABLE "Schema_Progetto".TMP
( Cod_Dirigente "Schema_Progetto"."CodiceF",
CONSTRAINT TMP_PK PRIMARY KEY(Cod_Dirigente)
) ';
EXECUTE sql_smt;
sql_smt:='CREATE TABLE "Schema_Progetto".TMP2
( Cod_Lab "Schema_Progetto"."CodiceL",
CONSTRAINT TMP2_PK PRIMARY KEY(Cod_Lab)
) ';
EXECUTE sql_smt;

IF(NEW.Anni_Servizio<3) THEN 

--prima di cancellare salvare i suoi dirigenti e i suoi laboratori

sql_smt='SELECT cod_dirigente FROM "Schema_Progetto".dirigenzamiddle WHERE cod_middle=$1';
OPEN cursore1 FOR  EXECUTE sql_smt USING NEW.cf;--tutti i dirigenti dell'impiegato
LOOP
FETCH cursore1 INTO dirigente_trovato;
EXIT WHEN NOT FOUND;
sql_smt='INSERT INTO "Schema_Progetto".TMP(Cod_Dirigente) VALUES($1)';
EXECUTE sql_smt USING dirigente_trovato;
END LOOP;
CLOSE cursore1;


sql_smt='SELECT cod_lab FROM "Schema_Progetto".lavoromiddle WHERE cod_middle=$1';
OPEN cursore1 FOR  EXECUTE sql_smt USING NEW.cf;--tutti i laboratori dell'impiegato
LOOP
FETCH cursore1 INTO lab_trovato;
EXIT WHEN NOT FOUND;
sql_smt='INSERT INTO "Schema_Progetto".TMP2(Cod_Lab) VALUES($1)';
EXECUTE sql_smt USING lab_trovato;
END LOOP;
CLOSE cursore1;


DELETE FROM "Schema_Progetto".middle WHERE middle.cf=NEW.cf;

INSERT INTO "Schema_Progetto".junior(nome,cognome,cf,anni_servizio)
VALUES(NEW.nome,NEW.cognome,NEW.cf,NEW.anni_servizio);




sql_smt:='SELECT Cod_Dirigente FROM "Schema_Progetto".TMP';
OPEN cursore1 FOR  EXECUTE sql_smt;
LOOP
FETCH cursore1 INTO tmp_trovato;
EXIT WHEN NOT FOUND;
sql_smt:='INSERT INTO "Schema_Progetto".dirigenzajunior(cod_dirigente,cod_junior) 
VALUES($1,$2)';
EXECUTE sql_smt USING tmp_trovato,NEW.cf;

END LOOP;
CLOSE cursore1;
sql_smt:='SELECT Cod_Lab FROM "Schema_Progetto".TMP2';
OPEN cursore1 FOR  EXECUTE sql_smt;
LOOP
FETCH cursore1 INTO tmp2_trovato;
EXIT WHEN NOT FOUND;
sql_smt:='INSERT INTO "Schema_Progetto".lavorojunior(cod_lab,cod_junior) 
VALUES($1,$2)';
EXECUTE sql_smt USING tmp2_trovato,NEW.cf;

END LOOP;
CLOSE cursore1;


END IF;

IF(NEW.Anni_Servizio>=7) THEN

--prima di cancellare salvare i suoi dirigenti e i suoi laboratori

sql_smt='SELECT cod_dirigente FROM "Schema_Progetto".dirigenzamiddle WHERE cod_middle=$1';
OPEN cursore1 FOR  EXECUTE sql_smt USING NEW.cf;--tutti i dirigenti dell'impiegato
LOOP
FETCH cursore1 INTO dirigente_trovato;
EXIT WHEN NOT FOUND;
sql_smt='INSERT INTO "Schema_Progetto".TMP(Cod_Dirigente) VALUES($1)';
EXECUTE sql_smt USING dirigente_trovato;
END LOOP;
CLOSE cursore1;


sql_smt='SELECT cod_lab FROM "Schema_Progetto".lavoromiddle WHERE cod_middle=$1';
OPEN cursore1 FOR  EXECUTE sql_smt USING NEW.cf;--tutti i laboratori dell'impiegato
LOOP
FETCH cursore1 INTO lab_trovato;
EXIT WHEN NOT FOUND;
sql_smt='INSERT INTO "Schema_Progetto".TMP2(Cod_Lab) VALUES($1)';
EXECUTE sql_smt USING lab_trovato;
END LOOP;
CLOSE cursore1;


DELETE FROM "Schema_Progetto".middle WHERE middle.cf=NEW.cf; 

INSERT INTO "Schema_Progetto".senior(nome,cognome,cf,anni_servizio)
VALUES(NEW.nome,NEW.cognome,NEW.cf,NEW.anni_servizio);


sql_smt:='SELECT Cod_Dirigente FROM "Schema_Progetto".TMP';
OPEN cursore1 FOR  EXECUTE sql_smt;
LOOP
FETCH cursore1 INTO tmp_trovato;
EXIT WHEN NOT FOUND;
sql_smt:='INSERT INTO "Schema_Progetto".dirigenzasenior(cod_dirigente,cod_senior) 
VALUES($1,$2)';
EXECUTE sql_smt USING tmp_trovato,NEW.cf;

END LOOP;
CLOSE cursore1;
sql_smt:='SELECT Cod_Lab FROM "Schema_Progetto".TMP2';
OPEN cursore1 FOR  EXECUTE sql_smt;
LOOP
FETCH cursore1 INTO tmp2_trovato;
EXIT WHEN NOT FOUND;
sql_smt:='INSERT INTO "Schema_Progetto".lavorosenior(cod_lab,cod_senior) 
VALUES($1,$2)';
EXECUTE sql_smt USING tmp2_trovato,NEW.cf;

END LOOP;
CLOSE cursore1;


END IF;


sql_smt:='DROP TABLE "Schema_Progetto".TMP,"Schema_Progetto".TMP2';
EXECUTE sql_smt;



RETURN NEW;
END;
$$;

ALTER FUNCTION "Schema_Progetto"."ProScattiM"()
    OWNER TO postgres;
```


Questa procedura funziona nel seguente modo:
Vengono create due tabelle temporanee chiamate TMP(la quale conterrà i codici dei dirigenti che dirigono l'impiegato in questione) e TMP2(la quale conterrà i codici dei laboratori dove l'impiegato lavora).Queste tabelle sono fondamentali per ciò che deve fare la procedura perchè si dovrà cancellare dalla tabella Middle la tupla dell'impiegato che effettua uno scatto di carriera per crearne una nuova nella categoria dove è stato inserito dopo lo scatto di carriera.Senza le tabelle TMP e TMP2 si andrebbero a perdere i valori contenuti nelle tuple delle tabelle dirigenzamiddle e lavoromiddle legate all'impiegato che effettua lo scatto.
Verrà poi controllato il nuovo valore degli anni e se sono meno di 3 lo scatto sarà effettuato verso la categoria junior mentre se sono almeno 7 lo scatto sarà effettuato verso la categoria senior(non è possibile avere scatti verso dirigente perchè è l'unica categoria senza un obbligo temporale).
Dopo aver controllato gli anni si effettueranno le stesse operazioni(cambierà solo la categoria di tabelle dove inserire nuove tuple)si effettua una query che seleziona i dirigenti dell'impiegato che ha attivato il trigger e tramite un loop vengono inseriti nella tabella TMP.La stessa operazione viene effettuata per i laboratori dove l'impiegato lavora e sono inseriti nella tabella TMP2.
Ora viene effettuata la cancellazione della tupla di Middle che contiene i dati dell'impiegato che ha attivato il trigger(le tabelle dirigenzamiddle e lavoromiddle hanno chiavi esterne con azione ON UPDATE CASCADE  e ON DELETE CASCADE quindi vengono cancellate delle tuple anche in queste due tabelle).
In base al valore degli anni di servizio dell'impiegato quest'ultima parte di codice andrà ad inserire valori nelle tabelle legate a Junior o Senior.(per comodità viene indicato con Categoria ogni categoria diversa da quella di partenza dell'impiegato per evitare ridondanza nella descrizione di questa parte di codice)
Quindi verranno inserite tramite delle query (ed anche  dei loop nel caso delle tabelle dirigenzaCategoria e lavoroCategoria visto che potrebbero esserci multipli inserimenti)nuove tuple in Categoria,dirigenzaCategoria e lavoroCategoria, le quali conterranno esattamente gli stessi valori che erano presenti in Middle,dirigenzamiddle e lavoromiddle prima che venisse eliminato l'impiegato Middle che ha attivato il trigger.
Dopo aver inserito questi nuovi dati  si effettuerà come ultima operazione la cancellazione delle due tabelle temporanee TMP e TMP2.
Quindi lo scopo di questo trigger è gestire la variazione di categoria di un impiegato Middle dovuta all'aggiornamento del valore degli anni di servizio tramite l'inserimento di dati legati ad esso nelle tabelle legate alla sua nuova categoria.

**ControlloSenior.SQL**

```
CREATE TRIGGER "ControlloSenior"
    BEFORE INSERT ON "Schema_Progetto".senior
    FOR EACH ROW
    EXECUTE FUNCTION "Schema_Progetto"."ProControlloSenior"();
```

Questo trigger viene eseguito prima dell'inserimento su Senior ed esegue la procedura ProControlloSenior.

**ProControlloSenior.SQL**

```
CREATE FUNCTION "Schema_Progetto"."ProControlloSenior"()
    RETURNS trigger
    LANGUAGE 'plpgsql'
     NOT LEAKPROOF
AS 
$$
DECLARE  
sql_smt VARCHAR(200);
cf_trovato "Schema_Progetto"."senior".cf%TYPE;

BEGIN
sql_smt:='SELECT cf FROM "Schema_Progetto".junior WHERE cf=$1';
EXECUTE sql_smt INTO cf_trovato USING NEW.cf;
IF cf_trovato=NEW.cf THEN 
RAISE EXCEPTION 'Codice Fiscale già presente 'USING ERRCODE='unique_violation';
END IF;

sql_smt:='SELECT cf FROM "Schema_Progetto".middle WHERE cf=$1';
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

ALTER FUNCTION "Schema_Progetto"."ProControlloSenior"()
    OWNER TO postgres;
```

Questa procedura verifica tramite delle semplici query se esiste un impiegato di una categoria diversa da Senior ma con lo stesso codice fiscale.
Se viene trovato un'impiegato di un altra categoria ma con lo stesso cf che si vorrebbe inserire in Senior(il trigger è before insert quindi per ora non c'è ancora una tupla in Senior con il NEW.cf)allora avviene un eccezione che stampa il messaggio:Codice Fiscale già presente.
Quindi lo scopo di questo trigger è di verificare l'unicità del codice fiscale che si vuole inserire in Senior.

**InsSenior.SQL**

```
CREATE TRIGGER "InsSenior"
    AFTER INSERT ON "Schema_Progetto".senior
    FOR EACH ROW
	WHEN(NEW.anni_servizio<7)
    EXECUTE FUNCTION "Schema_Progetto"."ProInsSenior"();
```

Questo trigger viene eseguito dopo l'inserimento su Senior con la condizione che gli anni inseriti siano < 7(quindi quando gli anni di servizio dell' impiegato Senior sono diversi da quelli richiesti per essere nella sua categoria) ed esegue la procedura ProInsSenior.

**ProInsSenior.SQL**

```
CREATE FUNCTION "Schema_Progetto"."ProInsSenior"()
    RETURNS trigger
    LANGUAGE 'plpgsql'
     NOT LEAKPROOF
AS 
$$
BEGIN
DELETE FROM "Schema_Progetto".senior WHERE cf=NEW.cf;
IF (NEW.anni_servizio<3) THEN 
INSERT INTO "Schema_Progetto".junior(cf,nome,cognome,anni_servizio) VALUES(NEW.cf,NEW.nome,NEW.cognome,NEW.anni_servizio);
END IF;
IF (NEW.anni_servizio<7 AND NEW.anni_servizio>=3) THEN 
INSERT INTO "Schema_Progetto".middle(cf,nome,cognome,anni_servizio) VALUES(NEW.cf,NEW.nome,NEW.cognome,NEW.anni_servizio);
END IF;
RETURN NEW;
END;
$$;

ALTER FUNCTION "Schema_Progetto"."ProInsSenior"()
    OWNER TO postgres;
```

Questa procedura cancella la tupla appena inserita su Senior(in PostgreSQL non è possibile creare una procedura che gestisca anche l'andamento delle transazioni del database con commit e rollback manuali quindi si è optato per realizzare quest'azione manualmente con un trigger AFTER INSERT ed un'operazione DELETE)e verifica quanti sono gli anni di servizio dell'impiegato.
Se l'impiegato lavorava da meno di 3 anni allora i suoi dati vengono inseriti come tupla di Junior mentre se gli anni sono tra i 3 ed i 6(quindi >=3 e <7)  allora i dati sono vengono inseriti come tupla di Middle.
Lo scopo di questo trigger è quello di gestire gli inserimenti in Senior con anni diversi da quelli richiesti per essere in questa categoria ed effettuare l'inserimento nella categoria corretta.


**ScattiCarrieraS.SQL**

```
CREATE TRIGGER "ScattiCarrieraS"
    AFTER UPDATE OF anni_servizio
    ON "Schema_Progetto".senior
    FOR EACH ROW
    WHEN (NEW.anni_servizio<7)
    EXECUTE FUNCTION "Schema_Progetto"."ProScattiS"();
```


Questo trigger viene eseguito dopo aver aggiornato il valore degli anni su Senior con la condizione che il nuovo valore degli anni sia <7(quindi diversi da quelli richiesti per essere nella categoria Senior)ed esegue la procedura ProScattiS.

**ProScattiS.SQL**


```
CREATE FUNCTION "Schema_Progetto"."ProScattiS"()
    RETURNS trigger
    LANGUAGE 'plpgsql'
     NOT LEAKPROOF
AS 
$$
DECLARE
sql_smt VARCHAR(200);
cursore1 refcursor;
dirigente_trovato "Schema_Progetto"."dirigente".cf%TYPE;
lab_trovato "Schema_Progetto"."laboratorio".cod_lab%TYPE;
tmp_trovato "Schema_Progetto"."dirigente".cf%TYPE;
tmp2_trovato "Schema_Progetto"."laboratorio".cod_lab%TYPE;



BEGIN
sql_smt:='CREATE TABLE "Schema_Progetto".TMP
( Cod_Dirigente "Schema_Progetto"."CodiceF",
CONSTRAINT TMP_PK PRIMARY KEY(Cod_Dirigente)
) ';
EXECUTE sql_smt;
sql_smt:='CREATE TABLE "Schema_Progetto".TMP2
( Cod_Lab "Schema_Progetto"."CodiceL",
CONSTRAINT TMP2_PK PRIMARY KEY(Cod_Lab)
) ';
EXECUTE sql_smt;
IF(NEW.Anni_Servizio<3) THEN 

--prima di cancellare salvare i suoi dirigenti e i suoi laboratori

sql_smt='SELECT cod_dirigente FROM "Schema_Progetto".dirigenzasenior WHERE cod_senior=$1';
OPEN cursore1 FOR  EXECUTE sql_smt USING NEW.cf;--tutti i dirigenti dell'impiegato
LOOP
FETCH cursore1 INTO dirigente_trovato;
EXIT WHEN NOT FOUND;
sql_smt='INSERT INTO "Schema_Progetto".TMP(Cod_Dirigente) VALUES($1)';
EXECUTE sql_smt USING dirigente_trovato;
END LOOP;
CLOSE cursore1;


sql_smt='SELECT cod_lab FROM "Schema_Progetto".lavorosenior WHERE cod_senior=$1';
OPEN cursore1 FOR  EXECUTE sql_smt USING NEW.cf;--tutti i laboratori dell'impiegato
LOOP
FETCH cursore1 INTO lab_trovato;
EXIT WHEN NOT FOUND;
sql_smt='INSERT INTO "Schema_Progetto".TMP2(Cod_Lab) VALUES($1)';
EXECUTE sql_smt USING lab_trovato;
END LOOP;
CLOSE cursore1;


DELETE FROM "Schema_Progetto".senior WHERE senior.cf=NEW.cf;

INSERT INTO "Schema_Progetto".junior(nome,cognome,cf,anni_servizio)
VALUES(NEW.nome,NEW.cognome,NEW.cf,NEW.anni_servizio);


sql_smt:='SELECT Cod_Dirigente FROM "Schema_Progetto".TMP';
OPEN cursore1 FOR  EXECUTE sql_smt;
LOOP
FETCH cursore1 INTO tmp_trovato;
EXIT WHEN NOT FOUND;
sql_smt:='INSERT INTO "Schema_Progetto".dirigenzajunior(cod_dirigente,cod_junior) 
VALUES($1,$2)';
EXECUTE sql_smt USING tmp_trovato,NEW.cf;

END LOOP;
CLOSE cursore1;
sql_smt:='SELECT Cod_Lab FROM "Schema_Progetto".TMP2';
OPEN cursore1 FOR  EXECUTE sql_smt;
LOOP
FETCH cursore1 INTO tmp2_trovato;
EXIT WHEN NOT FOUND;
sql_smt:='INSERT INTO "Schema_Progetto".lavorojunior(cod_lab,cod_junior) 
VALUES($1,$2)';
EXECUTE sql_smt USING tmp2_trovato,NEW.cf;

END LOOP;
CLOSE cursore1;

END IF;

IF(NEW.Anni_Servizio>=3) THEN

--prima di cancellare salvare i suoi dirigenti e i suoi laboratori

sql_smt='SELECT cod_dirigente FROM "Schema_Progetto".dirigenzasenior WHERE cod_senior=$1';
OPEN cursore1 FOR  EXECUTE sql_smt USING NEW.cf;--tutti i dirigenti dell'impiegato
LOOP
FETCH cursore1 INTO dirigente_trovato;
EXIT WHEN NOT FOUND;
sql_smt='INSERT INTO "Schema_Progetto".TMP(Cod_Dirigente) VALUES($1)';
EXECUTE sql_smt USING dirigente_trovato;
END LOOP;
CLOSE cursore1;


sql_smt='SELECT cod_lab FROM "Schema_Progetto".lavorosenior WHERE cod_senior=$1';
OPEN cursore1 FOR  EXECUTE sql_smt USING NEW.cf;--tutti i laboratori dell'impiegato
LOOP
FETCH cursore1 INTO lab_trovato;
EXIT WHEN NOT FOUND;
sql_smt='INSERT INTO "Schema_Progetto".TMP2(Cod_Lab) VALUES($1)';
EXECUTE sql_smt USING lab_trovato;
END LOOP;
CLOSE cursore1;


DELETE FROM "Schema_Progetto".senior WHERE senior.cf=NEW.cf; 

INSERT INTO "Schema_Progetto".middle(nome,cognome,cf,anni_servizio)
VALUES(NEW.nome,NEW.cognome,NEW.cf,NEW.anni_servizio);


sql_smt:='SELECT Cod_Dirigente FROM "Schema_Progetto".TMP';
OPEN cursore1 FOR  EXECUTE sql_smt;
LOOP
FETCH cursore1 INTO tmp_trovato;
EXIT WHEN NOT FOUND;
sql_smt:='INSERT INTO "Schema_Progetto".dirigenzamiddle(cod_dirigente,cod_middle) 
VALUES($1,$2)';
EXECUTE sql_smt USING tmp_trovato,NEW.cf;

END LOOP;
CLOSE cursore1;
sql_smt:='SELECT Cod_Lab FROM "Schema_Progetto".TMP2';
OPEN cursore1 FOR  EXECUTE sql_smt;
LOOP
FETCH cursore1 INTO tmp2_trovato;
EXIT WHEN NOT FOUND;
sql_smt:='INSERT INTO "Schema_Progetto".lavoromiddle(cod_lab,cod_middle) 
VALUES($1,$2)';
EXECUTE sql_smt USING tmp2_trovato,NEW.cf;

END LOOP;
CLOSE cursore1;


END IF;
sql_smt:='DROP TABLE "Schema_Progetto".TMP,"Schema_Progetto".TMP2';
EXECUTE sql_smt;


RETURN NEW;
END;
$$;

ALTER FUNCTION "Schema_Progetto"."ProScattiS"()
    OWNER TO postgres;
```



Questa procedura funziona nel seguente modo:
Vengono create due tabelle temporanee chiamate TMP(la quale conterrà i codici dei dirigenti che dirigono l'impiegato in questione) e TMP2(la quale conterrà i codici dei laboratori dove l'impiegato lavora).Queste tabelle sono fondamentali per ciò che deve fare la procedura perchè si dovrà cancellare dalla tabella Senior la tupla dell'impiegato che effettua uno scatto di carriera per crearne una nuova nella categoria dove è stato inserito dopo lo scatto di carriera.Senza le tabelle TMP e TMP2 si andrebbero a perdere i valori contenuti nelle tuple delle tabelle dirigenzasenior e lavorosenior legate all'impiegato che effettua lo scatto.
Verrà poi controllato il nuovo valore degli anni e se sono meno di 3 lo scatto sarà effettuato verso la categoria junior mentre se sono almeno 3 lo scatto sarà effettuato verso la categoria middle(non è possibile avere scatti verso dirigente perchè è l'unica categoria senza un obbligo temporale).
Dopo aver controllato gli anni si effettueranno le stesse operazioni(cambierà solo la categoria di tabelle dove inserire nuove tuple)si effettua una query che seleziona i dirigenti dell'impiegato che ha attivato il trigger e tramite un loop vengono inseriti nella tabella TMP.La stessa operazione viene effettuata per i laboratori dove l'impiegato lavora e sono inseriti nella tabella TMP2.
Ora viene effettuata la cancellazione della tupla di Senior che contiene i dati dell'impiegato che ha attivato il trigger(le tabelle dirigenzasenior e lavorosenior hanno chiavi esterne con azione ON UPDATE CASCADE  e ON DELETE CASCADE quindi vengono cancellate delle tuple anche in queste due tabelle).
In base al valore degli anni di servizio dell'impiegato quest'ultima parte di codice andrà ad inserire valori nelle tabelle legate a Junior o Middle.(per comodità viene indicato con Categoria ogni categoria diversa da quella di partenza dell'impiegato per evitare ridondanza nella descrizione di questa parte di codice)
Quindi verranno inserite tramite delle query (ed anche  dei loop nel caso delle tabelle dirigenzaCategoria e lavoroCategoria visto che potrebbero esserci multipli inserimenti)nuove tuple in Categoria,dirigenzaCategoria e lavoroCategoria, le quali conterranno esattamente gli stessi valori che erano presenti in Senior,dirigenzasenior e lavorosenior prima che venisse eliminato l'impiegato Senior che ha attivato il trigger.
Dopo aver inserito questi nuovi dati  si effettuerà come ultima operazione la cancellazione delle due tabelle temporanee TMP e TMP2.
Quindi lo scopo di questo trigger è gestire la variazione di categoria di un impiegato Senior dovuta all'aggiornamento del valore degli anni di servizio tramite l'inserimento di dati legati ad esso nelle tabelle legate alla sua nuova categoria.


**ControlloDirigente.SQL**

```
CREATE TRIGGER "ControlloDirigente"
    BEFORE INSERT ON "Schema_Progetto".dirigente
    FOR EACH ROW
    EXECUTE FUNCTION "Schema_Progetto"."ProControlloDirigente"();
```

Questo trigger viene eseguito prima dell'inserimento su Dirigente ed esegue la procedura ProControlloDirigente.



**ProControlloDirigente.SQL**


```
CREATE FUNCTION "Schema_Progetto"."ProControlloDirigente"()
    RETURNS trigger
    LANGUAGE 'plpgsql'
     NOT LEAKPROOF
AS 
$$
DECLARE  
sql_smt VARCHAR(200);
cf_trovato "Schema_Progetto"."dirigente".cf%TYPE;

BEGIN
sql_smt:='SELECT cf FROM "Schema_Progetto".junior WHERE cf=$1';
EXECUTE sql_smt INTO cf_trovato USING NEW.cf;
IF cf_trovato=NEW.cf THEN 
RAISE EXCEPTION 'Codice Fiscale già presente 'USING ERRCODE='unique_violation';
END IF;

sql_smt:='SELECT cf FROM "Schema_Progetto".middle WHERE cf=$1';
EXECUTE sql_smt INTO cf_trovato USING NEW.cf;
IF cf_trovato=NEW.cf THEN 
RAISE EXCEPTION 'Codice Fiscale già presente ' USING ERRCODE='unique_violation';
END IF;

sql_smt:='SELECT cf FROM "Schema_Progetto".senior WHERE cf=$1';
EXECUTE sql_smt INTO cf_trovato USING NEW.cf;
IF cf_trovato=NEW.cf THEN 
RAISE EXCEPTION 'Codice Fiscale già presente 'USING ERRCODE='unique_violation';
END IF;

RETURN NEW;
END;
$$;

ALTER FUNCTION "Schema_Progetto"."ProControlloDirigente"()
    OWNER TO postgres;
```

Questa procedura verifica tramite delle semplici query se esiste un impiegato di una categoria diversa da Dirigente ma con lo stesso codice fiscale.
Se viene trovato un'impiegato di un altra categoria ma con lo stesso cf che si vorrebbe inserire in Dirigente(il trigger è before insert quindi per ora non c'è ancora una tupla in Dirigente con il NEW.cf)allora avviene un eccezione che stampa il messaggio:Codice Fiscale già presente.
Quindi lo scopo di questo trigger è di verificare l'unicità del codice fiscale che si vuole inserire in Dirigente.




