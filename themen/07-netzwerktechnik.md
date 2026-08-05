# 07 — Netzwerktechnik

> **Warum wichtig:** „IT-gestützter Arbeitsplatz" heißt immer auch: Der Rechner
> muss ins Netz. IP-Adressen, Subnetting, DHCP/DNS und Verkabelung sind
> Standardstoff, meist 5–10 Punkte.

---

## 1. OSI-Modell (7 Schichten)

| # | Schicht (dt.) | Aufgabe | Geräte / Protokolle |
|---|---|---|---|
| 7 | Anwendung | Schnittstelle zur Anwendung | HTTP(S), SMTP, IMAP, DNS, FTP |
| 6 | Darstellung | Kodierung, Verschlüsselung, Komprimierung | TLS, ASCII, JPEG |
| 5 | Sitzung | Auf- und Abbau von Sitzungen | NetBIOS, RPC |
| 4 | Transport | Ende-zu-Ende, Ports, Segmentierung | **TCP, UDP** |
| 3 | Vermittlung | Wegewahl zwischen Netzen | **IP**, ICMP, **Router** |
| 2 | Sicherung | Rahmen, MAC-Adressen, Fehlererkennung | Ethernet, **Switch**, MAC |
| 1 | Bitübertragung | Physikalische Signale | Kabel, **Hub**, Repeater |

**Eselsbrücke:** *Alle Deutschen Studenten Trinken Verschiedene Sorten Bier*
(7 → 1) oder von unten: *Bitte Sende Vier Tolle Schokoladen Direkt Anna*.

**Merke die Gerätezuordnung** — das wird gern gefragt:
Hub = Schicht 1 · Switch = Schicht 2 · Router = Schicht 3

### TCP vs. UDP ⭐
| | **TCP** | **UDP** |
|---|---|---|
| Verbindung | verbindungsorientiert (Handshake) | verbindungslos |
| Zuverlässigkeit | Bestätigung, Neuübertragung, Reihenfolge garantiert | keine Garantie |
| Geschwindigkeit | langsamer, mehr Overhead | schnell, wenig Overhead |
| Einsatz | HTTP, E-Mail, Dateitransfer, SSH | DNS, VoIP, Video-Streaming, DHCP |

---

## 2. IP-Adressen

### IPv4
32 Bit, geschrieben als 4 Oktette: `192.168.10.25`
Dazu gehört immer eine **Subnetzmaske**: `255.255.255.0` (= `/24`)

**Aufbau:** Die Maske trennt die Adresse in **Netzanteil** (Einsen) und
**Hostanteil** (Nullen).

```
IP    192.168.10.25   →  11000000.10101000.00001010.00011001
Maske 255.255.255.0   →  11111111.11111111.11111111.00000000
                          └────── Netz ──────────┘ └ Host ┘
```

### Private Adressbereiche (AUSWENDIG!)
| Klasse | Bereich | CIDR |
|---|---|---|
| A | 10.0.0.0 – 10.255.255.255 | /8 |
| B | 172.16.0.0 – 172.31.255.255 | /12 |
| C | 192.168.0.0 – 192.168.255.255 | /16 |

Sonderadressen: `127.0.0.1` = Loopback (localhost) ·
`169.254.x.x` = APIPA (**heißt: DHCP war nicht erreichbar!**) ·
`0.0.0.0` = keine Adresse / Default-Route

### IPv6
128 Bit, hexadezimal: `2001:0db8:0000:0000:0000:ff00:0042:8329`
Kurzschreibweise: führende Nullen weglassen, **eine** Nullfolge durch `::`
ersetzen → `2001:db8::ff00:42:8329`

**Vorteile gegenüber IPv4:** riesiger Adressraum (kein NAT mehr nötig),
Autokonfiguration (SLAAC), IPsec integriert, einfacherer Header, kein Broadcast.

---

## 3. Subnetting (Schritt für Schritt)

### Die Tabelle, die du auswendig brauchst
| CIDR | Subnetzmaske | Hosts nutzbar | Netze |
|---|---|---|---|
| /24 | 255.255.255.0 | 254 | 1 |
| /25 | 255.255.255.128 | 126 | 2 |
| /26 | 255.255.255.192 | 62 | 4 |
| /27 | 255.255.255.224 | 30 | 8 |
| /28 | 255.255.255.240 | 14 | 16 |
| /29 | 255.255.255.248 | 6 | 32 |
| /30 | 255.255.255.252 | 2 | 64 |

