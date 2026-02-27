void pointcloudShader() {
  int children = currentShape.getChildCount();
  for (int i = 0; i < children; i++) {
    PShape child = currentShape.getChild(i);
    int total = child.getVertexCount();

    for (int j = 0; j < total; j++) {
      PVector vertex = child.getVertex(j);
      //stroke((frameCount + (i+1)*j) % 255);
      stroke(255);
      point(vertex.x, vertex.y, vertex.z);
    }
  }
}

// makes duplicate of obj file with material reference removed
void flatShader() {
  String[] objCopied = loadStrings(currentShapePath);
  String[] objNoMtl = new String[objCopied.length];
  for (int i = 0; i < objCopied.length; i++) {
    if (!objCopied[i].startsWith("mtllib"))
      objNoMtl[i] = objCopied[i];
  }
  saveStrings("noMtl.obj", objNoMtl);
  PShape noMtlShape = loadShape("noMtl.obj");
  shape(noMtlShape, 0, 0);
}

// make duplicate of obj file with only vertices and faces
// connect vertices in each face to make a triangle
void wireframeShader() {
  String[] objCopied = loadStrings(currentShapePath);
  StringList vertices = new StringList();
  String[][] faces = new String[objCopied.length][objCopied.length];

  int faceIndex = 0;
  // ITERATE OVER OBJ FILE
  for (int i = 0; i < objCopied.length; i++) {
    // RECORD VERTICES
    if (objCopied[i].startsWith("v "))
      vertices.append(objCopied[i]);

    // RECORD FACES
    if (objCopied[i].startsWith("f")) {
      String curLine = objCopied[i];
      // e.g: f 2/10/10 62/11/11 120/12/12 40/13/13
      String[] verticesInFace = split(curLine, " "); // [f, 2/10/10, 62/11/11, 120/12/12, 40/13/13]
      String[] cleanedVertices = new String[verticesInFace.length - 1]; // -1 to get rid of "f"
      for (int j = 1; j < verticesInFace.length; j++) {
        cleanedVertices[j - 1] = split(verticesInFace[j], "/")[0]; // fV
      }
      faces[faceIndex] = cleanedVertices;
      faceIndex++;
    }
  }
  print(faces[0]);
  print("\n");
  print(faces[1]);
  print("\n");
}
