import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:coronavirus_social_distancing_game/main.dart';

class People extends SpriteComponent {
  Size dimensions;
  int xposition;
  int yposition;
  bool socialDistancingBackHome = false;
  double maxY;
  double maxX;

  People(this.dimensions, this.xposition, this.yposition)
      : super.square(PEOPLE_SIZE, 'people.png');

  @override
  void update(double t) {
    if(!socialDistancingBackHome) {
      y += gameOver ? 0 : (t * PEOPLESPEED);
    }
    else {
      if (x > maxX / 2) {
        x += (t * PEOPLESPEED) + 10;
        y -= (t * PEOPLESPEED) + 10;
      }
      else {
        x -= (t * PEOPLESPEED) + 10;
        y -= (t * PEOPLESPEED) + 10;
      }
    }
  }

  @override
  bool destroy() {
    if (socialDistancingBackHome) {
      if ((x >= maxX + PEOPLE_SIZE / 2) || (x <= 0 + PEOPLE_SIZE / 2)) {
        return true;
      }
    }
    if (y == null || maxY == null) {
      return false;
    }
    bool socialDistancingFailure = y >= maxY + PEOPLE_SIZE / 2;
    if (socialDistancingFailure) {
      gameOver = true;

      print("Game over");

      return true;
    }
    return socialDistancingFailure;
  }

  @override
  void resize(Size size) {
    this.x = (PEOPLE_SIZE * xposition);
    this.y = PEOPLE_SIZE * yposition;
    this.maxY = size.height;
    this.maxX = size.width;
  }
}
