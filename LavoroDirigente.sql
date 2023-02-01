CREATE TABLE "Schema_Progetto".LavoroDirigente
( Cod_Lab "Schema_Progetto"."CodiceL" NOT NULL,
Cod_Dirigente "Schema_Progetto"."CodiceF" NOT NULL,
CONSTRAINT LavoroDirigentePK PRIMARY KEY(Cod_Lab,Cod_Dirigente),
CONSTRAINT LavoroDirigenteFK1 FOREIGN KEY (Cod_Lab) REFERENCES  "Schema_Progetto".Laboratorio(Cod_Lab)  ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT LavoroDirigenteFK2 FOREIGN KEY (Cod_Dirigente) REFERENCES  "Schema_Progetto".Dirigente(CF)   ON UPDATE CASCADE ON DELETE CASCADE
);