CREATE TABLE "Schema_Progetto".LavoroSenior
( Cod_Lab "Schema_Progetto"."CodiceL" NOT NULL,
Cod_Senior "Schema_Progetto"."CodiceF" NOT NULL,
CONSTRAINT LavoroSeniorPK PRIMARY KEY(Cod_Lab,Cod_Senior),
CONSTRAINT LavoroSeniorFK1 FOREIGN KEY (Cod_Lab) REFERENCES  "Schema_Progetto".Laboratorio(Cod_Lab)  ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT LavoroSeniorFK2 FOREIGN KEY (Cod_Senior) REFERENCES  "Schema_Progetto".Senior(CF)   ON UPDATE CASCADE ON DELETE CASCADE
);