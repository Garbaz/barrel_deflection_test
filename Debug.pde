PGraphics debugLayer;

void debug_init() {
  debugLayer = createGraphics(width, height);
}

void debug_begin_draw() {
  debugLayer.beginDraw();
  debugLayer.background(0, 0, 0, 0);
}

void debug_end_draw() {
  debugLayer.endDraw();
  image(debugLayer, 0, 0);
}


void debug_drawArrow(float x_from, float y_from, float x_to, float y_to) {
  debugLayer.line(x_from, y_from, x_to, y_to);
  PVector v = new PVector(x_from - x_to, y_from - y_to);
  v.normalize();
  v.mult(5);
  v.rotate(QUARTER_PI);
  debugLayer.line(x_to, y_to, x_to+v.x, y_to+v.y);
  v.rotate(-HALF_PI);
  debugLayer.line(x_to, y_to, x_to+v.x, y_to+v.y);
}

void debug_drawArrow(PVector from, PVector to) {
  debug_drawArrow(from.x, from.y, to.x, to.y);
}

void debug_drawArrow_(float x_pos, float y_pos, float x_dir, float y_dir) {
  debug_drawArrow(x_pos, y_pos, x_pos+x_dir, y_pos+y_dir);
}

void debug_drawArrow_(PVector pos, PVector dir) {
  debug_drawArrow_(pos.x, pos.y, dir.x, dir.y);
}
