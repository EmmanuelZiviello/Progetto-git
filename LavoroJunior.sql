CREATE TABLE "Schema_Progetto".LavoroJunior
( Cod_Lab "Schema_Progetto"."CodiceL" NOT NULL,
Cod_Junior "Schema_Progetto"."CodiceF" NOT NULL,
CONSTRAINT LavoroJuniorPK PRIMARY KEY(Cod_Lab,Cod_Junior),
CONSTRAINT LavoroJuniorFK1 FOREIGN KEY (Cod_Lab) REFERENCES  "Schema_Progetto".Laboratorio(Cod_Lab)  ON UPDATE CASCADE,
CONSTRAINT LavoroJuniorFK2 FOREIGN KEY (Cod_Junior) REFERENCES  "Schema_Progetto".Junior(CF)  ON UPDATE CASCADE
);