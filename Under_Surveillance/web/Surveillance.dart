part of UnderSurveillance;

class Surveillance extends Sprite {
  Surveillance(Person person, ResourceManager resourceManager) {
    var nameLabel = new TextField()
      ..x = 0
      ..y = 0
      ..width = 150
      ..height = 40
      ..text = person.Id;
    this.addChild(nameLabel);
    
    var cctvLabel = new TextField()
      ..x = 0
      ..y = 40
      ..width = 150
      ..height = 40
      ..text = "  CCTV Surveillance  "
      ..background = true
      ..backgroundColor = Color.Purple
      ..onMouseClick.listen((evt) => person.ToggleCctv());
    this.addChild(cctvLabel);
    
    var creditCardLabel = new TextField()
      ..x = 0
      ..y = 80
      ..width = 150
      ..height = 40
      ..text = "Credit Card Surveillance"
      ..background = true
      ..backgroundColor = Color.Orange
      ..onMouseClick.listen((evt) => person.ToggleCreditCard());
    this.addChild(creditCardLabel);
    
    var emailLabel = new TextField()
      ..x = 0
      ..y = 120
      ..width = 150
      ..height = 40
      ..text = "Email Surveillance"
      ..background = true
      ..backgroundColor = Color.Blue
      ..onMouseClick.listen((evt) => person.ToggleEmail());
    this.addChild(emailLabel);
    
    var phoneLabel = new TextField()
      ..x = 0
      ..y = 160
      ..width = 150
      ..height = 40
      ..text = "Phone Surveillance"
      ..background = true
      ..backgroundColor = Color.Yellow
      ..onMouseClick.listen((evt) => person.TogglePhone());
    this.addChild(phoneLabel);
    
    var agentLabel = new TextField()
      ..x = 0
      ..y = 200
      ..width = 150
      ..height = 40
      ..text = "Agent Surveillance"
      ..background = true
      ..backgroundColor = Color.Magenta
      ..onMouseClick.listen((evt) => person.ToggleAgent());
    this.addChild(agentLabel);
  }
}