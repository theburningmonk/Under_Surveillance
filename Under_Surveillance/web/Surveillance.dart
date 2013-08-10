part of UnderSurveillance;

class Surveillance extends Sprite {
  Surveillance(Person person, ResourceManager resourceManager) {
    TextFormat textFormat = new TextFormat("Arial", 16, Color.Black, bold : true);
    num width = 200;
    num disabledAlpha = 0.5;
    
    var nameLabel = new TextField()
      ..x = 0
      ..y = 0
      ..width = width
      ..height = 40
      //..background = true
      //..backgroundColor = Color.LightGreen
      ..text = person.Id
      ..defaultTextFormat = textFormat;
    this.addChild(nameLabel);
    
    var cctvLabel = new TextField()
      ..x = 0
      ..y = 40
      ..width = width
      ..height = 40
      ..text = "  CCTV Surveillance  "
      ..background = true
      ..backgroundColor = Color.Purple
      ..defaultTextFormat = textFormat
      ..onMouseClick.listen((evt) => person.ToggleCctv());
    this.addChild(cctvLabel);
    
    var creditCardLabel = new TextField()
      ..x = 0
      ..y = 80
      ..width = width
      ..height = 40
      ..text = "Credit Card Surveillance"
      ..background = true
      ..backgroundColor = Color.Orange
      ..defaultTextFormat = textFormat
      ..onMouseClick.listen((evt) => person.ToggleCreditCard());
    this.addChild(creditCardLabel);
    
    var emailLabel = new TextField()
      ..x = 0
      ..y = 120
      ..width = width
      ..height = 40
      ..text = "Email Surveillance"
      ..background = true
      ..backgroundColor = Color.Blue
      ..defaultTextFormat = textFormat
      ..onMouseClick.listen((evt) => person.ToggleEmail());
    this.addChild(emailLabel);
    
    var phoneLabel = new TextField()
      ..x = 0
      ..y = 160
      ..width = width
      ..height = 40
      ..text = "Phone Surveillance"
      ..background = true
      ..backgroundColor = Color.Yellow
      ..defaultTextFormat = textFormat
      ..onMouseClick.listen((evt) => person.TogglePhone());
    this.addChild(phoneLabel);
    
    var agentLabel = new TextField()
      ..x = 0
      ..y = 200
      ..width = width
      ..height = 40
      ..text = "Agent Surveillance"
      ..background = true
      ..backgroundColor = Color.Magenta
      ..defaultTextFormat = textFormat
      ..onMouseClick.listen((evt) => person.ToggleAgent());
    this.addChild(agentLabel);
  }
}