library UnderSurveillance;

import 'dart:math';
import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';

part "Level.dart";
part "Person.dart";
part "Criminal.dart";

Stage stage;
RenderLoop renderLoop;
ResourceManager resourceManager;

void main() {
  stage = new Stage("myStage", html.document.query('#stage'));

  renderLoop = new RenderLoop();
  renderLoop.addStage(stage);
  
  stage.onEnterFrame.listen(Loop);
  resourceManager = new ResourceManager();
  
  //resourceManager.load().then(onValue)
}

void Loop(EnterFrameEvent evt) {
  print("loop");
  
  
  
}