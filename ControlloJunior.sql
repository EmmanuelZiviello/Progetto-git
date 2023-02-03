CREATE TRIGGER "ControlloJunior"
    BEFORE INSERT ON "Schema_Progetto".junior
    FOR EACH ROW
    EXECUTE FUNCTION "Schema_Progetto"."ProControlloJunior"();