SELECT * FROM fluglinie;
DESCRIBE fluglinie;
CREATE TABLE buchung AS
	SELECT *
    FROM buchung_sample;

/*
SELECT * FROM buchung;
SELECT * FROM buchung_sample;
*/

DROP TABLE IF EXISTS buchung;

SHOW TABLES;

SELECT * FROM passagier;

INSERT INTO passagier (passagier_id, passnummer, vorname, nachname) VALUES (DEFAULT, 'P891289', 'Maria', 'Maler');

ALTER TABLE passagier
	ADD COLUMN nationalität VARCHAR(50) NOT NULL;

UPDATE passagier
	SET nationalität = 'Schweiz'
    WHERE passagier_id = #DEFAULT AUTO INCREMENT der passagier_id
    ;

ALTER TABLE passagier
	DROP nationalität;
