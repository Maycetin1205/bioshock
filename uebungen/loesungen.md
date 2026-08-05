# Lösungen zu den Übungsaufgaben

---

## Block A — Netzplan

### A1 a) + b) Komplette Tabelle

Vorwärts (`FEZ = FAZ + Dauer`, `FAZ = max` der Vorgänger-FEZ):

| Vorgang | Herleitung FAZ | FAZ | Dauer | FEZ |
|---|---|---|---|---|
| A | Start | 0 | 3 | 3 |
| B | FEZ(A) | 3 | 5 | 8 |
| C | FEZ(A) | 3 | 2 | 5 |
| D | FEZ(B) | 8 | 4 | 12 |
| E | max(8 ; 5) | 8 | 6 | 14 |
| F | max(12 ; 14) | **14** | 2 | **16** |

Rückwärts (`SAZ = SEZ − Dauer`, `SEZ = min` der Nachfolger-SAZ):

| Vorgang | Herleitung SEZ | SEZ | SAZ |
|---|---|---|---|
| F | = FEZ(F) | 16 | 14 |
| D | SAZ(F) | 14 | 10 |
| E | SAZ(F) | 14 | 8 |
| B | min(SAZ D=10 ; SAZ E=8) | 8 | 3 |
| C | SAZ(E) | 8 | 6 |
| A | min(SAZ B=3 ; SAZ C=6) | 3 | **0** ✅ |

Puffer:

| Vorgang | FAZ | FEZ | SAZ | SEZ | GP | FP |
|---|---|---|---|---|---|---|
| A | 0 | 3 | 0 | 3 | **0** | 0 |
| B | 3 | 8 | 3 | 8 | **0** | 0 |
| C | 3 | 5 | 6 | 8 | 3 | 3 |
| D | 8 | 12 | 10 | 14 | 2 | 2 |
| E | 8 | 14 | 8 | 14 | **0** | 0 |
| F | 14 | 16 | 14 | 16 | **0** | 0 |

**c)** Projektdauer = **16 Tage**

**d)** Kritischer Pfad: **A → B → E → F** (3 + 5 + 6 + 2 = 16 ✅)

**e)** D hat GP = 2. Verzögerung 3 > 2 → das Projektende verschiebt sich um
**3 − 2 = 1 Tag** auf **17 Tage**. D liegt danach selbst auf dem kritischen Pfad.

**f)** C hat GP = 3. Verzögerung 8 > 3 → Projektende verschiebt sich um
**8 − 3 = 5 Tage** auf **21 Tage**.

---

## Block B — Energie & Strom

### B1
```
a)  P_zu = 320 W / 0,85 = 376,47 W

b)  Betriebsstunden = 24 h × 365 = 8.760 h
    376,47 W × 8.760 h = 3.297.877 Wh = 3.297,88 kWh
    3.297,88 kWh × 0,32 EUR = 1.055,32 EUR pro Jahr
```

### B2
```
a)  4 × 35 W  =   140 W
    2 × 250 W =   500 W
    Drucker   =   900 W
    Wasserk.  = 2.200 W
    ───────────────────
    Gesamt    = 3.740 W

    I = 3.740 W / 230 V = 16,26 A
    16,26 A > 16 A  →  NEIN, gleichzeitiger Betrieb nicht möglich.

b)  P_max = 230 V × 16 A = 3.680 W
```
Antwort: Die Leiste wird um 60 W bzw. 0,26 A überlastet. Der Wasserkocher sollte
an einen anderen Stromkreis.

### B3
```
Einsparung = 45 W − 22 W = 23 W
Stunden    = 8 h × 22 Tage = 176 h/Monat
Energie    = 23 W × 176 h = 4.048 Wh = 4,048 kWh
Ersparnis  = 4,048 kWh × 0,35 EUR = 1,4168 EUR/Monat

90 EUR / 1,4168 EUR = 63,52 → 64 Monate
```
Antwort: Der Mehrpreis amortisiert sich nach **64 Monaten** (gut 5 Jahre) — das
liegt über der üblichen Nutzungsdauer, die Anschaffung lohnt sich rein
wirtschaftlich also **nicht**. (Solche „Gegenbeispiele" kommen in der Prüfung
vor — dann ist genau diese Bewertung die gefragte Leistung!)

---

## Block C — RAID & Speicher

### C1 a) 6 Platten à 8 TB = 48 TB brutto

| Level | Rechnung | Nutzkapazität | Ausfall verkraftet |
|---|---|---|---|
| RAID 0 | 6 × 8 | **48 TB** | 0 Platten |
| RAID 1 | 48 / 2 | **24 TB** | 1 (bzw. je Spiegel) |
| RAID 5 | (6−1) × 8 | **40 TB** | 1 Platte |
| RAID 6 | (6−2) × 8 | **32 TB** | 2 Platten |
| RAID 10 | 48 / 2 | **24 TB** | mind. 1, günstigenfalls 3 |

