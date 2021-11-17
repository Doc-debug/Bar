public class BodyRig {

    int complexity = 10; // sides

    float bodyWidth;
    float bodyDepth;

    float headWidthRatio = 0.3;
    float headDepthRatio = 1;
    float trunkWidthRatio = 1;
    float trunkDepthRatio = 0.4;
    float legWidthRatio = 0.5; // thickness
    float armWidthRatio = 0.2;

    float headWidth;
    float headDepth;
    float trunkWidth;
    float trunkDepth;
    float legWidth;
    float armWidth;

    PVector headVector = new PVector(0, 0, 0);

    PVector shoulderLeftVector = new PVector(0, 0, 0);
    PVector shoulderRightVector = new PVector(0, 0, 0);
    PVector elbowLeftVector = new PVector(0, 0, 0);
    PVector elbowRightVector = new PVector(0, 0, 0);
    PVector handLeftVector = new PVector(0, 0, 0);
    PVector handRightVector = new PVector(0, 0, 0);

    PVector legLeftVector = new PVector(0, 0, 0);  // the attach point of the leg
    PVector legRightVector = new PVector(0, 0, 0);  // the attach point of the leg
    PVector kneeLeftVector = new PVector(0, 0, 0);
    PVector kneeRightVector = new PVector(0, 0, 0);
    PVector footLeftVector = new PVector(0, 0, 0);
    PVector footRightVector = new PVector(0, 0, 0);

    Cylinder upperArmLeft;
    Cylinder upperArmRight;
    Cylinder lowerArmLeft;
    Cylinder lowerArmRight;

    Cylinder upperLegLeft;
    Cylinder upperLegRight;
    Cylinder lowerLegLeft;
    Cylinder lowerLegRight;
    

    // public BodyRig(float bodyWidth, float bodyDepth, PVector[] points) {
    //     this.footLeftVector       = points[0];
    //     this.footRightVector      = points[1];
    //     this.kneeLeftVector       = points[2];
    //     this.kneeRightVector      = points[3];
    //     this.legLeftVector        = points[4];
    //     this.legRightVector       = points[5];
    //     this.shoulderLeftVector   = points[6];
    //     this.shoulderRightVector  = points[7];
    //     this.elbowLeftVector      = points[8];
    //     this.elbowRightVector     = points[9];
    //     this.handLeftVector       = points[10];
    //     this.handRightVector      = points[11];
    //     this.headVector           = points[12];
    //     updateProportions(bodyWidth, bodyDepth);
    //     initObjects();
    // }

    public BodyRig(float bodyWidth, float bodyDepth, PVector shoulderLeftVector, PVector elbowLeftVector, PVector handLeftVector, 
                                                     PVector shoulderRightVector, PVector elbowRightVector, PVector handRightVector,
                                                     PVector legLeftVector, PVector kneeLeftVector, PVector footLeftVector,
                                                     PVector legRightVector, PVector kneeRightVector, PVector footRightVector) {
        this.shoulderLeftVector   = shoulderLeftVector;
        this.elbowLeftVector   = elbowLeftVector;
        this.handLeftVector    = handLeftVector;
        this.shoulderRightVector = shoulderRightVector;
        this.elbowRightVector = elbowRightVector;
        this.handRightVector = handRightVector;

        this.legLeftVector = legLeftVector;
        this.kneeLeftVector = kneeLeftVector;
        this.footLeftVector = footLeftVector;
        this.legRightVector = legRightVector;
        this.kneeRightVector = kneeRightVector;
        this.footRightVector = footRightVector;

        updateProportions(bodyWidth, bodyDepth);
        initObjects();
    }

    private void updateProportions(float bodyWidth, float bodyDepth) {
        this.bodyWidth  = bodyWidth;
        this.bodyDepth  = bodyDepth;

        this.headWidth  = headWidthRatio    * bodyWidth;
        this.headDepth  = headDepthRatio    * bodyDepth;
        this.trunkWidth = trunkWidthRatio   * bodyWidth;
        this.trunkDepth = trunkDepthRatio   * bodyDepth;
        this.legWidth   = legWidthRatio     * bodyWidth;
        this.armWidth   = armWidthRatio     * bodyWidth;
    }

    private void initObjects() {
        float upperArmLeftLen   = dist(shoulderLeftVector.x, shoulderLeftVector.y, shoulderLeftVector.z, elbowLeftVector.x, elbowLeftVector.y, elbowLeftVector.z);
        this.upperArmLeft       = new Cylinder(complexity, armWidth / 2, armWidth / 2, upperArmLeftLen);
        float upperArmRightLen  = dist(shoulderRightVector.x, shoulderRightVector.y, shoulderRightVector.z, elbowRightVector.x, elbowRightVector.y, elbowRightVector.z);
        this.upperArmRight      = new Cylinder(complexity, armWidth / 2, armWidth / 2, upperArmRightLen);
        float lowerArmLeftLen   = dist(elbowLeftVector.x, elbowLeftVector.y, elbowLeftVector.z, handLeftVector.x, handLeftVector.y, handLeftVector.z);
        this.lowerArmLeft       = new Cylinder(complexity, armWidth / 2, armWidth / 2, lowerArmLeftLen);
        float lowerArmRightLen  = dist(elbowRightVector.x, elbowRightVector.y, elbowRightVector.z, handRightVector.x, handRightVector.y, handRightVector.z);
        this.lowerArmRight      = new Cylinder(complexity, armWidth / 2, armWidth / 2, lowerArmRightLen);

        float upperLegLeftLen   = dist(legLeftVector.x, legLeftVector.y, legLeftVector.z, kneeLeftVector.x, kneeLeftVector.y, kneeLeftVector.z);
        this.upperLegLeft       = new Cylinder(complexity, legWidth / 2, legWidth / 2, upperLegLeftLen);
        float upperLegRightLen  = dist(legRightVector.x, legRightVector.y, legRightVector.z, kneeRightVector.x, kneeRightVector.y, kneeRightVector.z);
        this.upperLegRight      = new Cylinder(complexity, legWidth / 2, legWidth / 2, upperLegRightLen);
        float lowerLegLeftLen   = dist(kneeLeftVector.x, kneeLeftVector.y, kneeLeftVector.z, footLeftVector.x, footLeftVector.y, footLeftVector.z);
        this.lowerLegLeft       = new Cylinder(complexity, legWidth / 2, legWidth / 2, lowerLegLeftLen);
        float lowerLegRightLen  = dist(kneeRightVector.x, kneeRightVector.y, kneeRightVector.z, footRightVector.x, footRightVector.y, footRightVector.z);
        this.lowerLegRight      = new Cylinder(complexity, legWidth / 2, legWidth / 2, lowerLegRightLen);
    }

    void draw() {
        buildLimb(shoulderLeftVector, elbowLeftVector, handLeftVector, upperArmLeft, lowerArmLeft); // arm left
        buildLimb(shoulderRightVector, elbowRightVector, handRightVector, upperArmRight, lowerArmRight); // arm right
        buildLimb(legLeftVector, kneeLeftVector, footLeftVector, upperLegLeft, lowerLegLeft); // leg left
        buildLimb(legRightVector, kneeRightVector, footRightVector, upperLegRight, lowerLegRight); // leg right
    }

    void updateData() {

    }

    void buildLimb(PVector top, PVector mid, PVector bot, Cylinder upper, Cylinder lower) {
        testSphere(top);
        testSphere(mid);
        testSphere(bot);

        pushMatrix();
        pushStyle();
            emissive(0, 255, 0);
            PVector upperMid = calcMidPoint(top, mid);
            PVector rotationUpper = calcRotation(top, mid);
            translate(upperMid.x, upperMid.y, upperMid.z);
            // rotateX(-rotationUpper.x);
            rotateZ(-rotationUpper.z);
            // rotateY(-rotationUpper.y);
            upper.draw();
        popStyle();
        popMatrix();
        pushMatrix();
        pushStyle();
            emissive(255, 0, 0);
            PVector lowerMid = calcMidPoint(mid, bot);
            PVector rotationLower = calcRotation(mid, bot);
            translate(lowerMid.x, lowerMid.y, lowerMid.z);
            rotateX(-rotationLower.x);
            // rotateY(-rotationLower.y);
            // rotateZ(-rotationLower.z);
            lower.draw();
        popStyle();
        popMatrix();
    }

    void testSphere(PVector pos) {
        pushMatrix();
            translate(pos.x, pos.y, pos.z);
            sphere(5);
        popMatrix();
    }

    void buildLeg(PVector leg, PVector knee, PVector foot) {
        
    }

    PVector calcMidPoint(PVector p1, PVector p2) {
        return new PVector((p1.x + p2.x) / 2, (p1.y + p2.y) / 2, (p1.z + p2.z) / 2);
    }

    PVector calcRotation(PVector p1, PVector p2) {
        float x = ((p2.z - p1.z) / (p2.y - p1.y));
        float y = ((p2.z - p1.z) / (p2.x - p1.x));
        float z = ((p2.x - p1.x) / (p2.y - p1.y));

        return new PVector(x, y, z);
    }

}
