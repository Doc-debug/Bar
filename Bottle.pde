/**
* Creates and Draws a Bottle with specified size
*
* Created by Sofia Martinez, Jan Naubert, Patrick Neumann on 10.10.2021
*/
public class Bottle extends DrawableObject {

    float h;
    float r;
    int sides = 20;
    int transitionSteps = 20;

    float bodyRatio = 0.6;
    float transitionRatio = 0.1;
    float neckRatio = 0.3;

    float minThick = 0.4;

    float randomHue;

    public Bottle (float bottleHeight) {
        this(bottleHeight, bottleHeight * 0.15);
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

    /**
    * calculates the transition curve from bottle neck to body
    */
    private float transitionFunct(float x) {
        float start = 1;
        float end = 0;
        float steps = transitionSteps;
        float inverseThick = r * (1 - minThick);

        float subRatio = -(start / steps) * x + start + end;

        return r - inverseThick * (1 - subRatio);
    }

    /**
    * creates a tube only (a cylinder without the end caps)
    */
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

    /**
    * draws a disc shaped plane
    */
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
    
    /**
    * sets the color of the bottle
    */
    private void setColorBottle() {
        colorMode(HSB, 100);
        fill(randomHue, 40, 100, 50);
        shininess(2);
    }

}
