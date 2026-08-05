# 08 — Betriebssysteme & Skripting

> **Warum wichtig:** Seit der AO 2020 kommen regelmäßig kleine **Skript-Analysen**
> vor: „Finden Sie die zwei Fehler." Das sind 6–8 Punkte, und man braucht dafür
> **kein** Programmieren zu können — nur systematisches Lesen.

---

## 1. Aufgaben eines Betriebssystems

- **Prozessverwaltung** — Zuteilung der CPU (Scheduling), Multitasking
- **Speicherverwaltung** — RAM zuteilen, virtueller Speicher / Paging
- **Dateiverwaltung** — Dateisystem, Rechte, Verzeichnisse
- **Geräteverwaltung** — Treiber, Ein-/Ausgabe
- **Benutzerverwaltung** — Konten, Rechte, Authentifizierung
- **Benutzerschnittstelle** — GUI oder CLI

---

## 2. Dateisysteme

| Dateisystem | System | Merkmale |
|---|---|---|
| **NTFS** | Windows | Rechte (ACL), Journaling, Verschlüsselung (EFS), Kompression, große Dateien |
| **FAT32** | universell | max. **4 GB** pro Datei, keine Rechte, überall lesbar → USB-Sticks |
| **exFAT** | universell | wie FAT32 ohne 4-GB-Grenze, für große Wechseldatenträger |
| **ext4** | Linux | Journaling, Standard bei Linux |
| **ZFS / Btrfs** | Linux/Unix | Snapshots, Prüfsummen, Copy-on-Write, integriertes RAID |
| **APFS** | macOS | Snapshots, Verschlüsselung |

> ⚠️ **Klassische Frage:** „Warum lässt sich die 6-GB-Datei nicht auf den USB-Stick
> kopieren?" → Der Stick ist mit **FAT32** formatiert (max. 4 GB pro Datei),
> Lösung: mit **exFAT** oder NTFS formatieren.

---

## 3. Berechtigungen

### Windows (NTFS)
Lesen · Schreiben · Ausführen · Ändern · Vollzugriff.
Vergabe über **Gruppen**, nicht über einzelne Benutzer!
Merksatz: **AGDLP** — Accounts → Global groups → Domain Local groups → Permissions.
**Verweigern schlägt Erlauben** (Deny hat Vorrang).

### Linux (Unix-Rechte)
```
-rwxr-xr--   1 root  admin   4096  file.sh
 │└┬┘└┬┘└┬┘
 │ │  │  └── others (andere)
 │ │  └───── group (Gruppe)
 │ └──────── user (Besitzer)
 └────────── Typ (- Datei, d Verzeichnis, l Link)
```
| Recht | Zahl | Datei | Verzeichnis |
|---|---|---|---|
| r (read) | 4 | lesen | Inhalt auflisten |
| w (write) | 2 | ändern | Dateien anlegen/löschen |
| x (execute) | 1 | ausführen | hineinwechseln (cd) |

`chmod 755 datei` → `rwx r-x r-x` (7=4+2+1, 5=4+1)
`chmod 644 datei` → `rw- r-- r--`

> **Prinzip der minimalen Rechte (Least Privilege):** Jeder bekommt nur die
> Rechte, die er für seine Aufgabe wirklich braucht. Wird in der AP1 sehr gern
> als Begründung verlangt.

---

## 4. Virtualisierung

**Prinzip:** Auf einer physischen Maschine laufen mehrere virtuelle Maschinen
(VMs), verwaltet durch einen **Hypervisor**.

| | **Typ 1 (Bare Metal)** | **Typ 2 (Hosted)** |
|---|---|---|
| Läuft auf | direkt auf der Hardware | in einem Betriebssystem |
| Leistung | hoch | geringer |
| Beispiele | VMware ESXi, Proxmox, Hyper-V (Rolle) | VirtualBox, VMware Workstation |
| Einsatz | Rechenzentrum, Server | Test, Entwicklung, Schulung |

**Vorteile:** bessere Hardwareauslastung, weniger physische Server (Strom, Platz,
Klima), einfache Sicherung per Snapshot, schnelle Bereitstellung, Isolation der
Systeme, einfache Migration bei Hardwaretausch.
**Nachteile:** Single Point of Failure (Hostausfall trifft alle VMs), Overhead,
Lizenzkosten, benötigt Know-how, hohe Anforderungen an den Host.

**Container (Docker) vs. VM:** Container teilen sich den Kernel des Hosts →
deutlich schlanker und schneller startbar, aber weniger isoliert und an das
Host-Betriebssystem gebunden.

---

## 5. Skript-Aufgaben lösen ⭐

### Die Methode (funktioniert für PowerShell, Bash, Pseudocode)

