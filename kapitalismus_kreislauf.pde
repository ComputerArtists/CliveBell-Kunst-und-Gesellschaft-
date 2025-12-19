// Kapitalismus & Konsum – Der endlose Kreislauf (ULTIMATIVE KOMBINATION)
// Maus bewegen = schneller | Space = Crash | L = neue TXT | S = Screenshot

float angle = 0;
int items = 12;
int maxItems = 60;
float speed = 0.01;
String[] slogans = {};
int currentSlogan = 0;

ArrayList<PVector> particles = new ArrayList<PVector>();
boolean crashing = false;

void setup() {
  size(900, 900);
  frameRate(60);
  textAlign(CENTER);
  
  // Start-Dialog für Slogans
  selectInput("Wähle eine TXT-Datei mit Slogans (eine pro Zeile):", "fileSelected");
}

void fileSelected(File selection) {
  if (selection != null) {
    slogans = loadStrings(selection.getAbsolutePath());
    println("Geladene Slogans: " + slogans.length);
  } else {
    slogans = new String[]{"Kauf → Konsum → Kauf → Konsum", "Profit > Planet", "Mehr = Besser?", "Endloser Kreislauf"};
  }
}

void draw() {
  background(0);
  translate(width/2, height/2);
  
  // Maus-Interaktion: schneller Kreislauf
  float mouseSpeed = dist(mouseX, mouseY, pmouseX, pmouseY);
  speed = map(mouseSpeed, 0, 100, 0.005, 0.08);  // je hektischer du bewegst, desto schneller
  angle += speed;
  
  // Vermehrung der Produkte
  if (frameCount % 300 == 0 && items < maxItems) {
    items += 3;
  }
  
  // Zeichne Produkte (Farbe wird dunkler je mehr Items)
  for (int i = 0; i < items; i++) {
    float a = map(i, 0, items, 0, TWO_PI);
    pushMatrix();
    rotate(a);
    float darkness = map(items, 12, maxItems, 0, 200);
    fill(255 - darkness, 50, 100);
    rect(0, -200, 40, 80);
    popMatrix();
  }
  
  // Pulsierender Text aus TXT
  if (slogans.length > 0) {
    fill(255);
    textSize(40 + sin(frameCount * 0.05) * 10);
    text(slogans[currentSlogan], 0, 300);
    if (frameCount % 300 == 0) currentSlogan = (currentSlogan + 1) % slogans.length;
  }
  
  // Crash-Partikel
  if (crashing) {
    for (int i = 0; i < items; i++) {
      particles.add(new PVector(random(-width/2, width/2), random(-height/2, height/2)));
    }
    items = 12;  // Reset Items
    crashing = false;
  }
  
  // Zeichne und update Partikel
  for (int i = particles.size() - 1; i >= 0; i--) {
    PVector p = particles.get(i);
    fill(255, 200);
    ellipse(p.x, p.y, 5, 5);
    p.mult(0.98);  // Verkleinern & verlangsamen
    if (p.mag() < 1) particles.remove(i);
  }
  
  // Hilfstext
  fill(150);
  textSize(18);
  text("Maus bewegen = Konsum beschleunigen | Space = Crash | L = neue Slogans | S = Screenshot", 0, -350);
}

void keyPressed() {
  if (key == ' ') {
    crashing = true;
  }
  if (key == 'l' || key == 'L') {
    selectInput("Wähle eine neue TXT-Datei mit Slogans:", "fileSelected");
  }
  if (key == 's' || key == 'S') {
    saveFrame("kapitalismus_kreislauf_####.png");
    println("Screenshot gespeichert!");
  }
  if (key == 'r' || key == 'R') {
    items = 12;
    angle = 0;
    speed = 0.01;
    particles.clear();
    currentSlogan = 0;
  }
}
