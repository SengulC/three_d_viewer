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
void wireframeData() {
  // ITERATE OVER OBJ FILE
  for (int i = 0; i < objCopied.length; i++) {
    // RECORD VERTICES
    if (objCopied[i].startsWith("v ")) {
      // v -2.600941 51.171219 -24.912411
      String[] curVertex = split(objCopied[i], " ");
      // [v, -2.600941, 51.171219, -24.912411]
      vertices.add(new PVector(float(curVertex[1]), float(curVertex[2]), float(curVertex[3])));
      // <-2.600941, 51.171219, -24.912411>
    }

    // RECORD FACES
    if (objCopied[i].startsWith("f")) {
      String curLine = objCopied[i];
      // e.g: f 2/10/10 62/11/11 120/12/12 40/13/13
      String[] verticesInFace = split(curLine, " "); // [f, 2/10/10, 62/11/11, 120/12/12, 40/13/13]
      String[] cleanedVertices = new String[verticesInFace.length - 1]; // -1 to get rid of "f"
      for (int j = 1; j < verticesInFace.length; j++) {
        cleanedVertices[j-1] = split(verticesInFace[j], "/")[0];
      }
      faces.add(cleanedVertices);
    }
  }
  //print(faces[0]);
  //print("\n");
}

void wireframeShader() {

  for (String[] faceVertices : faces) {
    beginShape();
    stroke(255);
    noFill();
    // faceVertices[0]: 1 33 109 39
    // for each face, find corresponding vertices
    // then for each vertex, draw x y z of that vertex
    for (String indexOfV : faceVertices) {
      //faceVertices[0][0]: 1
      if (indexOfV != null) {
        PVector point = vertices.get(int(indexOfV)-1);
        if (point != null)
          vertex(point.x, point.y, point.z);
      }
    }
    endShape();
  }
}
