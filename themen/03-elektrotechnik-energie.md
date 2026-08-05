# 03 — Elektrotechnik, Leistung & Energiekosten ⭐

> **Warum wichtig:** Fast jede AP1 hat eine Stromrechnung drin — Wirkungsgrad,
> kWh-Kosten, Absicherung einer Steckdosenleiste, USV-Laufzeit. 6–12 Punkte.
> Es sind **immer dieselben vier Formeln**.

---

## 1. Die vier Grundformeln

```
1)  P = U · I            Leistung = Spannung · Stromstärke      [W = V · A]
2)  E = P · t            Energie  = Leistung · Zeit             [Wh = W · h]
3)  η = P_ab / P_zu      Wirkungsgrad = Nutzleistung / Aufgenommene Leistung
4)  Kosten = E[kWh] · Preis[EUR/kWh]
```

**Umgestellt** (das brauchst du dauernd):

```
I = P / U          U = P / I
P_zu = P_ab / η    P_ab = P_zu · η
```

### Einheiten — hier verliert man Punkte

| Größe | Einheit | Formelzeichen |
|---|---|---|
| Spannung | Volt (V) | U |
| Stromstärke | Ampere (A) | I |
| Leistung | Watt (W) | P |
| Energie / Arbeit | Wattstunde (Wh), Kilowattstunde (kWh) | E oder W |
| Widerstand | Ohm (Ω) | R |

**Netzspannung in Deutschland: 230 V** (Einphasenwechselstrom). Merken! Wird in
Aufgaben oft nicht angegeben, sondern vorausgesetzt.

**1 kWh = 1000 Wh.** Also: `kWh = Wh / 1000`. Der häufigste Fehler in der ganzen
Prüfung ist, diese Division zu vergessen oder durch 100 zu teilen.

---

## 2. Wirkungsgrad (Efficiency) — das Netzteil-Thema

In der Prüfung steht oft die englische Definition da:

> **Efficiency = Useful power output / Total power input**

Übersetzt: `Wirkungsgrad = abgegebene (genutzte) Leistung / aufgenommene Leistung`

### Was passiert physikalisch?

Ein PC-Netzteil zieht Strom aus der Steckdose (**P_zu**) und gibt Gleichstrom an
die Komponenten ab (**P_ab**). Die Differenz wird **in Wärme umgewandelt** — sie
ist verloren, du bezahlst sie aber trotzdem.

```
Steckdose ──[ P_zu = 139,53 W ]──► NETZTEIL ──[ P_ab = 60 W ]──► Mainboard, CPU, …
                                       │
                                       └──► 79,53 W Abwärme (= Verlust)
```

### Die entscheidende Denkrichtung

> Der Wirkungsgrad ist **immer < 100 %**, also ist **P_zu immer GRÖSSER als P_ab**.
> Wenn dein Ergebnis kleiner ist als die Nutzleistung → du hast multipliziert
> statt dividiert.

```
P_zu = P_ab / η          ← so rum, wenn du die Steckdosen-Leistung suchst
```

### Rechenbeispiel (Herbst 2021, Aufgabe 2a)

PC-A: Wirkungsgrad 43 %, Komponenten brauchen 60 W.

```
P_zu = 60 W / 0,43 = 139,53 W        ✅ (steht so im Aufgabensatz — Kontrolle!)
```

PC-B: Wirkungsgrad 76 %, Komponenten brauchen 60 W.

```
P_zu = 60 W / 0,76 = 78,947… ≈ 78,95 W
```

### 80 PLUS — die Zertifizierungsstufen

Wird gern als Wissensfrage gestellt. Werte bei 50 % Last, 230 V:

| Zertifikat | Wirkungsgrad (ca.) |
|---|---|
| 80 PLUS (Standard) | 82 % |
| 80 PLUS Bronze | 85 % |
| 80 PLUS Silber | 88 % |
| **80 PLUS Gold** | **90 %** |
| 80 PLUS Platin | 92 % |
| 80 PLUS Titan | 94 % |

**Nutzen des höheren Wirkungsgrads:** weniger Stromkosten, weniger Abwärme →
weniger Kühlaufwand → leiserer Betrieb → längere Lebensdauer der Bauteile.

---

## 3. Energiekosten pro Monat/Jahr berechnen

**Schema in 4 Schritten — immer gleich:**

```
1. Betriebsstunden ausrechnen:   h/Tag × Tage/Monat  =  h/Monat
2. Energie:                       P[W] × h  =  Wh
3. In kWh umrechnen:              Wh / 1000  =  kWh
4. Kosten:                        kWh × Preis pro kWh  =  EUR
```

### Beispiel (Herbst 2021, Aufgabe 2a)

Gegeben: 9 h/Tag, 20 Arbeitstage/Monat, 0,30 EUR/kWh.

```
Betriebsstunden = 9 h/Tag × 20 Tage = 180 h/Monat

PC-A:  139,53 W × 180 h = 25.115,4 Wh = 25,1154 kWh
       25,1154 kWh × 0,30 EUR/kWh = 7,53 EUR/Monat

PC-B:  78,95 W × 180 h = 14.211 Wh = 14,211 kWh
       14,211 kWh × 0,30 EUR/kWh = 4,26 EUR/Monat
```

**Ersparnis: 7,53 − 4,26 = 3,27 EUR pro Monat**

---

## 4. Absicherung / Mehrfachsteckdose (16-A-Aufgabe)

