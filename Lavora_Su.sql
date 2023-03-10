CREATE TABLE "Schema_Progetto".Lavora_Su
( CUP "Schema_Progetto"."CodiceP",
Cod_Lab "Schema_Progetto"."CodiceL",
Nome VARCHAR(20) , 
CONSTRAINT Lavora_SuPK PRIMARY KEY(CUP,Nome,Cod_Lab),
CONSTRAINT Lavora_SuFK1 FOREIGN KEY (Cod_Lab) REFERENCES  "Schema_Progetto".Laboratorio(Cod_Lab)  ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT Lavora_SuFK2 FOREIGN KEY (CUP,Nome) REFERENCES  "Schema_Progetto".Progetto(CUP,Nome)  ON UPDATE CASCADE ON DELETE CASCADE
);
