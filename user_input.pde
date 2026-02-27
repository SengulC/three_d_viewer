// PROCESSING LIGHT AND CAMERA MOVEMENT VIA KEYBOARD INPUT
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

// CAMERA MOVEMENT VIA MOUSE INPUT
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

// ZOOMING IN/OUT VIA MOUSEWHEEL
void mouseWheel(MouseEvent event) {
  zoom += event.getCount() * 10;
}

// KEY INPUTS FOR SHADING AND LIGHTING MODES
void keyPressed() {
  switch(key) {
    // shading modes
  case'1':
    drawMode ="default";
    break;
  case '2':
    drawMode ="pointcloud";
    break;
  case '3':
    drawMode ="flat";
    break;
  case '4':
    drawMode ="wireframe";
    break;

    // lighting modes
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

// LOADING NEW FOLDER, FINDING OBJ FILE WITHIN THAT FOLDER
void folderSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    File objFile = findObjFile(selection);
    if (objFile != null) {
      currentShape = loadShape(objFile.getAbsolutePath());
      currentShapePath = objFile.getAbsolutePath();

      // reset and ready wireframe data
      objCopied = loadStrings(objFile.getAbsolutePath());
      vertices = new ArrayList<PVector>();
      faces = new ArrayList<String[]>();
      wireframeData();
    } else {
      println("No .obj file found in the selected folder.");
    }
  }
}

File findObjFile(File folder) {
  File[] files = folder.listFiles();
  if (files == null) return null;
  for (File f : files) {
    if (f.isFile() && f.getName().toLowerCase().endsWith(".obj")) {
      return f;
    }
  }
  return null;
}
