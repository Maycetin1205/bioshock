# 14 — Softwareentwicklung-Basics (für Anwendungsentwickler)

> **Warum wichtig:** In der AP1 ist das noch nicht der Schwerpunkt (das kommt in
> Teil 2), aber Datenmodellierung, einfache SQL-Abfragen, Pseudocode und
> Struktogramme tauchen regelmäßig als Teilaufgabe auf — 4–10 Punkte.

---

## 1. Datentypen

| Typ | Beschreibung | Beispiel | Speicher |
|---|---|---|---|
| **Integer** (int) | Ganzzahl | 42, −7 | 4 Byte |
| **Float / Double** | Gleitkommazahl | 3,14 | 4 / 8 Byte |
| **Boolean** | Wahrheitswert | true / false | 1 Bit/Byte |
| **Char** | Einzelzeichen | 'A' | 1–2 Byte |
| **String** | Zeichenkette | "Hallo" | variabel |
| **Date/DateTime** | Datum/Zeit | 2026-08-05 | variabel |

**Wertebereich:** Ein vorzeichenbehafteter Integer mit n Bit umfasst
`−2^(n−1)` bis `2^(n−1) − 1`. Bei 8 Bit: **−128 bis 127**. Ohne Vorzeichen
(unsigned): `0 bis 2^n − 1`, bei 8 Bit **0 bis 255**.

> ⚠️ **Warum nie `float` für Geldbeträge?** Gleitkommazahlen sind binär nicht
> exakt (0,1 + 0,2 ≠ 0,3). Für Geld nimmt man `decimal` oder rechnet in Cent
> als Integer. Beliebte Prüfungsfrage!

---

## 2. Kontrollstrukturen & Pseudocode

```
// Sequenz
x = 5

// Verzweigung
WENN bedingung DANN
    anweisung
SONST
    anweisung
ENDE WENN

// Kopfgesteuerte Schleife (Bedingung zuerst → evtl. 0 Durchläufe)
SOLANGE bedingung
    anweisung
ENDE SOLANGE

// Fußgesteuerte Schleife (Bedingung am Ende → mind. 1 Durchlauf)
WIEDERHOLE
    anweisung
BIS bedingung

// Zählschleife
FÜR i VON 1 BIS 10
    anweisung
ENDE FÜR
```

**Struktogramm (Nassi-Shneiderman):** Rechtecke von oben nach unten, Verzweigung
als Dreieck mit zwei Spalten, Schleife als umschließender Rahmen.
**PAP (Programmablaufplan, DIN 66001):**
Oval = Start/Ende · Rechteck = Verarbeitung · **Raute = Verzweigung** ·
Parallelogramm = Ein-/Ausgabe · Pfeile = Ablauf.

---

## 3. Datenbanken & ER-Modell ⭐

### Begriffe
- **Tabelle (Entität)** — z. B. `Patient`
- **Attribut (Spalte)** — z. B. `Nachname`
- **Datensatz (Tupel/Zeile)** — ein konkreter Patient
- **Primärschlüssel (PK)** — eindeutige Identifikation, nie NULL, nie doppelt
- **Fremdschlüssel (FK)** — verweist auf den PK einer anderen Tabelle
- **Referentielle Integrität** — ein FK muss auf einen existierenden PK zeigen

### Kardinalitäten
| Beziehung | Beispiel | Umsetzung |
|---|---|---|
| **1:1** | Mitarbeiter ↔ Dienstwagen | FK in einer der beiden Tabellen |
| **1:n** | Arzt → Termine | **FK auf der n-Seite** |
| **n:m** | Patient ↔ Diagnose | **Zwischentabelle** mit beiden FKs |

> 🔑 **Die wichtigste Regel:** Eine **n:m-Beziehung** lässt sich in einer
> relationalen Datenbank **nicht direkt** abbilden — sie wird immer in zwei
> 1:n-Beziehungen über eine **Zwischen-/Verknüpfungstabelle** aufgelöst.

### Normalformen
| NF | Regel | Merksatz |
|---|---|---|
| **1. NF** | Alle Attribute sind **atomar** (unteilbar), keine Wiederholgruppen | Keine Liste in einer Zelle |
| **2. NF** | 1. NF **und** jedes Nichtschlüsselattribut hängt vom **gesamten** Schlüssel ab | Nur relevant bei zusammengesetztem PK |
| **3. NF** | 2. NF **und** keine **transitiven** Abhängigkeiten (Nichtschlüssel → Nichtschlüssel) | PLZ → Ort gehört in eine eigene Tabelle |