### C2
> Ein RAID 1 schützt ausschließlich vor dem **physischen Ausfall einer
> Festplatte** — es ist eine Verfügbarkeitsmaßnahme, keine Sicherung. Wird eine
> Datei versehentlich gelöscht, durch Ransomware verschlüsselt oder von einem
> Virus verändert, geschieht das **sofort auf beiden Platten gleichzeitig**.
> Außerdem befinden sich beide Platten im selben Gerät und Raum und sind damit
> von Diebstahl, Feuer oder Wasserschaden gleichermaßen betroffen. Ein Backup
> nach der 3-2-1-Regel ist deshalb zwingend zusätzlich erforderlich.

### C3
> **NAS** ist ein Speichersystem, das über das normale LAN angebunden wird und
> Daten auf **Dateiebene** über Protokolle wie SMB oder NFS bereitstellt. Es ist
> einfach einzurichten und eignet sich für gemeinsame Dateiablagen im Büro.
>
> **SAN** ist ein eigenständiges Speichernetz (Fibre Channel oder iSCSI), das
> Speicher auf **Blockebene** bereitstellt — Server sehen den Speicher wie eine
> lokale Festplatte. Es ist deutlich performanter und hochverfügbar, aber teuer
> und komplex. Einsatz: Virtualisierungs-Cluster und Datenbankserver im
> Rechenzentrum.

---

## Block D — Netzwerk

### D1 — 192.168.30.145 /26
```
a)  /26 → 255.255.255.192

b)  Blockgröße = 256 − 192 = 64
    Subnetze: .0 | .64 | .128 | .192
    .145 liegt im Block .128 – .191

    Netzadresse:      192.168.30.128
    Erster Host:      192.168.30.129
    Letzter Host:     192.168.30.190
    Broadcast:        192.168.30.191

c)  2^(32−26) − 2 = 64 − 2 = 62 Hosts
```

### D2
```
a)  2^5 − 2 = 30 ≥ 25  →  5 Hostbits  →  32 − 5 = /27  (255.255.255.224)
b)  Von /24 auf /27 = 3 zusätzliche Netzbits → 2^3 = 8 Subnetze
```

### D3
Hub = **Schicht 1** (Bitübertragung) · Switch = **Schicht 2** (Sicherung, MAC) ·
Router = **Schicht 3** (Vermittlung, IP)

### D4
HTTPS **443** · SSH **22** · DNS **53** · IMAPS **993** · RDP **3389**

### D5
```
12 GB = 12.000 MB
12.000 MB × 8 = 96.000 Mbit
96.000 Mbit / 250 Mbit/s = 384 s = 6,4 Minuten
```
Antwort: theoretisch **384 Sekunden (6 min 24 s)**. In der Praxis länger, da
durch Protokoll-Overhead nur etwa 80–90 % der Bruttorate nutzbar sind.

---

## Block E — Skript

### E1 — die zwei Fehler
```powershell
$Wert = $CPU.CounterSamples.CookedValue / 100     # ← Fehler 1
if ($Wert -lt 90)                                  # ← Fehler 2
```

| Fehler | Erklärung | Korrektur |
|---|---|---|
| 1 | Der Zählerwert liegt bereits in Prozent vor. Die Division durch 100 macht aus 20 % den Wert 0,2 — der Vergleich mit 90 wird dadurch sinnlos | Die Division entfernen: `$Wert = $CPU.CounterSamples.CookedValue` |
| 2 | `-lt` bedeutet „kleiner als". Bei 20 % ist `0,2 -lt 90` **wahr** → Warnung. Gesucht ist aber „**über** 90 %" | `-gt` statt `-lt` |

**Korrigiert:**
```powershell
$Wert = $CPU.CounterSamples.CookedValue
if ($Wert -gt 90)
```
**Kontrolle:** 20 % → `20 -gt 90` = falsch → else-Zweig → „Normalbereich" ✅

### E2 — chmod 640
```
6 = 4+2 = rw-    Besitzer:  lesen und schreiben
4 = 4   = r--    Gruppe:    nur lesen
0 =     = ---    Andere:    kein Zugriff

→  -rw-r-----
```

### E3
```
30 22 * * 1-5
```
Minute 30, Stunde 22, jeder Tag im Monat, jeder Monat, Wochentage 1–5 (Mo–Fr).

---

## Block F — Datenschutz & Sicherheit

### F1

