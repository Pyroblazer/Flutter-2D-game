import 'package:flame/components/animation_component.dart';
import 'package:coronavirus_social_distancing_game/people.dart';
import 'package:coronavirus_social_distancing_game/main.dart';

class collisionSpark extends AnimationComponent {
  static const TIME = 0.75;

  collisionSpark(People people)
      : super.sequenced(PEOPLE_SIZE, PEOPLE_SIZE, 'collisionSpark-4.png', 7,
            textureWidth: 31.0, textureHeight: 31.0) {
    this.x = people.x;
    this.y = people.y;
    this.animation.stepTime = TIME / 7;
  }

  bool destroy() {
    return this.animation.isLastFrame;
  }
}
