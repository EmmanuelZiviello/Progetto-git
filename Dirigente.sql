CREATE TABLE "Schema_Progetto".Dirigente
( CF "Schema_Progetto"."CodiceF",
Nome VARCHAR(8) NOT NULL,
Cognome VARCHAR(14) NOT NULL,
Anni_Servizio INTEGER NOT NULL,
CONSTRAINT DirigentePK PRIMARY KEY(CF)
);
