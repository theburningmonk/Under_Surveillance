import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';

Stage stage;
RenderLoop renderLoop;
ResourceManager resourceManager;

void main() {
  stage = new Stage("myStage", html.document.query('#stage'));

  renderLoop = new RenderLoop();
  renderLoop.addStage(stage);
  
  stage.onEnterFrame.listen(Loop);
  
}

void Loop(evt) {
  
  
}