| Maßnahme | Schutzziel | Begründung |
|---|---|---|
| USV | **Verfügbarkeit** | Bei einem Stromausfall bleiben die Systeme erreichbar bzw. können kontrolliert heruntergefahren werden, statt unkontrolliert auszufallen |
| Digitale Signatur von E-Mails | **Integrität** (+ Authentizität) | Eine nachträgliche Veränderung der Nachricht wird erkannt, und der Absender ist eindeutig nachweisbar |
| Automatische Bildschirmsperre | **Vertraulichkeit** | Unbefugte können bei kurzzeitiger Abwesenheit keine Daten am unbeaufsichtigten Arbeitsplatz einsehen |
| Redundante Internetanbindung | **Verfügbarkeit** | Fällt ein Provider aus, bleibt der Zugang über die zweite Leitung bestehen |
| Schreibgeschützte Archivierung | **Integrität** | Archivierte Rechnungen können nachträglich nicht mehr verändert werden |
| VPN im Homeoffice | **Vertraulichkeit** | Der Datenverkehr wird verschlüsselt übertragen und kann auf dem Übertragungsweg nicht mitgelesen werden |

### F2
**Technisch:** Festplattenverschlüsselung · verschlüsselte Übertragung
(TLS/VPN) · Zugriffskontrolle über personalisierte Konten und Rollen ·
Firewall und Virenschutz · automatische Bildschirmsperre · Protokollierung der
Zugriffe · regelmäßige Backups · Patchmanagement

**Organisatorisch:** Verpflichtung der Mitarbeitenden auf Vertraulichkeit ·
regelmäßige Datenschutzschulungen · Berechtigungskonzept nach dem Prinzip der
minimalen Rechte · Zutrittskontrolle zu Büro- und Serverräumen ·
Clean-Desk-Policy · Auftragsverarbeitungsverträge mit Dienstleistern ·
Löschkonzept, Aktenvernichtung nach DIN 66399

### F3
> Innerhalb von **72 Stunden** nach Bekanntwerden an die zuständige
> **Aufsichtsbehörde** (Landesdatenschutzbeauftragter) — **Art. 33 DSGVO**.
> Besteht ein hohes Risiko für die Betroffenen, sind diese zusätzlich
> unverzüglich zu informieren (**Art. 34 DSGVO**).

### F4
> **Länge (mind. 12 Zeichen):** Jedes zusätzliche Zeichen vervielfacht die Zahl
> der möglichen Kombinationen, wodurch der Zeitaufwand für einen
> Brute-Force-Angriff exponentiell steigt und das Passwort praktisch nicht
> durchprobierbar ist.
>
> **Verschiedene Zeichenarten:** Groß- und Kleinbuchstaben, Ziffern und
> Sonderzeichen vergrößern den Zeichenvorrat pro Stelle von 26 auf über 90 und
> machen Wörterbuchangriffe wirkungslos.

### F5
> Ein Administratorkonto besitzt weitreichende Rechte auf dem gesamten System.
> Wird beim Surfen Schadsoftware eingefangen, läuft diese **mit genau diesen
> Rechten** und kann Systemdateien verändern, Sicherheitsfunktionen abschalten
> und sich im Netzwerk ausbreiten. Nach dem **Prinzip der minimalen Rechte** wird
> für die tägliche Arbeit deshalb ein Standardkonto verwendet und das
> Administratorkonto nur gezielt für administrative Aufgaben.

---

## Block G — Projekt, Beschaffung, Beratung

### G1
Einmaligkeit · zeitliche Begrenzung (definierter Anfang und Endtermin) · klare
Zielvorgabe · begrenzte Ressourcen
*(auch gültig: Komplexität, eigene Projektorganisation, Interdisziplinarität, Risiko)*

### G2
> „Bis zum 31.03.2027 wird für die 45 Mitarbeitenden des Kundenservice ein
> webbasiertes Ticketsystem eingeführt, über das mindestens 90 % aller
> Supportanfragen erfasst und nachverfolgt werden, bei einem Budget von maximal
> 25.000 EUR."

Prüfe selbst: spezifisch (Ticketsystem, Kundenservice) ✓ messbar (90 %, 45
Personen, 25.000 EUR) ✓ erreichbar ✓ relevant ✓ terminiert (31.03.2027) ✓

### G3
> **Lastenheft** — erstellt vom **Auftraggeber (Kunde)**, beschreibt das **WAS**.
> Inhalte z. B.: Ausgangssituation/Ist-Zustand, Zielsetzung, funktionale
> Anforderungen, Mengengerüst, Termine, Budget.
>
> **Pflichtenheft** — erstellt vom **Auftragnehmer (Dienstleister)**, beschreibt
> das **WIE**. Inhalte z. B.: technische Lösungsbeschreibung, eingesetzte
> Hard- und Software, Systemarchitektur, Schnittstellen, Projektplan,
> Abnahmekriterien.

