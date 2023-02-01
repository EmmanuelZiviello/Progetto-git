CREATE TABLE "Schema_Progetto".Laboratorio
( Cod_Lab "Schema_Progetto"."CodiceL" NOT NULL,
Cod_Senior "Schema_Progetto"."CodiceF" NOT NULL,
Topic VARCHAR(18) NOT NULL, 
Afferenti INTEGER NOT NULL,
CONSTRAINT LabPK PRIMARY KEY(Cod_Lab),
CONSTRAINT LabFK FOREIGN KEY (Cod_Senior) REFERENCES  "Schema_Progetto".Senior(CF)  ON UPDATE CASCADE ON DELETE CASCADE
);