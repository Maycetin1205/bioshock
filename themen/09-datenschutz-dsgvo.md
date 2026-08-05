# 09 — Datenschutz & DSGVO ⭐

> **Warum wichtig:** Datenschutz kommt in **fast jeder** AP1 vor, oft 6–12 Punkte.
> Und die AP1-Szenarien spielen auffällig oft in Arztpraxen, Kanzleien oder
> Personalabteilungen — also genau dort, wo besonders geschützte Daten liegen.

---

## 1. Datenschutz vs. Datensicherheit ⭐

Das wird gern verwechselt — und genau deshalb gefragt.

| | **Datenschutz** | **Datensicherheit** |
|---|---|---|
| Schützt | den **Menschen** vor Missbrauch seiner Daten | die **Daten** selbst |
| Frage | *Darf* ich diese Daten verarbeiten? | Sind die Daten technisch geschützt? |
| Grundlage | DSGVO, BDSG (rechtlich) | BSI-Grundschutz, ISO 27001 (technisch/organisatorisch) |
| Beispiel | Einwilligung einholen, Löschfristen | Verschlüsselung, Backup, Firewall |

**Merksatz:** *Datenschutz ist juristisch, Datensicherheit ist technisch.*

---

## 2. Personenbezogene Daten (Art. 4 DSGVO)

> **Personenbezogene Daten** sind alle Informationen, die sich auf eine
> **identifizierte oder identifizierbare natürliche Person** beziehen.

Beispiele: Name, Adresse, Geburtsdatum, E-Mail, Telefonnummer, IP-Adresse,
Personalnummer, Kfz-Kennzeichen, Standortdaten, Cookie-IDs.

**Nicht** personenbezogen: Daten juristischer Personen (Firmendaten),
**anonymisierte** Daten (Personenbezug endgültig entfernt).
**Pseudonymisierte** Daten bleiben personenbezogen — der Bezug ist nur mit einem
Zusatzschlüssel wiederherstellbar!

### Besondere Kategorien personenbezogener Daten — **Art. 9 DSGVO** ⭐

Das ist die Antwort auf die Standardfrage *„Für welche Daten ist ein besonderer
Schutz gesetzlich vorgeschrieben? Nennen Sie eine Rechtsgrundlage."*

- **Gesundheitsdaten** ← das sind Patientendaten in der Arztpraxis!
- rassische und ethnische Herkunft
- politische Meinungen
- religiöse oder weltanschauliche Überzeugungen
- Gewerkschaftszugehörigkeit
- genetische Daten
- biometrische Daten zur eindeutigen Identifizierung
- Daten zum Sexualleben oder der sexuellen Orientierung

**Verarbeitung ist grundsätzlich VERBOTEN**, außer es greift eine Ausnahme nach
Art. 9 Abs. 2 (z. B. ausdrückliche Einwilligung oder Verarbeitung durch
Gesundheitspersonal zur medizinischen Versorgung).

> ✅ **Musterantwort (Herbst 2021, Aufgabe 4d):**
> „Besonders geschützt sind personenbezogene Daten besonderer Kategorien, in einer
> Arztpraxis vor allem **Gesundheitsdaten der Patienten**. Rechtliche Grundlage
> ist **Art. 9 DSGVO** (Verarbeitung besonderer Kategorien personenbezogener
> Daten); ergänzend gelten das **BDSG** sowie die **ärztliche Schweigepflicht
> nach § 203 StGB**."

---

## 3. Die Grundsätze der Verarbeitung (Art. 5 DSGVO)

| Grundsatz | Bedeutung |
|---|---|
| **Rechtmäßigkeit, Verarbeitung nach Treu und Glauben, Transparenz** | Es braucht eine Rechtsgrundlage, und die Person muss informiert werden |
| **Zweckbindung** | Nur für den festgelegten Zweck verwenden |
| **Datenminimierung** | Nur so viele Daten wie nötig |
| **Richtigkeit** | Daten müssen korrekt und aktuell sein |
| **Speicherbegrenzung** | Löschen, sobald der Zweck erfüllt ist |
| **Integrität und Vertraulichkeit** | Angemessene Sicherheit (TOM) |
| **Rechenschaftspflicht** | Der Verantwortliche muss die Einhaltung **nachweisen** können |

