CREATE TABLE "Schema_Progetto".DirigenzaJunior
( Cod_Dirigente "Schema_Progetto"."CodiceF" NOT NULL,
Cod_Junior "Schema_Progetto"."CodiceF" NOT NULL,
CONSTRAINT DirigenzaJuniorPK PRIMARY KEY(Cod_Dirigente,Cod_Junior),
CONSTRAINT DirigenzaJuniorFK1 FOREIGN KEY (Cod_Dirigente) REFERENCES  "Schema_Progetto".Dirigente(CF)  ON UPDATE CASCADE  ON DELETE CASCADE,
CONSTRAINT DirigenzaJuniorFK2 FOREIGN KEY (Cod_Junior) REFERENCES  "Schema_Progetto".Junior(CF)   ON UPDATE CASCADE ON DELETE CASCADE
);