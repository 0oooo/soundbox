void randomCircle(){

    //Creation of the circle
  s = createShape(); 
  s.beginShape(); 
  s.fill(102);
  s.stroke(255);
  s.strokeWeight(2);

  for (int angle = 0; angle <= 360; angle +=  36) { 
    float aX = cos(radians(angle)) * random(70, 130) + width/2;
    float aY = sin(radians(angle)) * random(70, 130) + height/2;
    s.curveVertex(aX, aY); 
  }
  s.endShape(CLOSE); 

}
