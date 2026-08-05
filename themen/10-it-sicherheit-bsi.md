# 10 — IT-Sicherheit & BSI-Grundschutz ⭐

> **Warum wichtig:** Schutzziele, Schutzbedarfsanalyse und Passwortsicherheit sind
> AP1-Dauerbrenner. In Herbst 2021 allein waren das **18 von 24 Punkten** der
> vierten Aufgabe.

---

## 1. Die drei Schutzziele (CIA) ⭐⭐⭐

Das musst du im Schlaf können — inklusive Zuordnung von Maßnahmen.

| Schutzziel | Englisch | Bedeutung | Typische Maßnahmen |
|---|---|---|---|
| **Vertraulichkeit** | Confidentiality | Nur **Befugte** dürfen die Daten **sehen** | Verschlüsselung, Passwörter, Berechtigungen, Zutrittskontrolle, VPN, Blickschutzfolie |
| **Integrität** | Integrity | Daten sind **unverfälscht und vollständig** | Prüfsummen/Hashwerte, digitale Signatur, Prüfziffern, Versionierung, Schreibrechte, ECC-RAM |
| **Verfügbarkeit** | Availability | Daten sind **da, wenn man sie braucht** | Backup, RAID, USV, Redundanz, Cluster, Wartung, Notfallplan |

### Ergänzende Schutzziele
- **Authentizität** — die Identität ist echt und nachweisbar
- **Nichtabstreitbarkeit / Verbindlichkeit** — eine Handlung kann nicht geleugnet
  werden (digitale Signatur, Protokollierung)

### 🔑 Der Trick zur Zuordnung

Frag dich bei jeder Maßnahme genau eine Frage:

```
Verhindert sie, dass jemand die Daten SIEHT?        → Vertraulichkeit
Verhindert sie, dass die Daten VERÄNDERT werden?    → Integrität
Sorgt sie dafür, dass die Daten NOCH DA sind?       → Verfügbarkeit
```

### Übungstabelle (genau das Format aus Herbst 2021, Aufgabe 4a)

| Maßnahme | Schutzziel | Begründung |
|---|---|---|
| Sichere Passwörter wählen | **Vertraulichkeit** | Der Zugriff Fremder auf die Benutzerdaten wird besser geschützt |
| Regelmäßige Datensicherung der Patientendaten | **Verfügbarkeit** | Nach Datenverlust können die Daten wiederhergestellt werden und stehen weiter zur Verfügung |
| Verschlüsselung der Festplatten | **Vertraulichkeit** | Bei Diebstahl des Geräts können Unbefugte die Daten nicht lesen |
| Zentrale Bearbeitung wichtiger Dokumente auf dem Server | **Integrität** | Es existiert nur eine gültige Version; widersprüchliche lokale Kopien und Änderungskonflikte werden vermieden |
| Hashwertüberprüfung bei Softwareinstallation | **Integrität** | Eine Abweichung des Hashwerts zeigt, dass die Datei nachträglich verändert oder manipuliert wurde |

> ⚠️ **Häufiger Fehler:** „Datensicherung" wird oft der Integrität zugeordnet.
> Falsch — ein Backup stellt sicher, dass die Daten **wieder verfügbar** sind.
> Integrität = Schutz vor **Verfälschung**.

---

## 2. Schutzbedarfsanalyse (BSI)

Ziel: Für jede IT-Anwendung festlegen, **wie schlimm** ein Schaden wäre — daraus
folgt, wie viel Schutz sich lohnt.

### Die drei Kategorien
| Kategorie | Beschreibung |
|---|---|
| **Normal (niedrig bis mittel)** | Die Schadensauswirkungen sind begrenzt und überschaubar |
| **Hoch** | Die Schadensauswirkungen können beträchtlich sein |
| **Sehr hoch** | Die Schadensauswirkungen können ein existenziell bedrohliches, katastrophales Ausmaß erreichen |

### Das Maximumprinzip
Der Schutzbedarf eines **Systems** richtet sich nach der **Anwendung mit dem
höchsten** Schutzbedarf, die darauf läuft. (Ergänzt durch das **Kumulationsprinzip**
— viele kleine Schäden können zusammen groß werden — und das
**Verteilungsprinzip**.)

### Begründungen formulieren — das Schema

> **„Wenn [Schutzziel verletzt wird], dann [konkrete Folge für den Betrieb /
> die Patienten / rechtlich]."**

Beispiele (Herbst 2021, Aufgabe 4c):

