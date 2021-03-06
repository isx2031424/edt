use lab_clinic;

DROP TABLE if EXISTS pacients;
CREATE TABLE pacients (
  idpacient bigint unsigned not null auto_increment PRIMARY KEY,
  nom varchar(15) NOT NULL,
  cognoms varchar(30) NOT NULL,
  dni varchar(9),
  data_naix date NOT NULL,
  sexe varchar(1) NOT NULL,
  adreca varchar(50) NOT NULL,
  ciutat varchar(30) NOT NULL,
  c_postal varchar(10) NOT NULL,
  telefon varchar(9) NOT NULL,
  email varchar(30) NOT NULL,
  num_ss varchar(12) ,
  num_cat varchar(20) ,
  nie varchar(20),
  passaport varchar(20) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE if EXISTS doctors;
CREATE TABLE doctors (
  iddoctor bigint unsigned not null auto_increment PRIMARY KEY,
  nom varchar(15) NOT NULL,
  cognoms varchar(30) NOT NULL,
  especialitat varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE if EXISTS analitiques;
CREATE TABLE analitiques (
  idanalitica bigint unsigned not null auto_increment PRIMARY KEY,
  iddoctor bigint unsigned,
  idpacient bigint unsigned,
  dataanalitica timestamp NOT NULL 
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE if EXISTS catalegproves;
CREATE TABLE catalegproves (
  idprova bigint unsigned not null auto_increment  PRIMARY KEY,
  nom_prova varchar(15) NOT NULL,
  descripcio varchar(100) NOT NULL,
  acronim varchar (15),
  info_autoritats tinyint NOT NULL DEFAULT false
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE if EXISTS provestecnica;
CREATE TABLE provestecnica (
  idprovatecnica bigint unsigned not null auto_increment PRIMARY KEY,
  idprova bigint unsigned ,
  sexe varchar(1) NOT NULL,
  dataprova timestamp NOT NULL ,
  resultat_numeric tinyint NOT NULL DEFAULT true,
  minpat float NOT NULL,
  maxpat float NOT NULL,
  minpan float NOT NULL,
  maxpan float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE if EXISTS resultats;
CREATE TABLE resultats (
  idresultat bigint unsigned not null auto_increment PRIMARY KEY,
  idanalitica bigint unsigned,
  idprovatecnica bigint unsigned,
  resultats varchar(10) NOT NULL,
  dataresultat timestamp NOT NULL,
  UNIQUE(idanalitica,idprovatecnica) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE if EXISTS alarmes;
CREATE TABLE alarmes (
  idalarma bigint unsigned not null auto_increment PRIMARY KEY,
  idresultat bigint unsigned,
  nivellalama tinyint NOT NULL,
  validat tinyint NOT NULL,
  missatge varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/* ALTERS*/


/*analitiques*/
ALTER TABLE analitiques
  ADD CONSTRAINT `fk_idpacient` FOREIGN KEY (idpacient) REFERENCES pacients (idpacient) 
  ON UPDATE CASCADE,

  ADD CONSTRAINT `fk_iddoctor` FOREIGN KEY (iddoctor) REFERENCES doctors (iddoctor) 
  ON UPDATE CASCADE;
  
/* provestecnica*/
ALTER TABLE provestecnica
  ADD CONSTRAINT `fk_idprova` FOREIGN KEY (idprova) REFERENCES catalegproves (idprova) 
  ON UPDATE CASCADE;
/* provestecnica amb sexe i edats
CREATE TABLE provestecnica (
  idprovatecnica serial,
  idprova int ,
  sexe int NOT NULL,
  edatini int NOT NULL,
  edatfi int NOT NULL,
  dataprova timestamp NOT NULL ,
  resultat_numeric boolean NOT NULL DEFAULT true,
  minpat float NOT NULL,
  maxpat float NOT NULL,
  minpan float NOT NULL,
  maxpan float NOT NULL,
  PRIMARY KEY (idprovatecnica, sexe, edatini)
);	

ALTER TABLE provestecnica
  ADD CONSTRAINT fk_idprova FOREIGN KEY (idprova) REFERENCES catalegproves (idprova) ON UPDATE CASCADE;  
*/
/*resultas*/
ALTER TABLE resultats
  ADD CONSTRAINT `fk_idanalitica` FOREIGN KEY (idanalitica) REFERENCES analitiques (idanalitica) 
  ON UPDATE CASCADE,

  ADD CONSTRAINT `fk_idprovatecnica` FOREIGN KEY (idprovatecnica) REFERENCES provestecnica (idprovatecnica)
  ON UPDATE CASCADE;
  
/* alarmes*/ 
ALTER TABLE alarmes
  ADD CONSTRAINT `fk_idresultat` FOREIGN KEY (idresultat) REFERENCES resultats (idresultat) 
  ON UPDATE CASCADE;

/* INSERTS*/
INSERT INTO pacients (idpacient, nom, cognoms, dni, data_naix, sexe, adreca, ciutat, c_postal, telefon, email, num_ss, num_cat, nie, passaport) VALUES (default, 'jose', 'remar silva', '4811111M', '1996-07-12', 'M', 'veciana 8 2 2', 'barcelona', '08023', '989856565', 'jose@mail.com', NULL, NULL, NULL, NULL);
INSERT INTO pacients (idpacient, nom, cognoms, dni, data_naix, sexe, adreca, ciutat, c_postal, telefon, email, num_ss, num_cat, nie, passaport) VALUES (default, 'cecilia', 'vazques', '47888855M', '2007-11-12', 'F', 'tallat 27', 'cornella', '08632', '989877878', 'cesi@mail.com', NULL, NULL, 'x232233321l', NULL);
INSERT INTO doctors (iddoctor, nom, cognoms, especialitat) VALUES (default, 'albert', 'marinom', 'cirugia');
INSERT INTO doctors (iddoctor, nom, cognoms, especialitat) VALUES (default, 'maria', 'benavent', 'podologia');
INSERT INTO doctors (iddoctor, nom, cognoms, especialitat) VALUES (default, 'renzo', 'remar', 'fisioterapia');
INSERT INTO catalegproves (idprova, nom_prova, descripcio,acronim) VALUES ('101', 'glucosa', 'Es una hexosa',NULL);
INSERT INTO catalegproves (idprova, nom_prova, descripcio, acronim) VALUES ('82520', 'COCAINA', 'prueba de cocaina', 'COAC');
INSERT INTO catalegproves (idprova, nom_prova, descripcio, acronim) VALUES ('202', 'colesterol', 'test colesterol nivell en sangre', 'COL');
INSERT INTO analitiques (idanalitica, iddoctor, idpacient, dataanalitica) VALUES (default, '1', '2', CURRENT_TIMESTAMP);
INSERT INTO analitiques (idanalitica, iddoctor, idpacient, dataanalitica) VALUES (default, '1', '1', CURRENT_TIMESTAMP);
INSERT INTO analitiques (idanalitica, iddoctor, idpacient, dataanalitica) VALUES (default, '2', '1', CURRENT_TIMESTAMP);
INSERT INTO provestecnica (idprovatecnica, idprova, sexe, dataprova, minpat, maxpat, minpan, maxpan) VALUES (default, '101', 'M', CURRENT_TIMESTAMP, '80', '100', '60', '150');
INSERT INTO provestecnica (idprovatecnica, idprova, sexe, dataprova, minpat, maxpat, minpan, maxpan) VALUES (default, '101', 'F', CURRENT_TIMESTAMP, '70', '90', '50', '110');
INSERT INTO provestecnica (idprovatecnica, idprova, sexe, dataprova, minpat, maxpat, minpan, maxpan) VALUES (default, '101', 'M', '2017-11-01 00:00:00', '111', '150', '80', '170');
