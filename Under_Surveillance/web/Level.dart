part of UnderSurveillance;

class Configuration {
  num cctvIntrusion;
  num cctvEffect;
  num cctvCost;
  num creditCardIntrusion;
  num creditCardEffect;
  num creditCardCost;
  num emailIntrusion;
  num emailEffect;
  num emailCost;
  num phoneIntrusion;
  num phoneEffect;
  num phoneCost;
  num agentIntrusion;
  num agentEffect;
  num agentCost;
  
  Configuration() {
     cctvIntrusion = 0.05;
     cctvEffect = 0.05;
     cctvCost = 1;
     
     creditCardIntrusion = 0.1;
     creditCardEffect = 0.1;
     creditCardCost = 5;
     
     emailIntrusion = 0.3;
     emailEffect = 0.15;
     emailCost = 10;
     
     phoneIntrusion = 0.6;
     phoneEffect = 0.3;
     phoneCost = 20;
     
     agentIntrusion = 1.5;
     agentEffect = 0.8;
     agentCost = 100;
  }
}

class Level extends DisplayObjectContainer {
  int level;
  int timeLeft;
  int maxX;
  int maxY;
  int numOfInnocents;
  int numOfCriminals;
  List<Innocent> innocents;
  List<Criminal> criminals;
  List<Person> all;
  
  TextField _timerText;
  TextField _budgetLeftText;
  StreamController _gameOverController;
  StreamController _completeController;
  
  num civilCompliance;
  num maxCivilCompliance;
  int budget;
  int budgetLeft;
  
  Bitmap complianceBarBackground;
  Bitmap complianceBar;
  
  Surveillance _surveillance;
  
  Configuration _configuration;
  
  Level(Stage stage, ResourceManager resourceManager, this.level, this.timeLeft, this.maxX, this.maxY, this.numOfInnocents, this.numOfCriminals, this.budget)
  {
    _configuration = new Configuration();
    
    Random random = new Random();
    civilCompliance = 0;
    maxCivilCompliance = 0.5 * 100.0 * (numOfInnocents + numOfCriminals);
    budgetLeft = budget;
    
    all = new List<Person>(numOfInnocents + numOfCriminals);
    
    innocents = new List<Innocent>(numOfInnocents);
    for (var i = 0; i < numOfInnocents; i++) {
      Innocent innocent = new Innocent(random.nextInt(60), random.nextInt(maxX), random.nextInt(maxY), maxX, maxY);
      innocent.onSelected.listen(SelectPerson);
      
      this.addChild(innocent);
      innocents[i] = innocent;
      all[i] = innocent;
    }
    
    criminals = new List<Criminal>(numOfCriminals);
    for (var i = 0; i < numOfCriminals; i++) {
      Criminal criminal = new Criminal(random.nextInt(maxX), random.nextInt(maxY), maxX, maxY);
      criminal.onSelected.listen(SelectPerson);
      
      this.addChild(criminal);
      criminals[i] = criminal;
      all[i + numOfInnocents] = criminal;      
    }
    
    _timerText = new TextField()
        ..x = 300
        ..y = 30
        ..text = timeLeft.toString();
    this.addChild(_timerText);
    
    _budgetLeftText = new TextField()
      ..x = 200
      ..y = 30
      ..text = budgetLeft.toString();
    this.addChild(_budgetLeftText);
    
    complianceBarBackground = new Bitmap(new BitmapData(150, 10, false, Color.LightPink))
    ..x = 30
    ..y = 30;
    this.addChild(complianceBarBackground);
    
    complianceBar = new Bitmap(new BitmapData(1, 10, false, Color.Red))
      ..x = 30
      ..y = 30;
    this.addChild(complianceBar);
    
    _gameOverController = new StreamController.broadcast();
    _completeController = new StreamController.broadcast();
  }
  
  Stream get onGameover => _gameOverController.stream;
  Stream get onComplete => _completeController.stream;
  
  void Start()
  {
    Timer timer = new Timer.periodic(new Duration(seconds : 1), OnTimerEvent);
  }
  
  void Complete(Criminal criminal)
  {
    _completeController.add(level);
  }
  
  void GameOver(String reason)
  {
    _gameOverController.add(reason);
  }
  
  void OnTimerEvent(Timer timer)
  {
    timeLeft -= 1;
    print("$timeLeft");
    _timerText.text = timeLeft.toString();
    
    if (timeLeft == 0) {
      GameOver("time over");
      timer.cancel();
    }
  }
  
  void Loop()
  {
    for (var person in all) {
      Surveil(person);
      person.Loop();
    }
    
    _budgetLeftText.text = "\$ $budgetLeft";
    
    for (var criminal in criminals)
    {
      if (criminal.suspisionLevel == 100.0) {
        Complete(criminal);
        break;
      }
    }
    
    complianceBar.width = civilCompliance / maxCivilCompliance * complianceBarBackground.width;
  }
  
  void IncrIntrusion(num amt) {
    civilCompliance = min(maxCivilCompliance, civilCompliance + amt);
  }
  
  void Surveil(Person person) {
    if (person.underCctvSurveillance) {
      person.IncrSuspicion(_configuration.cctvEffect);
      person.IncrIntrusion(_configuration.cctvIntrusion);
      IncrIntrusion(_configuration.cctvIntrusion);
      budgetLeft -= _configuration.cctvCost;
    }
    
    if (person.underCreditCardSurveillance) {
      person.IncrSuspicion(_configuration.creditCardEffect);
      person.IncrIntrusion(_configuration.creditCardIntrusion);
      IncrIntrusion(_configuration.creditCardIntrusion);
      budgetLeft -= _configuration.creditCardCost;
    }
    
    if (person.underEmailSurveillance) {
      person.IncrSuspicion(_configuration.emailEffect);
      person.IncrIntrusion(_configuration.emailIntrusion);
      IncrIntrusion(_configuration.emailIntrusion);
      budgetLeft -= _configuration.emailCost;
    }
    
    if (person.underPhoneSurveillance) {
      person.IncrSuspicion(_configuration.phoneEffect);
      person.IncrIntrusion(_configuration.phoneIntrusion);
      IncrIntrusion(_configuration.phoneIntrusion);
      budgetLeft -= _configuration.phoneCost;
    }
    
    if (person.underAgentSurveillance) {
      person.IncrSuspicion(_configuration.agentEffect);
      person.IncrIntrusion(_configuration.agentIntrusion);
      IncrIntrusion(_configuration.agentIntrusion);
      budgetLeft -= _configuration.agentCost;
    }
    
    budgetLeft = max(0.0, budgetLeft);
    if (budgetLeft == 0.0) {
      GameOver("Out of Budget");
    }
  }
  
  void SelectPerson(Person person) {
    if (_surveillance != null) {
      this.removeChild(_surveillance);
    }
    
    _surveillance = new Surveillance(person, resourceManager)
      ..x = 450
      ..y = 100;
    this.addChild(_surveillance);
  }
}