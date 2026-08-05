# Musterlösung — AP1 Herbst 2021, Teil 1

**Fachinformatiker/-in Anwendungsentwicklung (AO 2020)**
Prüfungstermin: Mittwoch, 29. September 2021 · 90 Minuten · **100 Punkte**

**Szenario:** Du bist Mitarbeiter/-in der **IT.SYS GmbH** (Systemhaus). Kunde ist
die **Arztpraxis Care**, die an einen neuen Standort zieht; die IT wird teilweise
erneuert. Die IT.SYS GmbH plant und setzt den Umzug um.

> 📌 **So arbeitest du mit dieser Datei:** Erst die Aufgabe selbst lösen, dann
> vergleichen. Zu jeder Aufgabe steht dabei, **welches Lernmodul** dahintersteckt
> und **worauf der Korrektor achtet**.

---

# 1. Aufgabe — Projektplanung (25 Punkte)

📖 Module: [01 Projektmanagement](../themen/01-projektmanagement.md) ·
[02 Netzplantechnik](../themen/02-netzplantechnik.md)

## a) Vier Merkmale eines Projekts (4 Punkte)

> **Lösung** (vier beliebige davon, je 1 Punkt):
> 1. **Einmaligkeit** — das Vorhaben ist in dieser Form neu, es handelt sich nicht
>    um eine Routineaufgabe
> 2. **Zeitliche Begrenzung** — es gibt einen festgelegten Anfangs- und Endtermin
> 3. **Klare Zielvorgabe** — ein definiertes Projektziel ist vorgegeben
> 4. **Begrenzte Ressourcen** — Personal, Budget und Sachmittel stehen nur in
>    begrenztem Umfang zur Verfügung
> 5. *(alternativ)* Komplexität, eigene Projektorganisation, Interdisziplinarität, Risiko

⚠️ **Achtung:** Es sind **genau vier** gefordert. Schreibst du sechs, werden nur
die **ersten vier** gewertet — steht so in den Bearbeitungshinweisen.

## b) Die vier weiteren SMART-Kriterien (4 Punkte)

Vorgegeben war bereits: **S** = specific / spezifisch

> **Lösung:**
> - **M** = measurable / **messbar**
> - **A** = achievable / accepted / **erreichbar bzw. akzeptiert**
> - **R** = reasonable / relevant / **angemessen bzw. realistisch**
> - **T** = time-bound / terminated / **terminiert (mit festem Endtermin)**

Deutsch **oder** Englisch ist zulässig.

## c) Netzplan vervollständigen (14 Punkte) ⭐

### Gegebene Vorgangsliste

| Vorgang | Beschreibung | Dauer (h) | Vorgänger |
|---|---|---|---|
| A | Ist-Analyse | 2 | — |
| B | Soll-Konzept | 4 | A |
| C | Beschaffung neuer Server | 3 | B |
| D | Installation strukturierter Netzwerk-Verkabelung | 8 | B |
| E | Datensicherung | 2 | B |
| F | Dokumentation des neuen Netzwerkes | 5 | B |
| G | Installation neuer Server | 4 | C, D |
| H | Abbau alter Infrastruktur | 1 | E |
| I | Einrichtung Clients | 3 | G, H |
| J | Funktionstest | 1 | I |
| K | Übergabe und Einweisung der Mitarbeiter | 2 | F, J |

### Vorwärtsrechnung — FAZ und FEZ
*(Regel: `FEZ = FAZ + Dauer`, `FAZ = **größter** FEZ der Vorgänger`)*

| Vorgang | Herleitung FAZ | FAZ | FEZ |
|---|---|---|---|
| A | Start | 0 | 2 |
| B | FEZ(A) | 2 | 6 |
| C | FEZ(B) | 6 | 9 |
| D | FEZ(B) | 6 | 14 |
| E | FEZ(B) | 6 | 8 |
| F | FEZ(B) | 6 | 11 |
| G | **max**(9 ; 14) | **14** | 18 |
| H | FEZ(E) | 8 | 9 |
| I | **max**(18 ; 9) | **18** | 21 |
| J | FEZ(I) | 21 | 22 |
| K | **max**(11 ; 22) | **22** | 24 |

➡️ **Projektdauer = 24 Stunden**

### Rückwärtsrechnung — SEZ und SAZ
*(Regel: `SAZ = SEZ − Dauer`, `SEZ = **kleinster** SAZ der Nachfolger`)*

