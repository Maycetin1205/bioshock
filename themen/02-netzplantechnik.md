# 02 — Netzplantechnik ⭐

> **Warum wichtig:** Wenn ein Netzplan drankommt, sind das **10–15 Punkte am
> Stück**. Und: Es ist ein reines Rechenverfahren. Wer das Schema kann, macht
> **keinen einzigen Fehler**. Das ist die zuverlässigste Punktequelle der ganzen
> AP1. Lern das hier bis es sitzt.

---

## 1. Wofür ist ein Netzplan da?

Der Netzplan beantwortet drei Fragen:

1. **Wie lange dauert das Projekt insgesamt?**
2. **Welche Vorgänge dürfen sich auf keinen Fall verzögern?** (= kritischer Pfad)
3. **Wie viel Luft (Puffer) hat jeder einzelne Vorgang?**

Ausgangspunkt ist immer eine **Vorgangsliste**:

| Vorgang | Beschreibung | Dauer | Vorgänger |
|---------|--------------|-------|-----------|
| A | Ist-Analyse | 2 | — |
| B | Soll-Konzept | 4 | A |
| C | Beschaffung Server | 3 | B |

„Vorgänger" heißt: **Das muss komplett fertig sein, bevor ich anfangen darf.**

---

## 2. Der Vorgangsknoten — was steht in welchem Kästchen?

In der AP1 wird fast immer **diese** Anordnung verwendet (steht als „Legende"
im Aufgabensatz — **immer erst die Legende anschauen, sie kann abweichen!**):

```
   FAZ              FEZ
 ┌──────────────────────┐
 │       Vorgang        │      ← Name des Vorgangs (A, B, C …)
 ├──────┬───────┬───────┤
 │Dauer │  GP   │  FP   │
 └──────┴───────┴───────┘
   SAZ              SEZ
```

| Kürzel | Voller Name | Bedeutung im Klartext |
|--------|-------------|------------------------|
| **FAZ** | Frühester Anfangszeitpunkt | Frühestens ab jetzt *darf* ich starten |
| **FEZ** | Frühester Endzeitpunkt | Frühestens dann *bin* ich fertig |
| **SAZ** | Spätester Anfangszeitpunkt | Spätestens dann *muss* ich starten |
| **SEZ** | Spätester Endzeitpunkt | Spätestens dann *muss* ich fertig sein |
| **GP** | Gesamtpuffer | Wie viel darf sich der Vorgang verspäten, **ohne dass das Projektende kippt** |
| **FP** | Freier Puffer | Wie viel darf er sich verspäten, **ohne dass ein Nachfolger später anfangen muss** |

---

## 3. Die 5 Formeln (das ist alles!)

```
1)  FEZ = FAZ + Dauer
2)  FAZ = GRÖSSTER FEZ aller Vorgänger          ← MAXIMUM!
3)  SAZ = SEZ − Dauer
4)  SEZ = KLEINSTER SAZ aller Nachfolger        ← MINIMUM!
5)  GP  = SAZ − FAZ   (identisch mit SEZ − FEZ)
    FP  = kleinster FAZ der Nachfolger − eigener FEZ
```

### 🔑 Die einzige Sache, die man sich merken muss

> **Vorwärts = MAXIMUM. Rückwärts = MINIMUM.**

**Warum Maximum vorwärts?** Wenn zwei Vorgänger fertig sein müssen und einer
braucht bis Stunde 9, der andere bis Stunde 14 — dann kann ich frühestens ab
**14** loslegen. Der Langsamere bestimmt.

**Warum Minimum rückwärts?** Wenn ich zwei Nachfolger habe und einer muss
spätestens bei 6 starten, der andere bei 17 — dann muss ich spätestens bei **6**
fertig sein, sonst blockiere ich den ersten.

---

## 4. Das Verfahren in 5 Schritten

### Schritt 1 — Vorwärtsrechnung (von links nach rechts)
- Startvorgang: **FAZ = 0**
- Für jeden Vorgang: `FEZ = FAZ + Dauer`
- Nächster Vorgang: `FAZ = größter FEZ seiner Vorgänger`
- Der **FEZ des letzten Vorgangs = Projektdauer**

### Schritt 2 — Rückwärtsrechnung (von rechts nach links)
- Endvorgang: **SEZ = sein eigener FEZ** (Projektdauer)
- Für jeden Vorgang: `SAZ = SEZ − Dauer`
- Vorheriger Vorgang: `SEZ = kleinster SAZ seiner Nachfolger`
- **Kontrolle:** Beim Startvorgang muss SAZ = 0 herauskommen. Wenn nicht →
  Rechenfehler. **Das ist deine kostenlose Selbstkontrolle in der Prüfung!**

