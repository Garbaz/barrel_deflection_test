class Actor implements Drawable {
  final int COLLISION_PASSES = 2;

  final float RADIUS = PLAYER_RADIUS;
  PVector pos, vel;

  Actor(PVector pos_) {
    pos = pos_.copy();
    vel = new PVector(0, 0);
    drawables.add(this);
  }

  void update(float dt) {
    pos.add(PVector.mult(vel, dt));
    for (int i = 0; i < COLLISION_PASSES; i++) {
      for (Prop p : props) {
        PVector backstep = collide(p);
        if (backstep != null) {
          pos.add(backstep);
        }
      }
    }
  }

  void show() {
  }

  PVector collide(Prop p) {
    PVector rel_pos = PVector.sub(pos, p.pos);
    float dist_x = abs(rel_pos.x), dist_y = abs(rel_pos.y);

    if (p.collisionShape.shape == Shape.CIRCLE && rel_pos.mag() <= p.collisionShape.radius+RADIUS) {
      rel_pos.setMag(RADIUS+p.collisionShape.radius-rel_pos.mag());
      return rel_pos;
    } else if (p.collisionShape.shape == Shape.SQUARE) {
      if (dist_x > RADIUS + p.collisionShape.radius || dist_y > RADIUS + p.collisionShape.radius) {
        return null;
      } else if (dist_x <= p.collisionShape.radius || dist_y <= p.collisionShape.radius) {
        if (dist_x < dist_y) {
          if (rel_pos.x < rel_pos.y) {
            return new PVector(0, RADIUS+p.collisionShape.radius-dist_y);
          } else {
            return new PVector(0, -(RADIUS+p.collisionShape.radius-dist_y));
          }
        } else {
          if (rel_pos.x < rel_pos.y) {
            return new PVector(-(RADIUS+p.collisionShape.radius-dist_x), 0);
          } else {
            return new PVector(RADIUS+p.collisionShape.radius-dist_x, 0);
          }
        }
      } else {
        float corner_dist_x = dist_x-p.collisionShape.radius, corner_dist_y = dist_y-p.collisionShape.radius;
        float corner_dist_sq = corner_dist_x*corner_dist_x + corner_dist_y*corner_dist_y;
        if (corner_dist_sq <= RADIUS*RADIUS) {
          PVector ret = new PVector((rel_pos.x/dist_x) * corner_dist_x, (rel_pos.y/dist_y) * corner_dist_y);
          ret.setMag(RADIUS-sqrt(corner_dist_sq));
          return ret;
        }
      }
    }

    return null;
  }
}


/*
String s1 = "", s2 = "";
 
 PVector deflected_vel = vel.copy();
 s1 += "("+int(deflected_vel.x*10)/10.0+","+int(deflected_vel.y*10)/10.0+")" + " ";
 
 debugLayer.stroke(128, 0, 255);
 debug_drawArrow_(pos, PVector.mult(deflected_vel, 1));
 
 for (Prop p : props) {
 PVector norm = collide(p);
 if (norm != null) {
 debugLayer.stroke(0, 255, 255);
 debug_drawArrow_(pos, PVector.mult(norm, 64));
 
 PVector tang = new PVector(-norm.y, norm.x);
 
 PVector player_vel_nt_base = vector_toBasis(deflected_vel, norm, tang);
 
 s2 += "("+int(player_vel_nt_base.x*10)/10.0+","+int(player_vel_nt_base.y*10)/10.0+")" + " ";
 
 if (player_vel_nt_base.x < 0) player_vel_nt_base.x = 0;
 deflected_vel = vector_fromBasis(player_vel_nt_base, norm, tang);
 
 debugLayer.stroke(255, 0, 255);
 debug_drawArrow_(pos, PVector.mult(deflected_vel, 1));
 
 s1 += "("+int(deflected_vel.x*10)/10.0+","+int(deflected_vel.y*10)/10.0+")" + " ";
 
 
 }
 }
 fill(0);
 text(s1, 0, 0);
 text(s2, 0, 20);
 pos.add(deflected_vel.x * dt, deflected_vel.y * dt);
 */