| Vorgang | Herleitung SEZ | SEZ | SAZ |
|---|---|---|---|
| K | = FEZ(K) | 24 | 22 |
| J | SAZ(K) | 22 | 21 |
| F | SAZ(K) | 22 | 17 |
| I | SAZ(J) | 21 | 18 |
| G | SAZ(I) | 18 | 14 |
| H | SAZ(I) | 18 | 17 |
| C | SAZ(G) | 14 | 11 |
| D | SAZ(G) | 14 | 6 |
| E | SAZ(H) | 17 | 15 |
| B | **min**(11 ; 6 ; 15 ; 17) | **6** | 2 |
| A | SAZ(B) | 2 | **0** ✅ |

✅ **Kontrolle bestanden:** SAZ(A) = 0 → die Rechnung ist korrekt.

### Gesamtergebnis mit Puffern

| Vorgang | FAZ | FEZ | SAZ | SEZ | **GP** | **FP** | kritisch? |
|---|---|---|---|---|---|---|---|
| **A** | 0 | 2 | 0 | 2 | **0** | 0 | ✅ |
| **B** | 2 | 6 | 2 | 6 | **0** | 0 | ✅ |
| C | 6 | 9 | 11 | 14 | 5 | 5 | |
| **D** | 6 | 14 | 6 | 14 | **0** | 0 | ✅ |
| E | 6 | 8 | 15 | 17 | 9 | 0 | |
| F | 6 | 11 | 17 | 22 | 11 | 11 | |
| **G** | 14 | 18 | 14 | 18 | **0** | 0 | ✅ |
| H | 8 | 9 | 17 | 18 | 9 | 9 | |
| **I** | 18 | 21 | 18 | 21 | **0** | 0 | ✅ |
| **J** | 21 | 22 | 21 | 22 | **0** | 0 | ✅ |
| **K** | 22 | 24 | 22 | 24 | **0** | 0 | ✅ |

`GP = SAZ − FAZ` · `FP = kleinster FAZ der Nachfolger − eigener FEZ`

## d) Kritischen Pfad markieren (1 Punkt)

> **Lösung:** **A → B → D → G → I → J → K**
> (alle Vorgänge mit Gesamtpuffer = 0)
>
> Probe: 2 + 4 + 8 + 4 + 3 + 1 + 2 = **24 Stunden** ✅

## e) Vorgang H verzögert sich um vier Stunden (2 Punkte)

> **Lösung:** Vorgang H liegt **nicht** auf dem kritischen Pfad und verfügt über
> einen **Gesamtpuffer von 9 Stunden**. Da die Verzögerung von 4 Stunden kleiner
> ist als dieser Puffer, hat sie **keine Auswirkung auf das Projektende** — das
> Projekt bleibt bei einer Gesamtdauer von **24 Stunden**. Der verbleibende
> Gesamtpuffer von H reduziert sich lediglich von 9 auf 5 Stunden.

💡 **Merkschema für jede Verzögerungsfrage:**
`Verzögerung ≤ GP` → keine Auswirkung · `Verzögerung > GP` → Projektende
verschiebt sich um `(Verzögerung − GP)`.

---

# 2. Aufgabe — Energieeffizienz & Skript (25 Punkte)

📖 Module: [03 Elektrotechnik & Energie](../themen/03-elektrotechnik-energie.md) ·
[04 Kaufmännisches Rechnen](../themen/04-kaufmaennisches-rechnen.md) ·
[08 Skripting](../themen/08-betriebssysteme-skripting.md)

**Gegeben:** 9 Betriebsstunden/Tag · 20 Arbeitstage/Monat · 0,30 EUR/kWh
PC-A: Netzteil ohne Zertifikat, η = 43 % · PC-B: 80 PLUS Gold, η = 76 %
Leistungsbedarf der Komponenten: jeweils 60 W

## a) Leistung und Energiekosten pro Monat (6 Punkte)

**Formel aus dem englischen Manual:**
`Efficiency = Useful power output / Total power input` → `η = P_ab / P_zu`
Umgestellt: **`P_zu = P_ab / η`**

### Schritt 1 — Leistungsaufnahme aus dem Netz
```
PC-A:  P_zu = 60 W / 0,43 = 139,53 W       (Kontrollwert, war vorgegeben ✅)
PC-B:  P_zu = 60 W / 0,76 = 78,947… W  ≈  78,95 W
```

