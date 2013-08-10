part of UnderSurveillance;

class Criminal extends Person {
  Criminal(id, x, y, maxX, maxY)
  {
    this.Id = id;
    this.x = x;
    this.y = y;
    this.maxX = maxX;
    this.maxY = maxY;
    this.maxSuspisionLevel = 100.0;
    
    SetDirection();
    Init(Color.Green);
  }
  
  void OnMouseClick(evt) {
    _selectedController.add(this);
  }
}