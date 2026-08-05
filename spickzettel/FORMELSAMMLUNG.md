# Formelsammlung & Spickzettel AP1

> Das hier ist der **letzte Zettel vor der Prüfung**. Wenn du eine Woche vorher
> nur noch eine Datei anschaust, dann diese.

---

## ⚡ Elektrotechnik & Energie

```
P = U · I                       Leistung [W] = Spannung [V] · Stromstärke [A]
I = P / U                       Stromstärke
E = P · t                       Energie [Wh] = Leistung [W] · Zeit [h]
η = P_ab / P_zu                 Wirkungsgrad (Efficiency = output / input)
P_zu = P_ab / η                 ⭐ aufgenommene Leistung (IMMER größer als P_ab!)
Kosten = kWh · Preis            1 kWh = 1000 Wh
```

**Fixwerte zum Merken:**
- Netzspannung Deutschland: **230 V**
- Max. Dauerleistung bei 16 A: **230 V × 16 A = 3.680 W**
- 80 PLUS Gold ≈ **90 %** Wirkungsgrad

**Energiekosten in 4 Schritten:**
`h/Tag × Tage → Stunden` → `× Watt = Wh` → `/1000 = kWh` → `× Preis = EUR`

---

## 💰 Kaufmännisches Rechnen

```
Amortisation = Mehrkosten / Ersparnis pro Periode      → IMMER AUFRUNDEN
Gesamtkosten = Menge · Aufwand · Stundensatz
Dauer        = Gesamtstunden / (Personen · Stunden pro Tag)  → AUFRUNDEN
Brutto→Netto = Brutto / 1,19          (nicht −19 %!)
Netto→Brutto = Netto · 1,19
Rabatt 15 %  = · 0,85       Skonto 3 % = · 0,97
Verfügbarkeit = (Gesamtzeit − Ausfallzeit) / Gesamtzeit · 100
Kritische Menge: Fix + var·x = Preis_extern·x
```

---

## 🕸️ Netzplan ⭐

```
FEZ = FAZ + Dauer
FAZ = MAXIMUM der FEZ aller Vorgänger        ← vorwärts = max
SAZ = SEZ − Dauer
SEZ = MINIMUM der SAZ aller Nachfolger       ← rückwärts = min
GP  = SAZ − FAZ  =  SEZ − FEZ
FP  = kleinster FAZ der Nachfolger − eigener FEZ
```

- **Kritischer Pfad** = alle Vorgänge mit **GP = 0**, lückenlos Start → Ende
- **Projektdauer** = FEZ des letzten Vorgangs
- **Kontrolle:** SAZ des Startvorgangs **muss 0** sein
- **Verzögerung ≤ GP** → kein Einfluss · **> GP** → Ende verschiebt sich um `(Verz. − GP)`
- Es gilt immer: **FP ≤ GP**

---

## 💾 RAID

| Level | Min. Platten | Nutzkapazität | Ausfall verkraftet |
|---|---|---|---|
| 0 | 2 | 100 % | **0** |
| 1 | 2 | 50 % | 1 |
| 5 | 3 | **(n−1)/n** | 1 |
| 6 | 4 | (n−2)/n | 2 |
| 10 | 4 | 50 % | ≥ 1 |

`Nutzkapazität RAID 5 = (n − 1) × Plattengröße`
**⚠️ RAID ersetzt kein Backup!**

---

## 🌐 Netzwerk

```
Adressen im Subnetz = 2^(32 − CIDR)
Nutzbare Hosts      = 2^(32 − CIDR) − 2      (Netz- + Broadcastadresse)
Blockgröße          = 256 − letztes Oktett der Maske
```

| CIDR | Maske | Hosts |
|---|---|---|
| /24 | 255.255.255.0 | 254 |
| /25 | .128 | 126 |
| /26 | .192 | 62 |
| /27 | .224 | 30 |
| /28 | .240 | 14 |
| /29 | .248 | 6 |
| /30 | .252 | 2 |

