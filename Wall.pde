/**
* Creates and Draws a Wall / Plane with specified size and texture
*
* Created by Sofia Martinez, Jan Naubert, Patrick Neumann on 9.10.2021
*/
public class Wall extends DrawableObject{
    
    PImage tex;
    float wTex;
    float hTex;
    float w;
    float h;
    
    public Wall(float wallWidth, float wallHeight, PImage texture, float texWidth, float texHeight) {
        this.w = wallWidth;
        this.h = wallHeight;
        this.wTex = texWidth;
        this.hTex = texHeight;
        this.tex = texture;
    }
    
    public void draw() {
        pushMatrix();
        pushStyle();
        beginShape();
        texture(tex);
        vertex( -this.w / 2, -this.h / 2, 0, 0, 0);
        vertex(this.w / 2, -this.h / 2, 0, wTex, 0);
        vertex(this.w / 2,  this.h / 2, 0, wTex, hTex);
        vertex( -this.w / 2,  this.h / 2, 0, 0, hTex);
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
    
    /**
    * sets the color of the wall
    */
    private void setColorWall() {
        fill(230);
        shininess(100);
    }
    
}
