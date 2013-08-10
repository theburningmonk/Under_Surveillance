part of UnderSurveillance;

class Level extends DisplayObjectContainer {
  int level;
  int timeLeft;
  int maxX;
  int maxY;
  int agents;
  int numOfInnocents;
  int numOfCriminals;
  List<Innocent> innocents;
  List<Criminal> criminals;
  
  TextField _timerText;
  StreamController _timeOverController;
  
  Level(Stage stage, ResourceManager resourceManager, this.level, this.timeLeft, this.maxX, this.maxY, this.agents, this.numOfInnocents, this.numOfCriminals)
  {
    Random random = new Random();
    
    innocents = new List<Innocent>(numOfInnocents);
    for (var i = 0; i < numOfInnocents; i++) {
      Innocent innocent = new Innocent(random.nextInt(60), random.nextInt(maxX), random.nextInt(maxY), maxX, maxY);
      this.addChild(innocent);
      innocents[i] = innocent;
    }
    
    criminals = new List<Criminal>(numOfCriminals);
    for (var i = 0; i < numOfCriminals; i++) {
      Criminal criminal = new Criminal(10, 10, maxX, maxY);
      this.addChild(criminal);
      criminals[i] = criminal;
    }
    
    _timerText = new TextField();
    _timerText
        ..x = 300
        ..y = 30
        ..text = timeLeft.toString();
    this.addChild(_timerText);
    
    _timeOverController = new StreamController.broadcast();

    
  }
  
  Stream get timeover => _timeOverController.stream;
  
  void Start()
  {
    Timer timer = new Timer.periodic(new Duration(seconds : 1), OnTimerEvent);
  }
  
  void OnTimerEvent(Timer timer)
  {
    timeLeft -= 1;
    print("$timeLeft");
    _timerText.text = timeLeft.toString();
    
    if (timeLeft == 0) {
      _timeOverController.add("timer over");
      timer.cancel();
    }
  }
  
  void Loop()
  {
    for (var innocent in innocents)
    {
      innocent.Loop();
    }
    
    for (var criminal in criminals)
    {
      criminal.Loop();
    }
  }
}