### Schritt 2 — Betriebsstunden pro Monat
```
9 h/Tag × 20 Tage = 180 h/Monat
```

### Schritt 3 — Energiekosten
```
PC-A:  139,53 W × 180 h = 25.115,4 Wh = 25,1154 kWh
       25,1154 kWh × 0,30 EUR/kWh = 7,5346… EUR  ≈  7,53 EUR

PC-B:   78,95 W × 180 h = 14.211,0 Wh = 14,2110 kWh
       14,2110 kWh × 0,30 EUR/kWh = 4,2633 EUR    ≈  4,26 EUR
```

### Ausgefüllte Tabelle

| | **PC-A** | **PC-B** |
|---|---|---|
| Wirkungsgrad des Netzteils bei 60 W | 43 % | 76 % |
| Benötigte durchschnittliche Leistung | 60 W | 60 W |
| **Vom Netzteil bezogene Leistung** | 139,53 W | **78,95 W** |
| **Energiekosten pro Monat** | **7,53 EUR** | **4,26 EUR** |

⚠️ **Die zwei Fehlerquellen hier:**
1. `60 × 0,43` statt `60 / 0,43` rechnen — die Netzaufnahme muss **größer** als
   60 W sein!
2. Wh nicht durch **1000** teilen.

## b) Amortisationsdauer (4 Punkte)

Der PC mit Gold-Netzteil kostet **100 EUR mehr** in der Anschaffung.

```
Ersparnis pro Monat     = 7,53 EUR − 4,26 EUR = 3,27 EUR
Amortisationsdauer      = 100 EUR / 3,27 EUR/Monat = 30,58… Monate
                        → aufgerundet: 31 Monate
```

> **Antwortsatz:** Die Mehrkosten von 100 EUR haben sich nach **31 Monaten**
> (rund 2 Jahre und 7 Monate) durch die eingesparten Energiekosten amortisiert.

**Mit den vorgegebenen Ersatzwerten** (falls a) nicht gelöst wurde — 6,83 EUR /
4,78 EUR):
```
Ersparnis = 6,83 − 4,78 = 2,05 EUR/Monat
100 EUR / 2,05 EUR = 48,78 → 49 Monate
```

⚠️ **Immer aufrunden!** Nach 30 Monaten sind die 100 EUR noch nicht ganz wieder
eingespielt.

## c) Drei Vorschläge zur Senkung der Energiekosten (3 Punkte)

> **Lösung** (drei beliebige, je 1 Punkt):
> 1. **Energiesparoptionen aktivieren** — Bildschirm und Festplatten nach kurzer
>    Inaktivität abschalten, Ruhezustand nutzen
> 2. **Geräte nach Feierabend vollständig vom Netz trennen** über schaltbare
>    Steckdosenleisten → vermeidet Standby-Verluste
> 3. **Energieeffiziente Hardware einsetzen** — LED-Monitore, SSDs statt HDDs,
>    Notebooks oder Thin Clients statt Desktop-PCs
> 4. *(alternativ)* Zentraler Netzwerkdrucker statt vieler Einzeldrucker
> 5. *(alternativ)* Server virtualisieren und konsolidieren
> 6. *(alternativ)* Mitarbeitende sensibilisieren, automatisches Herunterfahren
>    per Gruppenrichtlinie

## d) Nachweis der Überlastung der Mehrfachsteckdose (4 Punkte)

**Gegeben:** Mehrfachsteckdose „maximal 16 A" · 3 PCs à 180 W · Drucker 400 W ·
Kaffeemaschine 1.200 W · Klimagerät 2.000 W

```
Schritt 1 — Gesamtleistung:
    3 × 180 W  =    540 W
    Drucker    =    400 W
    Kaffee     =  1.200 W
    Klimagerät =  2.000 W
    ─────────────────────
    Gesamt     =  4.140 W

Schritt 2 — Stromstärke (Netzspannung 230 V):
    I = P / U = 4.140 W / 230 V = 18 A

Schritt 3 — Vergleich:
    18 A > 16 A  →  Überlastung
```

