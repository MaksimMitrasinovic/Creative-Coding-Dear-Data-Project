final int SCREEN_W = 1491;
final int SCREEN_H = 700;

final int RESET_INTERVAL = 5000;
final int TRANSITION_DURATION = 3000;

final int SKY_R = 82;
final int SKY_G = 85;
final int SKY_B = 144;

final int BIG_STAR_COUNT = 500;
final int BRIGHT_STAR_COUNT = 150;
final int SHOOTING_STAR_COUNT = 8;

Starfield starfield;
ShootingStar[] shootingStars;

int lastFpsPrint = 0;


void settings() {
  size(SCREEN_W, SCREEN_H);
}


void setup() {
  frameRate(60);

  starfield = new Starfield(width, height);

  shootingStars = new ShootingStar[SHOOTING_STAR_COUNT];

  for (int i = 0; i < shootingStars.length; i++) {
    shootingStars[i] = new ShootingStar();
  }
}


void draw() {
  // Constant full-screen fade, preserving the original trail effect.
  noStroke();
  fill(SKY_R, SKY_G, SKY_B, 3);
  rect(0, 0, width, height);

  starfield.update();
  starfield.display();

  for (ShootingStar star : shootingStars) {
    star.update();
    star.display();
  }

  // Console FPS counter, twice per second.
  if (millis() - lastFpsPrint >= 500) {
    println("FPS: " + nf(frameRate, 0, 1));
    lastFpsPrint = millis();
  }
}


// ====================================
// STARFIELD
// ====================================

class Starfield {
  int w, h;
  int seed = 9909;
  int lastReset;
  int transitionStart;

  PGraphics currentField;
  PGraphics oldField;
  PGraphics newField;

  boolean transitioning = false;

  Starfield(int w, int h) {
    this.w = w;
    this.h = h;

    currentField = createGraphics(w, h);
    oldField = createGraphics(w, h);
    newField = createGraphics(w, h);

    generateField(currentField, seed);
    lastReset = millis();
  }


  void update() {
    int now = millis();

    if (!transitioning &&
        now - lastReset >= RESET_INTERVAL) {

      seed = (int) random(100000);

      oldField.beginDraw();
      oldField.clear();
      oldField.image(currentField, 0, 0);
      oldField.endDraw();

      generateField(newField, seed);

      transitionStart = now;
      lastReset = now;
      transitioning = true;
    }

    if (transitioning &&
        now - transitionStart >= TRANSITION_DURATION) {

      PGraphics temp = currentField;
      currentField = newField;
      newField = temp;

      transitioning = false;
    }
  }


  void display() {
    if (transitioning) {
      float progress = getTransitionProgress();

      tint(255, 255 * (1.0 - progress));
      image(oldField, 0, 0);

      tint(255, 255 * progress);
      image(newField, 0, 0);

      noTint();
    } else {
      image(currentField, 0, 0);
    }
  }


  float getTransitionProgress() {
    return constrain(
      (millis() - transitionStart) /
      (float) TRANSITION_DURATION,
      0, 1
    );
  }


  void generateField(PGraphics pg, int fieldSeed) {
    java.util.Random rng =
      new java.util.Random(fieldSeed);

    pg.beginDraw();
    pg.clear();
    pg.noStroke();

    drawBand(pg, rng, h * 0.36, 45, 0.010, 0.055, 34);
    drawBand(pg, rng, h * 0.68, 75, 0.006, 0.035, 25);

    drawSmallStars(pg, rng);
    drawBigStars(pg, rng);
    drawBrightStars(pg, rng);

    pg.endDraw();
  }


  // Smooth, wandering bands with soft edges.
  void drawBand(
    PGraphics pg,
    java.util.Random rng,
    float centreY,
    int bandWidth,
    float drift,
    float roughness,
    int maxAlpha
  ) {
    float y = centreY;
    float velocity = 0;

    for (int x = 0; x < w; x++) {
      velocity = velocity * 0.94
        + (rng.nextFloat() - 0.5) * roughness;

      y += velocity + sin(x * drift) * 0.12;

      y = constrain(
        y,
        bandWidth + 5,
        h - bandWidth - 5
      );

      for (int offset = -bandWidth;
           offset <= bandWidth;
           offset++) {

        float normalized =
          abs(offset) / (float) bandWidth;

        float falloff = 1.0 - normalized;
        falloff *= falloff;

        int alpha = (int)(maxAlpha * falloff);

        if (alpha > 0) {
          pg.stroke(
            SKY_R + 35,
            SKY_G + 35,
            255,
            alpha
          );

          pg.point(x, y + offset);
        }
      }
    }

    pg.noStroke();
  }


