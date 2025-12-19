// Klimawandel – Konsumgesellschaft – Massive Interaktive Version (ohne Mausrad)
// Maus bewegen = CO₂ | Rechtsklick halten = Konsum hoch | Linksklick = Kaufrausch | Leertaste halten = Konsum runter

float[] iceLevels = new float[400];
float seaLevel = 0;
float co2 = 0;
float consumption = 1.0;
ArrayList<Smoke> smokes = new ArrayList<Smoke>();
ArrayList<Product> products = new ArrayList<Product>();
int lastClickTime = 0;
boolean rightMousePressed = false;
boolean spacePressed = false;

void setup() {
  size(1400, 800);
  frameRate(60);
  noStroke();
  
  for (int i = 0; i < iceLevels.length; i++) {
    iceLevels[i] = random(350, 600);
  }
  
  for (int i = 0; i < 20; i++) {
    products.add(new Product());
  }
}

void draw() {
  float skyDarkness = map(co2, 0, 10000, 50, 200);
  background(20, 50, 100 - skyDarkness);
  
  seaLevel += map(co2, 0, 10000, 0, 0.2);
  seaLevel = constrain(seaLevel, 0, 300);
  
  // CO₂ durch Mausbewegung
  float mouseSpeed = dist(mouseX, mouseY, pmouseX, pmouseY);
  co2 += mouseSpeed * consumption * 0.1;
  
  // Konsum durch Rechtsklick halten
  if (rightMousePressed) {
    consumption += 0.03;
    consumption = constrain(consumption, 0.5, 5.0);
  }
  // Konsum senken durch Leertaste halten
  if (spacePressed) {
    consumption -= 0.02;
    consumption = constrain(consumption, 0.5, 5.0);
  }
  
  if (frameCount % 5 == 0 && co2 > 500) {
    smokes.add(new Smoke());
  }
  
  drawOcean();
  drawIcebergs();
  drawSmokes();
  drawProducts();
  
  // Warntexte
  fill(255, 255, 0, sin(frameCount * 0.1) * 100 + 155);
  textSize(40);
  textAlign(CENTER);
  text("DEIN KONSUM = KLIMAWANDEL", width/2, 80);
  
  fill(255);
  textSize(24);
  text("Maus bewegen = CO₂ | Rechtsklick halten = Konsum hoch", width/2, height-90);
  text("Linksklick = Kaufrausch | Leertaste halten = Konsum runter", width/2, height-60);
  text("Aktueller CO₂-Wert: " + nf(co2, 0, 0) + " | Konsum-Stufe: " + nf(consumption, 1, 1), width/2, height-30);
}

void drawOcean() {
  fill(0, 80, 150, 220);
  rect(0, height - seaLevel - 50, width, seaLevel + 50);
}

void drawIcebergs() {
  fill(220, 240, 255);
  for (int i = 0; i < iceLevels.length; i++) {
    float x = map(i, 0, iceLevels.length, 0, width);
    float w = width / iceLevels.length * 1.5;
    
    beginShape();
    vertex(x - w/2, height - seaLevel);
    vertex(x, height - seaLevel - iceLevels[i]);
    vertex(x + w/2, height - seaLevel);
    endShape(CLOSE);
    
    iceLevels[i] -= map(co2, 0, 10000, 0, 0.5) * consumption;
    iceLevels[i] = max(iceLevels[i], 0);
    
    if (iceLevels[i] < 50 && random(1) < 0.01) {
      iceLevels[i] = 0;
      for (int j = 0; j < 5; j++) {
        iceLevels[(i + j) % iceLevels.length] = random(100, 300);
      }
    }
  }
}

void drawSmokes() {
  for (int i = smokes.size() - 1; i >= 0; i--) {
    Smoke s = smokes.get(i);
    s.update();
    s.display();
    if (s.alpha <= 0) smokes.remove(i);
  }
}

void drawProducts() {
  for (int i = products.size() - 1; i >= 0; i--) {
    Product p = products.get(i);
    p.update();
    p.display();
    if (p.lifetime <= 0) products.remove(i);
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    if (millis() - lastClickTime > 500) {
      for (int i = 0; i < 30; i++) {
        products.add(new Product());
      }
      lastClickTime = millis();
    }
  } else if (mouseButton == RIGHT) {
    rightMousePressed = true;
  }
}

void mouseReleased() {
  if (mouseButton == RIGHT) {
    rightMousePressed = false;
  }
}

void keyPressed() {
  if (key == ' ' ) spacePressed = true;
  if (key == 's' || key == 'S') {
    saveFrame("klimawandel_konsum_####.png");
    println("Screenshot gespeichert!");
  }
  if (key == 'r' || key == 'R') {
    co2 = 0;
    seaLevel = 0;
    consumption = 1.0;
    for (int i = 0; i < iceLevels.length; i++) {
      iceLevels[i] = random(350, 600);
    }
    smokes.clear();
    products.clear();
    for (int i = 0; i < 20; i++) {
      products.add(new Product());
    }
  }
}

void keyReleased() {
  if (key == ' ') spacePressed = false;
}

// Hilfsklassen (unverändert)
class Smoke {
  PVector pos;
  float size, alpha;
  Smoke() {
    pos = new PVector(random(width), random(height/2));
    size = random(20, 60);
    alpha = 255;
  }
  void update() {
    pos.y -= 0.5;
    alpha -= 1;
  }
  void display() {
    fill(100, 100, 100, alpha);
    ellipse(pos.x, pos.y, size, size);
  }
}

class Product {
  PVector pos, vel;
  color col;
  float lifetime = 255;
  Product() {
    pos = new PVector(mouseX, mouseY);
    vel = PVector.random2D().mult(random(2, 8));
    col = color(random(200, 255), random(100, 200), random(50, 150));
  }
  void update() {
    pos.add(vel);
    lifetime -= 2;
  }
  void display() {
    fill(col, lifetime);
    rectMode(CENTER);
    rect(pos.x, pos.y, 30, 40);
    fill(0, lifetime);
    textSize(12);
    textAlign(CENTER);
    text("Kauf!", pos.x, pos.y + 5);
  }
}
