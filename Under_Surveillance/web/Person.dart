part of UnderSurveillance;

abstract class Person extends Sprite {
  int suspisionLevel;
  int maxSuspisionLevel;
  int maxX;
  int maxY;
  num xDir;
  num yDir;
  Random random = new Random();
  
  void Init(colour)
  {
    var background = new BitmapData(40, 40, false, colour);
    var backgroundBitmap = new Bitmap(background);
    backgroundBitmap
      ..x = 0
      ..y = 0;
    this.addChild(backgroundBitmap);
    
    this.onMouseClick.listen(OnMouseClick);
  }
  
  void OnMouseClick(MouseEvent evt);
  
  void Move()
  {
    x = min(maxX, max(0, x += xDir));
    y = min(maxY, max(0, y += yDir));
    
    // if the person has reached the boundary, then change direction for the next turn
    if (x == 0 || x == maxX || y == 0 || y == maxY)
    {
      SetDirection();
    }
  }
  
  void SetDirection()
  {
    xDir = random.nextDouble();
    yDir = random.nextDouble();
    
    if (random.nextDouble() > 0.5) 
    {
      xDir *= -1;
    }
    
    if (random.nextDouble() > 0.5)
    {
      yDir *= -1;
    }
  }
  
  void Loop() {
    if (random.nextInt(100) < 1)
    {
      SetDirection();
    }
    
    Move();
  }
}