// Social Media Echo Chamber – Ultimate Cool Version (jetzt mit funktionierendem Datei-Dialog)

ArrayList<Bubble> bubbles = new ArrayList<Bubble>();
String[] hashtags = {};
PFont font;

Bubble fakeNews;

void setup() {
  size(1400, 800);
  frameRate(60);
  noStroke();
  
  // Datei-Dialog öffnen (ruft fileSelected() auf, sobald Datei ausgewählt)
  selectInput("Wähle eine TXT-Datei mit Hashtags (eine pro Zeile):", "fileSelected");
  
  // Fake-News-Blase
  fakeNews = new Bubble();
  fakeNews.pos = new PVector(width/2, height/2);
  fakeNews.size = 80;
  fakeNews.col = color(0, 0, 0, 220);
  fakeNews.vel = new PVector(0, 0);
  bubbles.add(fakeNews);
  
  // Startblasen
  for (int i = 0; i < 400; i++) {
    bubbles.add(new Bubble());
  }
  
  // Font (plattformunabhängig)
  //font = createFont("Helvetica", 12);
  //textFont(font);
}

void draw() {
  fill(0, 8); // Trail
  rect(0, 0, width, height);
  
  // Fake-News-Einfluss
  for (Bubble b : bubbles) {
    if (b != fakeNews) {
      float d = PVector.dist(b.pos, fakeNews.pos);
      if (d < 300) {
        float pull = map(d, 300, 0, 0, 0.1);
        PVector dir = PVector.sub(fakeNews.pos, b.pos).normalize().mult(pull);
        b.vel.add(dir);
        b.col = lerpColor(b.col, color(0, 0, 0, 180), 0.005);
      }
    }
  }
  
  for (Bubble b : bubbles) {
    b.update();
    b.display();
  }
  
  fill(255, 150);
  textSize(20);
  textAlign(CENTER);
  text("Bewege die Maus, um Blasen zu stören", width/2, height-40);
  text("Drücke S zum Screenshot", width/2, height-15);
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    saveFrame("echo_chamber_####.png");
    println("Screenshot gespeichert!");
  }
}

// Callback-Funktion für den Datei-Dialog – jetzt korrekt platziert!
void fileSelected(File selection) {
  if (selection != null) {
    hashtags = loadStrings(selection.getAbsolutePath());
    println("Geladene Hashtags: " + hashtags.length);
  } else {
    // Fallback, falls abgebrochen
    hashtags = new String[]{"#EchoChamber", "#FakeNews", "#Woke", "#CancelCulture", "#MAGA"};
    println("Keine Datei ausgewählt – Fallback-Hashtags verwendet");
  }
  
  // Hashtags sofort auf bestehende Blasen verteilen
  for (Bubble b : bubbles) {
    if (hashtags.length > 0 && random(1) < 0.7) { // nicht alle, sonst zu voll
      b.hashtag = hashtags[int(random(hashtags.length))];
    }
  }
}

class Bubble {
  PVector pos, vel;
  float size;
  color col;
  String hashtag = "";
  
  Bubble() {
    pos = new PVector(random(width), random(height));
    vel = PVector.random2D().mult(random(0.5, 1.2));
    size = random(10, 50);
    col = color(random(180, 255), random(80, 220), random(50, 180), 180);
  }
  
  void update() {
    pos.add(vel);
    
    // Maus-Störer
    PVector mouse = new PVector(mouseX, mouseY);
    float d = PVector.dist(pos, mouse);
    if (d < 150) {
      PVector repel = PVector.sub(pos, mouse).normalize().mult(0.6);
      vel.add(repel);
      col = lerpColor(col, color(255, 50, 50), 0.08);
    }
    
    // Bounce
    if (pos.x < size || pos.x > width - size) vel.x *= -1;
    if (pos.y < size || pos.y > height - size) vel.y *= -1;
    
    size = 10 + sin(frameCount * 0.05 + pos.x) * 5 + 20;
  }
  
  void display() {
    for (int i = 0; i < 8; i++) {
      float glow = map(i, 0, 7, 255, 20);
      fill(red(col), green(col), blue(col), glow);
      ellipse(pos.x, pos.y, size + i * 6, size + i * 6);
    }
    fill(col);
    ellipse(pos.x, pos.y, size, size);
    
    if (size > 25 && hashtag != "") {
      fill(255, 220);
      textAlign(CENTER, CENTER);
      textSize(size * 0.4);
      text(hashtag, pos.x, pos.y);
    }
  }
}