### Die zwei Formeln
```
Anzahl Adressen im Subnetz = 2^(32 − CIDR)
Nutzbare Hosts             = 2^(32 − CIDR) − 2
```
**Warum −2?** Die **erste** Adresse ist die **Netzadresse**, die **letzte** ist die
**Broadcast-Adresse**. Beide können keinem Host zugewiesen werden.

### Aufgabe: „Wie viele Bits für X Hosts?"
> Es werden 50 Hosts benötigt.
```
2^5 − 2 = 30   → zu wenig
2^6 − 2 = 62   → passt ✅
6 Host-Bits  →  32 − 6 = 26  →  /26  →  255.255.255.192
```

### Aufgabe: „Netzadresse und Broadcast bestimmen"
> Gegeben: 192.168.10.100 /26
```
1. Blockgröße = 256 − 192 = 64
2. Netze:  .0  .64  .128  .192
3. .100 liegt zwischen 64 und 127
   → Netzadresse:      192.168.10.64
   → Erster Host:      192.168.10.65
   → Letzter Host:     192.168.10.126
   → Broadcast:        192.168.10.127
```

> 🔑 **Trick „Blockgröße":** `256 − letztes Oktett der Maske` = Schrittweite der
> Subnetze. Damit löst du jede Subnetting-Aufgabe in 30 Sekunden.

---

## 4. Netzwerkdienste

| Dienst | Port | Aufgabe |
|---|---|---|
| **DHCP** | 67/68 UDP | Vergibt automatisch IP, Maske, Gateway, DNS |
| **DNS** | 53 | Übersetzt Namen (`www.ihk.de`) in IP-Adressen |
| **HTTP / HTTPS** | 80 / **443** | Webseiten (HTTPS = TLS-verschlüsselt) |
| **SMTP** | 25 / 587 | E-Mail **senden** |
| **POP3** | 110 / 995 | E-Mail **abholen** (lädt herunter, löscht meist vom Server) |
| **IMAP** | 143 / **993** | E-Mail **synchronisieren** (bleibt auf dem Server) |
| **SSH** | 22 | Verschlüsselte Fernwartung (Linux) |
| **RDP** | 3389 | Remote Desktop (Windows) |
| **FTP / SFTP** | 21 / 22 | Dateiübertragung |
| **LDAP / LDAPS** | 389 / 636 | Verzeichnisdienst (Active Directory) |
| **SMB** | 445 | Windows-Dateifreigaben |
| **NTP** | 123 | Zeitsynchronisation |
| **SNMP** | 161/162 | Netzwerküberwachung |

### POP3 vs. IMAP ⭐ (Klassiker bei E-Mail-Migration)
| | POP3 | IMAP |
|---|---|---|
| Speicherort | lokal auf dem Client | auf dem Server |
| Mehrere Geräte | ungeeignet | **ideal** — alles synchron |
| Serverplatz | wenig | viel |
| Offline-Zugriff | vollständig | nur zwischengespeicherte Mails |
| Backup | Client muss gesichert werden | **zentral am Server** |

Für eine Arztpraxis mit mehreren Arbeitsplätzen → **IMAP**, weil Postfächer
zentral liegen und zentral gesichert werden können.

**NAT (Network Address Translation):** Der Router übersetzt viele private
Adressen auf eine öffentliche IP. Spart Adressen und wirkt nebenbei wie eine
einfache Firewall (von außen kein direkter Zugriff nach innen).

---

## 5. Verkabelung

### Twisted-Pair-Kategorien
| Kategorie | Bandbreite | Typisch für |
|---|---|---|
| Cat 5e | 100 MHz | 1 Gbit/s |
| **Cat 6** | 250 MHz | 1 Gbit/s / 10 Gbit/s bis 55 m |
| **Cat 6A** | 500 MHz | **10 Gbit/s bis 100 m** — heutiger Standard |
| Cat 7 / 7A | 600/1000 MHz | 10 Gbit/s+, GG45/TERA |

**Maximale Segmentlänge Kupfer: 100 m** (90 m fest verlegt + 2 × 5 m Patchkabel).
Merken — wird gefragt!

**Schirmung:** U/UTP (ungeschirmt) · F/UTP (Folie gesamt) · S/FTP (Geflecht
gesamt + Folie je Paar, beste Störfestigkeit).

