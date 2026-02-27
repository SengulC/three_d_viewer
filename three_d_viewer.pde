PVector lightPos, cameraPos, lightDir;
boolean lightDirectional;
PShape initShape;
int degreeX, degreeY, degreeZ = 0;
float zoom = 500;
String lightState = "default", drawMode = "default";

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

  // rotation transforms before obj rendering to apply onto it
  rotateX(radians(degreeX));
  rotateY(radians(degreeY));
  rotateZ(radians(degreeZ));
  drawObj();
}

void drawObj() {
  if (drawMode == "default") //1
    shape(initShape, 0, 0);
  if (drawMode == "pointcloud") //2
    wireframeShader();
  if (drawMode == "flat") { //3
    shape(initShape, 0, 0);
  }
  if (drawMode == "wireframe")
    shape(initShape, 0, 0);
}

void wireframeShader() {
  int children = initShape.getChildCount();
  for (int i = 0; i < children; i++) {
    PShape child = initShape.getChild(i);
    int total = child.getVertexCount();

    for (int j = 0; j < total; j++) {
      PVector vertex = child.getVertex(j);
      //stroke((frameCount + (i+1)*j) % 255);
      stroke(255);
      point(vertex.x, vertex.y, vertex.z);
    }
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