### G4
```
a)  35 Arbeitsplätze × 1,5 h = 52,5 h
    52,5 h × 95 EUR/h = 4.987,50 EUR

b)  Kapazität = 3 Techniker × 8 h = 24 h/Tag
    52,5 h / 24 h = 2,1875 Tage → 3 Arbeitstage
```

### G5
> **Vorteile Webinar:** keine Reisekosten und Reisezeit; viele Teilnehmende von
> verschiedenen Standorten gleichzeitig; meist aufzeichenbar und dadurch
> nachträglich nutzbar.
>
> **Nachteile Webinar:** kein Zugriff auf das reale System, praktische Übungen
> nur eingeschränkt möglich; geringere Aufmerksamkeit und Interaktion, technische
> Voraussetzungen (stabile Verbindung, Endgeräte) müssen erfüllt sein.

### G6
> **Merkmal:** Das Netzteil ist nach 80 PLUS Gold zertifiziert und erreicht rund
> 90 % Wirkungsgrad statt etwa 43 % bei einem Modell ohne Zertifikat.
>
> **Vorteil:** Es wird deutlich weniger Strom aus dem Netz gezogen, und es
> entsteht wesentlich weniger Abwärme.
>
> **Nutzen für Sie:** Sie sparen pro Gerät rund 3,27 EUR Stromkosten im Monat —
> bei zwölf Arbeitsplätzen sind das etwa 470 EUR in drei Jahren, womit sich der
> Mehrpreis von 100 EUR pro Gerät nach gut zweieinhalb Jahren bezahlt macht.
> Zusätzlich laufen die Rechner kühler und leiser, was die Lebensdauer der
> Bauteile verlängert und die Arbeitsumgebung angenehmer macht.

---

## Block H — Hardware & Betriebssystem

### H1
> **Ursache:** Der USB-Stick ist mit **FAT32** formatiert. Dieses Dateisystem
> erlaubt eine maximale Dateigröße von **4 GB**, unabhängig von der
> Gesamtkapazität des Sticks.
>
> **Lösung:** Den Stick mit **exFAT** (plattformübergreifend) oder **NTFS**
> (Windows) neu formatieren. Vorher vorhandene Daten sichern, da beim
> Formatieren alles gelöscht wird.

### H2
> **HDD — Vorteile:** deutlich günstigerer Preis pro Gigabyte; sehr große
> Kapazitäten verfügbar.
> **HDD — Nachteile:** langsam (hohe Zugriffszeit durch Mechanik);
> stoßempfindlich, Verschleiß beweglicher Teile, hörbare Geräusche.
>
> **SSD — Vorteile:** sehr hohe Geschwindigkeit und minimale Zugriffszeit; keine
> beweglichen Teile → robust, lautlos, geringerer Stromverbrauch.
> **SSD — Nachteile:** höherer Preis pro Gigabyte; begrenzte Anzahl an
> Schreibzyklen (TBW).

### H3
> Blendfreier, flimmerfreier und in Helligkeit regelbarer Bildschirm ·
> Aufstellung mit Blickrichtung parallel zum Fenster · höhenverstellbarer Stuhl
> mit Lehne und ausreichend großer, möglichst höhenverstellbarer Tisch ·
> Beleuchtungsstärke von mindestens 500 Lux · Sehabstand 50–80 cm, Oberkante des
> Bildschirms leicht unter Augenhöhe · ausreichend Beinfreiheit · regelmäßige
> Pausen bzw. Tätigkeitswechsel

### H4
> **Typ 1 (Bare Metal):** läuft direkt auf der Hardware ohne darunterliegendes
> Betriebssystem, dadurch sehr geringer Overhead und hohe Leistung. Einsatz im
> Rechenzentrum. Beispiel: **VMware ESXi**, Proxmox VE.
>
> **Typ 2 (Hosted):** läuft als Anwendung innerhalb eines vorhandenen
> Betriebssystems, dadurch geringere Leistung, aber sehr einfach einzurichten.
> Einsatz für Test und Entwicklung. Beispiel: **VirtualBox**, VMware Workstation.

### H5
> Bessere Auslastung der vorhandenen Hardware und dadurch weniger physische
> Server (geringere Kosten für Strom, Kühlung und Stellfläche) · schnelle
> Bereitstellung neuer Systeme und einfache Sicherung per Snapshot · Isolation
> der Systeme voneinander und einfache Migration auf andere Hardware im
> Störungsfall.
