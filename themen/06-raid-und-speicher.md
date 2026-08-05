# 06 — RAID & Speichersysteme ⭐

> **Warum wichtig:** RAID ist eines der **allerhäufigsten** AP1-Themen. Meist
> 5–8 Punkte. Und es ist völlig berechenbar: Es geht praktisch immer um
> RAID 0, 1, 5 (manchmal 6 und 10) und die Frage „welches empfehlen Sie und
> warum?".

---

## 1. Was ist RAID?

**RAID = Redundant Array of Independent Disks** — mehrere Festplatten werden zu
einem logischen Laufwerk zusammengeschaltet, um **Ausfallsicherheit** und/oder
**Geschwindigkeit** zu erhöhen.

> ⚠️ **Der wichtigste Satz überhaupt (und eine Lieblingsfrage der IHK):**
> **RAID ersetzt KEIN Backup!**
> Grund: RAID schützt nur gegen den **physischen Ausfall einer Festplatte**.
> Gegen versehentliches Löschen, Ransomware/Verschlüsselung, Viren, Diebstahl,
> Feuer, Wasser oder einen Bedienfehler hilft es **nicht** — alle diese Ereignisse
> werden sofort auf alle Platten gespiegelt.

---

## 2. Die RAID-Level im Überblick

| Level | Prinzip | Min. Platten | Nutzkapazität | Ausfalltoleranz | Geschwindigkeit |
|---|---|---|---|---|---|
| **RAID 0** | Striping (Aufteilen) | 2 | **100 %** | **keine** ❌ | Lesen ++ / Schreiben ++ |
| **RAID 1** | Mirroring (Spiegeln) | 2 | **50 %** | 1 Platte ✅ | Lesen + / Schreiben = |
| **RAID 5** | Striping + verteilte Parität | 3 | **(n−1)/n** | 1 Platte ✅ | Lesen + / Schreiben − |
| **RAID 6** | Striping + doppelte Parität | 4 | **(n−2)/n** | 2 Platten ✅✅ | Lesen + / Schreiben −− |
| **RAID 10** | Spiegel + Striping kombiniert | 4 | **50 %** | mind. 1 (oft mehr) ✅ | Lesen ++ / Schreiben + |

---

## 3. Die Level einzeln erklärt

### RAID 0 — Striping
```
Datei: [A][B][C][D]

Platte 1: A  C
Platte 2: B  D
```
Die Daten werden in Blöcke zerlegt und **abwechselnd** auf die Platten verteilt.
Beide Platten arbeiten gleichzeitig → **doppelte Geschwindigkeit**, **volle
Kapazität**.

**Aber:** Fällt **eine** Platte aus, sind **alle** Daten verloren — auch die auf
der anderen Platte, weil jede Datei zerstückelt ist.

> 🔑 **Merke:** Das „R" für redundant ist bei RAID 0 gelogen. RAID 0 hat **keine
> Redundanz**. Die Ausfallwahrscheinlichkeit ist sogar **höher** als bei einer
> Einzelplatte, weil zwei Platten kaputtgehen können.

**Einsatz:** Nur wo Geschwindigkeit zählt und Daten egal sind — Videoschnitt-
Cache, temporäre Renderdaten.

### RAID 1 — Mirroring
```
Datei: [A][B]

Platte 1: A  B
Platte 2: A  B      (identische Kopie)
```
Jede Platte enthält eine **vollständige Kopie**. Fällt eine aus, läuft der
Betrieb ohne Unterbrechung weiter.

**Preis dafür:** Nur **50 % der gekauften Kapazität** ist nutzbar. Zwei
4-TB-Platten ergeben 4 TB Nutzkapazität.

**Einsatz:** Systemlaufwerke von Servern, kleine Systeme mit nur 2 Platten.

### RAID 5 — Striping mit verteilter Parität ⭐
```
Platte 1: A1  B1  Cp        (p = Paritätsblock)
Platte 2: A2  Bp  C1
Platte 3: Ap  B2  C2
```
Daten werden gestript (schnell) **plus** ein Paritätsblock pro Streifen. Die
Parität ist eine XOR-Prüfsumme und wird **gleichmäßig über alle Platten verteilt**.

**Wie funktioniert die Rekonstruktion?**
Die Parität ist die XOR-Verknüpfung der Datenblöcke:
```
A1 XOR A2 = Ap
```
Fällt Platte 2 aus, rechnet der Controller: `A2 = A1 XOR Ap` — der fehlende Block
wird aus den übrigen zurückgerechnet.

**Nutzkapazität:** Genau **eine Platte** geht für Parität drauf.
```
Nutzkapazität = (n − 1) × Plattengröße
```
- 3 × 4 TB → (3−1) × 4 TB = **8 TB** nutzbar (66,7 %)
- 4 × 4 TB → (4−1) × 4 TB = **12 TB** nutzbar (75 %)
- 5 × 2 TB → (5−1) × 2 TB = **8 TB** nutzbar (80 %)