> **Antwortsatz:** Die Geräte benötigen zusammen 4.140 W. Bei einer Netzspannung
> von 230 V ergibt das eine Stromstärke von **18 A**. Da die Mehrfachsteckdose auf
> maximal **16 A** ausgelegt ist, wird sie überlastet — die Sicherung würde
> auslösen bzw. es bestünde Brand- und Überhitzungsgefahr. Die Geräte dürfen
> daher **nicht gleichzeitig** betrieben werden.

**Alternativer, ebenso gültiger Rechenweg:**
`P_max = 230 V × 16 A = 3.680 W` → `4.140 W > 3.680 W` → Überlastung.

## e) Zwei Fehler im PowerShell-Skript korrigieren (8 Punkte)

**Ziel des Skripts:** Warnung ausgeben, wenn der freie Speicherplatz auf
Laufwerk Z **unter 15 %** fällt.
**Beobachtetes Fehlverhalten:** Warnung erscheint, obwohl das Laufwerk nur zu
**50 %** gefüllt ist.

### Fehlerhaftes Skript
```powershell
$Drive = Get-Volume -DriveLetter Z
$Prozent = ($Drive.SizeRemaining / $Drive.Size) * 1000    # ← Fehler 1
if ($Prozent -gt 15)                                       # ← Fehler 2
{
    Write-Host "Es sind weniger als 15% Speicherplatz frei."
}
else
{
    Write-Host "Es ist genügend Speicherplatz verfügbar."
}
```

### Fehleranalyse mit dem Beispielwert (50 % frei)

| | Rechnung | Ergebnis |
|---|---|---|
| **Fehler 1** | `0,5 × 1000` | `500` — sollte `50` sein. Für eine Prozentangabe wird mit **100** multipliziert, nicht mit 1000 |
| **Fehler 2** | `if (500 -gt 15)` | **wahr** → Warnung wird ausgegeben. Gesucht ist aber „**unter** 15 %", also `-lt` (**l**ess **t**han) statt `-gt` (**g**reater **t**han) |

### Korrigierte Zeilen (das gehört in die Spalte „Falsche Zeilen korrigieren")

```powershell
$Prozent = ($Drive.SizeRemaining / $Drive.Size) * 100      # ✅ Fehler 1 behoben
if ($Prozent -lt 15)                                        # ✅ Fehler 2 behoben
```

**Kontrolle:** 50 % frei → `0,5 × 100 = 50` → `50 -lt 15` = **falsch** →
else-Zweig → „Es ist genügend Speicherplatz verfügbar." ✅ Korrekt.

---

# 3. Aufgabe — Beschaffung, Migration, Beratung (26 Punkte)

📖 Module: [12 Lastenheft](../themen/12-lastenheft-pflichtenheft.md) ·
[04 Rechnen](../themen/04-kaufmaennisches-rechnen.md) ·
[07 Netzwerk/Remote](../themen/07-netzwerktechnik.md) ·
[13 Schulung](../themen/13-kundenberatung-schulung.md) ·
[06 RAID](../themen/06-raid-und-speicher.md)

## a) Fünf inhaltliche Aspekte eines Lastenhefts (5 Punkte)

> **Lösung** (fünf beliebige, je 1 Punkt):
> 1. **Ausgangssituation / Ist-Zustand** — Beschreibung der vorhandenen IT und
>    der bestehenden Probleme
> 2. **Zielsetzung / Soll-Zustand** — was mit dem Projekt erreicht werden soll
> 3. **Funktionale Anforderungen** — welche Funktionen die Lösung erfüllen muss
> 4. **Nicht-funktionale Anforderungen** — Verfügbarkeit, Performance, Sicherheit,
>    Datenschutz, Bedienbarkeit
> 5. **Mengengerüst** — Anzahl der Arbeitsplätze, Nutzer, Datenvolumen
> 6. *(alternativ)* Rahmenbedingungen und Schnittstellen zu Bestandssystemen
> 7. *(alternativ)* Termine und Meilensteine
> 8. *(alternativ)* Budget / Kostenrahmen
> 9. *(alternativ)* Abnahmekriterien
> 10. *(alternativ)* Lieferumfang (Installation, Schulung, Dokumentation, Support)

💡 **Merke:** Das **Lastenheft** schreibt der **Auftraggeber** und beschreibt das
**WAS**. Das **Pflichtenheft** schreibt der **Auftragnehmer** und beschreibt das
**WIE**.

## ba) Gesamtkosten der Migration (2 Punkte)

