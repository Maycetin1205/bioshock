# Übungsaufgaben AP1

> **Regel:** Erst alles selbst lösen, Lösungen in
> [loesungen.md](loesungen.md) erst danach anschauen. Papier und Taschenrechner
> bereitlegen.

---

## Block A — Netzplan (20 Punkte)

**A1.** Gegeben ist folgende Vorgangsliste:

| Vorgang | Dauer (Tage) | Vorgänger |
|---|---|---|
| A | 3 | — |
| B | 5 | A |
| C | 2 | A |
| D | 4 | B |
| E | 6 | B, C |
| F | 2 | D, E |

a) Führen Sie die Vorwärts- und Rückwärtsrechnung durch (FAZ, FEZ, SAZ, SEZ).
b) Berechnen Sie für jeden Vorgang GP und FP.
c) Wie lange dauert das Projekt?
d) Nennen Sie den kritischen Pfad.
e) Vorgang D verzögert sich um 3 Tage. Welche Auswirkung hat das?
f) Vorgang C verzögert sich um 8 Tage. Welche Auswirkung hat das?

---

## Block B — Energie & Strom (16 Punkte)

**B1.** Ein Server benötigt intern 320 W. Das Netzteil hat einen Wirkungsgrad
von 85 %.
a) Welche Leistung wird aus dem Stromnetz bezogen?
b) Der Server läuft 24/7. Wie hoch sind die Energiekosten pro Jahr bei
   0,32 EUR/kWh? (365 Tage)

**B2.** In einem Büro sollen an eine mit 16 A abgesicherte Steckdosenleiste
angeschlossen werden: 4 Monitore à 35 W, 2 PCs à 250 W, 1 Laserdrucker mit
900 W, 1 Wasserkocher mit 2.200 W.
a) Ist der gleichzeitige Betrieb möglich? Rechnung erforderlich.
b) Welche Leistung dürfte maximal angeschlossen werden?

**B3.** Ein Monitor mit 45 W wird durch ein Modell mit 22 W ersetzt. Das neue
Gerät kostet 90 EUR mehr. Betrieb: 8 h/Tag, 22 Tage/Monat, 0,35 EUR/kWh.
Nach wie vielen Monaten amortisiert sich der Mehrpreis?

---

## Block C — RAID & Speicher (12 Punkte)

**C1.** Ein Server hat 6 Festplatten à 8 TB.
a) Wie groß ist die Nutzkapazität bei RAID 0, RAID 1, RAID 5, RAID 6, RAID 10?
b) Wie viele Platten dürfen jeweils ausfallen?

**C2.** Ein Kunde sagt: „Wir haben ein RAID 1, also brauchen wir kein Backup."
Nehmen Sie in drei Sätzen begründet Stellung.

**C3.** Erklären Sie den Unterschied zwischen NAS und SAN und nennen Sie je einen
typischen Einsatzzweck.

---

## Block D — Netzwerk (16 Punkte)

**D1.** Gegeben: `192.168.30.145 / 26`
a) Wie lautet die Subnetzmaske in Dezimalschreibweise?
b) Netzadresse, erste und letzte nutzbare Hostadresse, Broadcastadresse?
c) Wie viele Hosts sind pro Subnetz nutzbar?

**D2.** Ein Netz `10.0.0.0/24` soll in Subnetze mit jeweils mindestens 25 Hosts
aufgeteilt werden.
a) Welche CIDR-Notation wählen Sie?
b) Wie viele Subnetze entstehen?

**D3.** Ordnen Sie zu: Switch, Router, Hub — welche OSI-Schicht?

**D4.** Nennen Sie die Standardports von HTTPS, SSH, DNS, IMAPS und RDP.

**D5.** Eine 12-GB-Datei soll über eine 250-Mbit/s-Leitung übertragen werden.
Wie lange dauert das theoretisch?

---

## Block E — Skript (8 Punkte)

