class Prop implements Drawable {

  Prop() {
    drawables.add(this);
  }

  PVector pos;
  CollisionShape collisionShape;

  void draw() {
  }
}

class Barrel extends Prop {
  float radius;
  Barrel(PVector pos_, float radius_) {
    super();
    this.pos = pos_;
    this.radius = radius_;
    this.collisionShape = new CollisionShape(Shape.CIRCLE, radius);
  }

  void draw() {
    fill(#e02c08);
    circle(pos.x, pos.y, 2*radius);
  }
}

class Box extends Prop {
  float radius;
  Box(PVector pos_, float radius_) {
    super();
    this.pos = pos_;
    this.radius = radius_;
    this.collisionShape = new CollisionShape(Shape.SQUARE, radius);
  }

  void draw() {
    fill(#603814);
    rect(pos.x - radius, pos.y - radius, 2*radius, 2*radius);
  }
}
