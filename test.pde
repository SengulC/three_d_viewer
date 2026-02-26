//PVector renderSpace, cameraPos;
//PShape s;
//int degreeX, degreeY, degreeZ = 0;

//void setup() {
//  //s = loadShape("./spider/Spider.obj");
//  background(20);
//  cameraPos = new PVector(0, 0, (height/2.0) / tan(PI*30.0 / 180.0));
//  renderSpace = new PVector(0, 0, 0);
//  size(600, 600, P3D);
//}

//void mousePressed() {
//  selectFolder("Select a folder:", "folderSelected");
//}

//void draw() {
//  camera(cameraPos.x, cameraPos.y, cameraPos.z, renderSpace.x, renderSpace.y, renderSpace.z, 0, 1, 0);
//  background(20);
  
//  rotateX(radians(degreeX));
//  rotateY(radians(degreeY));
//  rotateZ(radians(degreeZ));
  
//  //shape(s, 0, 0);

//  if (keyPressed) {
//    if (keyCode == LEFT) renderSpace.x -= 5; // panning around object in render space
//    if (keyCode == RIGHT) renderSpace.x += 5;
//    if (keyCode == UP) renderSpace.y -= 5;
//    if (keyCode == DOWN) renderSpace.y += 5;

//    if (key == 'S') degreeX -= 5;
//    if (key == 'W') degreeX += 5;

//    if (key == 'A') degreeY -= 5;
//    if (key == 'D') degreeY += 5;

//    if (key == 'X') degreeZ -= 5;
//    if (key == 'Z') degreeZ += 5;
    
//    if (key == 'R') {
//      // reset
//      cameraPos = new PVector(0, 0, (height/2.0) / tan(PI*30.0 / 180.0));
//      renderSpace = new PVector(0, 0, 0);
//    }
//  }
//}
