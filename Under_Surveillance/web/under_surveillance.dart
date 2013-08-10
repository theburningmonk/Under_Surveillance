library UnderSurveillance;

import 'dart:async';
import 'dart:math';
import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';

part "Game.dart";
part "Level.dart";
part "Person.dart";
part "Criminal.dart";
part "Innocent.dart";
part "Surveillance.dart";
part "Splash.dart";

Stage stage;
RenderLoop renderLoop;
ResourceManager resourceManager;
Game game;

void main() {
  stage = new Stage("myStage", html.document.query('#stage'));

  renderLoop = new RenderLoop();
  renderLoop.addStage(stage);
  
  resourceManager = new ResourceManager()
    ..addBitmapData("start", "images/Start.jpg")
    ..addBitmapData("intro", "images/Intro.jpg")
    ..addBitmapData("level_1_intro", "images/Level_1_Intro.jpg")
    ..addBitmapData("level_clear", "images/Level_Clear.jpg");
  
  resourceManager.load().then(Start);
}

void Start(result) {
  game = new Game(resourceManager, stage);
  game.Start();
  stage.addChild(game);
}