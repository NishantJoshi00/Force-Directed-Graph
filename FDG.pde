Simulation s = new Simulation();
{
  //Definition of the arrays;
  s.addBody(400, 300, 3);
  s.addBody(500, 300, 3);
  s.addBody(450, 350, 3);
  s.addEdge(0, 1);
  s.addEdge(0, 2);
  s.addBody(300, 300, 3);
  s.addEdge(1,3);
  s.addEdge(2,1);


}

void setup() {
  size(800, 600);
  s.frame();
}

void draw() {
  for(int i = 0; i < 50; ++i)
  s.timestamp(10, 0.0001, 0.1);
  s.frame();
}
