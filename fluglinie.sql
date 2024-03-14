/* Aufgabe 1 - ERD
Hints:
Passagiere haben ID (PK), Passportnummer, Vornamen, Nachnamen
Passagierdetails - ID, Geburtstag, Geschlecht, Adresse, Kontaktdaten
Buchungen - ID (PK), Platz, Preis, ID Flug
Flüge - ID (PK), Flugnummer, ZP Abfahrt, ZP Ankunft, Fluglinien-ID, Flugzeug-ID, Flughafen ID Ankunft, Flughafen ID Abfahrt
Fluglinien - ID (PK), IATA, Namen, ID Heimatflughafens
Flugzeuge - ID (PK), Kapazität, Flugzeugtyp, Fluglinie  
Flugzeugtyp - ID (PK), Kennung, Beschreibung  
Flughafen - ID (PK), Namen, Stadt, Land, weitere geografische Werte.
 */
 
 ## 2.3 Erstelle eine leere Tabelle fluglinie

DROP TABLE IF EXISTS `fluglinie`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;

CREATE TABLE `fluglinie` (
  `fluglinie_id` smallint(6) NOT NULL AUTO_INCREMENT,
  `IATA` varchar(50) NOT NULL,
  `stadt` varchar(50) DEFAULT NULL,
  `land` varchar(50) DEFAULT NULL,
  `breite` decimal(11,8) NOT NULL,
  `laenge` decimal(11,8) NOT NULL,
  `geolokation` varchar(50) NOT NULL,
  KEY `flughafen_idx` (`flughafen_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1021 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ;