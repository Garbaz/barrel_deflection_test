class CollisionShape {
  Shape shape;
  float radius;

  CollisionShape(Shape shape_, float radius_) {
    shape = shape_;
    radius = radius_;
  }
}

enum Shape {
  CIRCLE, SQUARE
}
