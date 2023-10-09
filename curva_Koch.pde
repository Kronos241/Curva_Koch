int level = 5; // Nivel de recursión
PVector start, end;
ArrayList<PVector> path = new ArrayList<PVector>();

void setup() {
  size(800, 800); // Aumenta el tamaño del lienzo
  background(0, 0, 0); // Fondo azul
  stroke(255); // Líneas blancas
  noFill();
  frameRate(100); // Velocidad de animación
  start = new PVector(100, 300); // Cambia las coordenadas iniciales
  end = new PVector(700, 300); // Cambia las coordenadas finales
  generateKoch(start, end, level); // Genera la Curva de Koch
}

void draw() {
  if (!path.isEmpty()) {
    PVector p1 = path.remove(0);
    PVector p2 = path.remove(0);
    line(p1.x, p1.y, p2.x, p2.y);
  } else {
    noLoop(); // Detiene la animación cuando se ha mostrado todo el trazo
  }
}

void generateKoch(PVector p1, PVector p2, int level) {
  if (level == 0) {
    path.add(p1);
    path.add(p2);
  } else {
    PVector[] v = new PVector[5];
    v[0] = p1.copy();
    v[4] = p2.copy();
    
    PVector delta = PVector.sub(p2, p1).div(3);
    v[1] = p1.copy().add(delta);
    v[3] = p2.copy().sub(delta);
    
    PVector offset = new PVector(cos(PI/3) * delta.x - sin(PI/3) * delta.y, sin(PI/3) * delta.x + cos(PI/3) * delta.y);
    v[2] = v[1].copy().add(offset);
    
    // Llama a la función recursiva para los segmentos más pequeños
    generateKoch(v[0], v[1], level - 1);
    generateKoch(v[1], v[2], level - 1);
    generateKoch(v[2], v[3], level - 1);
    generateKoch(v[3], v[4], level - 1);
  }
}
