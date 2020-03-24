import 'package:flutter/gestures.dart';

import 'package:flame/components/component.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'package:flame/flame.dart';
import 'package:coronavirus_social_distancing_game/bullet.dart';
import 'package:coronavirus_social_distancing_game/people.dart';
import 'package:coronavirus_social_distancing_game/beach.dart';

import 'package:url_launcher/url_launcher.dart'; //url launcher
import 'package:flutter/services.dart'; //services
//import 'package:audio_service/audio_service.dart'; //audio background sound

bool gameOver = false;
const PEOPLESPEED = 120.0;
const BULLETSPEED = 60.0;
const PEOPLE_SIZE = 40.0;
const BULLET_SIZE = 20.0;

var points = 0;
People people;
Bullet bullet;

var game;

bool bulletStartStop = false;

double touchPositionDx = 0.0;
double touchPositionDy = 0.0;


main() async {
  Flame.audio.disableLog();
  Flame.images.loadAll(['fire.png', 'people.png', 'bullet.png']);

  var dimensions = await Flame.util.initialDimensions();
  game = new Beach(dimensions);

    runApp(MyApp());
}

class GameWrapper extends StatelessWidget {
  final Beach game;
  GameWrapper(this.game);

  @override
  Widget build(BuildContext context) {
    return game.widget;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coronavirus Social Distancing Game',
      home: Scaffold(
        appBar: AppBar(
          title: Text(
              'Coronavirus Social Distancing Game'
          ),
        ),
        // #docregion centered-text
        body: Center(
          // #docregion text
          child: Column(
            children: [
              Text(
                "Coronavirus Social Distancing Game",
                style: TextStyle(
                  fontFamily: 'virus43',
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
              ),
            Text(
              ""
            ),
            Text(
              "Stop the spread of Coronavirus by shooting rubber bullets to force those people that still don't understand the importance of social distancing, and still going on a vacation, despite the government's efforts to order you to go social distancing, to go social distancing back home",
              style: TextStyle(
                  fontFamily: 'RobotoMono'
              ),
            ),
            Text(
              " "
            ),
            Text(
              "If you are one of those people that still go on vacation, despite the government asking you to do social distancing at home, please learn the importance of social distancing by clicking the button below"
            ),
            FlatButton(
              child: Text("Click Me for Social Distancing Info"),
              onPressed: _launchSocialDistancingURL,
            ),
            Text(
              "Other than that, just press Start game and \"press the screen anywhere\" to generate a rubber bullet on that exact same position where you pressed the screen. The bullet will fly forward starting from that position. Try to hit the naughty people that are still on vacation so that they'll go back home and do social distancing!"
            ),
            Text(
                " "
            ),
            Text(
              "Be careful not to let those people go to the end of the path and touch you though... They seem to be wearing masks, and infected with Coronavirus, and you might get infected with Coronavirus that way...",
            ),
            OutlineButton(
              onPressed: () {
                runApp(MaterialApp(
                  home: Scaffold(
                    body: Container(
                    decoration: new BoxDecoration(
                    image: new DecorationImage(
                    image: new AssetImage(
                    "assets/images/background.jpg"),
                    fit: BoxFit.cover,
                    ),
                    ),
                      child: GameWrapper(game),
                ))));

                HorizontalDragGestureRecognizer horizontalDragGestureRecognizer =
                new HorizontalDragGestureRecognizer();

                Flame.util.addGestureRecognizer(horizontalDragGestureRecognizer
                ..onUpdate = (startDetails) =>
                game.dragInput(startDetails.globalPosition));

                Flame.util.addGestureRecognizer(new TapGestureRecognizer()
                ..onTapDown = (TapDownDetails evt) =>
                game.tapInput(evt.globalPosition));

                // Adds onUP feature to fire bullets
                Flame.util.addGestureRecognizer(new TapGestureRecognizer()
                ..onTapUp = (TapUpDetails evt) =>
                game.onUp(evt.globalPosition));
              },
              child: Text(
                "Start game",
              ),
            ),
              OutlineButton(
                child:Text("Exit game"),
                onPressed: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                }
              ),
          ],
        ),
          // #enddocregion text
        // #enddocregion centered-text
      ),
      ),
    );
  }
}

_launchSocialDistancingURL() async {
  const url = 'https://www.alodokter.com/pentingnya-menerapkan-social-distancing-demi-mencegah-covid-19';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}