**Gegeben:** 20 Postfächer · je 2 h Migration · Dienstleister 130 EUR/h

```
Gesamtaufwand = 20 Postfächer × 2 h/Postfach = 40 h
Gesamtkosten  = 40 h × 130 EUR/h             = 5.200 EUR
```

> **Antwortsatz:** Die IT.SYS GmbH müsste Gesamtkosten von **5.200 EUR**
> berücksichtigen.

⚠️ Der Rechenweg ist ausdrücklich gefordert — beide Zeilen hinschreiben!

## bb) Anzahl der Arbeitstage (2 Punkte)

**Gegeben:** zwei Angestellte · je 8 h Arbeitszeit pro Tag

```
Kapazität pro Tag = 2 Personen × 8 h = 16 h/Tag
Benötigte Tage    = 40 h / 16 h/Tag  = 2,5 Tage
                  → aufgerundet: 3 Arbeitstage
```

> **Antwortsatz:** Die Migration ist frühestens nach **3 Arbeitstagen**
> abgeschlossen.

⚠️ **Aufrunden nicht vergessen** — nach 2,5 Tagen ist die Arbeit noch nicht
abgeschlossen, der dritte Tag wird angebrochen.

## c) Je zwei Vor- und Nachteile der Remote-Wartung (4 Punkte)

> **Vorteile:**
> 1. **Keine Anfahrt** — es entfallen Fahrzeit und Fahrtkosten, dadurch geringere
>    Kosten für den Kunden und mehr bearbeitete Fälle pro Tag
> 2. **Schnellere Reaktionszeit** — die Unterstützung kann sofort beginnen, ohne
>    dass ein Vor-Ort-Termin vereinbart werden muss
>
> **Nachteile:**
> 1. **Hardwareprobleme sind nicht lösbar** — defekte Geräte, Kabel oder
>    Austausch von Komponenten erfordern zwingend einen Einsatz vor Ort
> 2. **Setzt eine funktionierende Internet- bzw. Netzwerkverbindung voraus** —
>    genau bei Netzwerkstörungen ist die Fernwartung nicht möglich
> 3. *(alternativ)* **Datenschutz- und Sicherheitsrisiko** — der Dienstleister
>    erhält Zugriff auf ein System mit Patientendaten; nötig sind ein
>    Auftragsverarbeitungsvertrag (Art. 28 DSGVO), verschlüsselte Verbindung und
>    Protokollierung

## d) Drei von vier Möglichkeiten der Wissensvermittlung beschreiben (6 Punkte)

⚠️ Gefordert ist **beschreiben**, nicht nennen — also jeweils ein bis zwei
vollständige Aussagen. Je 2 Punkte.

> **(1) Schulung am Arbeitsplatz:**
> Die Mitarbeitenden werden direkt an ihrem eigenen Arbeitsplatz und an der real
> genutzten Software eingewiesen, während ein Trainer sie begleitet. Die Inhalte
> sind dadurch unmittelbar praxisbezogen, individuelle Rückfragen können sofort
> geklärt werden. Nachteilig sind der hohe Personalaufwand und die Störung des
> laufenden Praxisbetriebs.

> **(2) Webinare:**
> Die Schulung findet live über eine Videokonferenz statt; ein Referent
> präsentiert die Inhalte und die Teilnehmenden können in Echtzeit Fragen stellen.
> Es fallen keine Reisekosten an und es können viele Personen gleichzeitig
> teilnehmen, auch von verschiedenen Standorten. Der Bezug zum eigenen System ist
> jedoch geringer und praktische Übungen sind nur eingeschränkt möglich.

> **(3) Video-Tutorien:**
> Vorproduzierte Lernvideos zeigen die Bedienung der Programme Schritt für
> Schritt und stehen jederzeit zum Abruf bereit. Die Mitarbeitenden können in
> ihrem eigenen Tempo lernen und Abschnitte beliebig oft wiederholen. Rückfragen
> sind allerdings nicht möglich und die Videos müssen bei Softwareänderungen neu
> erstellt werden.

> **(4) Multiplikatoren-Schulung:**
> Einzelne Mitarbeitende werden intensiv geschult und geben ihr Wissen
> anschließend an ihre Kolleginnen und Kollegen weiter. Das ist bei vielen zu
> schulenden Personen kostengünstig und schafft dauerhafte Ansprechpartner in der
> Praxis. Die Qualität der Weitergabe hängt jedoch stark vom Multiplikator ab,
> und es kann Wissen verloren gehen.