Ein absoluter Klassiker: *„Weisen Sie durch eine Rechnung nach, dass diese Geräte
nicht gleichzeitig betrieben werden können."*

**Zwei Wege, beide korrekt — such dir einen aus und mach ihn immer:**

### Weg A: Gesamtleistung → Stromstärke (empfohlen)
```
1. Alle Leistungen addieren      → P_gesamt
2. I = P_gesamt / 230 V          → tatsächliche Stromstärke
3. Mit 16 A vergleichen
```

### Weg B: Maximal zulässige Leistung
```
1. P_max = 230 V × 16 A = 3.680 W
2. Alle Leistungen addieren → P_gesamt
3. Vergleichen
```

### Beispiel (Herbst 2021, Aufgabe 2d)

| Gerät | Anzahl | Leistung | Summe |
|---|---|---|---|
| PC | 3 | 180 W | 540 W |
| Drucker | 1 | 400 W | 400 W |
| Kaffeemaschine | 1 | 1.200 W | 1.200 W |
| Klimagerät | 1 | 2.000 W | 2.000 W |
| | | **Gesamt** | **4.140 W** |

```
I = P / U = 4.140 W / 230 V = 18 A
18 A > 16 A  →  Überlastung!
```

> ✅ **Antwortsatz:** „Die Geräte benötigen zusammen 4.140 W. Bei einer
> Netzspannung von 230 V ergibt das eine Stromstärke von 4.140 W / 230 V = 18 A.
> Da 18 A den zulässigen Maximalwert der Mehrfachsteckdose von 16 A übersteigt,
> dürfen die Geräte nicht gleichzeitig betrieben werden — die Sicherung würde
> auslösen bzw. es besteht Brandgefahr."

> ⚠️ **Merke:** Die 16 A sind ein **Dauerstrom**-Grenzwert. Die zugehörige
> maximale Dauerleistung ist **230 V × 16 A = 3.680 W**. Diese Zahl solltest du
> im Kopf haben.

---

## 5. Maßnahmen zur Senkung der Energiekosten

Wird regelmäßig gefragt (*„Machen Sie drei Vorschläge…"*). Sammlung:

**Hardware:**
- Netzteile mit hohem Wirkungsgrad (80 PLUS Gold/Platin) einsetzen
- Notebooks / Thin Clients statt Desktop-PCs verwenden
- LED- oder OLED-Monitore statt älterer Geräte, Bildschirmgröße angemessen wählen
- SSD statt HDD (weniger Verbrauch)
- Mehrere Dienste auf einem Server **virtualisieren** statt viele physische Server

**Betrieb / Organisation:**
- Energiesparoptionen aktivieren (Standby, Ruhezustand, Festplatte abschalten)
- Bildschirm nach kurzer Inaktivität abschalten
- Geräte nach Feierabend komplett vom Netz trennen (schaltbare Steckdosenleiste)
  → verhindert **Standby-Verluste**
- Zentraler Netzwerkdrucker statt vieler Einzeldrucker
- Mitarbeitende schulen / sensibilisieren
- Automatisches Herunterfahren per Skript oder Gruppenrichtlinie

**Umfeld:**
- Serverraum-Klimatisierung optimieren (Kalt-/Warmgang-Trennung, freie Kühlung)
- Abwärme zur Raumheizung nutzen

---

## 6. USV-Laufzeit (kommt gelegentlich)

**USV = Unterbrechungsfreie Stromversorgung.** Überbrückt Stromausfälle, damit
Server kontrolliert heruntergefahren werden können.

```
Laufzeit [h] = Kapazität [Wh] / Leistungsaufnahme [W]
```

Beispiel: USV mit 1.500 Wh, angeschlossene Last 500 W
→ `1.500 / 500 = 3 h` Überbrückungszeit.

Achtung bei Angaben in **VA** (Scheinleistung): `P[W] = S[VA] × Leistungsfaktor`
(oft 0,6–0,9). Steht der Faktor nicht da, sagt die Aufgabe meist selbst, dass du
VA = W setzen darfst.

**Drei USV-Klassen:**
- **Offline/Standby (VFD)** — schaltet erst bei Ausfall um, günstig, kurze Lücke
- **Line-Interactive (VI)** — gleicht zusätzlich Spannungsschwankungen aus
- **Online/Dauerwandler (VFI)** — versorgt permanent über den Wechselrichter,
  absolut unterbrechungsfrei, teuerste und sicherste Variante

---

## Prüfungsfragen, die daraus kommen

1. **Berechnen Sie die aus dem Netz bezogene Leistung bei X W Nutzleistung und
   Wirkungsgrad η.** → `P_zu = P_ab / η`
2. **Berechnen Sie die Energiekosten pro Monat.** → 4-Schritte-Schema
3. **Weisen Sie nach, dass die Geräte nicht gleichzeitig betrieben werden
   können.** → `I = P/U` mit 230 V, gegen 16 A prüfen
4. **Nennen Sie drei Maßnahmen zur Senkung der Energiekosten.**
5. **Was bedeutet 80 PLUS Gold?** → Wirkungsgrad ≈ 90 %
6. **Warum ist ein hoher Wirkungsgrad sinnvoll?** → geringere Stromkosten,
   weniger Abwärme, geringerer Kühlbedarf, leiser, längere Lebensdauer
7. **Berechnen Sie die Überbrückungszeit einer USV.**