### Schritt 3 — Gesamtpuffer
`GP = SAZ − FAZ` für jeden Vorgang.

### Schritt 4 — Freier Puffer
`FP = kleinster FAZ der Nachfolger − eigener FEZ`
Beim letzten Vorgang: `FP = Projektdauer − FEZ` (meist 0).

### Schritt 5 — Kritischer Pfad einzeichnen
Alle Vorgänge mit **GP = 0** verbinden. Das ergibt eine durchgehende Kette vom
Start zum Ende. Diese Kette **fett/farbig markieren**.

---

## 5. Komplettes Beispiel (das echte aus AP1 Herbst 2021)

### Vorgangsliste

| Vorgang | Beschreibung | Dauer (h) | Vorgänger |
|---------|--------------|-----------|-----------|
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

### Struktur als Baum

```
A(2) → B(4) ─┬→ C(3) ─┐
             ├→ D(8) ─┴→ G(4) ─┐
             ├→ E(2) → H(1) ───┴→ I(3) → J(1) ─┐
             └→ F(5) ──────────────────────────┴→ K(2)
```

### Schritt 1: Vorwärtsrechnung

| Vorgang | Rechnung FAZ | FAZ | Dauer | FEZ |
|---|---|---|---|---|
| A | Start | 0 | 2 | **2** |
| B | FEZ(A) = 2 | 2 | 4 | **6** |
| C | FEZ(B) = 6 | 6 | 3 | **9** |
| D | FEZ(B) = 6 | 6 | 8 | **14** |
| E | FEZ(B) = 6 | 6 | 2 | **8** |
| F | FEZ(B) = 6 | 6 | 5 | **11** |
| G | **max**(FEZ C=9, FEZ D=14) | **14** | 4 | **18** |
| H | FEZ(E) = 8 | 8 | 1 | **9** |
| I | **max**(FEZ G=18, FEZ H=9) | **18** | 3 | **21** |
| J | FEZ(I) = 21 | 21 | 1 | **22** |
| K | **max**(FEZ F=11, FEZ J=22) | **22** | 2 | **24** |

➡️ **Projektdauer = 24 Stunden**

### Schritt 2: Rückwärtsrechnung

| Vorgang | Rechnung SEZ | SEZ | Dauer | SAZ |
|---|---|---|---|---|
| K | Ende = FEZ(K) | 24 | 2 | **22** |
| J | SAZ(K) = 22 | 22 | 1 | **21** |
| F | SAZ(K) = 22 | 22 | 5 | **17** |
| I | SAZ(J) = 21 | 21 | 3 | **18** |
| G | SAZ(I) = 18 | 18 | 4 | **14** |
| H | SAZ(I) = 18 | 18 | 1 | **17** |
| C | SAZ(G) = 14 | 14 | 3 | **11** |
| D | SAZ(G) = 14 | 14 | 8 | **6** |
| E | SAZ(H) = 17 | 17 | 2 | **15** |
| B | **min**(SAZ C=11, D=6, E=15, F=17) | **6** | 4 | **2** |
| A | SAZ(B) = 2 | 2 | 2 | **0** |

✅ **Kontrolle:** SAZ(A) = 0 → Rechnung stimmt.

### Schritt 3+4: Puffer

| Vorgang | FAZ | FEZ | SAZ | SEZ | **GP** = SAZ−FAZ | **FP** = min FAZ(Nachf.) − FEZ |
|---|---|---|---|---|---|---|
| A | 0 | 2 | 0 | 2 | **0** | 2 − 2 = **0** |
| B | 2 | 6 | 2 | 6 | **0** | 6 − 6 = **0** |
| C | 6 | 9 | 11 | 14 | **5** | FAZ(G)14 − 9 = **5** |
| D | 6 | 14 | 6 | 14 | **0** | 14 − 14 = **0** |
| E | 6 | 8 | 15 | 17 | **9** | FAZ(H)8 − 8 = **0** |
| F | 6 | 11 | 17 | 22 | **11** | FAZ(K)22 − 11 = **11** |
| G | 14 | 18 | 14 | 18 | **0** | 18 − 18 = **0** |
| H | 8 | 9 | 17 | 18 | **9** | FAZ(I)18 − 9 = **9** |
| I | 18 | 21 | 18 | 21 | **0** | 21 − 21 = **0** |
| J | 21 | 22 | 21 | 22 | **0** | 22 − 22 = **0** |
| K | 22 | 24 | 22 | 24 | **0** | 24 − 24 = **0** |

### Schritt 5: Kritischer Pfad

Alle Vorgänge mit GP = 0:

> **A → B → D → G → I → J → K**

