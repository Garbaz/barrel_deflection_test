class Prop implements Drawable {

  Prop() {
    
  }

  PVector pos;
  CollisionShape collisionShape;

  void show() {
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

  void show() {
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


  void show() {
    fill(#603814);
    rect(pos.x - radius, pos.y - radius, 2*radius, 2*radius);
  }
}
