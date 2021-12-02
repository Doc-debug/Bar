/**
* Creates and Draws a Cylinder or cone with specified size (and rotation)
*
* Created by Sofia Martinez, Jan Naubert, Patrick Neumann on 2.12.2021
*/
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

    void draw() {
        draw(PI / 2);
    }

    void draw(float rotation) {
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

    float getR1() {
        return r1;
    }

    float getR2() {
        return r2;
    }

    float getSides() {
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


