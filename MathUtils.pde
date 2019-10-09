
PVector vector_toBasis(PVector v, PVector b1, PVector b2) {
  PVector ret = new PVector();
  float det = b1.x*b2.y-b1.y*b2.x;
  ret.x = (v.x *  b2.y + v.y * -b2.x)/det;
  ret.y = (v.x * -b1.y + v.y *  b1.x)/det;

  return ret;
}

PVector vector_fromBasis(PVector w, PVector b1, PVector b2) {
  PVector ret = new PVector();
  ret.x = w.x * b1.x + w.y * b2.x;
  ret.y = w.x * b1.y + w.y * b2.y;

  return ret;
}
