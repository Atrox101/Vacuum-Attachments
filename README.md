# Parametrische Staubsauger-Aufsätze (OpenSCAD)

OpenSCAD-Module für Staubsauger-Aufsätze (Adapter, Fugendüse, Flachdüse).  
Alle Maße sind parametrisierbar.

## Features
- **Adapter:** verbindet unterschiedliche Rohrdurchmesser
- **Fugendüse:** Länge, Wandstärke, Endwinkel parametrisierbar
- **Flachdüse:** Breite, Länge, Winkel einstellbar

## Verwendung
1. OpenSCAD öffnen
2. `src/attachments.scad` laden
3. Oben den gewünschten Aufsatz wählen:
   ```scad
   aufsatz_typ = "fugen_duese"; // "adapter", "flach_duese"
   ```
4. Parameter anpassen (Durchmesser, Länge, Wandstärke, Winkel)
5. Rendern (`F6`) und als STL exportieren

## Ordner
- `src/attachments.scad` – Quellcode
- `examples/` – Platz für exportierte STL-Beispiele
- `docs/images/` – Screenshots / Renderbilder

## Lizenz
MIT License
