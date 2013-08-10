part of UnderSurveillance;

abstract class Person {
  int suspisionLevel;
  int maxSuspisionLevel;
  int x;
  int maxX;
  int y;
  int maxY;
  int xDir;
  int yDir;
  Random random;
  
  Person(this.maxSuspisionLevel, this.x, this.y, this.maxX, this.maxY)
  {
    suspisionLevel = 0;
    random = new Random();
    SetDirection();
  }
  
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
    xDir = random.nextInt(5);
    yDir = random.nextInt(5);
    
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
    if (random.nextDouble() < 0.01)
    {
      // change direction once per 100 frame
      SetDirection();
    }
    
    Move();
  }
}