Probe: 2 + 4 + 8 + 4 + 3 + 1 + 2 = **24 h** ✅ (muss immer die Projektdauer sein)

---

## 6. Die typische Folgefrage: „Vorgang X verzögert sich um n Stunden"

**So gehst du vor — immer gleich:**

```
1. GP von X nachschlagen.
2. Verzögerung ≤ GP  →  Projektende bleibt gleich.
   Verzögerung >  GP  →  Projektende verschiebt sich um (Verzögerung − GP).
```

**Beispiel aus Herbst 2021 (Aufgabe 1e):**
> „Vorgang H (Abbau der alten Infrastruktur) verzögert sich um vier Stunden.
> Beschreiben Sie die Auswirkung auf das Projektende."

H hat **GP = 9 h**. Die Verzögerung beträgt 4 h, also **4 ≤ 9**.

> ✅ **Antwort:** Keine Auswirkung. Vorgang H liegt nicht auf dem kritischen Pfad
> und besitzt einen Gesamtpuffer von 9 Stunden. Da die Verzögerung von 4 Stunden
> kleiner als dieser Puffer ist, bleibt das Projektende unverändert bei
> **24 Stunden**. Der Puffer von H reduziert sich lediglich auf 5 Stunden.

> ⚠️ Wäre die Frage „H verzögert sich um 12 Stunden" gewesen:
> 12 − 9 = 3 → Projektende verschiebt sich um 3 h auf 27 h, und H wird
> Teil des (neuen) kritischen Pfads.

---

## 7. Unterschied GP und FP — endlich verständlich

Schau dir Vorgang **E** an: GP = 9, aber FP = 0.

- **FP = 0** bedeutet: Sobald E sich auch nur 1 Stunde verspätet, muss sein
  Nachfolger **H** später anfangen. E „stiehlt" also sofort aus fremden Puffern.
- **GP = 9** bedeutet: Die Kette E→H hat zusammen 9 Stunden Luft, bevor das
  **Projektende** kippt.

**Merksatz:**
> **FP** = mein eigener Puffer, den ich verbrauchen darf, ohne jemanden zu stören.
> **GP** = der Puffer der ganzen Kette, den ich mir mit anderen teile.

Deshalb gilt immer: **FP ≤ GP**.

---

## 8. Häufigste Fehler (und wie du sie vermeidest)

| Fehler | Gegenmittel |
|---|---|
| Vorwärts Minimum statt Maximum genommen | Merksatz: *vorwärts max, rückwärts min* |
| Bei mehreren Nachfolgern nur einen beachtet | Alle Pfeile **abzählen**, bevor du rechnest |
| SEZ des Endvorgangs falsch gesetzt | SEZ(Ende) = FEZ(Ende) = Projektdauer |
| Kontrolle vergessen | SAZ des Startvorgangs **muss 0** sein |
| Kritischen Pfad „nach Gefühl" markiert | Nur GP = 0 zählt, nichts anderes |
| Kritischer Pfad ist unterbrochen | Er muss **lückenlos** von Start zu Ende gehen — sonst hast du einen Rechenfehler |
| Legende ignoriert | Manche Aufgabensätze ordnen die Felder anders an! |

---

## 9. Gantt-Diagramm (die Alternative, kann auch drankommen)

Ein **Gantt-Diagramm** (Balkenplan) zeigt Vorgänge als Balken auf einer
Zeitachse.

| | Netzplan | Gantt-Diagramm |
|---|---|---|
| **Vorteil** | Zeigt Abhängigkeiten, Puffer und kritischen Pfad exakt | Sehr anschaulich, zeigt Zeitverlauf und Parallelität sofort |
| **Nachteil** | Unübersichtlich bei vielen Vorgängen | Abhängigkeiten und Puffer schlecht/gar nicht erkennbar |

---

## Prüfungsfragen, die daraus kommen

1. **Vervollständigen Sie den Netzplan (FAZ, FEZ, SAZ, SEZ, GP, FP).**
2. **Markieren Sie den kritischen Pfad.** → alle Knoten mit GP = 0
3. **Wie lange dauert das Projekt?** → FEZ des letzten Vorgangs
4. **Welche Auswirkung hat eine Verzögerung von Vorgang X um n Stunden?**
   → mit GP vergleichen
5. **Was bedeutet ein Gesamtpuffer von 0?** → Vorgang liegt auf dem kritischen
   Pfad; jede Verzögerung verschiebt das Projektende
6. **Erklären Sie den Unterschied zwischen Gesamtpuffer und freiem Puffer.**
7. **Nennen Sie je einen Vor- und Nachteil von Netzplan und Gantt-Diagramm.**