1. **Zuerst die mitgelieferte Anleitung („Manual") lesen.** Die IHK liefert immer
   genau die Tabelle mit, die man braucht. Die Lösung steht praktisch drin.
2. **Was SOLL das Skript tun?** Aus dem Aufgabentext exakt herausschreiben.
3. **Was TUT es tatsächlich?** Zeile für Zeile durchgehen — dabei eine
   Beispielzahl aus der Aufgabe einsetzen (z. B. „Laufwerk ist zu 50 % gefüllt").
4. **Wo weicht Soll von Ist ab?** Genau dort ist der Fehler.
5. **Nur die geforderte Anzahl Fehler korrigieren** — meist zwei.

### Die Fehlerarten, die vorkommen (95 % aller Fälle)
| Fehlerart | Beispiel |
|---|---|
| **Falscher Vergleichsoperator** | `-gt` statt `-lt`, `>` statt `<`, `=` statt `==` |
| **Falscher Faktor / Einheit** | `*1000` statt `*100`, MB statt GB |
| **Vertauschte Zweige** | if- und else-Block sind vertauscht |
| **Falsche Variable** | `$Size` statt `$SizeRemaining` |
| **Grenzwert falsch** | `>=` statt `>`, Zahl um 1 daneben |

### PowerShell-Vergleichsoperatoren (auswendig!)
| Operator | Bedeutung |
|---|---|
| `-eq` | equals — gleich |
| `-ne` | not equals — ungleich |
| `-gt` | **g**reater **t**han — größer als |
| `-ge` | greater or equal — größer oder gleich |
| `-lt` | **l**ess **t**han — **kleiner als** |
| `-le` | less or equal — kleiner oder gleich |
| `-and` / `-or` / `-not` | logisches UND / ODER / NICHT |

> 🔑 In der Prüfung steht das englische Manual dabei — aber es ist oft
> **absichtlich OCR-verunstaltet** („-It" statt `-lt`, „-je" statt `-le`).
> Lass dich nicht verwirren: **`-lt` = less than**.

### Durchgerechnetes Beispiel (Herbst 2021, Aufgabe 2e)

**Soll:** Warnung ausgeben, wenn der freie Speicherplatz auf Laufwerk Z **unter
15 %** fällt.

**Fehlerhaftes Skript:**
```powershell
$Drive = Get-Volume -DriveLetter Z
$Prozent = ($Drive.SizeRemaining / $Drive.Size) * 1000     # ← Fehler 1
if ($Prozent -gt 15)                                        # ← Fehler 2
{
    Write-Host "Es sind weniger als 15% Speicherplatz frei."
}
else
{
    Write-Host "Es ist genügend Speicherplatz verfügbar."
}
```

**Analyse mit dem Beispielwert aus der Aufgabe (Laufwerk zu 50 % gefüllt, also
50 % frei):**

```
Fehler 1:  0,5 * 1000 = 500      → müsste 50 sein
           Für eine Prozentangabe multipliziert man mit 100, nicht mit 1000.

Fehler 2:  if (500 -gt 15)  →  WAHR  →  gibt die Warnung aus
           Genau das beschriebene Fehlverhalten!
           Gesucht ist aber "unter 15 %", also -lt statt -gt.
```

**Korrigiert:**
```powershell
$Prozent = ($Drive.SizeRemaining / $Drive.Size) * 100      # ✅
if ($Prozent -lt 15)                                        # ✅
```

**Kontrolle (immer machen!):** Laufwerk zu 50 % gefüllt →
`0,5 × 100 = 50`, `50 -lt 15` = falsch → else-Zweig → „Es ist genügend
Speicherplatz verfügbar." ✅ Korrektes Verhalten.

---

## 6. Nützliche Befehle (können abgefragt werden)

### Windows / PowerShell
| Befehl | Zweck |
|---|---|
| `ipconfig /all` | IP-Konfiguration anzeigen |
| `ipconfig /release` + `/renew` | DHCP-Adresse neu beziehen |
| `ping <ziel>` | Erreichbarkeit prüfen |
| `tracert <ziel>` | Route verfolgen |
| `nslookup <name>` | DNS-Auflösung testen |
| `netstat -ano` | offene Verbindungen und Ports |
| `chkdsk` / `sfc /scannow` | Dateisystem / Systemdateien prüfen |
| `Get-Volume`, `Get-Service`, `Get-Process` | PowerShell-Cmdlets |
| `Write-Host "Text"` | Ausgabe auf dem Bildschirm |

### Linux / Bash
| Befehl | Zweck |
|---|---|
| `ip a` / `ifconfig` | IP-Konfiguration |
| `df -h` | freier Speicherplatz |
| `du -sh <pfad>` | Größe eines Verzeichnisses |
| `top` / `htop` | laufende Prozesse |
| `systemctl status <dienst>` | Dienststatus |
| `journalctl -xe` | Logs |
| `chmod` / `chown` | Rechte / Besitzer ändern |
| `rsync -av quelle ziel` | Daten synchronisieren (Backup!) |
| `cron` / `crontab -e` | zeitgesteuerte Aufgaben |

**Cron-Syntax** (kommt bei Backup-Aufgaben vor):
```
*  *  *  *  *   Befehl
│  │  │  │  └── Wochentag (0–7, 0/7 = Sonntag)
│  │  │  └───── Monat (1–12)
│  │  └──────── Tag im Monat (1–31)
│  └─────────── Stunde (0–23)
└────────────── Minute (0–59)

0 22 * * 1-5    → werktags um 22:00 Uhr
0 2 * * 0       → sonntags um 02:00 Uhr
```

---

## Prüfungsfragen, die daraus kommen

1. **Korrigieren Sie die zwei Fehler im Skript.** → Operator + Faktor
2. **Nennen Sie die PowerShell-Operatoren für „kleiner als" und „ungleich".**
3. **Warum lässt sich eine 5-GB-Datei nicht auf einen FAT32-Stick kopieren?**
4. **Erklären Sie `chmod 755`.**
5. **Nennen Sie drei Vor- und zwei Nachteile der Virtualisierung.**
6. **Was bedeutet das Prinzip der minimalen Rechte?**
7. **Mit welchem Befehl prüfen Sie die DNS-Auflösung?** → `nslookup` / `dig`
8. **Erstellen Sie einen Cron-Eintrag für ein tägliches Backup um 23 Uhr.**
   → `0 23 * * *`
