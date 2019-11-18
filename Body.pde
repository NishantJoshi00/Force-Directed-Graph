class Body {
  float[] forces = new float[2];
  float m;
  float[] u = new float[2];
  float[] pos = new float[2];
  Body(float x, float y, float mass) {
    pos[0] = x;
    pos[1] = y;
    u[0] = 0;
    u[1] = 0;
    m = mass;
  }
  Body(float[] coordinate, float mass) {
    pos[0] = coordinate[0];
    pos[1] = coordinate[1];
    u[0] = 0;
    u[1] = 0;
    m = mass;
  }
  void uReset() {
    u[0] = 0;
    u[1] = 0;
  }
  
  void uAdd(float[] newu) {
    u[0] += newu[0];
    u[1] += newu[1];
  }
  void forceReset() {
    forces[0] = 0;
    forces[1] = 0;
  }
  void forceAdd(float[] newforce) {
    forces[0] += newforce[0];
    forces[1] += newforce[1];
  }
  
  
  
  
  
  void drawBody() {
    stroke(255);
    strokeWeight(4);
    fill(0);
    ellipse(pos[0], pos[1], 10 * m, 10 * m);
  }
  
  
  void posGet() {
    print("POSITION: {"+pos[0]+", " + pos[1]+"}  ");
  }
  void forcesGet() {
    print("FORCE: {"+forces[0]+", " + forces[1]+"}  ");
  }
  void uGet() {
    print("VELOCITY: {"+u[0]+", " + u[1]+"}  ");
  }
  
  void Get() {
    posGet();
    uGet();
    forcesGet();
    print("\n");
  }
}
