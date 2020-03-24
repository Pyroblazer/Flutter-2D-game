import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:coronavirus_social_distancing_game/people.dart';
import 'package:coronavirus_social_distancing_game/collisionSpark.dart';
import 'package:coronavirus_social_distancing_game/main.dart';

class Bullet extends SpriteComponent {
  bool explode = false;
  double maxY;
  List<People> peopleList = <People>[];
  List<Bullet> bulletList = <Bullet>[];
  Bullet(this.peopleList, this.bulletList)
      : super.square(BULLET_SIZE, 'bullet.png');

  @override
  void update(double t) {
    y -= gameOver ? 0 : t * BULLETSPEED;

    if (peopleList.isNotEmpty)
      peopleList.forEach((people) {
        bool remove = this.toRect().contains(people.toRect().bottomCenter) ||
            this.toRect().contains(people.toRect().bottomLeft) ||
            this.toRect().contains(people.toRect().bottomRight);
        if (remove) {
          points += 1;
          people.socialDistancingBackHome = true;
          bullet.explode = true;
          peopleList.remove(people);
          game.add(new collisionSpark(people));
        }
      });
  }

  @override
  bool destroy() {
    if (explode) {
      return true;
    }
    if (y == null || maxY == null) {
      return false;
    }
    bool destroy = y >= maxY;

    return destroy;
  }

  @override
  void resize(Size size) {
    this.x = touchPositionDx;
    this.y = touchPositionDy;
    this.maxY = size.height;
  }
}
