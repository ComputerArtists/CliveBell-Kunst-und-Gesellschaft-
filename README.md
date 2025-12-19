# Kunst und Gesellschaft – Processing Skript-Sammlung

Eine Reihe interaktiver und generativer Processing-Skripte, die gesellschaftskritische Themen visuell und spielerisch erforschen. Alle Skripte sind für Processing 4 (Java-Modus) geschrieben und laufen auch in p5.js mit minimalen Anpassungen.

## 1. Social Media Echo Chamber

**Thema:** Filterblasen, Algorithmus-gesteuerte Polarisierung und die Verbreitung von Desinformation in sozialen Medien.

**Beschreibung:**  
Hunderte farbiger, pulsierender Blasen schweben durch den Raum. Ähnliche Farben ziehen sich an und bilden Cluster (Echo Chambers). Eine große schwarze „Fake-News“-Blase in der Bildmitte zieht alle anderen langsam an und färbt sie dunkler. Bewegt man die Maus in die Nähe, fliehen die Blasen und werden rot – Symbol für die unangenehme Konfrontation mit anderen Meinungen. Große Blasen zeigen Hashtags an.

**Features:**
- Neon-Glow-Effekt mit leuchtenden Ringen
- Sanfter Trail-Effekt für hypnotische Bewegung
- Maus als „Störer“ (Repulsion + Rotfärbung)
- Zentrale Fake-News-Blase mit Anziehung und Verdunkelung
- Hashtags werden aus einer TXT-Datei geladen (eine pro Zeile)
- Datei-Auswahl-Dialog beim Start
- Screenshot mit Taste **S** (`echo_chamber_####.png`)

**Bedienung:**
- Bewege die Maus, um Blasen zu stören
- Drücke **S**, um einen Screenshot zu speichern

## 2. Klimawandel – Konsumgesellschaft

**Thema:** Die direkte Verbindung zwischen individuellem Konsumverhalten und dem Schmelzen der Polkappen.

**Beschreibung:**  
Eine stilisierte Ansicht der Arktis mit weißen Eisbergen vor blauem Himmel. Je weiter du die Maus nach rechts bewegst (symbolisiert steigenden Konsum/CO₂-Ausstoß), desto schneller schmilzt das Eis. Die Metapher ist bewusst einfach und direkt.

**Features:**
- Interaktive Schmelzgeschwindigkeit abhängig von Mausposition
- Minimalistische, aber starke visuelle Sprache

**Bedienung:**
- Maus nach rechts = mehr Konsum = schnelleres Schmelzen
- Maus nach links = geringerer Konsum = langsameres Schmelzen

## 3. Kunst als Widerstand – Graffiti Generator

**Thema:** Straßenkunst als Akt des Widerstands und der Selbstermächtigung.

**Beschreibung:**  
Ein digitaler Spraydosen-Simulator. Du malst mit der Maus freie Linien, drückst die Leertaste – und die Linie wird als kurviges, neonfarbenes Graffiti „gesprüht“. Symbolisiert spontane, rebellische Kunst im öffentlichen Raum.

**Features:**
- Freies Zeichnen mit der Maus
- Leertaste = Sprühen in zufälliger Neonfarbe
- Rechtsklick = Alles löschen

**Bedienung:**
- Maus halten und ziehen = Linie zeichnen
- **Leertaste** = Graffiti sprühen
- **Rechtsklick** = Leinwand löschen

## 4. Kapitalismus & Konsum – Der endlose Kreislauf

**Thema:** Die hypnotische Wiederholung des Konsumkarussells im Kapitalismus.

**Beschreibung:**  
Ein Kreis aus roten „Produkten“ rotiert unaufhaltsam um die Bildmitte. Darunter steht in großer Schrift der Satz „Kauf → Konsum → Kauf → Konsum“. Die endlose Rotation erzeugt eine fast meditative, aber beklemmende Wirkung.

**Features:**
- Flüssige, hypnotische Rotation
- Klare, direkte Textbotschaft
- Minimalistisch und stark

**Bedienung:**
- Keine Interaktion nötig – einfach beobachten

---

**Tipps für alle Skripte:**
- Läuft am besten in Vollbild (ändere `size()` zu `fullScreen()`)
- Für Präsentationen oder Ausstellungen: Kombiniere mit Projektor oder großem Monitor
- Screenshots landen im Sketch-Ordner (bei Echo Chamber automatisch mit `S`)

Viel Spaß beim Ausprobieren, Teilen und Weiterentwickeln – Kunst und Kritik gehören zusammen!