  void drawSmallStars(
    PGraphics pg,
    java.util.Random rng
  ) {
    pg.noStroke();

    for (int i = 0; i < 3500; i++) {
      int x = rng.nextInt(w);
      int y = rng.nextInt(h);
      int alpha = 35 + rng.nextInt(150);

      pg.fill(255, 255, 255, alpha);
      pg.rect(x, y, 1, 1);
    }
  }


  void drawBigStars(
    PGraphics pg,
    java.util.Random rng
  ) {
    pg.noStroke();

    for (int i = 0; i < BIG_STAR_COUNT; i++) {
      int x = rng.nextInt(w);
      int y = rng.nextInt(h);
      int size = 2 + rng.nextInt(3);
      int alpha = 50 + rng.nextInt(206);

      pg.fill(255, 255, 255, alpha);
      pg.rect(x, y, size, size);
    }
  }


  void drawBrightStars(
    PGraphics pg,
    java.util.Random rng
  ) {
    pg.noStroke();

    for (int i = 0; i < BRIGHT_STAR_COUNT; i++) {
      int x = rng.nextInt(w);
      int y = rng.nextInt(h);
      int size = 3 + rng.nextInt(3);
      int alpha = 130 + rng.nextInt(126);

      pg.fill(255, 240, 75, alpha);
      pg.rect(x, y, size, size);

      pg.fill(255, 240, 75, alpha / 4);
      pg.rect(x - 3, y - 3, size + 6, size + 6);
    }
  }
}


// ====================================
// MULTIPLE SHOOTING STARS
// ====================================

class ShootingStar {
  float x, y;
  float vx, vy;

  float length;
  float thickness;
  float opacity;
  float fadeRate;

  boolean active = false;


  ShootingStar() {
    respawn(true);
  }


  void respawn(boolean stagger) {
    // Start from the left or upper part of the screen.
    if (random(1) < 0.7) {
      x = random(-width * 0.3, width * 0.75);
      y = random(-height * 0.4, height * 0.2);
    } else {
      x = random(-width * 0.3, 0);
      y = random(height * 0.05, height * 0.9);
    }

    float speed = random(9, 22);
    float angle = random(0.15, 0.75);

    vx = speed * cos(angle);
    vy = speed * sin(angle);

    length = random(25, 100);
    thickness = random(1.5, 3.5);
    opacity = 0;
    fadeRate = random(5, 12);

    active = true;

    if (stagger) {
      opacity = random(0, 180);
    }
  }


  void update() {
    if (!active) {
      respawn(false);
      return;
    }

    x += vx;
    y += vy;

    // Fade in, then fade out as the star crosses the sky.
    if (x < width * 0.65) {
      opacity = min(255, opacity + fadeRate);
    } else {
      opacity = max(0, opacity - fadeRate * 0.5);
    }

    if (x > width + length ||
        y > height + length ||
        (opacity <= 0 && x > width * 0.65)) {
      active = false;
    }
  }


  void display() {
    if (!active || opacity <= 0) {
      return;
    }

    pushStyle();
    strokeCap(ROUND);

    // Soft outer glow.
    stroke(180, 210, 255, opacity * 0.18);
    strokeWeight(thickness * 4);

    line(
      x - vx * (length / max(1, abs(vx))),
      y - vy * (length / max(1, abs(vx))),
      x, y
    );

    // Main tail.
    stroke(220, 235, 255, opacity * 0.65);
    strokeWeight(thickness);

    line(
      x - vx * 2.5,
      y - vy * 2.5,
      x, y
    );

    // Bright head.
    stroke(255, 255, 255, opacity);
    strokeWeight(thickness + 1);
    point(x, y);

    popStyle();
  }
}
