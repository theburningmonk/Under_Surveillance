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
 
  Level GetLevel(n) {
    switch (n) {
      case 1: 
        return new Level(stage, resourceManager, 1, 30, 600, 500, 2, 1, 100000, 0.95, 30);
      case 2:
        return new Level(stage, resourceManager, 2, 45, 600, 500, 4, 1, 100000, 0.9, 35);
      case 3:
        return new Level(stage, resourceManager, 3, 60, 600, 500, 6, 1, 100000, 0.85, 40);
      case 4:
        return new Level(stage, resourceManager, 4, 65, 600, 500, 7, 1, 90000, 0.825, 43);
      case 5:
        return new Level(stage, resourceManager, 5, 65, 600, 500, 8, 1, 90000, 0.8, 46);
      case 6:
        return new Level(stage, resourceManager, 6, 55, 600, 500, 9, 1, 90000, 0.78, 48);
      case 7:
        return new Level(stage, resourceManager, 7, 50, 600, 500, 10, 1, 80000, 0.76, 48);
      case 8:
        return new Level(stage, resourceManager, 8, 45, 600, 500, 10, 1, 70000, 0.74, 49);
      case 9:
        return new Level(stage, resourceManager, 9, 40, 600, 500, 11, 1, 60000, 0.73, 49);
      case 10:
        return new Level(stage, resourceManager, 10, 40, 600, 500, 12, 1, 50000, 0.72, 50);
      default:
        return null;
    }
  }
  
  void StartLevel(n) {
    this.removeChild(_splash);
    
    _level = GetLevel(n);
    
    if (_level == null) {
      _splash = new Splash("level_clear", 100, 100, resourceManager);
      this.addChild(_splash);
    }
    else {
      _level.x = 0;
      _level.y = 0;
      this.addChild(_level);
    
      _level.Start();
      _gameOverSubscription = _level.onGameover.listen(OnGameOver);
      _finishGameSubscription = _level.onComplete.listen(OnLevelComplete);
    
      _enterFrameSubscription = this.onEnterFrame.listen(Loop);
    }
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
    
    ShowStart();
  }
}

