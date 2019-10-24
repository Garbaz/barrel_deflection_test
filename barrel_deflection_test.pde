boolean paused = false;


final int PLAYER_RADIUS = 32;
final float PLAYER_SPEED = 200;

final int PROP_RADIUS = 64;

ArrayList<Drawable> drawables = new ArrayList<Drawable>();
ArrayList<Prop> props = new ArrayList<Prop>();

Player player;

PVector spawn_point = new PVector(100, 100);

boolean editMode = false;
boolean unsavedChanges = false;

void settings() {
  size(1000, 1000);
}

void setup() {
  frameRate(300);

  debug_init();

  textAlign(LEFT, TOP);

  loadLevel("save_test.hax");

  player = new Player(spawn_point);


  //for (int i = 0; i < 7; i++) {
  //  addProp(new Barrel(new PVector(width/2, 150+i*2*PROP_RADIUS), PROP_RADIUS));
  //  addProp(new Barrel(new PVector(width/2-2*(PROP_RADIUS+PLAYER_RADIUS-i), 150+i*2*PROP_RADIUS), PROP_RADIUS));
  //}
}


void draw() {
  float dt = deltatime();

  if (!paused) {
    background(#44aa44);

    debug_begin_draw();

    player.update(dt);
    
    pushStyle();
    strokeWeight(3);
    strokeCap(SQUARE);
    line(spawn_point.x, spawn_point.y, spawn_point.x, spawn_point.y - 50);
    rectMode(CORNERS);
    strokeWeight(1);
    fill(#cccccc);
    rect(spawn_point.x+1, spawn_point.y-25, spawn_point.x+40, spawn_point.y-50);
    popStyle();
    
    for (Drawable d : drawables) {
      d.show();
    }

    if (editMode) {
      pushStyle();
      textAlign(RIGHT, TOP);
      textSize(18);
      fill(0);
      text("EDIT MODE", width, 0);
      if (unsavedChanges) text("Unsaved changes!", width, 20);
      popStyle();
    }

    debug_end_draw();
  }
}

void mousePressed() {
  if (editMode) {
    if (mouseButton == LEFT) {
      addProp(new Barrel(new PVector(mouseX, mouseY), PROP_RADIUS));
    } else if (mouseButton == RIGHT) {
      addProp(new Box(new PVector(mouseX, mouseY), PROP_RADIUS));
    } else if (mouseButton == CENTER) {
      PVector mousePos = new PVector(mouseX, mouseY);
      ArrayList<Prop> toBeRemoved = new ArrayList<Prop>(); 
      for (Prop p : props) {
        if (p.collisionShape.shape == Shape.CIRCLE) {
          if (mousePos.dist(p.pos) < p.collisionShape.radius) {
            toBeRemoved.add(p);
          }
        } else if (p.collisionShape.shape == Shape.SQUARE) {
          if (abs(mousePos.x - p.pos.x) <= p.collisionShape.radius && abs(mousePos.y - p.pos.y) <= p.collisionShape.radius) {
            toBeRemoved.add(p);
          }
        }
      }
      removeAllProps(toBeRemoved);
    }
  }
}

boolean key_left  = false;
boolean key_right = false;
boolean key_up    = false;
boolean key_down  = false;

void keyPressed(KeyEvent e) {
  if (!e.isAutoRepeat()) {
    char e_key = e.getKey();
    int e_keyCode = e.getKeyCode();
    if (e_keyCode == LEFT || e_key == 'a') {
      key_left = true;
    } else if (e_keyCode == RIGHT || e_key == 'd') {
      key_right = true;
    } else if (e_keyCode == UP || e_key == 'w') {
      key_up = true;
    } else if (e_keyCode == DOWN || e_key == 's') {
      key_down = true;
    } else if (e_key == ' ') {
      paused = !paused;
    } else if (e_key == 'e') {
      editMode = !editMode;
    }
    if (editMode) {
      if (e_key == 'c') {
        drawables.removeAll(props);
        props.clear();
      } else if (e_key == 'v') {
        saveLevel("save_test.hax");
        unsavedChanges = false;
      } else if (e_key == 't') {
        spawn_point.set(player.pos);
        unsavedChanges = true;
      }
    }

    update_player_vel();
  }
}

void keyReleased() {
  if (keyCode == LEFT || key == 'a') {
    key_left = false;
  } else if (keyCode == RIGHT || key == 'd') {
    key_right = false;
  } else if (keyCode == UP || key == 'w') {
    key_up = false;
  } else if (keyCode == DOWN || key == 's') {
    key_down = false;
  }

  update_player_vel();
}

void addProp(Prop p) {
  props.add(p);
  drawables.add(p);
  unsavedChanges = true;
}

void removeProp(Prop p) {
  props.remove(p);
  drawables.remove(p);
  unsavedChanges = true;
}

void removeAllProps(java.util.Collection c) {
  if (!c.isEmpty()) {
    props.removeAll(c);
    drawables.removeAll(c);
    unsavedChanges = true;
  }
}

void update_player_vel() {
  player.vel.x = (int(key_right)-int(key_left));
  player.vel.y = (int(key_down)-int(key_up));
  player.vel.setMag(PLAYER_SPEED);
}


int lastTime = 0;
float deltatime() {
  int deltaTime = millis() - lastTime;
  lastTime += deltaTime;
  return deltaTime/1000.0;
}






// ~~~~~~~~~~~~ OLD CODE ~~~~~~~~~~~~~


//PVector norm = PVector.sub(barrel_pos, player_pos); 
//norm.normalize();
//PVector tang = new PVector(-norm.y, norm.x); 
//tang.normalize();


//  PVector player_vel_deflected;

//  if (player_pos.dist(barrel_pos) <= PLAYER_RADIUS + BARREL_RADIUS) {
//    PVector player_vel_nt_base = vector_toBasis(player_dir, norm, tang);
//    if (player_vel_nt_base.x > 0) player_vel_nt_base.x = 0;
//    player_vel_deflected = vector_fromBasis(player_vel_nt_base, norm, tang);
//  } else {
//    player_vel_deflected = player_dir;
//  }

//  player_pos.add(PLAYER_SPEED * player_vel_deflected.x * dt, PLAYER_SPEED * player_vel_deflected.y * dt);
