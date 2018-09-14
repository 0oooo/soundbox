PShape randomCircle(float newWidth, float newHeight, int xoffset, int yoffset, PShape ps){
    //Creation of the circle
  ps = createShape(); 
  ps.beginShape(); 
  ps.fill(102);
  ps.stroke(255);
  ps.strokeWeight(2);

  for (int angle = 0; angle <= 400; angle +=  40) { 
                                            //20 60
    float aX = cos(radians(angle)) * random(20, 60) + newWidth/2 + xoffset;
    float aY = sin(radians(angle)) * random(20, 60) + newHeight/2 + yoffset;
    ps.curveVertex(aX, aY); 
  }
  ps.endShape(CLOSE); 
  return ps; 
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
