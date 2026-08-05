# 12 — Lastenheft, Pflichtenheft & Angebot

> **Warum wichtig:** Der Klassiker „Nennen Sie fünf Inhalte eines Lastenhefts" ist
> geschenkte Punkte — wenn man die Liste kennt. 4–8 Punkte.

---

## 1. Lastenheft vs. Pflichtenheft ⭐

Der Unterschied wird **ständig** abgefragt.

| | **Lastenheft** | **Pflichtenheft** |
|---|---|---|
| Wer schreibt es? | **Auftraggeber** (Kunde) | **Auftragnehmer** (Dienstleister) |
| Wann? | Vor der Ausschreibung | Nach Erhalt des Lastenhefts, vor Vertragsabschluss |
| Inhalt | **WAS** soll erreicht werden — Anforderungen und Ziele | **WIE** wird es umgesetzt — technische Lösung |
| Sicht | Fachlich, lösungsneutral | Technisch, konkret |
| Zweck | Grundlage für Ausschreibung/Angebot | Grundlage für Vertrag und Abnahme |

> 🔑 **Merksatz:**
> **La**stenheft = **La**st des Kunden (*„Das ist meine Last, mein Problem"*) → **WAS**
> **Pf**lichtenheft = **Pf**licht des Auftragnehmers (*„Dazu verpflichte ich mich"*) → **WIE**
>
> Und: **erst L, dann P** — alphabetisch wie zeitlich.

### Beispiel
| Lastenheft (Kunde) | Pflichtenheft (Dienstleister) |
|---|---|
| „Alle 12 Arbeitsplätze müssen auf die Patientenverwaltung zugreifen können." | „Es wird ein Terminalserver mit Windows Server 2025 eingerichtet; die Clients greifen per RDP über ein eigenes VLAN zu." |
| „Die Daten müssen täglich gesichert werden." | „Tägliche inkrementelle Sicherung um 22:00 Uhr auf NAS (RAID 5) mit wöchentlicher verschlüsselter Auslagerung in ein Rechenzentrum in Frankfurt." |

---

## 2. Inhalte eines Lastenhefts ⭐

Die Standardfrage: *„Benennen Sie fünf inhaltliche Aspekte, die in einem
Lastenheft üblicherweise enthalten sind."*

1. **Ausgangssituation / Ist-Zustand** — bestehende Systeme, Probleme, Umfeld
2. **Zielsetzung / Soll-Zustand** — was soll erreicht werden (idealerweise SMART)
3. **Funktionale Anforderungen** — welche Funktionen die Lösung erfüllen muss
4. **Nicht-funktionale Anforderungen** — Performance, Verfügbarkeit, Sicherheit,
   Bedienbarkeit, Barrierefreiheit
5. **Mengengerüst** — Anzahl Arbeitsplätze, Nutzer, Datenvolumen, Standorte
6. **Rahmenbedingungen / Randbedingungen** — vorhandene Hard-/Software,
   Schnittstellen zu Bestandssystemen, gesetzliche Vorgaben (DSGVO!)
7. **Termine / Zeitrahmen** — gewünschter Liefertermin, Meilensteine
8. **Budget / Kostenrahmen**
9. **Lieferumfang und Leistungen** — Installation, Schulung, Dokumentation, Support
10. **Abnahmekriterien** — woran wird gemessen, dass die Leistung erfüllt ist
11. **Ansprechpartner** beim Auftraggeber

> 💡 Wenn du fünf nennen sollst, nimm: **Ist-Zustand, Zielsetzung, funktionale
> Anforderungen, Mengengerüst, Termine/Budget**. Damit deckst du sicher die
> Musterlösung ab.

---

## 3. Anforderungsarten

| Art | Beschreibung | Beispiel |
|---|---|---|
| **Funktional** | *Was* das System tun soll | „Das System muss Rezepte drucken können." |
| **Nicht-funktional** | *Wie gut* / unter welchen Bedingungen | „Die Suche muss in unter 2 Sekunden ein Ergebnis liefern." |

Nicht-funktionale Kategorien (Merkhilfe **PLUS-Z**): **P**erformance,
**L**ast/Skalierbarkeit, **U**sability, **S**icherheit, **Z**uverlässigkeit /
Verfügbarkeit — dazu Wartbarkeit, Portabilität, Rechtskonformität.

**Priorisierung — MoSCoW:**
- **Mu**st have — zwingend erforderlich
- **S**hould have — wichtig, aber nicht kritisch
- **C**ould have — wünschenswert
- **W**on't have — bewusst nicht in diesem Projekt

---

## 4. Der Beschaffungsprozess

```
Bedarf ermitteln
   ↓
Lastenheft erstellen (Kunde)
   ↓
Ausschreibung / Anfrage an Lieferanten
   ↓
Angebote einholen  →  Pflichtenheft (Anbieter)
   ↓
Angebotsvergleich (quantitativ + qualitativ)
   ↓
Auftragsvergabe / Vertrag
   ↓
Lieferung & Leistung
   ↓
Wareneingangs-/Leistungskontrolle → ABNAHME
   ↓
Rechnungsprüfung & Zahlung
```

---

## 5. Angebot und Vertrag

**Bestandteile eines Angebots:** Leistungsbeschreibung, Menge, Einzel- und
Gesamtpreise (netto/brutto), Liefer- und Leistungstermin, Zahlungsbedingungen
(Skonto, Zahlungsziel), Gewährleistung, Bindefrist des Angebots, AGB.

**Vertragsarten (BGB) — kommt gelegentlich:**
| Vertragsart | Geschuldet | Beispiel |
|---|---|---|
| **Werkvertrag** (§ 631) | Ein **Erfolg** / fertiges Werk | Individualsoftware, Netzwerkinstallation |
| **Dienstvertrag** (§ 611) | Ein **Tätigwerden**, kein Erfolg | Beratung, Support nach Aufwand |
| **Kaufvertrag** (§ 433) | Übereignung einer Sache | Hardware-Kauf, Standardsoftware |
| **Mietvertrag** (§ 535) | Gebrauchsüberlassung auf Zeit | SaaS/Cloud, Hardware-Leasing |

**SLA (Service Level Agreement):** Vereinbarung über die Qualität einer
Dienstleistung — Verfügbarkeit (z. B. 99,9 %), **Reaktionszeit** (wann wird mit
der Bearbeitung begonnen), **Wiederherstellungszeit**, Servicezeiten,
Eskalationsstufen, Vertragsstrafen (Pönalen).

> ⚠️ **Reaktionszeit ≠ Lösungszeit.** Das ist eine beliebte Fangfrage.

---

## 6. Abnahme und Dokumentation

**Abnahme:** Der Auftraggeber erklärt die Leistung als vertragsgemäß erbracht.
Rechtsfolgen: Fälligkeit der Vergütung, **Beweislastumkehr** (ab jetzt muss der
Kunde Mängel beweisen), Beginn der Gewährleistungsfrist, Gefahrübergang.

**Typische Dokumentationsbestandteile eines IT-Projekts:**
- Netzplan / Netzwerkdokumentation (IP-Konzept, VLANs, Verkabelungsplan)
- Systemdokumentation (Hardware, Software, Lizenzen, Konfiguration)
- Benutzerhandbuch / Kurzanleitung für Anwender
- Administrationshandbuch
- Backup- und Notfallkonzept
- Berechtigungskonzept
- Übergabe- und Abnahmeprotokoll
- Wartungs- und Supportvereinbarung

**Warum dokumentieren?** Nachvollziehbarkeit, Wartbarkeit durch Dritte,
Unabhängigkeit von einzelnen Personen, schnellere Fehlersuche, gesetzliche
Nachweispflichten (DSGVO Art. 5 Rechenschaftspflicht), Grundlage für Erweiterungen.

---

## Prüfungsfragen, die daraus kommen

1. **Benennen Sie fünf inhaltliche Aspekte eines Lastenhefts.**
2. **Erklären Sie den Unterschied zwischen Lastenheft und Pflichtenheft. Wer
   erstellt welches?**
3. **Nennen Sie je zwei funktionale und nicht-funktionale Anforderungen.**
4. **Welche Vertragsart liegt vor und warum?** → Werk- vs. Dienstvertrag
5. **Was regelt ein SLA? Nennen Sie drei Inhalte.**
6. **Welche Bedeutung hat die Abnahme rechtlich?**
7. **Nennen Sie vier Bestandteile einer Projektdokumentation.**
