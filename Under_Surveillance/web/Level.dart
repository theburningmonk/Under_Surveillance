part of UnderSurveillance;

class Configuration {
  int cctvIntrusion;
  int cctvEffect;
  int cctvCost;
  int creditCardIntrusion;
  int creditCardEffect;
  int creditCardCost;
  int emailIntrusion;
  int emailEffect;
  int emailCost;
  int phoneIntrusion;
  int phoneEffect;
  int phoneCost;
  int agentIntrusion;
  int agentEffect;
  int agentCost;
  
  Configuration() {
     cctvIntrusion = 1;
     cctvEffect = 1;
     cctvCost = 10;
     
     creditCardIntrusion = 5;
     creditCardEffect = 5;
     creditCardCost = 50;
     
     emailIntrusion = 10;
     emailEffect = 20;
     emailCost = 100;
     
     phoneIntrusion = 15;
     phoneEffect = 30;
     phoneCost = 200;
     
     agentIntrusion = 40;
     agentEffect = 80;
     agentCost = 500;
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
  StreamController _timeOverController;
  StreamController _completeController;
  
  int civilCompliance;
  int budget;
  int budgetLeft;
  
  Surveillance _surveillance;
  
  Configuration _configuration;
  
  Level(Stage stage, ResourceManager resourceManager, this.level, this.timeLeft, this.maxX, this.maxY, this.numOfInnocents, this.numOfCriminals, this.budget)
  {
    _configuration = new Configuration();
    
    Random random = new Random();
    civilCompliance = 0;
    budgetLeft = budget;
    
    all = new List<Person>(numOfInnocents + numOfCriminals);
    
    innocents = new List<Innocent>(numOfInnocents);
    for (var i = 0; i < numOfInnocents; i++) {
      Innocent innocent = new Innocent(random.nextInt(60), random.nextInt(maxX), random.nextInt(maxY), maxX, maxY);
      //innocent.onSelected.listen(SelectPerson);
      
      this.addChild(innocent);
      innocents[i] = innocent;
      all[i] = innocent;
    }
    
    criminals = new List<Criminal>(numOfCriminals);
    for (var i = 0; i < numOfCriminals; i++) {
      Criminal criminal = new Criminal(random.nextInt(maxX), random.nextInt(maxY), maxX, maxY);
      //criminal.onSelected.listen(SelectPerson);
      
      this.addChild(criminal);
      criminals[i] = criminal;
      all[i + numOfInnocents] = criminal;      
    }
    
    _timerText = new TextField();
    _timerText
        ..x = 300
        ..y = 30
        ..text = timeLeft.toString();
    this.addChild(_timerText);
    
    _timeOverController = new StreamController.broadcast();
    _completeController = new StreamController.broadcast();
  }
  
  Stream get onTimeover => _timeOverController.stream;
  Stream get onComplete => _completeController.stream;
  
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
      _completeController.add(level);
      timer.cancel();
    }
  }
  
  void Loop()
  {
    for (var person in all) {
      person.Loop();      
    }
  }
  
  void Surveil(Person person) {
    if (person.underCctvSurveillance) {
      person.IncrSuspicion(_configuration.cctvEffect);
    }
    
    if (person.underCreditCardSurveillance) {
      person.IncrSuspicion(_configuration.creditCardEffect);
    }
    
    if (person.underEmailSurveillance) {
      person.IncrSuspicion(_configuration.emailEffect);
    }
    
    if (person.underPhoneSurveillance) {
      person.IncrSuspicion(_configuration.phoneEffect);
    }
    
    if (person.underAgentSurveillance) {
      person.IncrSuspicion(_configuration.agentEffect);
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