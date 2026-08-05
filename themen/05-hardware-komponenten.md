# 05 — Hardware & Komponenten

> **Warum wichtig:** Die AP1 heißt „Einrichten eines IT-gestützten
> Arbeitsplatzes". Hardware-Auswahl und -Beratung ist das Kernthema. Meist
> 4–10 Punkte, oft als Beratungsfrage („Empfehlen Sie … und begründen Sie").

---

## 1. Die Komponenten eines PCs

| Komponente | Aufgabe | Wichtige Kennwerte |
|---|---|---|
| **CPU** (Prozessor) | Führt Befehle aus, rechnet | Kerne, Threads, Takt (GHz), Cache, TDP |
| **RAM** (Arbeitsspeicher) | Flüchtiger Zwischenspeicher für laufende Programme | Kapazität (GB), Typ (DDR4/DDR5), Takt, ECC ja/nein |
| **Mainboard** | Verbindet alle Komponenten | Sockel, Chipsatz, Formfaktor (ATX/mATX/ITX), Steckplätze |
| **Massenspeicher** | Dauerhafte Speicherung | HDD/SSD, Kapazität, Schnittstelle, IOPS |
| **Netzteil (PSU)** | Wandelt 230 V AC in 12/5/3,3 V DC | Leistung (W), Wirkungsgrad (80 PLUS) |
| **GPU** (Grafikkarte) | Bildberechnung, parallele Rechenlast | VRAM, Anschlüsse |
| **Kühlung** | Wärme abführen | Luft vs. Wasser, Lautstärke |

### RAM vs. Massenspeicher — der Klassiker
| | RAM | SSD/HDD |
|---|---|---|
| Flüchtig? | **Ja** — Inhalt weg bei Stromverlust | Nein — behält Daten |
| Geschwindigkeit | Sehr hoch (ns) | Deutlich langsamer (µs/ms) |
| Kapazität | Klein (8–64 GB) | Groß (0,5–20 TB) |
| Zweck | Aktuell laufende Programme/Daten | Dauerhafte Ablage |

---

## 2. HDD vs. SSD ⭐

| Kriterium | **HDD** (Magnetplatte) | **SSD** (Flash) |
|---|---|---|
| Technik | Rotierende Scheiben + Schreib-/Lesekopf | Halbleiter-Speicherzellen (NAND) |
| Geschwindigkeit | ca. 100–200 MB/s | 500 MB/s (SATA) bis 7.000+ MB/s (NVMe) |
| Zugriffszeit | ca. 5–10 ms | ca. 0,1 ms |
| Bewegliche Teile | Ja → stoßempfindlich, Verschleiß | Nein → robust |
| Lautstärke | hörbar | lautlos |
| Stromverbrauch | höher | niedriger |
| Preis pro GB | **günstiger** | teurer |
| Kapazität max. | sehr groß | groß, aber teurer |
| Schwäche | Mechanischer Ausfall | Begrenzte Schreibzyklen (TBW) |

**Typische Empfehlung in der Prüfung:**
> „SSD als Systemlaufwerk für Betriebssystem und Anwendungen (Geschwindigkeit),
> HDD als kostengünstiger Massenspeicher für Archiv- und Backup-Daten."

---

## 3. Schnittstellen

### Interne Schnittstellen
| Schnittstelle | Verwendung | Geschwindigkeit |
|---|---|---|
| **SATA III** | HDD, SSD, optische Laufwerke | 6 Gbit/s (≈ 600 MB/s) |
| **M.2 / NVMe** | SSD direkt am PCIe-Bus | bis > 7 GB/s |
| **PCIe** | Grafikkarten, Netzwerkkarten, SSDs | je nach Version und Lanes |
| **SAS** | Server-Festplatten, robuster als SATA | 12 Gbit/s |

### Externe Schnittstellen
| Schnittstelle | Nutzung | Hinweis |
|---|---|---|
| **USB-A / USB-C** | Peripherie, Speicher, Laden | USB 3.2 bis 20 Gbit/s, USB4/TB bis 40 |
| **Thunderbolt** | Docking, externe GPU, schnelle Speicher | über USB-C-Stecker |
| **HDMI / DisplayPort** | Monitore | DP kann besser mehrere Monitore verketten (MST) |
| **RJ45 (Ethernet)** | Netzwerk | 1 GbE / 2,5 GbE / 10 GbE |

---

## 4. Monitor & Arbeitsplatz-Ergonomie ⭐

Ergonomie kommt in der AP1 überraschend oft — Stichwort **Bildschirmarbeitsplatz**
(**ArbStättV** + **DGUV**).

### Anforderungen an den Arbeitsplatz
- **Bildschirm:** blendfrei/entspiegelt, flimmerfrei, Helligkeit/Kontrast
  regulierbar, dreh- und neigbar, Sehabstand 50–80 cm, Oberkante leicht unter
  Augenhöhe
- **Aufstellung:** Blickrichtung **parallel zum Fenster** (nicht davor, nicht mit
  dem Rücken dazu) → keine Blendung, keine Spiegelung
- **Tisch:** ausreichend groß, möglichst höhenverstellbar, matte Oberfläche
- **Stuhl:** höhenverstellbar, dynamisches Sitzen, Lehne mit Lordosenstütze
- **Beleuchtung:** min. 500 Lux am Arbeitsplatz, indirekt
- **Sonstiges:** ausreichend Beinfreiheit, geringer Geräuschpegel,
  Pausenregelung / Tätigkeitswechsel, Angebot einer Augenuntersuchung (G37)

### Rechtsgrundlagen (nennen können!)
- **ArbSchG** — Arbeitsschutzgesetz
- **ArbStättV** — Arbeitsstättenverordnung (Anhang 6: Bildschirmarbeitsplätze)
- **DGUV Information 215-410** — „Bildschirm- und Büroarbeitsplätze"

---

## 5. Thin Client vs. Fat Client vs. Notebook

| | **Fat Client** (klassischer PC) | **Thin Client** | **Notebook** |
|---|---|---|---|
| Rechenleistung | lokal | auf dem Server (Terminal/VDI) | lokal |
| Anschaffung | mittel | günstig | teuer |
| Stromverbrauch | hoch | sehr niedrig | niedrig |
| Administration | pro Gerät aufwändig | zentral, sehr einfach | pro Gerät |
| Ausfall Gerät | Daten evtl. lokal weg | egal, Gerät einfach tauschen | Daten evtl. lokal weg |
| Abhängigkeit | keine | **komplett vom Server/Netz abhängig** | keine |
| Mobilität | keine | keine | **hoch** |

Für eine Arztpraxis (typisches AP1-Szenario) ist der Thin Client oft die
Musterantwort: zentrale Datenhaltung → **keine Patientendaten auf den Endgeräten**,
zentrale Sicherung, einfache Administration.

---

## 6. Drucker

| Typ | Prinzip | Stärken | Schwächen |
|---|---|---|---|
| **Laser** | Toner + Trommel + Hitze | schnell, günstig pro Seite, wischfest, ideal für hohe Volumen | Anschaffung teurer, Feinstaub/Ozon, Farbe teuer |
| **Tinte** | Tintentropfen | günstig in Anschaffung, gute Fotoqualität | teuer pro Seite, Düsen trocknen ein |
| **Nadel** | Anschlag auf Farbband | **Durchschläge** möglich (Formulare!), robust | laut, schlechte Qualität, langsam |
| **Thermo** | Hitze auf Spezialpapier | Bons, Etiketten, wartungsarm | verblasst, Spezialpapier |

Für eine Arztpraxis: Nadeldrucker für mehrlagige Formulare, Laserdrucker für
Befunde, Thermodrucker für Etiketten.

**Netzwerkdrucker vs. lokale Drucker:** zentraler Netzwerkdrucker = weniger
Geräte, geringere Kosten, zentrale Verwaltung, aber Wege für die Nutzenden und
**Datenschutzproblem** (Ausdrucke mit Patientendaten liegen offen) →
Lösung: **Follow-Me-Printing / Pull-Printing** mit PIN oder Karte.

---

## 7. Auswahlkriterien bei Hardwarebeschaffung

Wenn gefragt wird *„Nennen Sie fünf Kriterien für die Auswahl von …"*:

- Anforderungen an Leistung (CPU, RAM, Speicher) — passend zum Einsatzzweck
- Erweiterbarkeit / Zukunftssicherheit
- Kompatibilität mit vorhandener Hard- und Software
- Anschaffungspreis **und** Betriebskosten (TCO: Strom, Wartung, Verbrauchsmaterial)
- Garantie / Gewährleistung, Reaktionszeit des Supports (SLA)
- Verfügbarkeit von Ersatzteilen, Lebenszyklus des Modells
- Energieeffizienz (80 PLUS, Energy Star, Blauer Engel)
- Lautstärke und Platzbedarf
- Sicherheitsfunktionen (TPM, Secure Boot, Kensington-Schloss)

**TCO (Total Cost of Ownership):** Gesamtkosten über die gesamte Nutzungsdauer =
Anschaffung + Betrieb (Strom, Wartung, Verbrauchsmaterial, Support, Schulung) +
Entsorgung. Der Begriff bringt fast immer einen Extrapunkt.

---

## Prüfungsfragen, die daraus kommen

1. **Nennen Sie vier Kriterien für die Auswahl eines neuen PCs.**
2. **Vergleichen Sie HDD und SSD — je zwei Vor- und Nachteile.**
3. **Welche Anforderungen stellt die ArbStättV an einen Bildschirmarbeitsplatz?
   Nennen Sie vier.**
4. **Empfehlen Sie einen Druckertyp für … und begründen Sie.**
5. **Erklären Sie den Unterschied zwischen Thin Client und Fat Client. Nennen Sie
   je einen Vor- und Nachteil.**
6. **Was versteht man unter TCO?**
7. **Nennen Sie zwei Gründe für den Einsatz von ECC-RAM in Servern.**
   → erkennt und korrigiert Bitfehler, verhindert stille Datenverfälschung
