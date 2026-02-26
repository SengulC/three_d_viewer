void folderSelected(File selection) {
  print("Hello");
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    File objFile = findObjFile(selection);
    if (objFile != null) {
      initShape = loadShape(objFile.getAbsolutePath());
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
