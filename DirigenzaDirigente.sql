CREATE TABLE "Schema_Progetto".DirigenzaDirigente
( Cod_Dirigente "Schema_Progetto"."CodiceF" ,
Cod_Dirigente2 "Schema_Progetto"."CodiceF" ,
CONSTRAINT DirigenzaDirigentePK PRIMARY KEY(Cod_Dirigente,Cod_Dirigente2),
CONSTRAINT DirigenzaDirigenteFK1 FOREIGN KEY (Cod_Dirigente) REFERENCES  "Schema_Progetto".Dirigente(CF)  ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT DirigenzaDirigenteFK2 FOREIGN KEY (Cod_Dirigente2) REFERENCES  "Schema_Progetto".Dirigente(CF)  ON UPDATE CASCADE  ON DELETE CASCADE
);
