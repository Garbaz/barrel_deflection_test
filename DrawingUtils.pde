
void drawArrow(float x_from, float y_from, float x_to, float y_to) {
  line(x_from, y_from, x_to, y_to);
  PVector v = new PVector(x_from - x_to, y_from - y_to);
  v.normalize();
  v.mult(5);
  v.rotate(QUARTER_PI);
  line(x_to, y_to, x_to+v.x, y_to+v.y);
  v.rotate(-HALF_PI);
  line(x_to, y_to, x_to+v.x, y_to+v.y);
}

void drawArrow(PVector from, PVector to) {
  drawArrow(from.x, from.y, to.x, to.y);
}

void drawArrow_(float x_pos, float y_pos, float x_dir, float y_dir) {
  drawArrow(x_pos, y_pos, x_pos+x_dir, y_pos+y_dir);
}

void drawArrow_(PVector pos, PVector dir) {
  drawArrow_(pos.x, pos.y, dir.x, dir.y);
}
