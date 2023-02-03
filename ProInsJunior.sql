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