## e) RAID 0, 1 und 5 erklären und begründet empfehlen (7 Punkte)

**Prioritäten laut Aufgabe:** hohe Verfügbarkeit · Ausfall **einer** Festplatte
soll kompensiert werden · Kapazitätsverlust soll **gering** bleiben

> **RAID 0 (Striping):** Die Daten werden in Blöcke aufgeteilt und gleichmäßig
> auf mindestens zwei Festplatten verteilt. Dadurch erhöhen sich Lese- und
> Schreibgeschwindigkeit und die volle Speicherkapazität steht zur Verfügung. Es
> gibt jedoch **keinerlei Redundanz** — fällt eine Festplatte aus, sind **alle**
> Daten des Verbunds verloren.

> **RAID 1 (Mirroring):** Die Daten werden vollständig und identisch auf zwei
> Festplatten gespiegelt. Fällt eine Platte aus, läuft der Betrieb ohne
> Datenverlust weiter. Allerdings stehen nur **50 %** der insgesamt verbauten
> Kapazität als Nutzdaten zur Verfügung.

> **RAID 5 (Striping mit verteilter Parität):** Die Daten werden über mindestens
> drei Festplatten verteilt; zusätzlich werden Paritätsinformationen berechnet und
> gleichmäßig auf alle Platten verteilt. Fällt eine Festplatte aus, lassen sich
> deren Daten aus den verbleibenden Daten und der Parität vollständig
> rekonstruieren. Es geht dabei nur die Kapazität **einer einzigen** Festplatte
> verloren (Nutzkapazität = (n−1) × Plattengröße).

> **✅ Empfehlung: RAID 5.**
> Es erfüllt beide Prioritäten des Praxisinhabers: Der Ausfall einer Festplatte
> wird kompensiert, sodass eine hohe Verfügbarkeit der Patientendaten
> gewährleistet ist. Gleichzeitig ist der Kapazitätsverlust mit nur einer
> Festplatte deutlich geringer als bei RAID 1, wo die Hälfte der Kapazität
> verloren geht. RAID 0 scheidet aus, da es keine Ausfallsicherheit bietet.
>
> **Hinweis für den Kunden:** Ein RAID ersetzt **kein Backup** — es schützt nur
> vor dem Ausfall von Hardware, nicht vor versehentlichem Löschen, Ransomware
> oder Feuer.

---

# 4. Aufgabe — Datenschutz und Datensicherheit (24 Punkte)

📖 Module: [10 IT-Sicherheit & BSI](../themen/10-it-sicherheit-bsi.md) ·
[09 Datenschutz](../themen/09-datenschutz-dsgvo.md) ·
[11 Backup](../themen/11-datensicherung-backup.md)

## a) Schutzziele zuordnen und begründen (6 Punkte)

**Die drei Schutzziele:** Vertraulichkeit (nur Befugte dürfen **sehen**) ·
Integrität (Daten sind **unverfälscht**) · Verfügbarkeit (Daten sind **da**)

| Sicherheitsmaßnahme | Schutzziel | Begründung |
|---|---|---|
| Sichere Passwörter wählen | **Vertraulichkeit** | *(vorgegeben)* Der Zugriff Fremder auf die Benutzerdaten wird besser geschützt |
| Regelmäßige Datensicherung der Patientendaten | **Verfügbarkeit** | Nach einem Datenverlust durch Hardwaredefekt, Bedienfehler oder Schadsoftware können die Patientendaten wiederhergestellt werden und stehen dem Praxisbetrieb weiterhin zur Verfügung |
| Verschlüsselung der Festplatten | **Vertraulichkeit** | Bei Diebstahl oder Verlust des Geräts können Unbefugte die gespeicherten Daten nicht lesen, da sie ohne den Schlüssel unbrauchbar sind |
| Zentrale Bearbeitung wichtiger Dokumente auf dem Server | **Integrität** | Es existiert nur eine einzige gültige Version des Dokuments; widersprüchliche lokale Kopien und einander überschreibende Änderungen werden vermieden |
| Hashwertüberprüfung bei Softwareinstallation | **Integrität** | Weicht der berechnete Hashwert vom Referenzwert des Herstellers ab, wurde die Datei nachträglich verändert oder manipuliert — die Unversehrtheit lässt sich so nachweisen |

