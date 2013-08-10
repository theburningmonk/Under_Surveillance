library UnderSurveillance;

import 'dart:async';
import 'dart:math';
import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';

part "Level.dart";
part "Person.dart";
part "Criminal.dart";
part "Innocent.dart";

Stage stage;
RenderLoop renderLoop;
ResourceManager resourceManager;
Level level;

void main() {
  stage = new Stage("myStage", html.document.query('#stage'));

  renderLoop = new RenderLoop();
  renderLoop.addStage(stage);
  
  stage.onEnterFrame.listen(Loop);
  resourceManager = new ResourceManager();
  
  level = new Level(stage, resourceManager, 1, 15, 400, 400, 3, 5, 1);
  level.x = 0;
  level.y = 0;
  stage.addChild(level);
  
  level.Start();
  level.timeover.listen(OnTimeOver);
  
  //resourceManager.load().then(onValue)
}

void OnTimeOver(evt) {
  print("GAME OVER");
}

void Loop(EnterFrameEvent evt) {
  level.Loop();
}