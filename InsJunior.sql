CREATE TRIGGER "InsJunior"
    AFTER INSERT ON "Schema_Progetto".junior
    FOR EACH ROW
	WHEN(NEW.anni_servizio>=3)
    EXECUTE FUNCTION "Schema_Progetto"."ProInsJunior"();