import java.util.Arrays;


public class Shelf extends DrawableObject {
    float w;
    float h;
    float d;
    
    float sideMargin = 0.1;
    float botMargin = 0.2;
    float topMargin = 0.1;
    
    float seperatorWidth = 0.01;
    float shelfThickness = 0.01;
    float shelfDepth = 0.8;
    
    
    float bottleSize = 50;
    DrawArray[] shelfBottles;

    Curtain curtain;
    
    public Shelf(float shelfWidth, float shelfHeight, float shelfDepth) {
        this.w = shelfWidth;
        this.h = shelfHeight;
        this.d = shelfDepth;
        this.shelfBottles = new DrawArray[] {
            new DrawArray(createBottles(8, bottleSize), 1.2, 0, 0, true, 0.2),
                new DrawArray(createBottles(8, bottleSize), 1.2, 0, 0, true, 0.2),
                new DrawArray(createBottles(8, bottleSize), 1.2, 0, 0, true, 0.2),
                new DrawArray(createBottles(8, bottleSize), 1.2, 0, 0, true, 0.2),
                new DrawArray(createBottles(8, bottleSize), 1.2, 0, 0, true, 0.2),
                new DrawArray(createBottles(8, bottleSize), 1.2, 0, 0, true, 0.2),
                new DrawArray(createBottles(8, bottleSize), 1.2, 0, 0, true, 0.2),
                new DrawArray(createBottles(8, bottleSize), 1.2, 0, 0, true, 0.2),
                new DrawArray(createBottles(8, bottleSize), 1.2, 0, 0, true, 0.2)
            };

        
        
        float innerWidth = w - w * sideMargin * 2;
        float innerHeight = h - h * botMargin - h * topMargin;
        float curtain_height = (this.h - innerHeight - this.w * shelfThickness) / 3;
        float curtain_depth = this.d * 0.2;

        this.curtain = new Curtain(innerWidth, curtain_height, curtain_depth);
    }
    
    public void draw() {
        pushStyle();
        setColorShelf();
        
        float innerWidth = w - w * sideMargin * 2;
        float innerHeight = h - h * botMargin - h * topMargin;
        
        pushMatrix();
        // left margin
        translate( - (w / 2) + w * sideMargin / 2, 0, 0);
        box(w * sideMargin, h, d);
        popMatrix();
        pushMatrix();
        // right margin
        translate( + (w / 2) - w * sideMargin / 2, 0, 0);
        box(w * sideMargin, h, d);
        popMatrix();
        
        pushMatrix();
        // seperators
        translate( - innerWidth / 3 / 2, h / 2 - h * botMargin - innerHeight / 2, 0);
        box(w * seperatorWidth, innerHeight, d);
        translate(innerWidth / 3, 0, 0);
        box(w * seperatorWidth, innerHeight, d);
        popMatrix();
        
        pushMatrix();
        // horizontals
        translate(0,(h / 2) - h * botMargin / 2, 0);
        box(innerWidth, h * botMargin, d); // bottom part

        // shelfs from bottom to top
        float shelfOffset = innerHeight / 4;
        translate(0, -h * botMargin / 2, 0);

        pushMatrix();
        translate(0, -(curtain.getH() / 2), 0);
        // curtain.draw(); // curtain still does not work properly
        popMatrix();

        translate(0, -shelfOffset, 0);

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
        translate(offsetX, -bottleSize / 2, 0);
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


Bottle[] createBottles(int n, float bottleHeight) {
    Bottle[] bottles = new Bottle[n];
    for (int i = 0; i < n; ++i) {
        bottles[i] = new Bottle(bottleHeight);
    }
    return bottles;
}
