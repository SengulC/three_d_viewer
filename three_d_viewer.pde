PVector lightPos, cameraPos, lightDir;
boolean lightDirectional;
PShape initShape;
int degreeX, degreeY, degreeZ = 0;
float zoom = 500;
String lightState = "default";
//{"r", "g", "b", "dir"};

void setup() {
  initShape = loadShape("./spider/Spider.obj");
  background(20);
  cameraPos = new PVector(0, 0, (height/2.0) / tan(PI*30.0 / 180.0));
  lightPos = new PVector(0, 0, 0);
  lightDir = new PVector(-1, 0, 0); // x,y,z corresponds to nx,ny,nz in directionalLight()
  size(600, 600, P3D);
}

void draw() {
  camera(cameraPos.x, cameraPos.y, zoom, 0, 0, 0, 0, 1, 0);
  background(20);
  rotateX(radians(degreeX));
  rotateY(radians(degreeY));
  rotateZ(radians(degreeZ));

  if (keyPressed) {
    processMovement();

    // loading a new object
    if (keyCode == BACKSPACE)
      selectFolder("Select a folder:", "folderSelected");

    // reset camera, render space and zoom
    if (key == 'R' || key == 'r') {
      cameraPos = new PVector(0, 0, (height/2.0) / tan(PI*30.0 / 180.0));
      lightPos = new PVector(0, 0, 0);
      lightDir = new PVector(-1, 0, 0);
      zoom = 500;
    }
  }

  renderLight();
  shape(initShape, 0, 0);
}

void processMovement() {
  // move lights around via ARROW BUTTONS
  if (keyCode == LEFT)
    if (lightDirectional)
      lightDir.x = -1;
    else
      lightPos.x -= 5;
  if (keyCode == RIGHT)
    if (lightDirectional)
      lightDir.x = 1;
    else
      lightPos.x += 5;
  if (keyCode == UP)
    if (lightDirectional)
      lightDir.y = 1;
    else
      lightPos.y -= 5;
  if (keyCode == DOWN)
    if (lightDirectional)
      lightDir.y = -1;
    else
      lightPos.y += 5;

  // camera  navigation via ASDW, XZ
  if (key == 'S' || key == 's') degreeX -= 5;
  if (key == 'W' || key == 'w') degreeX += 5;
  if (key == 'A' || key == 'a') degreeY -= 5;
  if (key == 'D' || key == 'd') degreeY += 5;
  if (key == 'X' || key == 'x') degreeZ -= 5;
  if (key == 'Z' || key == 'z') degreeZ += 5;
}

// camera space navigation via MOUSE x and y
void mouseDragged() {
  if (mouseX < pmouseX)
    degreeY -=5;
  if (mouseX > pmouseX)
    degreeY +=5;
  if (mouseY < pmouseY)
    degreeX -=5;
  if (mouseX > pmouseX)
    degreeX +=5;
}

// mousewheel interaction for zooming in/out
void mouseWheel(MouseEvent event) {
  zoom += event.getCount() * 10;
}

void keyPressed() {
  switch(key) {
  case '0':
    lightState = "r";
    lightDirectional = false;
    break;
  case '9':
    lightState = "g";
    lightDirectional = false;
    break;
  case '8':
    lightState = "b";
    lightDirectional = false;
    break;
  case '7':
    lightState = "dir";
    lightDirectional = true;
    break;
  case '6':
    lightState = "default";
    lightDirectional = false;
    break;
  }
}

void renderLight() {
  switch(lightState) {
  case "r":
    pointLight(255, 0, 0, lightPos.x, lightPos.y, lightPos.z);
    break;
  case "g":
    pointLight(0, 255, 0, lightPos.x, lightPos.y, lightPos.z);
    break;
  case "b":
    pointLight(0, 0, 255, lightPos.x, lightPos.y, lightPos.z);
    break;
  case "dir":
    directionalLight(255, 250, 250, lightDir.x, lightDir.y, lightDir.z);
    break;
  case "default":
    lights();
    break;
  }
}
