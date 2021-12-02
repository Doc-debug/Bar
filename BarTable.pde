/**
* Creates and Draws a Bartable with specified size
*
* Created by Sofia Martinez, Jan Naubert, Patrick Neumann on 2.12.2021
*/
public class BarTable extends DrawableObject {

    float w;
    float h;
    float d;
    float offsetLeft;
    float offsetRight;
    float topRatio = 0.1;
    float overhangRatio = 0.3;

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
 
    /**
    * sets the color of the top part of the table
    */
    private void setColorPlate() {
        fill(20);
        shininess(10);
    }
    
    /**
    * sets the color of the bottom part of the table
    */
    private void setColorFoot() {
        fill(230);
        shininess(5);
    }

}
