class Player extends Actor {
  
  Player(PVector pos_) {
    super(pos_);
  }
  
  void show() {
    fill(#2270ff);
    circle(pos.x, pos.y, 2*RADIUS);
    
    if(editMode) {
      fill(#f7ef43);
      circle(pos.x, pos.y, 1.5*RADIUS);
    }
  }

  
}
