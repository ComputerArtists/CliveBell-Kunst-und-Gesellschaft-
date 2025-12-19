// Kunst als Widerstand – Graffiti Generator (Ultimate Version 2.0)
// Auswechselbare Stencils + dynamische Skalierung per + / -

ArrayList<PVector> points = new ArrayList<PVector>();
color[] palette = {#FF0066, #00FF99, #FFCC00, #9900FF, #FFFFFF, #FF9900, #33CCFF, #CC33FF};
PImage stencil = null;
float stencilScale = 1.0;  // aktueller Skalierungsfaktor (1.0 = Originalgröße nach Laden)
float idleTime = 0;
boolean antiSurveillanceActive = false;
boolean warningTextActive = false;  // Steuert, ob der Text gerade aktiv ist

void setup() {
  size(1200, 800);
  background(20);
  strokeWeight(5);
  noFill();
  
  println("Tasten:");
  println("Links klicken + ziehen = Graffiti-Linie");
  println("Space = Sprühen");
  println("Rechtsklick = Alles löschen");
  println("1–5 = Stencil platzieren");
  println("+ / - = Stencil größer/kleiner");
  println("L = Neuen Stencil laden");
  println("S = Screenshot");
  
  // Erster Start: Datei-Dialog
  selectInput("Wähle dein erstes Stencil-Bild (PNG/JPG):", "fileSelected");
}

void fileSelected(File selection) {
  if (selection != null) {
    stencil = loadImage(selection.getAbsolutePath());
    if (stencil != null) {
      // Basis-Skalierung auf ca. 10% der Originalgröße (für sinnvolle Größe)
      int baseW = max(50, stencil.width / 10);
      int baseH = max(50, stencil.height / 10);
      stencil.resize(baseW, baseH);
      stencilScale = 1.0;
      println("Stencil geladen: " + selection.getName() + " (Basisgröße: " + baseW + "x" + baseH + ")");
    }
  } else {
    println("Keine Datei ausgewählt – Stencil-Modus deaktiviert");
  }
}

void draw() {
  // Anti-Überwachung: Verblassen bei Stillstand
  if (mouseX == pmouseX && mouseY == pmouseY) {
    idleTime += 1;
  } else {
    idleTime = 0;
    antiSurveillanceActive = false;
  }
  
   // Anti-Überwachung: Verblassen bei Stillstand
  if (mouseX == pmouseX && mouseY == pmouseY) {
    idleTime += 1;
  } else {
    idleTime = 0;
    antiSurveillanceActive = false;
    warningTextActive = false;  // Text nur einmal anzeigen
  }
  
  if (idleTime > 360) {  // z. B. 6 Sekunden – du kannst anpassen
    fill(0, 1);  // sehr langsam verblassen
    rect(0, 0, width, height);
    
    antiSurveillanceActive = true;
    
    // Text nur EINMAL anzeigen
    if (!warningTextActive) {
      warningTextActive = true;
      fill(255, 0, 0, 255);  // volle Helligkeit beim Erscheinen
      textSize(50);
      textAlign(CENTER);
      text("KAMERAS SEHEN DICH!", width/2, height/2);
    }
  }
  
  // Vorschau der aktuellen Linie
  if (mousePressed && mouseButton == LEFT) {
    points.add(new PVector(mouseX, mouseY));
    stroke(255, 80);
    beginShape();
    for (PVector p : points) {
      curveVertex(p.x, p.y);
    }
    endShape();
  }
}

void mouseReleased() {
  if (mouseButton == LEFT && points.size() > 1) {
    spray();
  }
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    background(20);
    points.clear();
  }
}

void keyPressed() {
  if (key == 'o' || key == 'O') {
    selectInput("Wähle ein neues Stencil-Bild:", "fileSelected");
    println("Öffne Datei-Dialog für neues Stencil...");
  }
  if (key == ' ') {
    spray();
  }
  if (key == 's' || key == 'S') {
    saveFrame("widerstand_graffiti_####.png");
    println("Screenshot gespeichert!");
  }
  
  // Stencil platzieren (1–5)
  if (stencil != null) {
    if (key == '1' || key == '2' || key == '3' || key == '4' || key == '5') {
      tint(palette[int(random(palette.length))]);
      image(stencil, mouseX - stencil.width*stencilScale/2, mouseY - stencil.height*stencilScale/2,
            stencil.width * stencilScale, stencil.height * stencilScale);
      noTint();
    }
  }
  
  // Skalierung anpassen
  if (key == '+') {
    stencilScale *= 1.5;
    println("Stencil größer: " + nf(stencilScale, 1, 2) + "×");
  }
  if (key == '-') {
    stencilScale *= 0.7;
    stencilScale = max(0.2, stencilScale); // Mindestgröße
    println("Stencil kleiner: " + nf(stencilScale, 1, 2) + "×");
  }
  
  // Neuen Stencil laden
  if (key == 'l' || key == 'L') {
    selectInput("Wähle ein neues Stencil-Bild:", "fileSelected");
  }
}

void spray() {
  if (points.size() > 1) {
    color sprayCol = palette[int(random(palette.length))];
    stroke(sprayCol, 180);
    strokeWeight(random(3, 10));
    beginShape();
    for (PVector p : points) {
      curveVertex(p.x, p.y);
    }
    endShape();
    
    // Drip-Effekt
    for (PVector p : points) {
      float dripY = p.y;
      for (int i = 0; i < 15; i++) {
        fill(sprayCol, 180 - i*12);
        ellipse(p.x + random(-6, 6), dripY, random(4, 10), random(10, 30));
        dripY += random(6, 15);
      }
    }
    
    points.clear();
  }
}
