# 04 — Kaufmännisches Rechnen

> **Warum wichtig:** In jeder AP1 stecken 6–15 Punkte in Rechenaufgaben, die
> mathematisch Mittelstufen-Niveau haben. Man verliert sie nur, weil man das
> Schema nicht kennt oder den Rechenweg nicht hinschreibt.

---

## 0. Die goldenen Regeln fürs Rechnen in der AP1

1. **Rechenweg IMMER hinschreiben** — auch wenn nicht ausdrücklich gefordert.
   Bei falschem Ergebnis gibt es Teilpunkte auf den Weg.
2. **Einheiten mitschreiben** — `180 h`, nicht `180`.
3. **Antwortsatz schreiben** — „Die Anschaffung amortisiert sich nach 31 Monaten."
4. **Kaufmännisch runden** (ab 5 aufrunden) — aber:
5. **Bei Zeit/Stückzahlen IMMER aufrunden**, auch bei 30,1 → 31. Man kann keine
   halbe Person, keinen halben Tag Amortisation haben.
6. Wenn du mit einem **gerundeten Zwischenergebnis** weiterrechnen sollst, dann
   rechne wirklich damit weiter (steht so in den Bearbeitungshinweisen).

---

## 1. Dreisatz

Die Basis von allem. Zwei Varianten:

### Proportional (je mehr, desto mehr)
> 3 Lizenzen kosten 150 EUR. Was kosten 7 Lizenzen?

```
3 Lizenzen → 150 EUR
1 Lizenz   → 150 / 3      =  50 EUR
7 Lizenzen →  50 × 7      = 350 EUR
```

### Antiproportional (je mehr, desto weniger)
> 2 Mitarbeiter brauchen 20 Tage. Wie lange brauchen 5?

```
2 MA → 20 Tage
1 MA → 20 × 2 = 40 Tage     (ein MA braucht LÄNGER → mal)
5 MA → 40 / 5 =  8 Tage
```

> 🔑 **Merke:** Beim antiproportionalen Dreisatz drehen sich Mal und Geteilt um.

---

## 2. Prozentrechnung

```
Prozentwert  W = G · p / 100
Grundwert    G = W · 100 / p
Prozentsatz  p = W · 100 / G
```

| Formulierung | Rechnung |
|---|---|
| „um 19 % erhöhen" | `× 1,19` |
| „um 15 % reduzieren" | `× 0,85` |
| „Netto → Brutto (19 % USt)" | `× 1,19` |
| „Brutto → Netto (19 % USt)" | `/ 1,19` |
| „3 % Skonto abziehen" | `× 0,97` |

> ⚠️ **Klassische Falle:** Brutto → Netto ist **nicht** „minus 19 %", sondern
> **geteilt durch 1,19**. 119 EUR brutto sind 100 EUR netto, nicht 96,39 EUR.

---

## 3. Amortisationsrechnung ⭐

**Amortisation = ab wann hat sich eine teurere Anschaffung durch die Ersparnis
bezahlt gemacht?**

```
Amortisationsdauer = Mehrkosten der Anschaffung / Ersparnis pro Zeiteinheit
```

Und dann **immer aufrunden** — erst nach dem vollen Zeitraum ist der Betrag
tatsächlich wieder drin.

### Beispiel (Herbst 2021, Aufgabe 2b)

Der PC mit Gold-Netzteil kostet 100 EUR mehr, spart aber Strom:

```
Ersparnis pro Monat  = 7,53 EUR − 4,26 EUR = 3,27 EUR
Amortisationsdauer   = 100 EUR / 3,27 EUR/Monat = 30,58 Monate
                     → aufgerundet 31 Monate
```

**Antwortsatz:** „Die Mehrkosten von 100 EUR amortisieren sich nach 31 Monaten
(rund 2 Jahre und 7 Monate)."

> 💡 Häufige Zusatzfrage: *„Beurteilen Sie, ob die Anschaffung sinnvoll ist."*
> Antwort: Bei einer üblichen Nutzungsdauer von PCs von 3–5 Jahren (36–60 Monate)
> liegt die Amortisation von 31 Monaten darunter — die Anschaffung lohnt sich
> also. Zusätzlich: geringere Abwärme, längere Lebensdauer, Nachhaltigkeit.

---

## 4. Personal- und Dienstleisterkosten

### Grundformel
```
Kosten = Anzahl × Aufwand pro Stück × Stundensatz
```

### Beispiel (Herbst 2021, Aufgabe 3ba)
> 20 Postfächer, je 2 h Migration, Dienstleister 130 EUR/h.

```
Gesamtstunden = 20 Postfächer × 2 h = 40 h
Gesamtkosten  = 40 h × 130 EUR/h    = 5.200 EUR
```

### Dauer bei mehreren Mitarbeitern (Herbst 2021, Aufgabe 3bb)
> Zwei Angestellte, je 8 h pro Tag.

```
Kapazität pro Tag = 2 Personen × 8 h = 16 h/Tag
Benötigte Tage    = 40 h / 16 h/Tag  = 2,5 Tage  → 3 Arbeitstage
```

