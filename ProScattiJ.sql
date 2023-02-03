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