| IT-Anwendung | Schutzziel | Kategorie | Begründung |
|---|---|---|---|
| Prüfziffernverfahren bei Übermittlung der Krankenversicherungsnummer | Integrität | hoch | Verfälschte Daten bei der Übertragung können zu fehlerhaften Abrechnungen führen |
| Textverarbeitung | Verfügbarkeit | mittel | Bei Ausfall kann kurzfristig auf andere Arbeitsplätze oder handschriftliche Erfassung ausgewichen werden; der Praxisbetrieb läuft weiter, es entsteht nur begrenzter Mehraufwand |
| Software zur telemedizinischen Beratung per Videokonferenz | Vertraulichkeit | hoch | Im Gespräch werden sensible Gesundheitsdaten übertragen; ein Mithören durch Dritte verletzt die ärztliche Schweigepflicht und Art. 9 DSGVO und schädigt das Vertrauensverhältnis erheblich |
| Patientendatenverarbeitung | Integrität | sehr hoch | Verfälschte Patientendaten (z. B. Diagnosen, Allergien, Medikation) können zu Fehlbehandlungen mit lebensbedrohlichen Folgen führen und die Existenz der Praxis gefährden |

---

## 3. BSI IT-Grundschutz

**BSI** = Bundesamt für Sicherheit in der Informationstechnik.
Das **IT-Grundschutz-Kompendium** enthält **Bausteine** mit Anforderungen in drei
Stufen: **Basis-Anforderungen** (MUSS) → Standard-Anforderungen (SOLL) →
Anforderungen bei erhöhtem Schutzbedarf.

### Basis-Anforderungen für PC-Clients und ihre Umsetzung ⭐

Genau die Frage aus Herbst 2021, Aufgabe 4b:

| Anforderung | Konkrete Maßnahme |
|---|---|
| **Aktivieren von Autoupdate-Mechanismen** | Automatische Updates in den Windows-Einstellungen bzw. zentral per Gruppenrichtlinie (GPO) oder WSUS aktivieren, sodass Sicherheitsupdates für Betriebssystem und Anwendungen ohne Zutun der Nutzenden regelmäßig eingespielt werden |
| **Differenzieren von Benutzerrollen (Rollentrennung)** | Für jede Person ein eigenes Benutzerkonto mit eingeschränkten Rechten anlegen und Berechtigungen über Gruppen nach dem Prinzip der minimalen Rechte vergeben; administrative Tätigkeiten erfolgen ausschließlich über ein getrenntes Administratorkonto |
| Einsatz von Virenschutzprogrammen | Zentral verwalteter Virenschutz mit automatischen Signatur-Updates |
| Absicherung des Bootvorgangs | BIOS/UEFI-Passwort, Secure Boot, Bootreihenfolge fixieren |
| Bildschirmsperre | Automatische Sperre nach wenigen Minuten Inaktivität, Sperren beim Verlassen (Win+L) |
| Verschlüsselung des Datenträgers | BitLocker / LUKS mit TPM |
| Protokollierung | Sicherheitsrelevante Ereignisse zentral protokollieren |
| Restriktive Rechtevergabe | Keine lokalen Administratorrechte für Standardnutzer |

---

## 4. Passwortsicherheit ⭐

Standardfrage: *„Führen Sie zwei Kriterien an, die ein sicheres Passwort erfüllen
sollte. Beschreiben Sie auch, warum diese Kriterien für höhere Sicherheit sorgen."*

> 🔑 **Wichtig:** Die Begründung ist die halbe Punktzahl! Nie nur das Kriterium
> nennen.

| Kriterium | Begründung |
|---|---|
| **Ausreichende Länge** (mind. 12, besser 16 Zeichen) | Jedes zusätzliche Zeichen vervielfacht die Anzahl möglicher Kombinationen. Der Aufwand für einen Brute-Force-Angriff steigt exponentiell, sodass das Passwort in vertretbarer Zeit nicht durchprobiert werden kann |
| **Verschiedene Zeichenarten** (Groß-/Kleinbuchstaben, Ziffern, Sonderzeichen) | Vergrößert den Zeichenvorrat und damit den Suchraum erheblich — statt 26 stehen über 90 mögliche Zeichen pro Stelle zur Verfügung |
| **Keine Wörter aus dem Wörterbuch, keine Namen/Geburtsdaten** | Wörterbuch- und Social-Engineering-Angriffe probieren gezielt sinnvolle Wörter und persönliche Daten zuerst durch — zufällige Zeichenfolgen sind dagegen wirkungslos |
| **Für jeden Dienst ein eigenes Passwort** | Bei einem Datenleck bei einem Anbieter können die Angreifer die Zugangsdaten nicht bei anderen Diensten wiederverwenden (Credential Stuffing) |
| **Nicht notieren / sicher aufbewahren** | Ein aufgeschriebenes Passwort unter der Tastatur macht alle technischen Maßnahmen wirkungslos — stattdessen Passwortmanager verwenden |

**Aktuelle BSI-Empfehlung:** Lieber **lang und einprägsam** als kurz und kryptisch.
Ein erzwungener regelmäßiger Wechsel wird **nicht mehr empfohlen** (führt zu
`Sommer2025!` → `Sommer2026!`) — gewechselt wird nur bei Verdacht auf Kompromittierung.

