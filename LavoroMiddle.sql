CREATE TABLE "Schema_Progetto".LavoroMiddle
( Cod_Lab "Schema_Progetto"."CodiceL",
Cod_Middle "Schema_Progetto"."CodiceF" ,
CONSTRAINT LavoroMiddlePK PRIMARY KEY(Cod_Lab,Cod_Middle),
CONSTRAINT LavoroMiddleFK1 FOREIGN KEY (Cod_Lab) REFERENCES  "Schema_Progetto".Laboratorio(Cod_Lab)  ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT LavoroMiddleFK2 FOREIGN KEY (Cod_Middle) REFERENCES  "Schema_Progetto".Middle(CF)   ON UPDATE CASCADE ON DELETE CASCADE
);
