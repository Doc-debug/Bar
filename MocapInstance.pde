class MocapInstance {   
  Mocap mocap;
  int currentFrame, firstFrame, lastFrame, startingFrame;
  float[] translation;
  float scl, strkWgt;
  color clr;
  int speed = 10; // frames skipped per iteration
 
  MocapInstance (Mocap mocap1, int startingFrame, float[] transl, float scl1, color clr1, float strkWgt1) {
    mocap = mocap1;
    currentFrame = startingFrame;
    this.startingFrame = startingFrame;
    firstFrame = startingFrame;
    lastFrame = startingFrame-1;   
    translation = transl;
    scl = scl1;
    clr = clr1;
    strkWgt = strkWgt1;
  }
 
  void drawMocap() {
    pushMatrix();
    //stroke(clr);
    noStroke();
    strokeWeight(strkWgt);
    translate(translation[0], translation[1], translation[2]);
    scale(scl);

    for (int i = 0; i < mocap.joints.size(); ++i) {
      Joint itJ = mocap.joints.get(i);

      line(itJ.position.get(currentFrame).x,
           itJ.position.get(currentFrame).y,
           itJ.position.get(currentFrame).z,
           itJ.parent.position.get(currentFrame).x,
           itJ.parent.position.get(currentFrame).y,
           itJ.parent.position.get(currentFrame).z);

      pushMatrix();
      pushStyle();
        colorMode(HSB, 255);
        // noStroke();
        strokeWeight(1);
        fill(0);

        PVector p1 = itJ.position.get(currentFrame);
        PVector p2 = itJ.parent.position.get(currentFrame);
        PVector p3 = itJ.parent.parent != null ? itJ.parent.parent.position.get(currentFrame) : null;
        float distance = dist(p1.x, p1.y, p2.x, p2.y);

        alignToVector(new PVector(1, 0, 0), p1, p2);

        float limbSize = 80; 
        PVector bodySize = new PVector(distance, 200, 150);

        if(i <= 3) { // body
          fill(0, 255, 0);
          box(bodySize.x, bodySize.y, bodySize.z);
        } else if(i <= 4){ // neck
          box(distance + 15, limbSize - 30, limbSize - 30);
        } else if(i <= 5) { // head
          sphere(distance / 2 +20);
        } else if(i <= 15) { // arms
          box(distance, limbSize, limbSize);
        } else if(i <= 25) { // legs
          box(distance, limbSize, limbSize);
        } else { // other data ??
          box(distance, limbSize, limbSize);
        }

      popStyle();
      popMatrix();
      
      //Joints
      pushMatrix();
      fill(0);
      translate(p1.x, p1.y, p1.z);
      float jointSize = 50;
      
      if(i<1){ // hips
        sphere(jointSize * 2);
      } else if(i <= 2){ // body
        sphere(bodySize.y / 2);
      } else if(i <= 4){ // neck
        sphere(jointSize - 10);
      } else if(i <= 5){ // head
        //sphere(0);
      } else if(i <= 6){ // left shoulder
        sphere(jointSize + 30);
      } else if(i <= 8){ // left elbow
        sphere(jointSize + 10);
      } else if(i <= 9 ){ // left wrist
        sphere(jointSize);
      } else if(i <= 10){ // left hand
        //sphere(0); 
      } else if(i <= 11){ //right shoulder
        sphere(jointSize + 30);
      } else if(i <= 13){ // right elbow
        sphere(jointSize + 10);
      } else if(i <= 14 ){ // right wrist
        sphere(jointSize);
      } else if(i <= 15){ // right hand
        //sphere(0); 
      } else if(i <= 16){ // left leg
        sphere(jointSize);
      } else if(i <= 17){ // left knee
        sphere(jointSize + 5);
      } else if(i <= 19){ // left leg
        sphere(jointSize);
      } else if(i <= 20){
        //sphere(0); 
      } else if(i <= 21){ // right leg
        sphere(jointSize);
      } else if(i <= 22){ // right knee
        sphere(jointSize + 5);
      } else if(i <= 24){ // right leg
        sphere(jointSize); 
      }
      
     
      popMatrix();
    }
    
    popMatrix();
    // freeze when animation is over
    // currentFrame = currentFrame + 2 >= mocap.frameNumber ? currentFrame : currentFrame + 2;

    // restart animation when over
    currentFrame = (currentFrame+speed) % (mocap.frameNumber);
    if (currentFrame<=lastFrame) currentFrame = firstFrame; 
  }

  PVector calcMidPoint(PVector p1, PVector p2) {
      return new PVector((p1.x + p2.x) / 2, (p1.y + p2.y) / 2, (p1.z + p2.z) / 2);
  }

  void alignToVector(PVector initialDirection, PVector p1, PVector p2) {

    PVector midPoint = p1.copy().add(p2).mult(0.5);
    PVector newDirection = p2.copy().sub(p1).normalize(); 
    PVector rotationAxis = initialDirection.cross(newDirection).normalize();
    float rotationAngle = acos(initialDirection.dot(newDirection));

    translate(midPoint.x, midPoint.y, midPoint.z);

    Rotate(rotationAngle, rotationAxis.x, rotationAxis.y, rotationAxis.z);
  }

  void Rotate(float angle, float x, float y, float z) {
      float c = cos(angle);
      float s = sin(angle);
      applyMatrix(
          x*x*(1.0f-c)+c,   x*y*(1.0f-c)-z*s, x*z*(1.0f-c)+y*s, 0.0f,
          y*x*(1.0f-c)+z*s, y*y*(1.0f-c)+c,   y*z*(1.0f-c)-x*s, 0.0f,
          z*x*(1.0f-c)-y*s, z*y*(1.0f-c)+x*s, z*z*(1.0f-c)+c,   0.0f,
          0.0f,             0.0f,             0.0f,             1.0f );
  }

  void restart() {
    currentFrame = startingFrame;
  }

  boolean isOver() {
    return currentFrame + speed >= mocap.frameNumber;
  }

  int getFrame() {
    return currentFrame;
  }

}