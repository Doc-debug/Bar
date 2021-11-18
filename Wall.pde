public class Wall extends DrawableObject{
    
    float w;
    float h;
    float d;
    
    public Wall(float wallWidth, float wallHeight, float wallDepth) {
        this.w = wallWidth;
        this.h = wallHeight;
        this.d = wallDepth;
    }
    
    public void draw() {
        // pushMatrix();
        // pushStyle();
        // beginShape();
        // //wall left
        // vertex( -500, -500, 1, 0, 0);
        // vertex(500, -500, 1, 500, 0);
        // vertex(500,  500, 1, 500, 500);
        // vertex( -500,  500, 1, 0, 500);
        // endShape(CLOSE);
        // popStyle();
        // popMatrix();
        // pushMatrix();
        // pushStyle();
        // beginShape();
        // //wall right
        // vertex(500, -500, 0, 0, 0);
        // vertex(500, -500, 1000, 500, 0);
        // vertex(500,  500, 1000, 500, 500);
        // vertex(500,  500, 0, 0, 500);
        // endShape(CLOSE);
        // popStyle();
        // popMatrix();
        // pushMatrix();
        // pushStyle();
        // beginShape();
        // //floor 
        // vertex( -500, 500, 0, 0, 0);
        // vertex( -500, 500, 1000, 500, 0);
        // vertex(500,  500, 1000, 500, 500);
        // vertex(500,  500, 0, 0, 500);
        // endShape(CLOSE);
        // popStyle();
        // popMatrix();
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