**Ziel der Normalisierung:** Redundanzen vermeiden → keine Anomalien beim
Einfügen, Ändern und Löschen; konsistente Daten.

### SQL — die Basis
```sql
-- Abfragen
SELECT nachname, vorname
FROM patient
WHERE geburtsdatum < '1960-01-01'
ORDER BY nachname ASC;

-- Verknüpfen
SELECT p.nachname, t.datum
FROM patient p
JOIN termin t ON t.patient_id = p.id
WHERE t.datum >= '2026-01-01';

-- Gruppieren
SELECT arzt_id, COUNT(*) AS anzahl
FROM termin
GROUP BY arzt_id
HAVING COUNT(*) > 10;

-- Ändern
INSERT INTO patient (nachname, vorname) VALUES ('Yilmaz', 'Ayse');
UPDATE patient SET telefon = '0123' WHERE id = 5;
DELETE FROM patient WHERE id = 5;
```

**Reihenfolge merken:** `SELECT … FROM … JOIN … WHERE … GROUP BY … HAVING …
ORDER BY … LIMIT`

> ⚠️ **WHERE vs. HAVING:** `WHERE` filtert **einzelne Zeilen vor** der
> Gruppierung, `HAVING` filtert **Gruppen nach** der Gruppierung. Klassische
> Prüfungsfrage.

**Aggregatfunktionen:** `COUNT()`, `SUM()`, `AVG()`, `MIN()`, `MAX()`

**ACID (Transaktionseigenschaften):** **A**tomarität (ganz oder gar nicht),
**C**onsistency (konsistenter Zustand), **I**solation (Transaktionen stören sich
nicht), **D**urability (Ergebnisse sind dauerhaft gespeichert).

---

## 4. UML — die drei relevanten Diagramme

| Diagramm | Zeigt | Typische AP1-Frage |
|---|---|---|
| **Use-Case-Diagramm** | Akteure und ihre Anwendungsfälle | „Zeichnen Sie das Anwendungsfalldiagramm für …" |
| **Klassendiagramm** | Klassen mit Attributen/Methoden und Beziehungen | „Ergänzen Sie die Kardinalitäten" |
| **Aktivitätsdiagramm** | Ablauf/Prozess mit Verzweigungen | „Modellieren Sie den Ablauf" |

**Sichtbarkeiten im Klassendiagramm:** `+` public · `−` private · `#` protected

**OOP-Grundprinzipien:**
- **Kapselung** — Attribute sind `private`, Zugriff nur über Methoden (Getter/Setter)
- **Vererbung** — Unterklasse erbt Eigenschaften der Oberklasse
- **Polymorphie** — gleicher Methodenaufruf, unterschiedliches Verhalten
- **Abstraktion** — nur das Wesentliche modellieren

---

## 5. Software-Qualität und Tests

| Testart | Was wird geprüft |
|---|---|
| **Unit-/Modultest** | Einzelne Funktion/Klasse isoliert |
| **Integrationstest** | Zusammenspiel mehrerer Module |
| **Systemtest** | Gesamtsystem gegen die Anforderungen |
| **Abnahmetest** | Durch den Kunden, gegen Lasten-/Pflichtenheft |
| **Regressionstest** | Funktioniert das Alte nach einer Änderung noch? |

**Black Box** = ohne Kenntnis des Codes, nur Ein-/Ausgabe.
**White Box** = mit Kenntnis des Codes, Pfadabdeckung.

**Testfälle für Grenzwerte** (Äquivalenzklassen): Bei „Alter zwischen 18 und 65"
testet man **17, 18, 65, 66** — Fehler sitzen fast immer an den Grenzen.

---

## Prüfungsfragen, die daraus kommen

1. **Wandeln Sie das ER-Modell in ein relationales Modell um.**
2. **Wie wird eine n:m-Beziehung aufgelöst?** → Zwischentabelle
3. **Formulieren Sie eine SQL-Abfrage, die …**
4. **Was ist der Unterschied zwischen WHERE und HAVING?**
5. **Nennen Sie die Bedingungen der 1., 2. und 3. Normalform.**
6. **Warum sollte man für Geldbeträge keinen Datentyp float verwenden?**
7. **Erstellen Sie ein Struktogramm / einen PAP für folgenden Ablauf.**
8. **Welche Testarten gibt es? Erklären Sie zwei davon.**
9. **Was bedeutet Kapselung in der OOP?**
