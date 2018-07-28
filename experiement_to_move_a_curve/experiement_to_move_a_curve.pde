int aX, aY, bX, bY, ctrlaX, ctrlaY, ctrlbX, ctrlbY, changingFactor, distanceMousePoint, distancePointMouse; 
float distFromA, distFromB; 
boolean lockedPoint; 

void setup(){
  size(600, 400); 
  
  //create shape
  aX = ctrlaX = 100; 
  aY = ctrlaY = bY = ctrlbY = 170;
  bX = ctrlbX = 400; 
  changingFactor = 10; 
}

void draw(){
  
  stroke(255); 
  noFill();
  background(0); 
  strokeWeight(7); 
 
  
  point(ctrlaX, ctrlaY); 
  point(aX, aY);
  point(bX, bY);
  point(ctrlbX, ctrlbY);
 
  beginShape(); 
  strokeWeight(1);
  
//if the mouse is pressed, check in what direction it is going
//then check the nearest point from the mouse
//this point is then affected by the movement of the mouse
  if(mousePressed){
   println("MouseX: ", mouseX, "MouseY: ", mouseY, "aX = ", aX, "aY = ", aY);
    if(approxClickPoint() > 0){
     // println("You are clicking on the point"); 
      changePoint(approxClickPoint());   
    }else{
      if(lockedPoint == false){
        changeCurve(); 
      }
    }
  }
  
  drawVertex(); 
  endShape(); 
}

void mouseReleased(){
  lockedPoint = false; 
}

int approxClickPoint()
{
  if( inRange(mouseX, aX) && inRange(mouseY, aY)){
    return 1; 
  }else if (inRange(mouseX, bX) && inRange(mouseY, bY)){
    return 2; 
  }else{
    println("Noteu trou");
    return 0; 
  }
}

boolean inRange(int mouse, int point){
  distanceMousePoint = mouse - point; 
  distancePointMouse = point - mouse;
  if(distanceMousePoint < 5 && distanceMousePoint > - 5){
    return true; 
  }else if (distancePointMouse < 5 && distancePointMouse > -5){
    return true;
  }else{
    return false; 
  }
}
