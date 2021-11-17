class MocapInstance {   
  Mocap mocap;
  int currentFrame, firstFrame, lastFrame, startingFrame;
  float[] translation;
  float scl, strkWgt;
  color clr;
 
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
    stroke(clr);
    strokeWeight(strkWgt);
    translate(translation[0], translation[1], translation[2]);
    scale(scl);

    for(Joint itJ : mocap.joints) {
      line(itJ.position.get(currentFrame).x,
           itJ.position.get(currentFrame).y,
           itJ.position.get(currentFrame).z,
           itJ.parent.position.get(currentFrame).x,
           itJ.parent.position.get(currentFrame).y,
           itJ.parent.position.get(currentFrame).z);
      pushMatrix();
        PVector p1 = itJ.position.get(currentFrame);
        PVector p2 = itJ.parent.position.get(currentFrame);
        float distance = dist(p1.x, p1.y, p2.x, p2.y);

        alignToVector(new PVector(1, 0, 0), p1, p2);

        float boxSize = 30;
        box(distance, boxSize, boxSize);
      popMatrix();
    }
    popMatrix();
    // freeze when animation is over
    currentFrame = currentFrame + 2 >= mocap.frameNumber ? currentFrame : currentFrame + 2;

    // restart animation when over
    // currentFrame = (currentFrame+1) % (mocap.frameNumber);
    // if (currentFrame==lastFrame+1) currentFrame = firstFrame; 
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
    return currentFrame + 1 >= mocap.frameNumber;
  }

  int getFrame() {
    return currentFrame;
  }

}