⚠️ **Der Klassiker-Fehler:** Datensicherung wird oft der Integrität zugeordnet.
Falsch — ein Backup sorgt dafür, dass die Daten **wieder da** sind
(= Verfügbarkeit).

## b) Umsetzung zweier BSI-Basis-Anforderungen (2 Punkte)

> **Aktivieren von Autoupdate-Mechanismen:**
> Die automatische Update-Funktion des Betriebssystems und der eingesetzten
> Anwendungen wird aktiviert und zentral per Gruppenrichtlinie (GPO) bzw. über
> einen Update-Server (z. B. WSUS) verwaltet, sodass Sicherheitsupdates
> regelmäßig und ohne Zutun der Nutzenden eingespielt werden.

> **Differenzieren von Benutzerrollen (Rollentrennung):**
> Für jede Person wird ein eigenes, personalisiertes Benutzerkonto mit
> eingeschränkten Rechten angelegt; Berechtigungen werden über Gruppen nach dem
> Prinzip der minimalen Rechte vergeben. Administrative Tätigkeiten erfolgen
> ausschließlich über ein separates Administratorkonto, nicht über das Konto für
> die tägliche Arbeit.

## c) Begründungen zur Schutzbedarfsfeststellung (6 Punkte)

**Kategorien:** *niedrig bis mittel* = begrenzt und überschaubar · *hoch* =
beträchtlich · *sehr hoch* = existenziell bedrohlich, katastrophal

| IT-Anwendung | Schutzziel | Kategorie | Begründung |
|---|---|---|---|
| Prüfziffernverfahren bei der Übermittlung der Krankenversicherungsnummer | Integrität | hoch | *(vorgegeben)* Verfälschte Daten bei der Übertragung können zu fehlerhaften Abrechnungen führen |
| **Textverarbeitung** | Verfügbarkeit | mittel | Bei einem Ausfall kann kurzfristig auf einen anderen Arbeitsplatz oder eine handschriftliche Erfassung ausgewichen werden. Der Praxisbetrieb läuft weiter, es entsteht lediglich ein begrenzter Mehraufwand und eine zeitliche Verzögerung |
| **Software zur telemedizinischen Beratung über Videokonferenz** | Vertraulichkeit | hoch | Während der Videosprechstunde werden hochsensible Gesundheitsdaten übertragen. Könnten Dritte mithören oder mitschneiden, wäre dies ein Verstoß gegen die ärztliche Schweigepflicht (§ 203 StGB) und Art. 9 DSGVO; es drohen erhebliche Bußgelder und ein schwerer Vertrauens- und Reputationsverlust |
| **Patientendatenverarbeitung** | Integrität | sehr hoch | Werden Patientendaten wie Diagnosen, Allergien, Blutgruppe oder Medikation unbemerkt verfälscht, kann dies zu Fehlbehandlungen mit lebensbedrohlichen Folgen für die Patienten führen. Zusätzlich drohen der Praxis existenzbedrohende Haftungs- und Bußgeldrisiken |

💡 **Schema für jede Begründung:** *„Wenn [Schutzziel verletzt wird], dann
[konkrete Folge für Betrieb / Patient / Recht]."*

## d) Besonders geschützte Daten und Rechtsgrundlage (2 Punkte)

