void loadLevel(String filePath) {
  BufferedReader reader = createReader(filePath);
  String line = null;
  try {
    while ((line = reader.readLine()) != null) {
      String[] pcs = line.split("\\s+");
      handleFileCmd(pcs);
    }
    reader.close();
  } 
  catch (IOException e) {
    e.printStackTrace();
  }
}

void saveLevel(String filePath) {
  PrintWriter writer = createWriter(filePath);
  writer.println("SPAWN " + round(spawn_point.x) + " " + round(spawn_point.y));
  for (Prop p : props) {
    if (p instanceof Box) {
      writer.println("BOX " + round(p.pos.x) + " " + round(p.pos.y) + " " +round(((Box)p).radius));
    } else if (p instanceof Barrel) {
      writer.println("BARREL " + round(p.pos.x) + " " + round(p.pos.y) + " " +round(((Barrel)p).radius));
    } else {
      println("Error: Prop of class \"" + p.getClass() + "\" isn't handled in saveLevel().");
    }
  }
  writer.flush();
  writer.close();
}

void handleFileCmd(String[] pcs) {
  if (pcs.length == 0 || pcs[0].isEmpty()) {
    return;
  }
  String cmd = pcs[0].toUpperCase().trim();
  if (cmd.equals("SPAWN")) {
    if (pcs.length >= 3) {
      float x = float(pcs[1]);
      float y = float(pcs[2]);
      if (!Float.isNaN(x) && !Float.isNaN(y)) {
        spawn_point.set(x, y);
        return;
      }
    }
  } else if (cmd.equals("BOX")) {
    if (pcs.length >= 3) {
      float x = float(pcs[1]);
      float y = float(pcs[2]);
      float r = (pcs.length < 4 ? PROP_RADIUS : float(pcs[3]));
      if (!Float.isNaN(x) && !Float.isNaN(y) && !Float.isNaN(r)) {
        addProp(new Box(new PVector(x, y), r));
        return;
      }
    }
  } else if (cmd.equals("BARREL")) {
    if (pcs.length >= 3) {     
      float x = float(pcs[1]);
      float y = float(pcs[2]);
      float r = (pcs.length < 4 ? PROP_RADIUS : float(pcs[3]));
      if (!Float.isNaN(x) && !Float.isNaN(y) && !Float.isNaN(r)) {
        addProp(new Barrel(new PVector(x, y), r));
        return;
      }
    }
  }
  println("Error: \"" + java.util.Arrays.toString(pcs) + "\" can't be interpreted by handleFileCmd().");
}