### Lichtwellenleiter (LWL)
| | **Multimode** | **Singlemode** |
|---|---|---|
| Kern | 50/62,5 µm | 9 µm |
| Reichweite | bis ~550 m | bis viele km |
| Lichtquelle | LED / VCSEL | Laser |
| Kosten | günstiger | teurer |
| Einsatz | Gebäude, Etagen | Standortverbindungen, WAN |

**Vorteile LWL allgemein:** unempfindlich gegen elektromagnetische Störungen,
keine Erdungsprobleme/Potentialausgleich, abhörsicherer, große Reichweite,
hohe Bandbreite.

### Strukturierte Verkabelung (EN 50173)
- **Primärbereich** — Gelände-/Standortverkabelung (LWL, zwischen Gebäuden)
- **Sekundärbereich** — Steigbereich zwischen Etagen (LWL)
- **Tertiärbereich** — Etagenverkabelung zum Arbeitsplatz (Kupfer, max. 100 m)

**Vorteile:** herstellerunabhängig, anwendungsneutral, einfach erweiterbar,
zukunftssicher, einfache Fehlersuche und Dokumentation.

---

## 6. Netzwerkkomponenten

| Gerät | OSI | Funktion |
|---|---|---|
| **Hub** | 1 | Sendet an alle Ports (veraltet, Kollisionen) |
| **Switch** | 2 | Leitet gezielt anhand der MAC-Adresse weiter |
| **Router** | 3 | Verbindet verschiedene Netze, Wegewahl |
| **Firewall** | 3–7 | Filtert Datenverkehr nach Regeln |
| **Access Point** | 2 | WLAN-Anbindung |
| **Patchpanel** | 1 | Rangierfeld im Serverschrank |

**VLAN (Virtual LAN):** Trennt ein physisches Netz logisch in mehrere Netze.
→ In der Arztpraxis: VLAN für Patientendaten, VLAN für Verwaltung, VLAN für
Gäste-WLAN. **Vorteile:** Sicherheit durch Trennung, weniger Broadcast-Last,
flexible Zuordnung unabhängig vom Standort.

**WLAN-Sicherheit:** **WPA3** (aktuell, empfohlen) > WPA2 > WPA > WEP (unsicher,
nie verwenden). Gäste-WLAN immer getrennt vom Praxisnetz mit
Client-Isolation.

---

## 7. Fernwartung / Remote-Zugriff

| | **Remote-Wartung** | **Vor-Ort-Wartung** |
|---|---|---|
| **Vorteile** | Keine Anfahrtszeit und -kosten · sofortige Reaktion · mehrere Kunden pro Tag · umweltfreundlich · Dokumentation per Sitzungsprotokoll | Hardware kann angefasst/getauscht werden · funktioniert ohne Netz · persönlicher Kundenkontakt · Umfeld direkt beurteilbar |
| **Nachteile** | Hardwareprobleme nicht lösbar · setzt funktionierende Internetverbindung voraus · Sicherheits-/Datenschutzrisiko (Zugriff auf Patientendaten!) · Kunde muss mitwirken | Anfahrtszeit und -kosten · längere Reaktionszeit · Termin nötig |

**Bei Fernwartung mit personenbezogenen Daten:** Es ist ein
**Auftragsverarbeitungsvertrag (AVV) nach Art. 28 DSGVO** erforderlich, der
Zugriff muss verschlüsselt (VPN/TLS), protokolliert und nur nach Freigabe durch
den Kunden erfolgen.

---

## Prüfungsfragen, die daraus kommen

1. **Nennen Sie die Schichten des OSI-Modells und ordnen Sie Switch/Router zu.**
2. **Berechnen Sie Netzadresse, erste/letzte Hostadresse und Broadcast.**
3. **Welche Subnetzmaske wird für X Hosts benötigt?**
4. **Nennen Sie die Ports von HTTPS, IMAP, SSH, DNS.**
5. **Erklären Sie den Unterschied zwischen POP3 und IMAP. Was empfehlen Sie?**
6. **Was ist die maximale Länge eines Kupfer-Segments?** → 100 m
7. **Nennen Sie drei Vorteile von LWL gegenüber Kupfer.**
8. **Nennen Sie zwei Vor- und zwei Nachteile der Remote-Wartung.**
9. **Was ist ein VLAN und welchen Vorteil bringt es?**
