# Water-Salt-Tracking-Appo

Tages-Tracker für Trinkmenge und Salz — ideal for tracking salt & water in peak weeks.

Installierbare Web-App (PWA): läuft offline, speichert alles lokal am Gerät,
braucht kein Konto und keine Verbindung nach außen.

**→ [domhoerti.github.io/Water-Salt-Tracking-Appo](https://domhoerti.github.io/Water-Salt-Tracking-Appo/)**

## Was sie kann

- **Salz** — ein Wert für den ganzen Tag, früh abgewogen eingetragen. Zeigt die
  Natriummenge dazu (Faktor 0,393) und was aufs Tagesziel noch fehlt.
- **Wasser** — Kacheln antippen, fertig: Shake 700 ml, Monster/Cola Zero 500 ml,
  Glas Wasser 330 ml, Doppio 80 ml, Espresso 30 ml, Porridge 250 ml, Reis 150 ml.
  Die **Uhrzeit setzt sich automatisch** — damit lässt sich nachvollziehen, ob
  schon getrunken wurde.
- **Kachelzähler** — Porridge zeigt `1/2`, Reis `0/1`: auf einen Blick sichtbar,
  was vom Fixprogramm noch offen ist.
- **Zeitleiste** — jeder Eintrag antippbar, Menge, Uhrzeit und Bezeichnung
  nachträglich korrigierbar oder löschbar. Nach jedem Log 6 Sekunden „Rückgängig".
- **Freie Menge** — für alles Krumme (320 ml Glas, Suppe, was auch immer).
- **Alle Mengen anpassbar** — Bezeichnung, Menge und „× pro Tag" pro Kachel,
  eigene Kacheln, beide Tagesziele.
- **Verlauf** — Tag zurückblättern, 7-Tage-Streifen mit je einem Balken für
  Wasser und Salz, Wochenschnitt.

## Aufs iPhone bringen

1. Seite am iPhone in **Safari** öffnen (nur Safari kann installieren, Chrome nicht):
   <https://domhoerti.github.io/Water-Salt-Tracking-Appo/>
2. Unten auf **Teilen** › **Zum Home-Bildschirm**.

Danach liegt die App mit eigenem Icon am Home-Bildschirm, startet im Vollbild
ohne Adressleiste und funktioniert ohne Internet.

## Daten

Alles liegt im `localStorage` des jeweiligen Geräts — nichts wird übertragen,
niemand außer dir sieht die Zahlen. Das heißt aber auch: **iPhone und Mac haben
getrennte Daten**, es gibt keine Synchronisierung.

Unter **Einstellungen › Sicherung**:

| Knopf | Zweck |
|---|---|
| `Sicherung speichern` | vollständiges Backup als JSON |
| `Sicherung einlesen` | Backup zurückspielen, z. B. nach Gerätewechsel |
| `Einträge-CSV einlesen` | Daten aus einer CSV übernehmen |

Und unter **Einstellungen › Export** zwei CSV-Dateien (semikolongetrennt, direkt
in Google Sheets importierbar über *Datei › Importieren*):

- `wasser-salz-eintraege.csv` — jede Einzelmenge mit Datum und Uhrzeit
- `wasser-salz-tage.csv` — eine Zeile pro Tag mit Summen, Zielen und Natrium

Werden in Safari die Website-Daten gelöscht, sind die Einträge weg — also ab und
zu eine Sicherung speichern.

## Dateien

| Datei | Zweck |
|---|---|
| `index.html` | die komplette App: Aufbau, Gestaltung, Logik |
| `manifest.webmanifest` | Name, Icon, Vollbildmodus |
| `sw.js` | Service Worker, macht die App offlinefähig |
| `icons/` | App-Icons (inkl. Quell-SVG) |

Keine Abhängigkeiten, kein Build-Schritt. Einzige externe Ressource sind die
Schriften (IBM Plex) von Google Fonts; die legt der Service Worker beim ersten
Start ab, danach läuft alles offline.

## Aktualisieren

`index.html` ändern, in `sw.js` die Zeile `const VERSION = "wasser-salz-v1"`
hochzählen, committen und pushen. Die App holt sich die neue Fassung beim
nächsten Start mit Internetverbindung.

## Lokal ausprobieren

```bash
python3 -m http.server 8000
```

Dann <http://localhost:8000> öffnen. Der Service Worker braucht `localhost` oder
HTTPS — als `file://` geöffnet funktioniert die Offline-Fähigkeit nicht.
