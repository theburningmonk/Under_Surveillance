part of UnderSurveillance;

Level _level;
Splash _splash;
StreamSubscription _enterFrameSubscription;
StreamSubscription _gameOverSubscription;
StreamSubscription _finishGameSubscription;

class Game extends DisplayObjectContainer {
  Game(ResourceManager resourceManager, Stage stage)
  {
  }
  
  void Start() {
    ShowStart();
  }
  
  void ShowStart() {
    _splash = new Splash("start", 384, 463, resourceManager);
    _splash.x = 0;
    _splash.y = 0;
    this.addChild(_splash);
    
    _splash.onContinue.listen(CloseStart);
  }
  
  void CloseStart(res) {
    this.removeChild(_splash);
    _splash = new Splash("intro", 383, 638, resourceManager);
    this.addChild(_splash);
    _splash.onContinue.listen((res) => StartLevel(1));
  }
  
  void CloseSplash(splash) {
    StartLevel(_level.level + 1);
  }
 
  void StartLevel(n) {
    this.removeChild(_splash);
    
    _level = new Level(stage, resourceManager, 1, 45, 800, 500, 5, 1, 100000);
    _level.x = 0;
    _level.y = 0;
    this.addChild(_level);
    
    _level.Start();
    _gameOverSubscription = _level.onGameover.listen(OnGameOver);
    _finishGameSubscription = _level.onComplete.listen(OnLevelComplete);
    
    _enterFrameSubscription = this.onEnterFrame.listen(Loop);
  }
  
  void Loop(evt)
  {
    if (_level != null) {
      _level.Loop();
    }
  }

  void OnLevelComplete(int level) {
    _enterFrameSubscription.cancel();
    _finishGameSubscription.cancel();
    _gameOverSubscription.cancel();
    
    this.removeChild(_level);
    _splash = new Splash("level_clear", 368, 551, resourceManager);
    this.addChild(_splash);
    _splash.onContinue.listen(CloseSplash);
  }
  
  void OnGameOver(reason) {
    _enterFrameSubscription.cancel();
    _finishGameSubscription.cancel();
    _gameOverSubscription.cancel();
    
    print("GAME OVER ($reason)");
  }
}