> ⚠️ **Aufrunden!** Nach 2,5 Tagen ist die Arbeit noch nicht abgeschlossen — der
> dritte Tag wird angebrochen. Die Frage lautet „nach wie vielen Tagen
> **abgeschlossen**" → **3 Tage**.

> 💡 **Zusatz-Denkfalle in genau dieser Aufgabe:** Es darf nur außerhalb der
> Öffnungszeiten gearbeitet werden (18:00–8:00 Uhr = 14 h Fenster). Zwei
> Mitarbeiter × 8 h = 16 h passen in dieses Fenster nicht ganz gleichzeitig,
> aber die IHK-Lösung rechnet mit der reinen Kapazität. Schreib deinen
> Rechenweg hin — dann bekommst du die Punkte in jedem Fall.

---

## 5. Angebotsvergleich (Bezugskalkulation)

Klassisches Schema, wenn zwei Lieferantenangebote verglichen werden sollen:

```
   Listeneinkaufspreis
−  Rabatt
=  Zieleinkaufspreis
−  Skonto
=  Bareinkaufspreis
+  Bezugskosten (Fracht, Verpackung, Versicherung)
=  BEZUGSPREIS   ← dieser Wert wird verglichen!
```

**Wichtig:** Verglichen wird immer der **Bezugspreis**, nicht der Listenpreis.
Und immer **netto** vergleichen, wenn beide Firmen vorsteuerabzugsberechtigt sind.

Qualitative Kriterien, die zusätzlich genannt werden können: Lieferzeit,
Zahlungsziel, Garantie/Gewährleistung, Support-Reaktionszeit (SLA),
Zuverlässigkeit, Referenzen, Ersatzteilverfügbarkeit, Nachhaltigkeit.

---

## 6. Make-or-Buy / Kostenvergleich

*„Ab welcher Menge lohnt sich Eigenfertigung?"* → Gleichung aufstellen:

```
Fixkosten_Eigen + variable_Eigen · x  =  Preis_extern · x
```
nach `x` auflösen → **kritische Menge**.

### Beispiel
Eigenbetrieb Server: 3.000 EUR Fixkosten + 5 EUR pro Nutzer/Monat.
Cloud: 20 EUR pro Nutzer/Monat.

```
3.000 + 5x = 20x
3.000 = 15x
x = 200
```
→ Ab **200 Nutzern** ist der Eigenbetrieb günstiger, darunter die Cloud.

---

## 7. Speichergrößen & Übertragungszeiten

**Einheiten (die zwei Systeme!):**

| Dezimal (SI) | Binär (IEC) |
|---|---|
| 1 kB = 1.000 Byte | 1 KiB = 1.024 Byte |
| 1 MB = 1.000 kB | 1 MiB = 1.024 KiB |
| 1 GB = 1.000 MB | 1 GiB = 1.024 MiB |
| 1 TB = 1.000 GB | 1 TiB = 1.024 GiB |

> ⚠️ **Bit vs. Byte:** `1 Byte = 8 Bit`. Netzwerkgeschwindigkeiten sind in
> **Bit/s** (Mbit/s, Gbit/s), Dateigrößen in **Byte**. Das ist die Falle Nummer 1.

### Übertragungszeit berechnen
```
Zeit [s] = Datenmenge [Bit] / Übertragungsrate [Bit/s]
```

**Beispiel:** 20 GB Backup über eine 100-Mbit/s-Leitung.
```
20 GB = 20 × 1.000 MB = 20.000 MB
20.000 MB × 8 = 160.000 Mbit
160.000 Mbit / 100 Mbit/s = 1.600 s = 26,67 min ≈ 27 Minuten
```

Realistischer Zusatz: In der Praxis kommen wegen Protokoll-Overhead nur ca.
80–90 % der Bruttorate an — das darfst du als Bemerkung dazuschreiben.

---

## 8. Verfügbarkeit berechnen

```
Verfügbarkeit [%] = (Gesamtzeit − Ausfallzeit) / Gesamtzeit × 100
```

Ausfallzeit pro Jahr (8.760 h) — Werte zum Merken:

| Verfügbarkeit | Ausfall pro Jahr | Bezeichnung |
|---|---|---|
| 99 % | ca. 3,65 Tage | |
| 99,9 % | ca. 8,8 Stunden | „drei Neunen" |
| 99,99 % | ca. 53 Minuten | „vier Neunen" |
| 99,999 % | ca. 5,3 Minuten | „fünf Neunen" / hochverfügbar |

---

## Prüfungsfragen, die daraus kommen

1. **Berechnen Sie die Gesamtkosten für X. Der Rechenweg ist anzugeben.**
2. **Nach wie vielen Tagen ist die Arbeit frühestens abgeschlossen?**
3. **Berechnen Sie die Amortisationsdauer in Monaten.**
4. **Vergleichen Sie die beiden Angebote und ermitteln Sie den Bezugspreis.**
5. **Wie lange dauert die Übertragung von X GB über eine Y-Mbit/s-Leitung?**
6. **Ab welcher Nutzerzahl lohnt sich Eigenbetrieb gegenüber Cloud?**
7. **Berechnen Sie die Verfügbarkeit in Prozent.**
