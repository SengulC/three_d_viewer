PVector cameraPos, renderSpace, rotation;
float zoom;

void setup() {
  background(20);
  cameraPos = new PVector(0, 0, (height/2.0) / tan(PI*30.0 / 180.0));
  renderSpace = new PVector(0, 0, 0);
  rotation = new PVector(0,0);
  zoom = 500;
  size(600, 600, P3D);
}

void draw() {
  background(20);

  // clamp rotation.x bc it tilts the 'eye' of the camera up and down, messing with what the up vector thinks is 'up'
  //rotation.x = constrain(rotation.x, -PI/2 + 0.01, PI/2 - 0.01);

  // update cameraPos via renderSpace coords
  cameraPos.x = renderSpace.x + zoom * sin(rotation.y) * cos(rotation.x);
  cameraPos.y = renderSpace.y - zoom * sin(rotation.x);
  cameraPos.z = renderSpace.z + zoom * cos(rotation.y) * cos(rotation.x);

  camera(cameraPos.x, cameraPos.y, cameraPos.z, renderSpace.x, renderSpace.y, renderSpace.z, 0, 1, 0);
  // 0,1,0 = up vector

  box(200);

  if (keyPressed) {
    if (keyCode == LEFT)   renderSpace.x -= 5; // panning around object render space
    if (keyCode == RIGHT)  renderSpace.x += 5;
    if (key == 'A')  rotation.y -= 0.05; // orbit horizontally
    if (key == 'D')  rotation.x += 0.05;
    if (key == 'S')  rotation.x -= 0.05; // vertically (w/ clamping in draw)
    if (key == 'W')  rotation.x += 0.05;
    if (key == 'Z')  zoom += 10; // zooming in&out
    if (key == 'X')  zoom -= 10;
  }
}