**Ergänzende Maßnahmen:** Multi-Faktor-Authentifizierung (MFA), Passwortmanager,
Account-Sperre nach mehreren Fehlversuchen, Passwortrichtlinie per GPO.

### Multi-Faktor-Authentifizierung
Kombination aus mindestens **zwei verschiedenen Faktoren**:
- **Wissen** — Passwort, PIN
- **Besitz** — Smartphone, Token, Chipkarte, TAN-Generator
- **Sein / Biometrie** — Fingerabdruck, Gesicht, Iris

> Zwei Passwörter sind **keine** MFA — es müssen unterschiedliche Kategorien sein.

---

## 5. Bedrohungen und Angriffsarten

| Bedrohung | Was passiert | Gegenmaßnahme |
|---|---|---|
| **Ransomware** | Verschlüsselt Daten, fordert Lösegeld | Offline-/Offsite-Backup (3-2-1), Updates, Virenschutz, Netzsegmentierung, Schulung |
| **Phishing** | Gefälschte Mails/Seiten erbeuten Zugangsdaten | Schulung, Spamfilter, MFA, DMARC/SPF/DKIM |
| **Social Engineering** | Manipulation von Menschen („Chef-Masche", falscher Techniker) | Schulung, Rückrufverfahren, klare Prozesse |
| **Brute Force** | Systematisches Durchprobieren von Passwörtern | Lange Passwörter, MFA, Account-Sperre, Fail2ban |
| **Man-in-the-Middle** | Mithören/Manipulieren der Verbindung | TLS/VPN, Zertifikatsprüfung, kein offenes WLAN |
| **DDoS** | Überlastung durch Anfragefluten | Filterung, CDN, Ratenbegrenzung |
| **SQL-Injection** | Einschleusen von SQL über Eingabefelder | Prepared Statements, Eingabevalidierung |
| **Zero-Day** | Lücke ohne verfügbaren Patch | Segmentierung, IDS/IPS, minimale Rechte |
| **Innentäter** | Missbrauch legitimer Rechte | Least Privilege, Protokollierung, Vier-Augen-Prinzip |

---

## 6. Hashwerte, Verschlüsselung, Zertifikate

### Hashfunktion
Erzeugt aus beliebigen Daten einen festen **Fingerabdruck** (z. B. SHA-256).
- **Einwegfunktion** — nicht umkehrbar
- Kleinste Änderung → völlig anderer Hash
- **Zweck: Integrität prüfen**, Passwörter speichern (mit Salt)
- Veraltet und unsicher: **MD5, SHA-1**. Verwenden: **SHA-256/SHA-3**

### Symmetrisch vs. asymmetrisch ⭐
| | **Symmetrisch** | **Asymmetrisch** |
|---|---|---|
| Schlüssel | **ein** gemeinsamer Schlüssel | **Schlüsselpaar**: öffentlich + privat |
| Geschwindigkeit | sehr schnell | langsam |
| Problem | sichere Schlüsselübergabe | Vertrauen in den öffentlichen Schlüssel (PKI) |
| Beispiel | AES | RSA, ECC |
| Einsatz | große Datenmengen, Festplatten | Schlüsselaustausch, Signaturen |

**Hybride Verschlüsselung** (das, was TLS/HTTPS wirklich macht): Der schnelle
symmetrische Sitzungsschlüssel wird **asymmetrisch** übertragen, die eigentlichen
Daten dann **symmetrisch** verschlüsselt. Beste aus beiden Welten.

### Verschlüsseln vs. Signieren — die Merkregel
```
VERSCHLÜSSELN:  mit dem ÖFFENTLICHEN Schlüssel des EMPFÄNGERS
                → nur der Empfänger kann entschlüsseln  → Vertraulichkeit

SIGNIEREN:      mit dem PRIVATEN Schlüssel des SENDERS
                → jeder kann prüfen, dass es von mir ist → Authentizität + Integrität
```

---

## Prüfungsfragen, die daraus kommen

1. **Ordnen Sie jeder Maßnahme ein Schutzziel zu und begründen Sie.**
2. **Nennen Sie die drei Schutzziele der Informationssicherheit.**
3. **Nennen Sie je eine Maßnahme zur Umsetzung folgender BSI-Basis-Anforderungen.**
4. **Führen Sie zwei Kriterien für ein sicheres Passwort an und begründen Sie.**
5. **Erklären Sie die Schutzbedarfskategorien und begründen Sie eine Zuordnung.**
6. **Was ist Multi-Faktor-Authentifizierung? Nennen Sie die drei Faktoren.**
7. **Wozu dient die Überprüfung eines Hashwerts?** → Integrität
8. **Erklären Sie den Unterschied zwischen symmetrischer und asymmetrischer
   Verschlüsselung.**
9. **Mit welchem Schlüssel wird verschlüsselt, mit welchem signiert?**
