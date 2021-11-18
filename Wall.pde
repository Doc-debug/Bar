public class Wall extends DrawableObject{
    
    float w;
    float h;
    
    public Wall(float wallWidth, float wallHeight) {
        this.w = wallWidth;
        this.h = wallHeight;
    }
    
    public void draw() {
        pushMatrix();
        pushStyle();
        beginShape();
            //wall left
            vertex(-this.w/2, -this.h/2, 0, 0, 0);
            vertex(this.w/2, -this.h/2, 0, 500, 0);
            vertex(this.w/2,  this.h/2, 0, 500, 500);
            vertex( -this.w/2,  this.h/2, 0, 0, 500);
            endShape(CLOSE);
        popStyle();
        popMatrix();
    }
    
    public float getH() {
        return h;
    }
    
    public float getW() {
        return w;
    }
    
    private void setColorWall() {
        fill(230);
        shininess(100);
    }
    
}
