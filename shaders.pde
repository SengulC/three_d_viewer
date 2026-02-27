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
