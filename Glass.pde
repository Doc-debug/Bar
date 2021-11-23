public class Glass extends DrawableObject {

    float r;
    float h;
    float thickness = 0.9; // of overall thickness ( r * thickness )
    int sides = 10;
    float botTopRatio = 0.7; // the radius on the the bottom (r * botTopRatio)

    public Glass (float radius) {
        this.r = radius;
        this.h = radius * 2.5;
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
        shininess(2);
    }
}