**Ports:** FTP 21 · **SSH 22** · SMTP 25/587 · **DNS 53** · HTTP 80 ·
POP3 110/995 · IMAP 143/**993** · **HTTPS 443** · SMB 445 · LDAP 389/636 ·
**RDP 3389**

**Private Netze:** 10.0.0.0/8 · 172.16.0.0/12 · 192.168.0.0/16
**APIPA 169.254.x.x** = DHCP nicht erreichbar!

**OSI:** 1 Bit (Hub) · 2 Sicherung (**Switch**, MAC) · 3 Vermittlung (**Router**, IP)
· 4 Transport (TCP/UDP) · 5 Sitzung · 6 Darstellung · 7 Anwendung

**Kupfer max. 100 m** · Cat 6A = 10 Gbit/s

**Übertragungszeit:** `Zeit = Datenmenge in Bit / Rate in Bit/s` — **1 Byte = 8 Bit!**

---

## 🔐 IT-Sicherheit

**Die 3 Schutzziele (CIA):**
| Schutzziel | Frage | Maßnahmen |
|---|---|---|
| **Vertraulichkeit** | Wer darf **sehen**? | Verschlüsselung, Passwörter, Rechte, Zutritt |
| **Integrität** | Sind die Daten **unverfälscht**? | Hash, Signatur, Prüfziffer, Versionierung |
| **Verfügbarkeit** | Sind die Daten **da**? | Backup, RAID, USV, Redundanz |

**MFA-Faktoren:** Wissen (Passwort) · Besitz (Token) · Sein (Biometrie)

**Verschlüsseln** = mit dem **öffentlichen** Schlüssel des **Empfängers**
**Signieren** = mit dem **privaten** Schlüssel des **Senders**

**Schutzbedarf:** normal (begrenzt) · hoch (beträchtlich) · sehr hoch
(existenzbedrohend) — **Maximumprinzip**

---

## 🗄️ Backup

```
3 - 2 - 1     3 Kopien · 2 Medientypen · 1 außer Haus & offline
```

| Art | Sichert | Restore braucht |
|---|---|---|
| **Voll** | alles | 1 Medium |
| **Differenziell** | seit letzter **Voll**sicherung | Voll + **letzte** diff. = 2 |
| **Inkrementell** | seit **letzter Sicherung** | Voll + **alle** ink. |

**Merkregel:** *Diffe*renziell → *Diff*erenz zur *Voll*sicherung.
Inkrementell: schnell sichern, langsam wiederherstellen. Differenziell: umgekehrt.

**RPO** = maximal tolerierbarer **Datenverlust** (Sicherungshäufigkeit)
**RTO** = maximal tolerierbare **Ausfallzeit** (Wiederherstellungsdauer)

---

## ⚖️ Datenschutz

- **Art. 9 DSGVO** — besondere Kategorien: **Gesundheitsdaten**, Biometrie,
  Genetik, Religion, Politik, Gewerkschaft, Sexualleben, Ethnie
- **Art. 5** — Grundsätze: Rechtmäßigkeit, Zweckbindung, Datenminimierung,
  Richtigkeit, Speicherbegrenzung, Integrität/Vertraulichkeit, Rechenschaft
- **Art. 6** — Rechtsgrundlagen: Einwilligung, Vertrag, rechtliche Pflicht,
  lebenswichtige Interessen, öffentliches Interesse, berechtigtes Interesse
- **Art. 15–22** — Betroffenenrechte: Auskunft, Berichtigung, Löschung,
  Einschränkung, Übertragbarkeit, Widerspruch
- **Art. 28** — **AVV** bei externen Dienstleistern
- **Art. 30** — Verzeichnis der Verarbeitungstätigkeiten
- **Art. 32** — **TOM**
- **Art. 33** — Datenpanne melden: **innerhalb 72 Stunden**
- **Art. 83** — Bußgeld bis **20 Mio. EUR / 4 % Jahresumsatz**
- **DSB-Pflicht** ab **20 Personen** mit automatisierter Verarbeitung (§ 38 BDSG)
- **Zutritt** = Raum · **Zugang** = System · **Zugriff** = Daten
- Patientenakten: **10 Jahre** aufbewahren · Buchhaltung: **10 Jahre**

---

## 📋 Projektmanagement

**Projektmerkmale:** Einmaligkeit · zeitliche Begrenzung · Zielvorgabe ·
begrenzte Ressourcen · Komplexität · eigene Organisation

**SMART:** **S**pezifisch · **M**essbar · **A**kzeptiert/erreichbar ·
**R**ealistisch/relevant · **T**erminiert

**Magisches Dreieck:** Zeit ↔ Kosten ↔ Qualität

**Lastenheft** = Kunde, **WAS** · **Pflichtenheft** = Auftragnehmer, **WIE**
(*erst L, dann P — alphabetisch wie zeitlich*)

**Scrum:** Product Owner (Was) · Scrum Master (Prozess) · Dev-Team (Wie)

---

## 💻 PowerShell-Operatoren

| Operator | Bedeutung |
|---|---|
| `-eq` | gleich |
| `-ne` | ungleich |
| `-gt` | **größer als** |
| `-ge` | größer oder gleich |
| `-lt` | **kleiner als** ⭐ |
| `-le` | kleiner oder gleich |

**Prozent = `(Teil / Ganzes) * 100`** — nicht 1000!

**Linux-Rechte:** r=4, w=2, x=1 → `755` = `rwx r-x r-x`

**Cron:** `Min Std Tag Monat Wochentag` → `0 23 * * *` = täglich 23:00 Uhr

---

## 🧮 Einheiten

```
1 Byte = 8 Bit                      ⚠️ Netz in Bit/s, Dateien in Byte!
1 kB = 1.000 Byte   |   1 KiB = 1.024 Byte
1 kWh = 1.000 Wh
1 h = 60 min = 3.600 s
```

---

## ✅ Die 6 Prüfungsregeln

1. **Genau so viele Antworten wie gefordert** — nur die ersten werden gewertet
2. **Rechenweg immer hinschreiben** — Teilpunkte
3. **Einheiten mitschreiben** — W, kWh, EUR, h
4. **Bei Zeit/Stück immer aufrunden**
5. **Ersatzwerte nutzen**, wenn angeboten — volle Punkte in der Folgeaufgabe
6. **Nie ein Feld leer lassen** — ein plausibler Satz bringt oft einen Punkt
