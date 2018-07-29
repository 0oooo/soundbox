void drawPoints(){
  point(ctrlaX, ctrlaY); 
  point(aX, aY);
  point(bX, bY);
  point(ctrlbX, ctrlbY);
}

void drawVertex(){  
  curveVertex(ctrlaX, ctrlaY);
  curveVertex(aX, aY);
  curveVertex(bX, bY);
  curveVertex(ctrlbX, ctrlbY);
}
