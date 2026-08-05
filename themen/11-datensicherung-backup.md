# 11 — Datensicherung & Backup ⭐

> **Warum wichtig:** Backup-Fragen sind in der AP1 fast garantiert. Besonders
> beliebt: ein **schlecht gemachtes Backup** im Szenario, dessen Risiken man
> benennen und verbessern soll. Das war in Herbst 2021 Aufgabe 4f.

---

## 1. Die drei Sicherungsarten ⭐

| Art | Was wird gesichert? | Sicherungsdauer | Speicherbedarf | Wiederherstellung |
|---|---|---|---|---|
| **Vollsicherung** | **Alle** Daten, jedes Mal komplett | lang | sehr hoch | **einfach** — nur 1 Medium |
| **Differenziell** | Alle Änderungen **seit der letzten Vollsicherung** | mittel, wächst täglich | mittel, wächst | Vollsicherung + **letzte** differenzielle (2 Medien) |
| **Inkrementell** | Alle Änderungen **seit der letzten Sicherung** (egal welcher Art) | **kurz** | **gering** | Vollsicherung + **alle** inkrementellen der Reihe nach (viele Medien) |

### Der Unterschied bildlich

```
Mo: VOLL ████████████

Differenziell (immer zurück zur Vollsicherung):
Di: ██          (Änderungen seit Mo)
Mi: ████        (Änderungen seit Mo — enthält Di nochmal!)
Do: ██████      (Änderungen seit Mo — enthält Di und Mi nochmal!)
→ Restore Do: VOLL + Do        = 2 Medien ✅

Inkrementell (immer zurück zur letzten Sicherung):
Di: ██          (Änderungen seit Mo)
Mi: ██          (Änderungen seit Di)
Do: ██          (Änderungen seit Mi)
→ Restore Do: VOLL + Di + Mi + Do = 4 Medien ⚠️
```

> 🔑 **Die Merkregel, mit der du das nie wieder verwechselst:**
> **Diffe**renziell = **Diff**erenz zur **Voll**sicherung (immer derselbe Bezugspunkt).
> **Inkre**mentell = kleine **Inkremente**, immer nur der letzte Schritt.
>
> Und daraus folgt logisch alles andere:
> **Inkrementell** spart Zeit und Platz beim **Sichern**, kostet aber beim
> **Wiederherstellen**. **Differenziell** genau umgekehrt.

**Weitere Begriffe:**
- **Spiegelung / Synchronisation** — 1:1-Kopie, keine Versionen (Vorsicht: gelöschte
  Dateien werden mitgelöscht!)
- **Snapshot** — Zeitpunktabbild eines Systems/Volumes, sehr schnell, aber
  **kein vollwertiges Backup** (liegt meist auf demselben Speicher)
- **Image / Vollsicherung des Systems** — komplettes Abbild inkl. Betriebssystem,
  ermöglicht **Bare-Metal-Restore**

---

## 2. Die 3-2-1-Regel ⭐

Die wichtigste Faustregel — nenn sie in jeder Backup-Antwort:

```
3  Kopien der Daten (Original + 2 Sicherungen)
2  verschiedene Medientypen / Speichersysteme
1  Kopie AUSSER HAUS (offsite) und OFFLINE
```

Moderne Erweiterung **3-2-1-1-0**: zusätzlich **1** unveränderliche/offline Kopie
(air-gapped, immutable — gegen Ransomware) und **0** Fehler beim getesteten
Wiederherstellungsversuch.

---

## 3. RPO und RTO (Fachbegriffe, die Punkte bringen)

| Begriff | Voll | Bedeutung | Bestimmt durch |
|---|---|---|---|
| **RPO** | Recovery **Point** Objective | Wie viel **Datenverlust** ist maximal akzeptabel? | **Häufigkeit** der Sicherung |
| **RTO** | Recovery **Time** Objective | Wie lange darf die **Wiederherstellung** dauern? | Sicherungsverfahren, Medien, Ersatzhardware |

```
        RPO                      Ausfall                    RTO
  ├──────────────┤                  ✕            ├────────────────────┤
  letztes Backup                                 System wieder verfügbar
  ← dieser Zeitraum an Daten ist weg →
```

**Beispiel:** Backup läuft täglich um 23 Uhr, System fällt um 16 Uhr aus →
RPO real = **17 Stunden Datenverlust**. Ist das akzeptabel? Wenn nicht: häufiger
sichern.

---

## 4. Backup-Strategien / Generationenprinzip

**Großvater-Vater-Sohn (GVS):**
- **Sohn** — tägliche Sicherung (Mo–Do), Aufbewahrung 1 Woche
- **Vater** — wöchentliche Vollsicherung (Fr), Aufbewahrung 1 Monat
- **Großvater** — monatliche Vollsicherung, Aufbewahrung 1 Jahr

**Vorteil:** Man kann auf **mehrere Zeitpunkte** zurückgehen — wichtig, weil
Ransomware oder eine schleichende Datenverfälschung oft erst Tage später auffällt.

---

## 5. Aufbewahrungsfristen (Deutschland)

| Daten | Frist | Grundlage |
|---|---|---|
| Handelsbücher, Bilanzen, Buchungsbelege | 10 Jahre | § 257 HGB, § 147 AO |
| Handelsbriefe (empfangen/abgesandt) | 6 Jahre | § 257 HGB |
| **Patientenakten** | **10 Jahre** nach Behandlungsabschluss | § 630f BGB, Berufsordnung |
| Röntgenaufzeichnungen | bis 30 Jahre | StrlSchG |

