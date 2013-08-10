part of UnderSurveillance;

class Criminal extends Person {
  Criminal(x, y, maxX, maxY)
  {
    this.x = x;
    this.y = y;
    this.maxX = maxX;
    this.maxY = maxY;
    
    SetDirection();
    Init(Color.Red);
  }
  
  void OnMouseClick(evt) {
    print("Criminal is clicked");
  }
}