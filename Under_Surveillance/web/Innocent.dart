part of UnderSurveillance;

class Innocent extends Person {
  Innocent(id, maxSuspisionLevel, x, y, maxX, maxY)
  {
    this.Id = id;
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