> ⚠️ Aufbewahrungspflicht und DSGVO-Löschpflicht stehen im Spannungsfeld:
> Solange eine gesetzliche Aufbewahrungsfrist läuft, wird **nicht gelöscht**,
> sondern die Verarbeitung **eingeschränkt** (Art. 18 DSGVO). Danach ist zu löschen.

---

## 6. Fallanalyse: ein schlechtes Backup bewerten ⭐

**Szenario aus Herbst 2021, Aufgabe 4f:**
> Die Gebührenabrechnungssoftware sichert den Datenbestand **freitags beim
> Herunterfahren** des PCs auf einer **speziell eingerichteten Partition
> derselben Festplatte**.

### So findest du die Risiken systematisch — 4 Fragen

| Frage | Antwort im Szenario | → Risiko |
|---|---|---|
| **Wo** liegt die Sicherung? | Auf derselben physischen Festplatte | Bei Defekt der Festplatte sind Original **und** Sicherung weg |
| **Wie oft**? | Nur einmal pro Woche | Bis zu **einer Woche Datenverlust** (RPO viel zu hoch) |
| **Wovon abhängig**? | Vom Herunterfahren durch den Nutzer | Wird der PC nicht heruntergefahren, findet **gar keine** Sicherung statt |
| **Was ist außer Haus / offline**? | Nichts | Feuer, Wasser, Diebstahl, Ransomware vernichten alles auf einmal |

### ✅ Musterantwort — Risiken (4fa, 2 Punkte)

> 1. **Kein Schutz vor Hardwaredefekt:** Die Sicherung liegt auf einer Partition
>    derselben physischen Festplatte. Fällt diese Festplatte aus, sind sowohl der
>    Originaldatenbestand als auch die Sicherung unwiederbringlich verloren.
> 2. **Zu großer Sicherungsabstand:** Da nur einmal wöchentlich gesichert wird,
>    können bis zu fünf Arbeitstage an Abrechnungsdaten verloren gehen.
> 3. *(weitere möglich)* Die Sicherung ist vom Verhalten der Mitarbeitenden
>    abhängig — wird der PC nicht heruntergefahren, erfolgt keine Sicherung.
> 4. *(weitere möglich)* Es existiert keine externe Kopie; bei Feuer, Diebstahl
>    oder einem Ransomware-Befall sind alle Daten gleichzeitig betroffen.

### ✅ Musterantwort — Verbesserungsvorschlag (4fb, 2 Punkte)

> Es sollte eine **automatisierte tägliche Sicherung** auf ein **separates,
> externes Medium** eingerichtet werden — beispielsweise auf ein NAS mit
> anschließender verschlüsselter Auslagerung in ein Rechenzentrum oder auf
> wechselnde externe Datenträger, die außerhalb der Praxis aufbewahrt werden.
> Dabei sollte die **3-2-1-Regel** eingehalten werden (drei Kopien, zwei
> verschiedene Medien, eine Kopie außer Haus und offline). Die Sicherung ist
> zeitgesteuert und benutzerunabhängig auszuführen, zu protokollieren und
> **regelmäßig durch eine Testwiederherstellung zu überprüfen**.

> 💡 Der Satz *„und regelmäßig durch eine Testwiederherstellung überprüfen"* ist
> in solchen Aufgaben oft ein eigener Punkt — nie vergessen!

---

## 7. Die Klassiker-Fehler bei Backups (Sammlung für Risiko-Fragen)

- Sicherung auf demselben Datenträger / im selben Gebäude
- Backup ist **permanent verbunden** → Ransomware verschlüsselt es mit
- Sicherung erfolgt manuell → wird vergessen
- **Wiederherstellung wurde nie getestet** → Backup unbrauchbar, fällt erst im
  Ernstfall auf
- Sicherung ist unverschlüsselt → Datenschutzverstoß bei Verlust des Mediums
- Kein Monitoring → fehlgeschlagene Backups fallen niemandem auf
- Zu kurze Aufbewahrung → alter, sauberer Stand nicht mehr verfügbar
- Datenbanken „offen" mitkopiert → inkonsistent (richtig: Datenbank-Dump oder
  VSS/Snapshot im Anwendungs-konsistenten Modus)

---

## 8. Speichermedien für Backups

| Medium | Vorteile | Nachteile |
|---|---|---|
| **Externe HDD/SSD** | günstig, schnell, einfach | wird oft angesteckt gelassen, mechanisch empfindlich |
| **NAS** | zentral, automatisierbar, RAID | im selben Gebäude, im Netz erreichbar (Ransomware!) |
| **Bandlaufwerk (LTO)** | sehr langlebig (30 J.), **offline**, günstig pro TB, ransomwaresicher | Anschaffung teuer, langsamer sequenzieller Zugriff |
| **Cloud-Backup** | offsite, automatisch, skalierbar | Internetbandbreite, laufende Kosten, **AVV + Verschlüsselung + EU-Standort nötig** |

---

## Prüfungsfragen, die daraus kommen

1. **Erklären Sie den Unterschied zwischen inkrementeller und differenzieller
   Sicherung.** → Bezugspunkt letzte Sicherung vs. letzte Vollsicherung
2. **Welche Sicherungsart braucht die wenigsten Medien zur Wiederherstellung?**
   → Vollsicherung (1), dann differenziell (2)
3. **Erklären Sie die 3-2-1-Regel.**
4. **Beschreiben Sie zwei Risiken der beschriebenen Sicherungsstrategie.**
5. **Unterbreiten Sie einen konkreten Verbesserungsvorschlag.**
6. **Was bedeuten RPO und RTO?**
7. **Warum ersetzt ein RAID kein Backup?**
8. **Wie lange müssen Patientenakten aufbewahrt werden?** → 10 Jahre
9. **Warum muss eine Wiederherstellung getestet werden?**
