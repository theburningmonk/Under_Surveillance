part of UnderSurveillance;

class Innocent extends Person {
  Innocent(maxSuspisionLevel, x, y, maxX, maxY)
  {
    this.x = x;    
    this.maxX = maxX;
    this.y = y;
    this.maxY = maxY;
    this.maxSuspisionLevel = maxSuspisionLevel;
    
    SetDirection();
    Init(Color.Green);
  }
  
  void OnMouseClick(evt) {
    _selectedController.add(this);
  }
}