> **Lösung:** Einen besonderen gesetzlichen Schutz genießen **personenbezogene
> Daten besonderer Kategorien**. In einer Arztpraxis sind das vor allem
> **Gesundheitsdaten der Patientinnen und Patienten** (Diagnosen, Befunde,
> Medikation), daneben etwa genetische und biometrische Daten.
>
> **Rechtliche Grundlage:** **Art. 9 DSGVO** („Verarbeitung besonderer Kategorien
> personenbezogener Daten"). Ihre Verarbeitung ist grundsätzlich untersagt und nur
> unter engen Voraussetzungen zulässig, etwa bei ausdrücklicher Einwilligung oder
> zur medizinischen Versorgung durch Berufsgeheimnisträger.
>
> *(Ergänzend nennbar: BDSG sowie die ärztliche Schweigepflicht nach § 203 StGB.)*

## e) Zwei Kriterien für ein sicheres Passwort mit Begründung (4 Punkte)

⚠️ Je Kriterium 1 Punkt, je Begründung 1 Punkt — **die Begründung ist die halbe
Punktzahl!**

> **Kriterium 1 — Ausreichende Länge (mindestens 12, besser 16 Zeichen):**
> Mit jedem zusätzlichen Zeichen vervielfacht sich die Anzahl der möglichen
> Kombinationen. Der Zeitaufwand für einen Brute-Force-Angriff, bei dem alle
> Kombinationen durchprobiert werden, steigt dadurch exponentiell an, sodass das
> Passwort in vertretbarer Zeit nicht zu erraten ist.

> **Kriterium 2 — Verwendung verschiedener Zeichenarten (Groß- und
> Kleinbuchstaben, Ziffern, Sonderzeichen):**
> Dadurch vergrößert sich der Zeichenvorrat pro Stelle von 26 auf über 90 Zeichen.
> Der zu durchsuchende Raum wird erheblich größer, und das Passwort ist nicht
> über einen Wörterbuchangriff zu finden, der gezielt sinnvolle Wörter durchprobiert.

> *(Weitere gültige Kriterien: keine Namen, Geburtsdaten oder Wörterbuchbegriffe;
> für jeden Dienst ein eigenes Passwort; nicht notiert oder weitergegeben.)*

## fa) Zwei Risiken der Sicherungsstrategie (2 Punkte)

**Beschriebene Strategie:** Der Datenbestand der Gebührenabrechnungssoftware wird
**freitags beim Herunterfahren** des PCs auf einer **speziell eingerichteten
Partition derselben Festplatte** gesichert.

> **Risiko 1 — Kein Schutz bei Hardwaredefekt:**
> Die Sicherung befindet sich lediglich auf einer anderen Partition **derselben
> physischen Festplatte**. Fällt diese Festplatte aus, sind sowohl der
> Originaldatenbestand als auch die Sicherung gleichzeitig verloren. Dasselbe gilt
> bei Diebstahl, Feuer, Wasserschaden oder einem Ransomware-Befall.

> **Risiko 2 — Zu großer Sicherungsabstand:**
> Da nur einmal wöchentlich gesichert wird, können im Ernstfall die
> Abrechnungsdaten **einer kompletten Arbeitswoche** verloren gehen. Zusätzlich
> ist die Sicherung davon abhängig, dass der PC am Freitag tatsächlich
> heruntergefahren wird — geschieht das nicht, findet gar keine Sicherung statt.

## fb) Konkreter Verbesserungsvorschlag (2 Punkte)

> **Lösung:** Es sollte eine **automatisierte, tägliche Datensicherung auf ein
> separates externes Speichermedium** eingerichtet werden, beispielsweise auf ein
> NAS mit anschließender verschlüsselter Auslagerung in ein Rechenzentrum oder auf
> wechselnde externe Datenträger, die außerhalb der Praxisräume aufbewahrt werden.
>
> Dabei ist die **3-2-1-Regel** einzuhalten: drei Kopien der Daten, auf zwei
> verschiedenen Medientypen, davon eine Kopie außer Haus und offline. Die
> Sicherung muss **zeitgesteuert und benutzerunabhängig** ablaufen, verschlüsselt
> und protokolliert werden und **regelmäßig durch eine Testwiederherstellung
> überprüft** werden.

---

## Punkteverteilung im Überblick

| Aufgabe | Thema | Punkte |
|---|---|---|
| 1 | Projektmanagement & Netzplan | 25 |
| 2 | Energieeffizienz, Amortisation, Skript | 25 |
| 3 | Lastenheft, Migration, Remote, Schulung, RAID | 26 |
| 4 | Datenschutz & Datensicherheit | 24 |
| | **Gesamt** | **100** |

## Was diese Prüfung dich lehrt

1. **Der Netzplan war 15 der 25 Punkte** von Aufgabe 1 — pures Rechenschema.
   Wer das Verfahren kann, hat 15 sichere Punkte.
2. **Rechnen war ~20 Punkte insgesamt** (2a, 2b, 2d, 3ba, 3bb). Alles
   Grundschulmathematik mit einer Formel.
3. **Datenschutz/Sicherheit war 24 Punkte** — reines Auswendiglernen plus
   sauberes Begründen.
4. → **Rund 60 der 100 Punkte** sind mit Schema und Auswendiglernen erreichbar,
   ohne echte Berufserfahrung. Genau deshalb funktioniert dieses Repo.
