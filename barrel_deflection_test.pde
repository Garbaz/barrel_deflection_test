boolean isLooping = true;

final int PLAYER_RADIUS = 32;
final float PLAYER_SPEED = 128;

final int PROP_RADIUS = 64;

//PVector player_pos, barrel_pos;
PVector player_dir;

ArrayList<Drawable> drawables = new ArrayList<Drawable>();
ArrayList<Prop> props = new ArrayList<Prop>();

Player player;

void settings() {
  size(1000, 1000);
}

void setup() {
  debug_init();

  textAlign(LEFT, TOP);

  player_dir = new PVector(0, 0);

  player = new Player(new PVector(100, 100));


  //player_pos = new PVector(20, 20);

  //barrel_pos = new PVector(width/2, height/2);
}


void draw() {
  float dt = deltatime();

  if (isLooping) {
    background(#44aa44);

    debug_begin_draw();


    player.update(dt);

    for (Drawable d : drawables) {
      d.draw();
    }

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


    debug_end_draw();
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    props.add(new Barrel(new PVector(mouseX, mouseY), PROP_RADIUS));
  } else if (mouseButton == RIGHT) {
    props.add(new Box(new PVector(mouseX, mouseY), PROP_RADIUS));
  }
}


void keyPressed() {
  if (keyCode == LEFT || key == 'a') {
    player_dir.x--;
    if (player_dir.x < -1) player_dir.x = -1;
  } else if (keyCode == RIGHT || key == 'd') {
    player_dir.x++;
    if (player_dir.x > 1) player_dir.x = 1;
  } else if (keyCode == UP || key == 'w') {
    player_dir.y--;
    if (player_dir.y < -1) player_dir.y = -1;
  } else if (keyCode == DOWN || key == 's') {
    player_dir.y++;
    if (player_dir.y > 1) player_dir.y = 1;
  } else if (key == ' ') {
    if (isLooping) {
      isLooping = false;
    } else {
      isLooping = true;
    }
  } else if (key == 'c') {
    drawables.removeAll(props);
    props.clear();
  }

  update_player_vel();
}

void keyReleased() {
  if (keyCode == LEFT || key == 'a') {
    player_dir.x++;
    if (player_dir.x > 1) player_dir.x = 1;
  } else if (keyCode == RIGHT || key == 'd') {
    player_dir.x--;
    if (player_dir.x < -1) player_dir.x = -1;
  } else if (keyCode == UP || key == 'w') {
    player_dir.y++;
    if (player_dir.y > 1) player_dir.y = 1;
  } else if (keyCode == DOWN || key == 's') {
    player_dir.y--;
    if (player_dir.y < -1) player_dir.y = -1;
  }

  update_player_vel();
}

void update_player_vel() {
  player.vel.x = player_dir.x * PLAYER_SPEED;
  player.vel.y = player_dir.y * PLAYER_SPEED;
}


int lastTime = 0;
float deltatime() {
  int deltaTime = millis() - lastTime;
  lastTime += deltaTime;
  return deltaTime/1000.0;
}
