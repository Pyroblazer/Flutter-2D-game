import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:coronavirus_social_distancing_game/bullet.dart';
import 'package:coronavirus_social_distancing_game/people.dart';
import 'package:coronavirus_social_distancing_game/main.dart';

class Beach extends BaseGame {
  bool checkOnce = true;

  List<People> peopleList = <People>[];
  List<Bullet> bulletList = <Bullet>[];
  Size dimensions;

  Beach(this.dimensions);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    String text = points.toString();
    TextPainter p = Flame.util
        .text(text, color: Colors.white, fontSize: 48.0, fontFamily: 'Halo');
    String over = "Game over";
    TextPainter overGame = Flame.util
        .text(over, color: Colors.white, fontSize: 48.0, fontFamily: 'Halo');
    gameOver
        ? overGame.paint(canvas, Offset(size.width / 5, size.height / 2))
        : p.paint(canvas, new Offset(size.width - p.width - 10, size.height - p.height - 10));
  }

  double creationTimer = 0.0;
  @override
  void update(double t) {
    creationTimer += t;
    if (creationTimer >= 4) {
      creationTimer = 0.0;

      for (int i = 1; i <= PEOPLE_SIZE / 7; i++) {
        for (int j = 0; j < i; ++j) {
          people = new People(dimensions, i, j);
          peopleList.add(people);
          add(people);
        }
      }
    }
    super.update(t);
  }

  void tapInput(Offset position) {
    touchPositionDx = position.dx;
    touchPositionDy = position.dy;
    bulletStartStop = true;
    bulletList.add(bullet);
    bullet = new Bullet(peopleList, bulletList);
    add(bullet);
  }

  void dragInput(Offset position) {
    touchPositionDx = position.dx;
    touchPositionDy = position.dy;
    bulletStartStop = true;
  }

  void onUp() {
    bulletStartStop = false;
  }
}
