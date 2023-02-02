CREATE TABLE "Schema_Progetto".Progetto
( CUP "Schema_Progetto"."CodiceP" ,
Cod_Senior "Schema_Progetto"."CodiceF" NOT NULL,
Cod_Dirigente "Schema_Progetto"."CodiceF" NOT NULL, 
Nome VARCHAR(20) , 
CONSTRAINT ProPK PRIMARY KEY(CUP,Nome),
CONSTRAINT nome_unico UNIQUE(Nome),--la chiave primaria è composta quindi senza questo vincolo sarebbe possibile avere progetti con cup diverso ma con il nome uguale ma è richiesto che ogni nome sia presente solo una volta nel database
CONSTRAINT ProFK1 FOREIGN KEY (Cod_Senior) REFERENCES  "Schema_Progetto".Senior(CF)  ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT ProFK2 FOREIGN KEY (Cod_Dirigente) REFERENCES  "Schema_Progetto".Dirigente(CF)  ON UPDATE CASCADE ON DELETE CASCADE
);
