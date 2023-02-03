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