**Nachteile:** Schreibvorgänge sind langsamer (Parität muss neu berechnet werden,
„write penalty"). Der **Rebuild** nach einem Plattentausch dauert bei großen
Platten viele Stunden und belastet alle übrigen Platten stark — in dieser Zeit ist
das System ungeschützt.

### RAID 6 — doppelte Parität
Wie RAID 5, aber mit **zwei** Paritätsblöcken → **zwei Platten** dürfen
gleichzeitig ausfallen. `Nutzkapazität = (n − 2) × Plattengröße`.
Einsatz bei großen Arrays mit sehr großen Platten (langer Rebuild).

### RAID 10 (= RAID 1+0)
Zwei gespiegelte Paare, die zusätzlich gestript werden.
```
     ┌── Stripe ──┐
  [P1 ⇄ P2]   [P3 ⇄ P4]
   Mirror       Mirror
```
**Schnellste redundante Variante** (kein Paritätsaufwand), sehr schneller Rebuild.
**Kostet aber 50 % Kapazität.** Einsatz: Datenbank- und Virtualisierungsserver.

---

## 4. Welches RAID empfehlen? — die Standard-Prüfungsfrage

Die Aufgabe nennt **Prioritäten**. Ordne sie zu:

| Priorität in der Aufgabe | Antwort |
|---|---|
| „maximale Geschwindigkeit, Daten unwichtig" | **RAID 0** |
| „nur 2 Platten, Ausfallsicherheit wichtig" | **RAID 1** |
| „Ausfallsicherheit **und** wenig Kapazitätsverlust" | **RAID 5** ⭐ |
| „sehr große Platten, maximale Sicherheit" | **RAID 6** |
| „Datenbank, Performance **und** Sicherheit, Kapazität egal" | **RAID 10** |

### Musterantwort (Herbst 2021, Aufgabe 3e)
Gefordert: hohe Verfügbarkeit, Ausfall **einer** Festplatte soll kompensiert
werden, Kapazitätsverlust soll **gering** bleiben.

> **RAID 0** verteilt die Daten auf mehrere Festplatten (Striping). Es bietet
> volle Kapazität und hohe Geschwindigkeit, aber **keinerlei Ausfallsicherheit** —
> beim Ausfall einer Platte sind alle Daten verloren.
>
> **RAID 1** spiegelt die Daten vollständig auf eine zweite Festplatte. Der
> Ausfall einer Platte wird kompensiert, allerdings stehen nur **50 %** der
> Gesamtkapazität als Nutzdaten zur Verfügung.
>
> **RAID 5** verteilt die Daten mit zusätzlichen Paritätsinformationen über
> mindestens drei Festplatten. Der Ausfall einer Festplatte kann kompensiert
> werden, da die fehlenden Daten aus der Parität rekonstruiert werden. Es geht
> dabei nur die Kapazität **einer** Platte verloren.
>
> **Empfehlung: RAID 5.** Es erfüllt beide Anforderungen des Praxisinhabers: Der
> Ausfall einer Festplatte wird kompensiert (hohe Verfügbarkeit) und der
> Kapazitätsverlust ist mit nur einer Festplatte deutlich geringer als bei
> RAID 1 mit 50 %.

> 💡 Fast immer richtig: Ergänze den Satz *„RAID ersetzt jedoch kein Backup"* —
> das ist oft ein eigener Punkt wert.

---

## 5. Hot Spare, Hardware- vs. Software-RAID

**Hot Spare:** Eine zusätzliche, im System eingebaute Reserveplatte, die im
Leerlauf mitläuft. Fällt eine Platte aus, startet der Rebuild **automatisch und
sofort** — ohne dass jemand vor Ort sein muss.

**Hot Swap:** Platten können im **laufenden Betrieb** getauscht werden.

| | **Hardware-RAID** | **Software-RAID** |
|---|---|---|
| Umsetzung | Eigener RAID-Controller mit Prozessor + Cache | Vom Betriebssystem berechnet |
| CPU-Last | keine | belastet die Haupt-CPU |
| Performance | höher, BBU-gepufferter Cache | geringer |
| Kosten | teuer | kostenlos |
| Risiko | Controller-Ausfall → identischer Ersatz nötig | keine Hardware-Bindung |
| Beispiele | LSI/Broadcom-Controller | Linux mdadm, ZFS, Windows Storage Spaces |

---

## 6. DAS, NAS, SAN — Speicherarchitekturen

| | **DAS** | **NAS** | **SAN** |
|---|---|---|---|
| Voll | Direct Attached Storage | Network Attached Storage | Storage Area Network |
| Anbindung | Direkt am Rechner (SATA/SAS/USB) | Über LAN (Ethernet) | Eigenes Speichernetz (FC, iSCSI) |
| Zugriffsebene | **Block** | **Datei** (SMB/CIFS, NFS) | **Block** |
| Nutzung | Einzelner Server/PC | Dateifreigaben im Büro | Rechenzentrum, Virtualisierung, Datenbanken |
| Kosten | gering | mittel | hoch |
| Vorteil | einfach, schnell | einfach zu teilen, zentral | sehr performant, hochverfügbar, flexibel |
| Nachteil | nicht teilbar | LAN-Last, langsamer als SAN | teuer, komplex, Spezialwissen |

---

## Prüfungsfragen, die daraus kommen

1. **Erklären Sie die Grundfunktionen von RAID 0, 1 und 5.**
2. **Welches RAID-Level empfehlen Sie und warum?** → Prioritäten der Aufgabe
   zitieren und dagegen argumentieren
3. **Berechnen Sie die Nutzkapazität eines RAID 5 aus n Platten à X TB.**
   → `(n−1) × X`
4. **Wie viele Festplatten dürfen bei RAID 5 / RAID 6 ausfallen?** → 1 / 2
5. **Warum ersetzt ein RAID kein Backup?** → schützt nur vor Hardwaredefekt,
   nicht vor Löschung, Ransomware, Diebstahl, Feuer
6. **Was ist eine Hot-Spare-Platte?**
7. **Nennen Sie je zwei Vor- und Nachteile von Hardware- und Software-RAID.**
8. **Erklären Sie den Unterschied zwischen NAS und SAN.**
