class Simulation {
  ArrayList<Body> bodies = new ArrayList<Body>();
  ArrayList<int[]> edges = new ArrayList<int[]>();

  void addBody(float x, float y, float mass) {
    bodies.add(new Body(x, y, mass));
  }
  void addEdge(int b1, int b2) {
    int[] arr = new int[2];
    arr[0] = b1;
    arr[1] = b2;
    edges.add(arr);
  }
  void addForces(float rc, float ac) {
    float Y, X, R2, F;
    float[] f;
    for (int i = 0; i < bodies.size(); ++i) {
      bodies.get(i).forceReset();
    }
    // Repultion Forces
    for (int i = 0; i < bodies.size() - 1; ++i) {
      for (int j = i + 1; j < bodies.size(); ++j) {
        // Extra ===
        F = 0;
        for (int k = 0; k < edges.size(); ++k) {
          if (edges.get(k)[0] == i && edges.get(k)[1] == j) {
            F = 1;
          }
          if (edges.get(k)[0] == j && edges.get(k)[1] == i) {
            F = 1;
          }
        }
        if (F == 0) {
          // === END
          Y = bodies.get(i).pos[1] - bodies.get(j).pos[1];
          X = bodies.get(i).pos[0] - bodies.get(j).pos[0];
          R2 = Y * Y + X * X;
          F = rc * bodies.get(i).m * bodies.get(j).m / R2;
          f = new float[2];
          f[0] = F * X / sqrt(R2);
          f[1] = F * Y / sqrt(R2);
          bodies.get(i).forceAdd(f);
          f[0] *= -1;
          f[1] *= -1;
          bodies.get(j).forceAdd(f);
        }// Extra ==
        else {
          Y = bodies.get(i).pos[1] - bodies.get(j).pos[1];
          X = bodies.get(i).pos[0] - bodies.get(j).pos[0];
          R2 = Y * Y + X * X;
          F = rc * bodies.get(i).m * bodies.get(j).m / (R2 * 10);
          f = new float[2];
          f[0] = F * X / sqrt(R2);
          f[1] = F * Y / sqrt(R2);
          bodies.get(i).forceAdd(f);
          f[0] *= -1;
          f[1] *= -1;
          bodies.get(j).forceAdd(f);
        }
      }
    }

    // Attraction Forces
    
    for (int i = 0; i < edges.size(); ++i) {
      Y = bodies.get(edges.get(i)[0]).pos[1] - bodies.get(edges.get(i)[1]).pos[1];
      X = bodies.get(edges.get(i)[0]).pos[0] - bodies.get(edges.get(i)[1]).pos[0];
      R2 = Y*Y + X*X;
      f = new float[2];
      f[0] = ac * X;
      f[1] = ac * Y;
      bodies.get(edges.get(i)[1]).forceAdd(f);
      f[0] *= -1;
      f[1] *= -1;
      bodies.get(edges.get(i)[0]).forceAdd(f);
    }
    
  }
  
  void run(float t) {
    Body b;
    for (int i = 0; i < bodies.size(); ++i) {
      b = bodies.get(i);
      b.pos[0] = b.pos[0] + b.u[0] * t + b.forces[0] * t * t / (2 * b.m);
      b.pos[1] = b.pos[1] + b.u[1] * t + b.forces[1] * t * t / (2 * b.m);
      b.u[0] = b.u[0] + b.forces[0] * t/b.m;
      b.u[1] = b.u[1] + b.forces[1] * t/b.m;
    }
  }

  void drawEdges() {
    for (int i = 0; i < edges.size(); ++i) {
      strokeWeight(4);
      stroke(255);
      line(bodies.get((int)edges.get(i)[0]).pos[0], bodies.get((int)edges.get(i)[0]).pos[1], bodies.get((int)edges.get(i)[1]).pos[0], bodies.get((int)edges.get(i)[1]).pos[1]);
    }
  }

  void drawBodies() {
    for (int i = 0; i < bodies.size(); ++i) {
      bodies.get(i).drawBody();
    }
  }
  void frame() {
    background(0);
    drawEdges();
    drawBodies();
  }
  void timestamp(float rc, float ac, float t) {
    addForces(rc, ac);
    run(t);
  }
}
