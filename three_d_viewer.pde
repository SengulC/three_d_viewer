PVector lightPos, cameraPos, lightDir;
boolean lightDirectional;
PShape currentShape;
String currentShapePath;
int degreeX, degreeY, degreeZ = 0;
float zoom = 500;
String lightState = "default", drawMode = "default";

String[] objCopied;
ArrayList<PVector> vertices;
ArrayList<String[]> faces;

void setup() {
  currentShape = loadShape("./spider/Spider.obj");
  currentShapePath = "./spider/Spider.obj";
  background(20);
  cameraPos = new PVector(0, 0, (height/2.0) / tan(PI*30.0 / 180.0));
  lightPos = new PVector(0, 0, 0);
  lightDir = new PVector(-1, 0, 0); // x,y,z corresponds to nx,ny,nz in directionalLight()
  size(600, 600, P3D);

  objCopied = loadStrings(currentShapePath);
  vertices = new ArrayList<PVector>();
  faces = new ArrayList<String[]>();
  wireframeData();
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
    shape(currentShape, 0, 0);
  if (drawMode == "pointcloud") //2
    pointcloudShader();
  if (drawMode == "flat") { //3
    flatShader();
  }
  if (drawMode == "wireframe") //4
    wireframeShader();
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
