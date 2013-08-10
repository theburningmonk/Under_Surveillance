part of UnderSurveillance;

class Criminal extends Person {
  Criminal(x, y, maxX, maxY)
  {
    this.x = x;
    this.y = y;
    this.maxX = maxX;
    this.maxY = maxY;
    this.maxSuspisionLevel = 100.0;
    
    SetDirection();
    Init(Color.Red);
  }
  
  void OnMouseClick(evt) {
    _selectedController.add(this);
  }
}