**E1.** Das Skript soll eine Warnung ausgeben, wenn die CPU-Auslastung
**über 90 %** liegt. Es meldet aber ständig eine Warnung, obwohl die Auslastung
bei 20 % liegt. Finden Sie die **zwei** Fehler.

```powershell
$CPU = Get-Counter '\Prozessor(_total)\Prozessorzeit (%)'
$Wert = $CPU.CounterSamples.CookedValue / 100
if ($Wert -lt 90)
{
    Write-Host "Warnung: CPU-Auslastung über 90%!"
}
else
{
    Write-Host "CPU-Auslastung im Normalbereich."
}
```

**E2.** Welche Linux-Rechte entsprechen `chmod 640`? Schreiben Sie die
Buchstabenschreibweise und erklären Sie, wer was darf.

**E3.** Formulieren Sie einen Cron-Eintrag für eine Sicherung, die von Montag bis
Freitag um 22:30 Uhr läuft.

---

## Block F — Datenschutz & Sicherheit (18 Punkte)

**F1.** Ordnen Sie jeder Maßnahme das passende Schutzziel zu (Vertraulichkeit,
Integrität, Verfügbarkeit) und begründen Sie in einem Satz:

| Maßnahme | Schutzziel | Begründung |
|---|---|---|
| Unterbrechungsfreie Stromversorgung (USV) | | |
| Digitale Signatur von E-Mails | | |
| Automatische Bildschirmsperre nach 5 Minuten | | |
| Redundante Internetanbindung über zwei Provider | | |
| Schreibgeschützte Archivierung von Rechnungen | | |
| VPN-Verbindung im Homeoffice | | |

**F2.** Ein Steuerberatungsbüro speichert Mandantendaten. Nennen Sie vier
technische und zwei organisatorische Maßnahmen (TOM).

**F3.** Innerhalb welcher Frist muss eine Datenschutzverletzung gemeldet werden
und an wen? Nennen Sie den Artikel.

**F4.** Nennen Sie zwei Kriterien eines sicheren Passworts **mit Begründung**.

**F5.** Ein Mitarbeiter fragt: „Warum darf ich nicht mit meinem
Administrator-Konto im Internet surfen?" Antworten Sie in zwei bis drei Sätzen.

---

## Block G — Projekt, Beschaffung, Beratung (20 Punkte)

**G1.** Nennen Sie vier Merkmale eines Projekts.

**G2.** Formulieren Sie ein SMARTes Ziel für: „Die Firma soll ein neues
Ticketsystem bekommen."

**G3.** Wer erstellt das Lastenheft, wer das Pflichtenheft? Nennen Sie je zwei
typische Inhalte.

**G4.** Ein Dienstleister verlangt 95 EUR/h. Es sind 35 Arbeitsplätze
einzurichten, je 1,5 h.
a) Gesamtkosten?
b) Wie viele Arbeitstage benötigen 3 Techniker bei 8 h/Tag?

**G5.** Nennen Sie je zwei Vor- und Nachteile eines Webinars gegenüber einer
Präsenzschulung.

**G6.** Ein Kunde möchte wissen, warum er mehr Geld für ein Netzteil mit
80-PLUS-Gold-Zertifizierung ausgeben soll. Argumentieren Sie mit
Merkmal → Vorteil → Nutzen.

---

## Block H — Hardware & Betriebssystem (10 Punkte)

**H1.** Eine 7-GB-Videodatei lässt sich nicht auf einen USB-Stick mit 64 GB
kopieren. Nennen Sie die wahrscheinliche Ursache und die Lösung.

**H2.** Nennen Sie je zwei Vor- und Nachteile von HDD und SSD.

**H3.** Nennen Sie vier Anforderungen an einen ergonomischen
Bildschirmarbeitsplatz.

**H4.** Erklären Sie den Unterschied zwischen Typ-1- und Typ-2-Hypervisor und
nennen Sie je ein Beispiel.

**H5.** Nennen Sie drei Vorteile der Servervirtualisierung.

---

**Gesamt: 120 Punkte** — Zeitvorgabe für alles: ca. 110 Minuten.
