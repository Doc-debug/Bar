/**
* Draws Mocap data with skinning
*
* Created by Sofia Martinez, Jan Naubert, Patrick Neumann on 22.10.2021
* Modified from files provided in class
*/
class MocapInstance {   
  Mocap mocap;
  int currentFrame, firstFrame, lastFrame, startingFrame;
  float[] translation;
  float scl, strkWgt;
  color clr;
  int speed = 10; // frames skipped per iteration
  int playMode; // behavior after a end of data is reached, 0=start from beginning, 1=reverse, 2=stop

  MocapInstance (Mocap mocap1, int startingFrame, float[] transl, float scl1, color clr1, float strkWgt1) {
    this(mocap1, startingFrame, transl, scl1, clr1, strkWgt1, 0);
  }
 
  MocapInstance (Mocap mocap1, int startingFrame, float[] transl, float scl1, color clr1, float strkWgt1, int playMode) {
    mocap = mocap1;
    currentFrame = startingFrame;
    this.startingFrame = startingFrame;
    firstFrame = startingFrame;
    lastFrame = mocap.frameNumber;   
    translation = transl;
    scl = scl1;
    clr = clr1;
    strkWgt = strkWgt1;
    this.playMode = playMode;
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
        //colorMode(HSB, 255);
        // noStroke();
        strokeWeight(1);
        fill(255);

        PVector p1 = itJ.position.get(currentFrame);
        PVector p2 = itJ.parent.position.get(currentFrame);
        PVector p3 = itJ.parent.parent != null ? itJ.parent.parent.position.get(currentFrame) : null;
        float distance = dist(p1.x, p1.y, p2.x, p2.y);

        alignToVector(new PVector(1, 0, 0), p1, p2);

        float limbSize = 80; 
        PVector bodySize = new PVector(distance, 200, 150);

        if(i <= 3) { // body
          fill(255, 255, 255);
          box(bodySize.x, bodySize.y, bodySize.z);
        } else if(i <= 4){ // neck
          fill(255, 205, 128);
          box(distance + 15, limbSize - 30, limbSize - 30);
        } else if(i <= 5) { // head
          fill(255, 205, 128);
          sphere(distance / 2 +20);
        } else if(i <= 15) { // arms
          fill(255, 205, 128);
          box(distance, limbSize, limbSize);
        } else if(i <= 25) { // legs
          fill(22, 22, 102);
          box(distance, limbSize, limbSize);
        } else { // other data ??
          box(distance, limbSize, limbSize);
        }

      popMatrix();
      
      //Joints
      pushMatrix();
      translate(p1.x, p1.y, p1.z);
      float jointSize = 50;
      
      if(i<1){ // hips
        fill(22, 22, 102);
        sphere(jointSize * 2);
      } else if(i <= 2){ // body
        fill(255, 255, 255);
        sphere(bodySize.y / 2);
      } else if(i <= 4){ // neck
        sphere(jointSize - 10);
      } else if(i <= 5){ // head
        //sphere(0);
      } else if(i <= 6){ // left shoulder
        fill(255, 255, 255);
        sphere(jointSize + 30);
      } else if(i <= 7){ // left shoulder
        fill(255, 255, 255);
        sphere(jointSize + 10);
      } else if(i <= 8){ // left elbow
        sphere(jointSize + 10);
      } else if(i <= 9 ){ // left wrist
        sphere(jointSize);
      } else if(i <= 10){ // left hand
        //sphere(0); 
      } else if(i <= 11){ //right shoulder
        fill(255, 255, 255);
        sphere(jointSize + 30);
      } else if(i <= 12){ // right shoulder
        fill(255, 255, 255);
        sphere(jointSize + 10);
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
      popStyle();
    }
    
    popMatrix();

    // handle frame progression
    if(playMode == 0) {
      currentFrame = (currentFrame+speed) % (mocap.frameNumber); // restart animation when over
      if (currentFrame >= lastFrame * 2) currentFrame = lastFrame; // to prevent integer overflow
    } else if(playMode == 1) {
      if(currentFrame + speed > lastFrame || currentFrame + speed < firstFrame) speed = -speed;
      currentFrame = (currentFrame+speed) % (mocap.frameNumber); // restart animation when over
    } else if(playMode == 2) {
      // freeze when animation is over
      currentFrame = currentFrame + speed >= lastFrame ? currentFrame : currentFrame + speed;
    }

  }

  /**
  * returns a vector that is between the two given vectors
  */
  PVector calcMidPoint(PVector p1, PVector p2) {
      return p1.copy().add(p2).mult(0.5);
  }

  /**
  * rotates on the Z axis of a given limb
  */
  void setLimbRotation(int limb, PVector initialDirection) {
    Joint joint = mocap.joints.get(limb);
    PVector p1 = joint.position.get(currentFrame);
    PVector p2 = joint.parent.position.get(currentFrame);

    PVector midPoint = p1.copy().add(p2).mult(0.5);
    PVector newDirection = p2.copy().sub(p1).normalize(); 
    PVector rotationAxis = initialDirection.cross(newDirection).normalize();
    float rotationAngle = acos(initialDirection.dot(newDirection));

    rotateZ(rotationAngle * rotationAxis.z);
  }

  /**
  * aligns rotation to two given vectors
  */
  void alignToVector(PVector initialDirection, PVector p1, PVector p2) {

    PVector midPoint = calcMidPoint(p1, p2);
    PVector newDirection = p2.copy().sub(p1).normalize(); 
    PVector rotationAxis = initialDirection.cross(newDirection).normalize();
    float rotationAngle = acos(initialDirection.dot(newDirection));

    translate(midPoint.x, midPoint.y, midPoint.z);

    Rotate(rotationAngle, rotationAxis.x, rotationAxis.y, rotationAxis.z);
  }

  /**
  * rotates to specified axises
  */
  void Rotate(float angle, float x, float y, float z) {
      float c = cos(angle);
      float s = sin(angle);
      applyMatrix( // rotation matrix
          x*x*(1.0f-c)+c,   x*y*(1.0f-c)-z*s, x*z*(1.0f-c)+y*s, 0.0f,
          y*x*(1.0f-c)+z*s, y*y*(1.0f-c)+c,   y*z*(1.0f-c)-x*s, 0.0f,
          z*x*(1.0f-c)-y*s, z*y*(1.0f-c)+x*s, z*z*(1.0f-c)+c,   0.0f,
          0.0f,             0.0f,             0.0f,             1.0f );
  }

  /**
  * sets the current frame to the starting frame
  */
  void restart() {
    currentFrame = startingFrame;
    speed = abs(speed);
  }

  /**
  * returns if the mocap data is over
  */
  boolean isOver() {
    return currentFrame + speed >= lastFrame;
  }

  /**
  * returns the current frame
  */
  int getFrame() {
    return currentFrame;
  }

}
