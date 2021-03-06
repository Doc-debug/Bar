/**
* Creates and Draws a round table with specified size
*
* Created by Sofia Martinez, Jan Naubert, Patrick Neumann on 18.10.2021
*/
public class RoundTable extends DrawableObject {

    float r;
    float h;
    int sides = 20;

    float plateRatio = 0.02;
    float footRatioMin = 0.1;
    float footRatioMax = 0.2;

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
    
    /**
    * sets the color of the table top
    */
    private void setColorPlate() {
        fill(20);
        shininess(10);
    }
    
    /**
    * sets the color of the table foot
    */
    private void setColorFoot() {
        fill(230);
        shininess(5);
    }

}
