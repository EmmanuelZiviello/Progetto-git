CREATE TABLE "Schema_Progetto".DirigenzaSenior
( Cod_Dirigente "Schema_Progetto"."CodiceF" NOT NULL,
Cod_Senior "Schema_Progetto"."CodiceF" NOT NULL,
CONSTRAINT DirigenzaSeniorPK PRIMARY KEY(Cod_Dirigente,Cod_Senior),
CONSTRAINT DirigenzaSeniorFK1 FOREIGN KEY (Cod_Dirigente) REFERENCES  "Schema_Progetto".Dirigente(CF)  ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT DirigenzaSeniorFK2 FOREIGN KEY (Cod_Senior) REFERENCES  "Schema_Progetto".Senior(CF)   ON UPDATE CASCADE ON DELETE CASCADE
);