void randomCircle(){
    //Creation of the circle
  s = createShape(); 
  s.beginShape(); 
  s.fill(102);
  s.stroke(255);
  s.strokeWeight(2);

  for (int angle = 0; angle <= 460; angle +=  36) { 
    float aX = cos(radians(angle)) * random(70, 130) + width/2;
    float aY = sin(radians(angle)) * random(70, 130) + height/2;
    s.curveVertex(aX, aY); 
  }
  s.endShape(CLOSE); 

}


int pixelCount(){
  int i, j; 
  int totalOfPixel = 0; 
  for(i = 0; i < width; i++ ){
    for (j = 0; j< height; j++){
      if(get(i, j) != BLACK){
        totalOfPixel += 1; 
      }
    }
  }
  //println("Total of grey pixels: ", totalOfPixel);
  return totalOfPixel; 
}
