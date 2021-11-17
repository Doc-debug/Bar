import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.opengl.*; 
import peasy.*; 
import java.util.Arrays; 
import java.util.Arrays; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Bar extends PApplet {




PeasyCam camera;

BarScene scene;
BarAnimations animation;

public void setup() {
    
    camera = new PeasyCam(this, 300);
    frameRate(60);
    randomSeed(1);
    
    scene = new BarScene();
    animation = new BarAnimations();

}

public void draw() {
    background(125);
    defaultStyle();
    
    translate(0, 0, -500);
    scene.draw();
    animation.draw();
}

public void defaultStyle() {
    noStroke();
    ambientLight(102, 102, 102);
    ambient(51, 26, 0);
    lightSpecular(204, 204, 204);
    specular(255);
}
public class BarAnimations {

    MocapInstance walkInMocapInst;
    MocapInstance barKeeperMocapInst;
    MocapInstance personSittingRightMocapInst;
    MocapInstance personSittingLeftMocapInst;

    float mocapScale = -0.1f;
    float heightOffset = 200;
    float strokeThickness = 50;
    int strokeColor = color(255, 255, 0);

    float[] walkInOffset =              new float[] {-170, heightOffset, 50};
    float[] barKeeperOffset =           new float[] { 100, heightOffset, 20};
    float[] personSittingRightOffset =  new float[] {-350, heightOffset, -200};
    float[] personSittingLeftOffset =   new float[] {-200, heightOffset, -200};

    int walkInTimeOffset =                0;
    int barKeeperTimeOffset =             2000;
    int personSittingRightTimeOffset =    1700;
    int personSittingLeftTimeOffset =     1700;


    public BarAnimations () {
        Mocap walkInMocap = new Mocap("mocap_data/person_walking_in.bvh");
        Mocap barKeeperMocap = new Mocap("mocap_data/barkeeper.bvh");
        Mocap personSittingRightMocap = new Mocap("mocap_data/person_sitting_right.bvh");
        Mocap personSittingLeftMocap = new Mocap("mocap_data/person_sitting_left.bvh");

        walkInMocapInst =               new MocapInstance(walkInMocap, walkInTimeOffset, walkInOffset, mocapScale, strokeColor, strokeThickness);
        barKeeperMocapInst =            new MocapInstance(barKeeperMocap, barKeeperTimeOffset, barKeeperOffset, mocapScale, strokeColor, strokeThickness);
        personSittingRightMocapInst =   new MocapInstance(personSittingRightMocap, personSittingRightTimeOffset, personSittingRightOffset, mocapScale, strokeColor, strokeThickness);
        personSittingLeftMocapInst =    new MocapInstance(personSittingLeftMocap, personSittingLeftTimeOffset, personSittingLeftOffset, mocapScale, strokeColor, strokeThickness);
    }

    public void draw() {
        pushMatrix();
            rotateY(PI / 2);
            walkInMocapInst.drawMocap();
            barKeeperMocapInst.drawMocap();
            personSittingRightMocapInst.drawMocap();
            personSittingLeftMocapInst.drawMocap();
        popMatrix();

        restart();
    }

    public void restart() {
        if(walkInMocapInst.isOver()) {
            walkInMocapInst.restart();
            barKeeperMocapInst.restart();
            personSittingRightMocapInst.restart();
            personSittingLeftMocapInst.restart();
        }
    }

}
public class BarScene {
    Wall wallRight = new Wall(1, 1000, 1000);
    Wall wallLeft = new Wall(1000, 1000, 1);
    Wall floor = new Wall(1000, 1, 1000);

    Shelf shelf = new Shelf(600, 300, 100);

    BarTable tableMain = new BarTable(600, 100, 50);
    BarTable tableShort = new BarTable(150, 100, 50, false, true);

    RoundTable roundTable = new RoundTable(60, 80);
    Stool stoolRight = new Stool(50, 15);
    Stool stoolLeft = new Stool(50, 15);

    DrawArray stools = new DrawArray(createStools(5, 80), 2, 0, 0, true, 0.2f);

    DrawArray glasses = new DrawArray(createGlasses(4, 5), 10, 0, 0, true, 1.2f);

    Bottle bottle = new Bottle(40);

    BodyRig testBody = new BodyRig(10, 50, new PVector(-50, 0, 0),  new PVector(-50, 50, -50), new PVector(-50, 100, 0), 
                                        new PVector(50, 0, 0),   new PVector(50, 50, -50),  new PVector(50, 100, 0),
                                        new PVector(-15, 80, 0), new PVector(-15, 130, 30), new PVector(-15, 180, 0),
                                        new PVector(15, 80, 0),  new PVector(15, 130, 30),  new PVector(15, 180, 0));


    public BarScene () {
        
    }

    public void draw() {
        pushMatrix();

        pushMatrix();
            translate(0, -100, -100);
        popMatrix();
        
        translate(0, 200, 0); // move everything a little lower :)
        
        // light
        pushMatrix();
            pointLight(255, 255, 255, -610, -1460, 1200);
        popMatrix();

        float shelfDist = -tableShort.getW() * 1.5f;
        // set floor
        pushMatrix();
        translate(-wallRight.getD() / 2 + tableMain.getW() / 2, 0, wallRight.getD() / 2 + shelfDist - shelf.getD() / 2);
            floor.draw();
        popMatrix();

        // wall right
        pushMatrix();
            translate(tableMain.getW() / 2, -wallRight.getH() / 2, wallRight.getD() / 2 + shelfDist - shelf.getD() / 2);
            wallRight.draw();
        popMatrix();

        // wall left
        pushMatrix();
            translate(-wallRight.getD() / 2 + tableMain.getW() / 2, -wallRight.getH() / 2, shelfDist - shelf.getD() / 2);
            wallLeft.draw();
        popMatrix();

        // set shelf
        pushMatrix();
            translate(0, -shelf.getH() / 2, shelfDist);
            shelf.draw();
        popMatrix();

        // set table
        pushMatrix();
            translate(0, -tableMain.getH() / 2, 0);
            tableMain.draw();
            translate(-tableMain.getW() / 2 - tableShort.getD() / 2, 0, -tableShort.getW() / 2 + tableMain.getD() / 2);
            rotateY(-PI / 2);
            tableShort.draw();
        popMatrix();

        // fill table
        pushMatrix();
            DrawableObject glass = glasses.getArray()[0];
            translate(0, -tableMain.getH() - glass.getH() / 2, 0);
            glasses.draw();
            translate(0, glass.getH() / 2 - bottle.getH() / 2, 0);
            bottle.draw();
        popMatrix();

        // set stools
        pushMatrix();
            DrawableObject stool = stools.getArray()[0];
            translate(0, -stool.getH() / 2, stool.getD() * 1.5f);
            stools.draw();
        popMatrix();

        // round table where the two people are sitting
        pushMatrix();
            translate(-200, -roundTable.getH(), 300 - 15);
            roundTable.draw();

            float chairDist = 80;
            translate(0, roundTable.getH() - stoolRight.getH() / 2, -chairDist);
            stoolRight.draw();
            translate(0, 0, chairDist * 2);
            stoolLeft.draw();

        popMatrix();

        popMatrix();
    }

    public Stool[] createStools(int n, float stoolHeight) {
        Stool[] stools = new Stool[n];
        for (int i = 0; i < n; ++i) {
            stools[i] = new Stool(stoolHeight);
        }
        return stools;
    }

    public Glass[] createGlasses(int n, float radius) {
        Glass[] glasses = new Glass[n];
        for (int i = 0; i < n; ++i) {
            glasses[i] = new Glass(radius);
        }
        return glasses;
    }

}
public class BarTable extends DrawableObject {

    float w;
    float h;
    float d;
    float offsetLeft;
    float offsetRight;
    float topRatio = 0.1f;
    float overhangRatio = 0.3f;

    public BarTable (float tableWidth, float tableHeight, float tableDepth) {
        this(tableWidth, tableHeight, tableDepth, false, false);
    }

    public BarTable (float tableWidth, float tableHeight, float tableDepth, boolean offsetLeft, boolean offsetRight) {
        this.w = tableWidth;
        this.h = tableHeight;
        this.d = tableDepth;
        this.offsetLeft = offsetLeft ? d * overhangRatio : 0;
        this.offsetRight = offsetRight ? d * overhangRatio : 0;
    }

    public void draw() {
        pushMatrix();
        pushStyle();
            setColorPlate();
            // top plate
            float offset = offsetRight / 2 - offsetLeft / 2;
            translate(0, -(h / 2) + h * topRatio / 2, 0);
            box(w, h * topRatio, d);
        popStyle();
        pushStyle();
            setColorFoot();
            // foot
            translate(-offset, h * topRatio / 2 + h * (1 - topRatio) / 2 , -d * overhangRatio / 2);
            box(w - offset * 2, h * (1 - topRatio), d * (1 - overhangRatio));
        popStyle();
        popMatrix();
    }

    public float getH() {
        return h;
    }

    public float getW() {
        return w;
    }

    public float getD() {
        return d;
    }

    private void setColorPlate() {
        fill(20);
        shininess(10);
    }

    private void setColorFoot() {
        fill(230);
        shininess(5);
    }

}
public class BodyRig {

    int complexity = 10; // sides

    float bodyWidth;
    float bodyDepth;

    float headWidthRatio = 0.3f;
    float headDepthRatio = 1;
    float trunkWidthRatio = 1;
    float trunkDepthRatio = 0.4f;
    float legWidthRatio = 0.5f; // thickness
    float armWidthRatio = 0.2f;

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

    public void draw() {
        buildLimb(shoulderLeftVector, elbowLeftVector, handLeftVector, upperArmLeft, lowerArmLeft); // arm left
        buildLimb(shoulderRightVector, elbowRightVector, handRightVector, upperArmRight, lowerArmRight); // arm right
        buildLimb(legLeftVector, kneeLeftVector, footLeftVector, upperLegLeft, lowerLegLeft); // leg left
        buildLimb(legRightVector, kneeRightVector, footRightVector, upperLegRight, lowerLegRight); // leg right
    }

    public void updateData() {

    }

    public void buildLimb(PVector top, PVector mid, PVector bot, Cylinder upper, Cylinder lower) {
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

    public void testSphere(PVector pos) {
        pushMatrix();
            translate(pos.x, pos.y, pos.z);
            sphere(5);
        popMatrix();
    }

    public void buildLeg(PVector leg, PVector knee, PVector foot) {
        
    }

    public PVector calcMidPoint(PVector p1, PVector p2) {
        return new PVector((p1.x + p2.x) / 2, (p1.y + p2.y) / 2, (p1.z + p2.z) / 2);
    }

    public PVector calcRotation(PVector p1, PVector p2) {
        float x = ((p2.z - p1.z) / (p2.y - p1.y));
        float y = ((p2.z - p1.z) / (p2.x - p1.x));
        float z = ((p2.x - p1.x) / (p2.y - p1.y));

        return new PVector(x, y, z);
    }

}
public class Bottle extends DrawableObject {

    float h;
    float r;
    int sides = 20;
    int transitionSteps = 20;

    float bodyRatio = 0.6f;
    float transitionRatio = 0.1f;
    float neckRatio = 0.3f;

    float minThick = 0.4f;

    float randomHue;

    public Bottle (float bottleHeight) {
        this(bottleHeight, bottleHeight * 0.15f);
    }

    public Bottle (float bottleHeight, float radius) {
        this.h = bottleHeight;
        this.r = radius;
        this.randomHue = random(100);
    }

    public void draw() {
        pushMatrix();
        pushStyle();
            setColorBottle();
            
            rotateZ(-PI / 2);
            pushMatrix();
                // start at bottom
                translate((-h) / 2, 0, 0);
                lid(r);
                translate(h * bodyRatio / 2, 0, 0);
                tube(r, r, h * bodyRatio);
            popMatrix();
            pushMatrix();
                // start transition
                translate(((-h) / 2) + (h * bodyRatio), 0, 0);

                float transitionStepSize = h * transitionRatio / transitionSteps;
                translate(-transitionStepSize / 2, 0, 0);
                for (int i = 0; i < transitionSteps; i++) {
                    translate(transitionStepSize, 0, 0);
                    float transR1 = transitionFunct(i);
                    float transR2 = transitionFunct(i+1);
                    // println("transitionFunct(0): "+transitionFunct(0));

                    tube(transR1, transR2, transitionStepSize);
                }

                // start neck
                translate(h * neckRatio / 2, 0, 0);
                tube(r * minThick, r * minThick, h * neckRatio);
                translate(h * neckRatio / 2, 0, 0);
                lid(r * minThick);
            popMatrix();
        popStyle();
        popMatrix();
    }

    private float transitionFunct(float x) {
        float start = 1;
        float end = 0;
        float steps = transitionSteps;
        float inverseThick = r * (1 - minThick);

        float subRatio = -(start / steps) * x + start + end;

        return r - inverseThick * (1 - subRatio);
    }

    private void tube(float r1, float r2, float h) {
        pushMatrix();
            rotateY(PI / 2);
            float angle = 360 / sides;
            float halfHeight = h / 2;

            // draw body
            beginShape(TRIANGLE_STRIP);
            for (int i = 0; i < sides + 1; i++) {
                float x1 = cos( radians( i * angle ) ) * r1;
                float y1 = sin( radians( i * angle ) ) * r1;
                float x2 = cos( radians( i * angle ) ) * r2;
                float y2 = sin( radians( i * angle ) ) * r2;
                vertex( x1, y1, -halfHeight);
                vertex( x2, y2, halfHeight);
            }
            endShape(CLOSE);
        popMatrix();
    }

    private void lid(float r) {
        pushMatrix();
            rotateY(PI / 2);
            float angle = 360 / sides;
            
            beginShape();
            for (int i = 0; i < sides; i++) {
                float x = cos( radians( i * angle ) ) * r;
                float y = sin( radians( i * angle ) ) * r;
                vertex( x, y, 0);
            }
            endShape(CLOSE);
        popMatrix();
    }

    public float getH() {
        return h;
    }

    public float getW() {
        return r * 2;
    }

    public float getD() {
        return r * 2;
    }

    private void setColorBottle() {
        colorMode(HSB, 100);
        fill(randomHue, 40, 100, 50);
        shininess(10.0f);
    }

}
// public class Curtain extends DrawableObject {
    
//     float w;
//     float h;
//     float d;
//     int u_ctrl_pts = 5;
//     int v_ctrl_pts = 5; 
//     float[] u_knots = { 0.0, 0.143, 0.286, 0.429, 0.571, 0.714, 0.857, 1.0 }; 
//     float[] v_knots = { 0.0, 0.167, 0.286, 0.429, 0.571, 0.714, 0.857, 1.0 };
//     float u_spacing;
//     float v_spacing; 
//     PVector[][] ctrl_pts;
    
//     public Curtain(float curtainWidth, float curtainHeight, float maxDepth) {
//         PVector[][] ctrl_pts = new PVector[u_ctrl_pts][v_ctrl_pts];
//         u_spacing = (curtainWidth / u_ctrl_pts);
//         v_spacing = (curtainWidth / v_ctrl_pts);
        
//         for (int i = 0; i < u_ctrl_pts; i++) { 
//             for (int j = 0; j < v_ctrl_pts; j++) { 
//                 ctrl_pts[i][j] = new PVector(u_spacing * i, random(0, maxDepth), -v_spacing * j); 
//             } 
//         } 
        
//         this.w = curtainWidth;
//         this.h = curtainHeight;
//         this.d = maxDepth;
//         this.ctrl_pts = ctrl_pts;
//     }
    
//     public Curtain(float curtainWidth, float curtainHeight, float maxDepth, PVector[][] control_points) {
//         this.w = curtainWidth;
//         this.h = curtainHeight;
//         this.d = maxDepth;
//         this.ctrl_pts = control_points;
//     }
    
//     public void draw() {
//         pushMatrix();
//         pushStyle();
//         curtainColor();
        
//         int u_deg = u_knots.length - u_ctrl_pts - 1;
//         int v_deg = v_knots.length - v_ctrl_pts - 1; 
//         // draw surface 
//         for (float u = u_knots[u_deg]; u <= u_knots[u_knots.length - u_deg - 1] - 0.01; u += 0.01) { 
//             beginShape(QUAD_STRIP); 
//             for (float v = v_knots[v_deg]; v <= v_knots[v_knots.length - v_deg - 1]; v += 0.01) { 
//                 PVector pt_uv = new PVector();
//                 PVector pt_u1v = new PVector(); // u plus 0.01 
//                 for (int i = 0; i < u_ctrl_pts; i++) { 
//                     for (int j = 0;j < v_ctrl_pts; j++) { 
//                         float basisv = basisn(v,j,v_deg,v_knots); float basisu = basisn(u,i,u_deg,u_knots); 
//                         float basisu1 = basisn(u + 0.01,i,u_deg,u_knots); 
//                         PVector pk = PVector.mult(ctrl_pts[i][j], basisu * basisv); 
//                         PVector pk1 = PVector.mult(ctrl_pts[i][j], basisu1 * basisv); 
//                         pt_uv.add(pk);
//                         pt_u1v.add(pk1);
//                     } 
//                 } 
//                 fill(255);
//                 noStroke(); //try without 'noStroke();' 
//                 vertex(pt_uv.x, pt_uv.y, pt_uv.z);
//                 vertex(pt_u1v.x, pt_u1v.y, pt_u1v.z); 
//             } 
//             endShape(); 
//         } 
        
//         popStyle();
//         popMatrix();
//     }
    
//     float basisn(float u, int k, int d, float[] knots) { 
//         if (d == 0) { 
//             return basis0(u,k,knots); 
//         } 
//         else{ 
//             float b1 = basisn(u,k,d - 1,knots) * (u - knots[k]) / (knots[k + d] - knots[k]); 
//             float b2 = basisn(u,k + 1,d - 1,knots) * (knots[k + d + 1] - u) / (knots[k + d + 1] - knots[k + 1]); 
//             return b1 + b2; 
//         } 
//     } 
    
//     float basis0(float u, int k, float[] knots) { 
//         if (u >=  knots[k] && u < knots[k + 1]) {
//             return 1;
//         } 
//         else{ 
//             return 0;
//         } 
//     } 
    
//     public float getH() {
//         return h;
//     }
    
//     public float getW() {
//         return w;
//     }
    
//     public float getD() {
//         return d;
//     }
    
//     public void curtainColor() {
//         fill(255, 0, 0);
//     }
    
// }
public class Cylinder extends DrawableObject  {

    int sides;
    float r1;
    float r2;
    float h;


    public Cylinder (int sides, float r1, float r2, float h) {
        if(sides <= 0) sides = 1; // avoid division by zero if 0 was passed

        this.sides = sides;
        this.r1 = r1;
        this.r2 = r2;
        this.h = h;
    }

    public void draw() {
        draw(PI / 2);
    }

    public void draw(float rotation) {
        pushMatrix();

        rotateX(rotation);
        float angle = 360 / sides;
        float halfHeight = h / 2;
        // top
        beginShape();
        for (int i = 0; i < sides; i++) {
            float x = cos( radians( i * angle ) ) * r1;
            float y = sin( radians( i * angle ) ) * r1;
            vertex( x, y, -halfHeight);
        }
        endShape(CLOSE);
        // bottom
        beginShape();
        for (int i = 0; i < sides; i++) {
            float x = cos( radians( i * angle ) ) * r2;
            float y = sin( radians( i * angle ) ) * r2;
            vertex( x, y, halfHeight);
        }
        endShape(CLOSE);
        // draw body
        beginShape(TRIANGLE_STRIP);
        for (int i = 0; i < sides + 1; i++) {
            float x1 = cos( radians( i * angle ) ) * r1;
            float y1 = sin( radians( i * angle ) ) * r1;
            float x2 = cos( radians( i * angle ) ) * r2;
            float y2 = sin( radians( i * angle ) ) * r2;
            vertex( x1, y1, -halfHeight);
            vertex( x2, y2, halfHeight);
        }
        endShape(CLOSE);

        popMatrix();
    }

    public float getR1() {
        return r1;
    }

    public float getR2() {
        return r2;
    }

    public float getSides() {
        return sides;
    }

    public float getH() {
        return h;
    }

    public float getW() {
        return max(r1, r2) * 2;
    }

    public float getD() {
        return max(r1, r2) * 2;
    }
}





public class DrawArray {

    DrawableObject[] objects;
    float x;
    float y;
    float z;
    int amount;
    boolean random;
    PVector[] randVals;

    public DrawArray (DrawableObject[] objects, float x, float y, float z) {
        this(objects, x, y, z, false);
    }
    public DrawArray (DrawableObject[] objects, float x, float y, float z, boolean random) {
        this(objects, x, y, z, false, 1);
    }

    public DrawArray (DrawableObject[] objects, float x, float y, float z, boolean random, float randomness) {

        this.objects = objects;

        this.x = x;
        this.y = y;
        this.z = z;
        this.amount = objects.length;
        this.random = random;

        DrawableObject obj0 = objects[0];
        randVals = new PVector[amount];
        if(random) {
            for (int i = 0; i < randVals.length; ++i) {
                randVals[i] = new PVector(random(-obj0.getW() * randomness, obj0.getW() * randomness), random(-obj0.getH() * randomness, obj0.getH() * randomness), random(-obj0.getD() * randomness, obj0.getD() * randomness));
            }
        }
    }

    public void draw() {
        pushMatrix();
            // center array to current coordinate
            translate(-x * objects[0].getW() * amount / 2, -y * objects[0].getH() * amount / 2, -z * objects[0].getD() * amount / 2);
            for (int i = 0; i < objects.length; ++i) {
                DrawableObject o = objects[i];
                if(o == null) continue;
                if(i != 0)
                    translate(x * o.getW(), y * o.getH(), z * o.getD());
                if(random) {
                    translate(randVals[i].x, 0, randVals[i].z);
                    pushMatrix();
                    popMatrix();
                }

                o.draw();
            }
        popMatrix();
    }

    public DrawableObject[] getArray() {
        return objects;
    }

}
public class DrawableObject {

    public void draw() {

    }

    public float getH() {
        return 0;
    }

    public float getW() {
        return 0;
    }

    public float getD() {
        return 0;
    }


}
public class Glass extends DrawableObject {

    float r;
    float h;
    float thickness = 0.9f; // of overall thickness ( r * thickness )
    int sides = 10;
    float botTopRatio = 0.7f; // the radius on the the bottom (r * botTopRatio)

    public Glass (float radius) {
        this.r = radius;
        this.h = radius * 2.5f;
    }

    public void draw() {
        pushMatrix();
        pushStyle();
            setColorGlass();
            // main body
            tube(r * botTopRatio, r, h);
            // bottom lid
            translate(0, h / 2, 0);
            lid(r * botTopRatio);
            // top inset
            translate(0, -h, 0);
            inset(r, r * thickness);
            // inside
            translate(0, h * thickness / 2, 0);
            tube(r * botTopRatio * thickness, r * thickness, h * thickness);
            // glass floor
            translate(0, h * thickness / 2, 0);
            lid(r * botTopRatio * thickness);
        popStyle();
        popMatrix();
    }

    private void tube(float r1, float r2, float h) {
        pushMatrix();
            rotateX(PI / 2);
            float angle = 360 / sides;
            float halfHeight = h / 2;
            
            beginShape(TRIANGLE_STRIP);
            for (int i = 0; i < sides + 1; i++) {
                float x1 = cos( radians( i * angle ) ) * r1;
                float y1 = sin( radians( i * angle ) ) * r1;
                float x2 = cos( radians( i * angle ) ) * r2;
                float y2 = sin( radians( i * angle ) ) * r2;
                vertex( x1, y1, -halfHeight);
                vertex( x2, y2, halfHeight);
            }
            endShape(CLOSE);
        popMatrix();
        
    }

    private void inset(float r1, float r2) {
        pushMatrix();
            rotateX(PI / 2);
            float angle = 360 / sides;
            
            beginShape(TRIANGLE_STRIP);
            for (int i = 0; i < sides + 1; i++) {
                float x1 = cos( radians( i * angle ) ) * r1;
                float y1 = sin( radians( i * angle ) ) * r1;
                float x2 = cos( radians( i * angle ) ) * r2;
                float y2 = sin( radians( i * angle ) ) * r2;
                vertex( x1, y1, 0);
                vertex( x2, y2, 0);
            }
            endShape(CLOSE);
        popMatrix();
    }

    private void lid(float r) {
        pushMatrix();
            rotateX(PI / 2);
            float angle = 360 / sides;
            
            beginShape();
            for (int i = 0; i < sides; i++) {
                float x = cos( radians( i * angle ) ) * r;
                float y = sin( radians( i * angle ) ) * r;
                vertex( x, y, 0);
            }
            endShape(CLOSE);
        popMatrix();
    }

    public float getH() {
        return h;
    }

    public float getW() {
        return r * 2;
    }

    public float getD() {
        return r * 2;
    }

    private void setColorGlass() {
        fill(0, 191, 255, 130);
        shininess(10.0f);
    }
}
class Joint {
    String name;
    int isRoot = 0;
    int isEndSite = 0;
    Joint parent;
    PVector offset = new PVector();
    //transformation types (CHANNELS):
    String[] rotationChannels = new String[3];
    //current transformation matrix applied to this joint's children:
    float[][] transMat = {{1.f, 0.f, 0.f} ,{0.f, 1.f, 0.f} ,{0.f, 0.f, 1.f} };
    //list of PVector, xyz position at each frame:
    ArrayList<PVector> position = new ArrayList<PVector>();  
}

class Mocap {
    float frmRate;
    int frameNumber;
    ArrayList<Joint> joints = new ArrayList<Joint>();
    
    Mocap(String fileName) {
        String[] lines = loadStrings(fileName);
        float frameTime;
        int readMotion = 0;
        int lineMotion = 0;
        Joint currentParent = new Joint();
        
        for (int i = 0;i < lines.length;i++) {
            
            //--- Read hierarchy --- 
            String[] words = splitTokens(lines[i], " \t");
            
            //listjoints, with parent
            if (words[0].equals("ROOT") ||  words[0].equals("JOINT") ||  words[0].equals("End")) {
                Joint joint = new Joint();
                joints.add(joint);
                if (words[0].equals("End")) {
                    joint.name = "EndSite" + ((Joint)joints.get(joints.size() - 1)).name;
                    joint.isEndSite = 1;
                }
                else joint.name = words[1];
                if (words[0].equals("ROOT")) {
                    joint.isRoot = 1;
                    currentParent = joint;
                }
                joint.parent = currentParent;
            }
            
            //findparent
            if (words[0].equals("{"))
                currentParent = (Joint)joints.get(joints.size() - 1);
            if (words[0].equals("}")) {
                currentParent = currentParent.parent;
            }
            
            //offset
            if (words[0].equals("OFFSET")) {
                joints.get(joints.size() - 1).offset.x = PApplet.parseFloat(words[1]);
                joints.get(joints.size() - 1).offset.y = PApplet.parseFloat(words[2]);
                joints.get(joints.size() - 1).offset.z = PApplet.parseFloat(words[3]);
            }
            
            //order of rotations
            if (words[0].equals("CHANNELS")) {
                joints.get(joints.size() - 1).rotationChannels[0] = words[words.length - 3];
                joints.get(joints.size() - 1).rotationChannels[1] = words[words.length - 2];
                joints.get(joints.size() - 1).rotationChannels[2] = words[words.length - 1];
            }
            
            if (words[0].equals("MOTION")) {
                readMotion = 1;
                lineMotion = i;
            }
            
            if (words[0].equals("Frames:"))
                frameNumber = PApplet.parseInt(words[1]);
            
            if (words[0].equals("Frame") && words[1].equals("Time:")) {
                frameTime = PApplet.parseFloat(words[2]);
                frmRate = round(1000.f / frameTime) / 1000.f;
            }
            
            //--- Read motion, compute positions ---   
            if (readMotion ==  1 && i > lineMotion + 2) {
                
                //motiondata
                PVector RotRelativPos = new PVector();
                int iMotionData = 3;// number of data points read, skip root position      
                for (Joint itJ : joints) {
                    if (itJ.isEndSite ==  0) {// skip end sites
                        float[][] currentTransMat = {{1.f, 0.f, 0.f} ,{0.f, 1.f, 0.f} ,{0.f, 0.f, 1.f} };
                        //The transformation matrix is the (right-)product
                        //of transformations specified by CHANNELS
                        for (int iC = 0;iC < itJ.rotationChannels.length;iC++) {
                            currentTransMat = multMat(currentTransMat,
                                makeTransMat(PApplet.parseFloat(words[iMotionData]),
                                itJ.rotationChannels[iC]));
                            iMotionData++;
                        }
                        if (itJ.isRoot ==  1) {//root has no parent:
                            //transformation matrix is read directly
                            itJ.transMat = currentTransMat;
                        }
                        else {//other joints:
                            //transformation matrix is obtained by right-applying
                            //the current transformation to the transMat of parent
                            itJ.transMat = multMat(itJ.parent.transMat, currentTransMat);
                        }
                    }
                    
                    //positions
                    if (itJ.isRoot ==  1) {//root: position read directly + offset
                        RotRelativPos.set(PApplet.parseFloat(words[0]), PApplet.parseFloat(words[1]), PApplet.parseFloat(words[2]));
                        RotRelativPos.add(itJ.offset);
                    }
                    else{//other joints:
                        //apply trasnformation matrix from parent on offset
                        RotRelativPos = applyMatPVect(itJ.parent.transMat, itJ.offset);
                        //add transformed offset to parent position
                        RotRelativPos.add(itJ.parent.position.get(itJ.parent.position.size() - 1));
                    }
                    //store position
                    itJ.position.add(RotRelativPos);
                }
            }
        }
    }  
    public float[][] multMat(float[][] A, float[][] B) {//computes the matrix product AB
        int nA = A.length;
        int nB = B.length;
        int mB = B[0].length;
        float[][] AB = new float[nA][mB];
        for (int i = 0;i < nA;i++) {
            for (int k = 0;k < mB;k++) {
                if (A[i].length!= nB) {
                    println("multMat: matrices A and B have wrong dimensions! Exit.");
                    exit();
                }
                AB[i][k] = 0.f;
                for (int j = 0;j < nB;j++) {
                    if (B[j].length!= mB) {
                        println("multMat: matrices A and B have wrong dimensions! Exit.");
                        exit();
                    }
                    AB[i][k] += A[i][j] * B[j][k];
                }
            }
        }
        return AB;
    }
    
    public float[][] makeTransMat(float a, String channel) {
        //produces transformation matrix corresponding to channel, with argument a
        float[][] transMat = {{1.f, 0.f, 0.f} ,{0.f, 1.f, 0.f} ,{0.f, 0.f, 1.f} };
        if (channel.equals("Xrotation")) {
            transMat[1][1] = cos(radians(a));
            transMat[1][2] = -sin(radians(a));
            transMat[2][1] = sin(radians(a));
            transMat[2][2] = cos(radians(a));
        }
        else if (channel.equals("Yrotation")) {
            transMat[0][0] = cos(radians(a));
            transMat[0][2] = sin(radians(a));
            transMat[2][0] = -sin(radians(a));
            transMat[2][2] = cos(radians(a));
        }
        else if (channel.equals("Zrotation")) {
            transMat[0][0] = cos(radians(a));
            transMat[0][1] = -sin(radians(a));
            transMat[1][0] = sin(radians(a));
            transMat[1][1] = cos(radians(a));
        }
        else{
            println("makeTransMat: unknown channel! Exit.");
            exit();
        }
        return transMat;
    }
    
    public PVector applyMatPVect(float[][] A, PVector v) {
        // apply(square matrix) A to v(both must have dimension 3)
        for (int i = 0;i < A.length;i++) {
            if (v.array().length!= 3 ||  A.length!= 3 ||  A[i].length!= 3) {
                println("applyMatPVect: matrix and/or vector not of dimension 3! Exit.");
                exit();
            }
        }
        
        PVector Av = new PVector();
        Av.x = A[0][0] * v.x + A[0][1] * v.y + A[0][2] * v.z;
        Av.y = A[1][0] * v.x + A[1][1] * v.y + A[1][2] * v.z;
        Av.z = A[2][0] * v.x + A[2][1] * v.y + A[2][2] * v.z;
        return Av;
    }
}
class MocapInstance {   
  Mocap mocap;
  int currentFrame, firstFrame, lastFrame, startingFrame;
  float[] translation;
  float scl, strkWgt;
  int clr;
 
  MocapInstance (Mocap mocap1, int startingFrame, float[] transl, float scl1, int clr1, float strkWgt1) {
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
 
  public void drawMocap() {
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

  public PVector calcMidPoint(PVector p1, PVector p2) {
      return new PVector((p1.x + p2.x) / 2, (p1.y + p2.y) / 2, (p1.z + p2.z) / 2);
  }

  public void alignToVector(PVector initialDirection, PVector p1, PVector p2) {

    PVector midPoint = p1.copy().add(p2).mult(0.5f);
    PVector newDirection = p2.copy().sub(p1).normalize(); 
    PVector rotationAxis = initialDirection.cross(newDirection).normalize();
    float rotationAngle = acos(initialDirection.dot(newDirection));

    translate(midPoint.x, midPoint.y, midPoint.z);
    Rotate(rotationAngle, rotationAxis.x, rotationAxis.y, rotationAxis.z);
  }

  public void Rotate(float angle, float x, float y, float z) {
      float c = cos(angle);
      float s = sin(angle);
      applyMatrix(
          x*x*(1.0f-c)+c,   x*y*(1.0f-c)-z*s, x*z*(1.0f-c)+y*s, 0.0f,
          y*x*(1.0f-c)+z*s, y*y*(1.0f-c)+c,   y*z*(1.0f-c)-x*s, 0.0f,
          z*x*(1.0f-c)-y*s, z*y*(1.0f-c)+x*s, z*z*(1.0f-c)+c,   0.0f,
          0.0f,             0.0f,             0.0f,             1.0f );
  }

  public void restart() {
    currentFrame = startingFrame;
  }

  public boolean isOver() {
    return currentFrame + 1 >= mocap.frameNumber;
  }

  public int getFrame() {
    return currentFrame;
  }

}
public class RoundTable extends DrawableObject {

    float r;
    float h;
    int sides = 20;

    float plateRatio = 0.02f;
    float footRatioMin = 0.1f;
    float footRatioMax = 0.2f;

    Cylinder footBot;
    Cylinder footTop;
    Cylinder plate;

    public RoundTable (float radius, float tableHeight) {
        this.r = radius;
        this.h = tableHeight;

        footTop =   new Cylinder(sides, r * footRatioMin, r * footRatioMax, (h * (1 - plateRatio)) / 2);
        footBot =   new Cylinder(sides, r * footRatioMax, r * footRatioMin, (h * (1 - plateRatio)) / 2);
        plate   =   new Cylinder(sides, r, r, h * plateRatio);
    }

    public void draw() {
        pushMatrix();
        // building from bottom to top
        // foot
        pushStyle();
            setColorFoot();
            translate(0, h / 2 + footBot.getH() / 2, 0);
            footBot.draw();

            translate(0, -footBot.getH(), 0);
            footTop.draw();

        popStyle();
        // plate
        pushStyle();
            setColorPlate();

            translate(0, -footTop.getH() / 2 - plate.getH() / 2, 0);
            plate.draw();

        popStyle();        
        popMatrix();
    }

    public float getH() {
        return h;
    }

    public float getW() {
        return r * 2;
    }

    public float getD() {
        return r * 2;
    }

    private void setColorPlate() {
        fill(20);
        shininess(10);
    }

    private void setColorFoot() {
        fill(230);
        shininess(5);
    }

}



public class Shelf extends DrawableObject {
    float w;
    float h;
    float d;

    float sideMargin = 0.1f;
    float botMargin = 0.2f;
    float topMargin = 0.1f;

    float seperatorWidth = 0.01f;
    float shelfThickness = 0.01f;
    float shelfDepth = 0.8f;

    
    float bottleSize = 50;
    DrawArray[] shelfBottles;

    public Shelf (float shelfWidth, float shelfHeight, float shelfDepth) {
        this.w = shelfWidth;
        this.h = shelfHeight;
        this.d = shelfDepth;
        this.shelfBottles = new DrawArray[] {
            new DrawArray(createBottles(8, bottleSize), 1.2f, 0, 0, true, 0.2f),
            new DrawArray(createBottles(8, bottleSize), 1.2f, 0, 0, true, 0.2f),
            new DrawArray(createBottles(8, bottleSize), 1.2f, 0, 0, true, 0.2f),
            new DrawArray(createBottles(8, bottleSize), 1.2f, 0, 0, true, 0.2f),
            new DrawArray(createBottles(8, bottleSize), 1.2f, 0, 0, true, 0.2f),
            new DrawArray(createBottles(8, bottleSize), 1.2f, 0, 0, true, 0.2f),
            new DrawArray(createBottles(8, bottleSize), 1.2f, 0, 0, true, 0.2f),
            new DrawArray(createBottles(8, bottleSize), 1.2f, 0, 0, true, 0.2f),
            new DrawArray(createBottles(8, bottleSize), 1.2f, 0, 0, true, 0.2f)
        }; // das geht sicherlich schöner ich bin nur zu doof :)
    }

    public void draw() {
        pushStyle();
        setColorShelf();

        float innerWidth = w - w * sideMargin * 2;
        float innerHeight = h - h * botMargin - h * topMargin;

        pushMatrix();
            // left margin
            translate(-(w/2) + w*sideMargin/2, 0, 0);
            box(w * sideMargin, h, d);
        popMatrix();
        pushMatrix();
            // right margin
            translate(+(w/2) - w*sideMargin/2, 0, 0);
            box(w * sideMargin, h, d);
        popMatrix();

        pushMatrix();
            // seperators
            translate(-innerWidth / 3 / 2, h/2 - h * botMargin - innerHeight / 2, 0);
            box(w * seperatorWidth, innerHeight, d);
            translate(innerWidth / 3, 0, 0);
            box(w * seperatorWidth, innerHeight, d);
        popMatrix();

        pushMatrix();
            // horizontals
            translate(0, (h/2) - h*botMargin/2, 0);
            box(innerWidth, h * botMargin, d);
            // shelfs
            float shelfOffset = innerHeight / 4;
            translate(0, -h * botMargin / 2 - shelfOffset, 0);
            box(innerWidth, h * shelfThickness, d * shelfDepth);
            placeBottles(0, innerWidth / 3);
            placeBottles(1, 0);
            placeBottles(2, -innerWidth / 3);
            
            translate(0, -shelfOffset, 0);
            box(innerWidth, h * shelfThickness, d * shelfDepth);
            placeBottles(3, innerWidth / 3);
            placeBottles(4, 0);
            placeBottles(5, -innerWidth / 3);

            translate(0, -shelfOffset, 0);
            box(innerWidth, h * shelfThickness, d * shelfDepth);
            placeBottles(6, innerWidth / 3);
            placeBottles(7, 0);
            placeBottles(8, -innerWidth / 3);
        popMatrix();

        pushMatrix();
            // top margin
            translate(0, -(h / 2) + h * topMargin / 2, 0);
            box(innerWidth, h * topMargin, d);

        popMatrix();
        popStyle();
    }

    private void placeBottles(int n, float offsetX) {
        pushMatrix();
            translate(offsetX, -bottleSize/2, 0);
            shelfBottles[n].draw();
        popMatrix();
    }

    public float getH() {
        return h;
    }

    public float getW() {
        return w;
    }

    public float getD() {
        return d;
    }

    private void setColorShelf() {
        fill(20);
        shininess(10);
    }

}


public Bottle[] createBottles(int n, float bottleHeight) {
    Bottle[] bottles = new Bottle[n];
    for (int i = 0; i < n; ++i) {
        bottles[i] = new Bottle(bottleHeight);
    }
    return bottles;
}
public class Stool extends DrawableObject {

    float h;
    float r;
    int sides = 10;

    float footRatio = 0.05f;
    float legWidth = 0.2f;
    float legRatio = 0.80f;
    float seatSupportRatio = 0.05f;
    float seatRatio = 0.1f;

    Cylinder foot;
    Cylinder leg;
    Cylinder seatSupport;
    Cylinder seat;

    public Stool (float stoolHeight) {
        this(stoolHeight, stoolHeight * 0.3f);
    }

    public Stool (float stoolHeight, float stoolRadius) {
        this.h = stoolHeight;
        this.r = stoolRadius;

        foot = new Cylinder(sides, r, r, h * footRatio);
        leg = new Cylinder(sides, r * legWidth, r * legWidth, h * legRatio);
        seatSupport = new Cylinder(sides, r, r, h * seatSupportRatio);
        seat = new Cylinder(sides, r, r, h * seatRatio);
    }

    public void draw() {
        pushMatrix();
        pushStyle();
            setColorMetal();
            // foot
            translate(0, h / 2 - foot.getH() / 2, 0);
            foot.draw();
            // leg
            translate(0, - foot.getH() / 2 - leg.getH() / 2, 0);
            leg.draw();
            // seatSupport
            translate(0, - leg.getH() / 2 - seatSupport.getH() / 2, 0);
            seatSupport.draw();
        popStyle();

        pushStyle();
            setColorSeat();
            // seat
            translate(0, - seatSupport.getH() / 2 - seat.getH() / 2, 0);
            seat.draw();
        popStyle();
        popMatrix();
    }

    public float getH() {
        return h;
    }

    public float getW() {
        return r * 2;
    }

    public float getD() {
        return r * 2;
    }

    private void setColorSeat() {
        fill(0);
        shininess(10);
    }

    private void setColorMetal() {
        fill(220);
        shininess(35);
    }

}
public class Wall extends DrawableObject{
    float w;
    float h;
    float d;

    public Wall (float shelfWidth, float shelfHeight, float shelfDepth) {
        this.w = shelfWidth;
        this.h = shelfHeight;
        this.d = shelfDepth;
    }

    public void draw() {
        pushMatrix();
        pushStyle();
            setColorWall();
            box(w,h,d);
        popStyle();
        popMatrix();
    }

    public float getH() {
        return h;
    }

    public float getW() {
        return w;
    }

    public float getD() {
        return d;
    }

    private void setColorWall() {
        fill(230);
        shininess(100);
    }

}
  public void settings() {  size(1920,1080,P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Bar" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
