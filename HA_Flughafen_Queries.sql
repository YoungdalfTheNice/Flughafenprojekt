## Aufgabe 1

SELECT min(preis),max(preis),avg(preis) from buchung;

## Aufgabe 2

SELECT p.vorname, p.nachname, b.passagier_id, preis

from buchung b

INNER JOIN passagier p ON b.passagier_id = p.passagier_id

Order by preis DESC
;

## Aufgabe 3 Welche Fluglinie hat die durchschnittlich teuersten Tickets?

SELECT sq1.namen AS "Teuerste Fluglinie", sq1.durchschnittspreis_linie AS "Durchschnittlicher Ticketpreis"
FROM (
    SELECT fl.fluglinie_id, fl.namen, AVG(b.preis) AS "durchschnittspreis_linie"
    FROM flug f
    INNER JOIN buchung b ON f.flug_id = b.flug_id
    INNER JOIN fluglinie fl ON f.fluglinie_id = fl.fluglinie_id
    GROUP BY fl.fluglinie_id, fl.namen
) AS sq1
ORDER BY sq1.durchschnittspreis_linie DESC
LIMIT 1;

## Aufgabe 4 Welche sind die fünf Flugzeuge mit der höchsten Kapazität, die vom Flughafen ALTAMIRA abgeflogen sind?

SELECT f.flugzeug_id, fz.kapazitaet, f.von, fh.name

from flug f

INNER JOIN flugzeug fz ON f.flugzeug_id = fz.flugzeug_id
INNER JOIN flughafen fh ON f.von = fh.flughafen_id

WHERE fh.name like "ALTAMIRA"

Order by fz.kapazitaet DESC

LIMIT 5
;

## Aufgabe 5 Wie viele Personen hat die Airline Spain Airlines vom 2015-06-06 bis zum 2015-06-08 transportiert?

SELECT SUM(sq2.passagiere_pro_flug) AS Personenzahl, sq2.namen
FROM (
    SELECT COUNT(b.buchung_id) AS "passagiere_pro_flug", f.abflug, fl.namen
    FROM buchung b
    INNER JOIN flug f ON b.flug_id = f.flug_id
    INNER JOIN fluglinie fl ON f.fluglinie_id = fl.fluglinie_id
    WHERE fl.namen LIKE 'Spain Airlines'
    AND DATE(f.abflug) BETWEEN '2015-06-06' AND '2015-06-08'
    GROUP BY f.abflug, fl.namen
) sq2
GROUP BY sq2.namen;

## Aufgabe 6 

SELECT f.flugnr, fz.kapazitaet, count(b.buchung_id) AS passagiere_pro_flug,

CASE WHEN (count(b.buchung_id)/fz.kapazitaet) > 0.1
	THEN 'Geringe Auslastung'
ELSE 'Normale Auslastung'
END AS Auslastung

FROM flug f

INNER JOIN flugzeug fz ON f.flugzeug_id = fz.flugzeug_id
INNER JOIN buchung b ON f.flug_id = b.flug_id

GROUP BY f.flugnr, fz.kapazitaet
;

## Aufgabe 7 Welche Fluglinie fliegt am meisten zum Flughafen KAGOSHIMA? 

SELECT count(f.flug_id) AS Flüge_insgesamt, fl.namen, fh.name

from flug f

INNER JOIN fluglinie fl ON f.fluglinie_id = f.fluglinie_id
INNER JOIN flughafen fh ON f.nach = fh.flughafen_id

WHERE fh.name like "KAGOSHIMA"

GROUP BY fl.namen, fh.name
Order by Flüge_insgesamt DESC

LIMIT 1
;

## Aufgabe 8 Welche Flugzeuge einer Fluglinie mit einem italienischen Flughafen als Basis machen die meisten Flüge und was für ein Typ sind sie?

SELECT sum(sq3.Flüge_insgesamt) AS Anzahl_Flüge, sq3.flugzeug_id, sq3.land, sq3.namen  
from
(SELECT count(f.fluglinie_id) AS Flüge_insgesamt, f.flugzeug_id, fzt.bezeichnung, fl.namen, fl.heimatflughafenID, fh.land, fh.name

from flug f

INNER JOIN fluglinie fl ON f.fluglinie_id = f.fluglinie_id
INNER JOIN flughafen fh ON f.nach = fh.flughafen_id
INNER JOIN flugzeug fz ON f.flugzeug_id = fz.flugzeug_id
INNER JOIN flugzeug_typ fzt ON fz.typ_id = fzt.typ_id

WHERE fh.land like "ITALY"

GROUP BY f.flugzeug_id, fl.namen, fl.heimatflughafenID, fh.land, fh.name

) sq3

GROUP BY sq3.flugzeug_id, sq3.land, sq3.namen
ORDER BY Anzahl_Flüge DESC
;

## Aufgabe 9 Wie groß sind die gesamten Anteile in Prozent aller Buchungen je nach Flugzeugtyp?

SELECT fzt.bezeichnung, count(b.buchung_id) AS Anzahl_Buchungen, 
	(count(b.buchung_id) / (SELECT count(*) FROM buchung)) * 100 AS Prozentualer_Anteil
FROM
    buchung b
INNER JOIN
    flug f ON b.flug_id = f.flug_id
INNER JOIN
    flugzeug fz ON f.flugzeug_id = fz.flugzeug_id
INNER JOIN
    flugzeug_typ fzt ON fz.typ_id = fzt.typ_id
GROUP BY
    fzt.bezeichnung
ORDER BY
    Prozentualer_Anteil DESC;


