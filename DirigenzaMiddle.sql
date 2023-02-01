CREATE TABLE "Schema_Progetto".DirigenzaMiddle
( Cod_Dirigente "Schema_Progetto"."CodiceF" NOT NULL,
Cod_Middle "Schema_Progetto"."CodiceF" NOT NULL,
CONSTRAINT DirigenzaMiddlePK PRIMARY KEY(Cod_Dirigente,Cod_Middle),
CONSTRAINT DirigenzaMiddleFK1 FOREIGN KEY (Cod_Dirigente) REFERENCES  "Schema_Progetto".Dirigente(CF)  ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT DirigenzaMiddleFK2 FOREIGN KEY (Cod_Middle) REFERENCES  "Schema_Progetto".Middle(CF)   ON UPDATE CASCADE ON DELETE CASCADE
);