---

## 4. Rechtsgrundlagen (Art. 6 DSGVO)

Eine Verarbeitung ist nur zulässig, wenn **mindestens eine** zutrifft:

1. **Einwilligung** der betroffenen Person (freiwillig, informiert, widerrufbar)
2. **Vertragserfüllung** oder vorvertragliche Maßnahmen
3. **Rechtliche Verpflichtung** (z. B. Aufbewahrungsfristen)
4. **Lebenswichtige Interessen** (Notfall)
5. **Öffentliches Interesse**
6. **Berechtigtes Interesse** des Verantwortlichen (mit Abwägung)

> 🔑 **Verbot mit Erlaubnisvorbehalt:** Jede Verarbeitung ist erst einmal
> **verboten**, es sei denn, einer dieser sechs Punkte greift. Das ist das
> Grundprinzip der DSGVO.

---

## 5. Rechte der betroffenen Person (Art. 15–22)

| Recht | Artikel | Inhalt |
|---|---|---|
| **Auskunft** | 15 | Welche Daten sind gespeichert, woher, wofür, wie lange? |
| **Berichtigung** | 16 | Falsche Daten korrigieren lassen |
| **Löschung** („Recht auf Vergessenwerden") | 17 | Daten löschen lassen |
| **Einschränkung der Verarbeitung** | 18 | Daten „einfrieren" statt löschen |
| **Datenübertragbarkeit** | 20 | Daten in maschinenlesbarem Format erhalten |
| **Widerspruch** | 21 | Der Verarbeitung widersprechen |
| **Keine automatisierte Einzelentscheidung** | 22 | Kein Profiling ohne menschliche Prüfung |

Frist für die Beantwortung: **ein Monat** (verlängerbar auf drei).

---

## 6. Pflichten des Unternehmens

| Pflicht | Artikel | Erklärung |
|---|---|---|
| **Verzeichnis von Verarbeitungstätigkeiten (VVT)** | 30 | Liste aller Verarbeitungen — Zweck, Kategorien, Empfänger, Fristen, TOM |
| **Technische und organisatorische Maßnahmen (TOM)** | 32 | Angemessene Sicherheit gewährleisten |
| **Meldung von Datenpannen** | 33 | An die Aufsichtsbehörde **innerhalb von 72 Stunden** |
| **Benachrichtigung Betroffener** | 34 | Bei hohem Risiko zusätzlich die Betroffenen informieren |
| **Datenschutz-Folgenabschätzung (DSFA)** | 35 | Bei voraussichtlich hohem Risiko (z. B. Gesundheitsdaten in großem Umfang) |
| **Auftragsverarbeitungsvertrag (AVV)** | 28 | Bei externen Dienstleistern (Cloud, IT-Wartung, Backup-Anbieter) |
| **Datenschutzbeauftragter (DSB)** | 37 | siehe unten |
| **Privacy by Design / by Default** | 25 | Datenschutz von Anfang an einbauen, datenschutzfreundliche Voreinstellungen |

### Wann ist ein Datenschutzbeauftragter Pflicht?
- wenn **mindestens 20 Personen** ständig mit automatisierter Verarbeitung
  personenbezogener Daten beschäftigt sind (§ 38 BDSG), **oder**
- wenn die Kerntätigkeit umfangreiche Verarbeitung **besonderer Kategorien**
  (Art. 9) ist — trifft auf größere Arztpraxen/Kliniken zu, **oder**
- bei umfangreicher regelmäßiger Überwachung von Personen, **oder**
- bei öffentlichen Stellen (immer)

### Bußgelder (Art. 83)
Bis zu **20 Mio. EUR** oder **4 % des weltweiten Jahresumsatzes** — der höhere
Wert gilt. (Geringere Stufe: 10 Mio. / 2 %.)

---

## 7. Technische und organisatorische Maßnahmen (TOM) — Art. 32

Die Standardfrage: *„Nennen Sie vier TOM."* Sortiere sie in zwei Töpfe:

### Technisch
- Verschlüsselung von Datenträgern (BitLocker, LUKS) und Übertragung (TLS, VPN)
- Pseudonymisierung / Anonymisierung
- Zugriffskontrolle über Benutzerkonten und Rollen
- Firewall, Virenschutz, Intrusion Detection
- Automatische Bildschirmsperre nach Inaktivität
- Protokollierung von Zugriffen (Logging)
- Regelmäßige Backups, getestete Wiederherstellung
- Updates / Patchmanagement

### Organisatorisch
- Verpflichtung der Mitarbeitenden auf Vertraulichkeit / Datengeheimnis
- Regelmäßige Schulungen und Sensibilisierung
- Berechtigungskonzept nach dem Prinzip der minimalen Rechte
- Zutrittskontrolle zu Server- und Behandlungsräumen (Schlüssel, Chipkarte)
- Clean-Desk-Policy, Bildschirme nicht zum Wartebereich ausrichten
- Verträge mit Dienstleistern (AVV)
- Notfall- und Löschkonzept, Datenschutz-Richtlinie
- Sichere Entsorgung: Aktenvernichter **DIN 66399**, Datenträger physisch
  vernichten oder mehrfach überschreiben

### Die klassischen „Kontrollen" (aus dem alten BDSG, wird noch gefragt)
Zutrittskontrolle (Räume) · **Zugangs**kontrolle (Systeme) · **Zugriffs**kontrolle
(Daten) · Weitergabekontrolle · Eingabekontrolle · Auftragskontrolle ·
Verfügbarkeitskontrolle · Trennungsgebot

> ⚠️ **Merke den Unterschied:** Zutritt = **Raum** · Zugang = **System/Anmeldung**
> · Zugriff = **Daten/Berechtigung**. Das wird gerne abgefragt.

---

## 8. Datenschutz in der Arztpraxis — typische Fallfragen

| Problem im Szenario | Richtige Maßnahme |
|---|---|
| Bildschirm an der Rezeption ist von Patienten einsehbar | Blickschutzfolie, Bildschirm drehen, automatische Sperre |
| Ausdrucke mit Patientendaten liegen am Drucker | Pull-Printing mit PIN/Karte, Drucker in geschütztem Raum |
| Patientenakten auf dem Tresen | Clean-Desk, abschließbare Schränke |
| Namensaufruf im Wartezimmer | Nummernsystem oder nur Nachname |
| Praxis nutzt Cloud-Backup | **AVV nach Art. 28**, Serverstandort EU, Verschlüsselung |
| Externer IT-Dienstleister wartet die Systeme | AVV, Verpflichtung auf Vertraulichkeit, protokollierter Zugriff |
| Alte PCs werden verkauft | Datenträger sicher löschen oder vernichten (DIN 66399) |
| Videosprechstunde | Zertifizierter Anbieter, Ende-zu-Ende-Verschlüsselung, Einwilligung |

---

## Prüfungsfragen, die daraus kommen

1. **Erklären Sie den Unterschied zwischen Datenschutz und Datensicherheit.**
2. **Für welche Daten gilt ein besonderer gesetzlicher Schutz? Nennen Sie eine
   Rechtsgrundlage.** → Art. 9 DSGVO, Gesundheitsdaten
3. **Nennen Sie vier technische und organisatorische Maßnahmen.**
4. **Nennen Sie vier Rechte betroffener Personen nach DSGVO.**
5. **Innerhalb welcher Frist ist eine Datenpanne zu melden?** → 72 Stunden
6. **Was ist ein Auftragsverarbeitungsvertrag und wann ist er nötig?**
7. **Wann muss ein Datenschutzbeauftragter benannt werden?**
8. **Nennen Sie die Grundsätze der Datenverarbeitung nach Art. 5 DSGVO.**
9. **Wie hoch können Bußgelder ausfallen?** → 20 Mio. EUR oder 4 % Jahresumsatz
