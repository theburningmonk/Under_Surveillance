part of UnderSurveillance;

class Splash extends Sprite {
  StreamController _continueController;
  
  Splash(String screenName, x, y, ResourceManager resourceManager)
  {
    Bitmap background = new Bitmap(resourceManager.getBitmapData(screenName))
      ..x = 0
      ..y = 0;
    this.addChild(background);
    
    Sprite continueButton = new Sprite()
      ..x = x
      ..y = y
      ..addChild(new Bitmap(new BitmapData(284, 79, false, Color.DarkGreen)));
    this.addChild(continueButton);
    
    _continueController = new StreamController.broadcast();
    
    continueButton.onMouseClick.listen(OnClick);
  }
  
  Stream get onContinue => _continueController.stream;
  
  void OnClick(evt) {
    _continueController.add(this);
  }
}