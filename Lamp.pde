/**
* Creates and Draws a Lamp with specified size
*
* Created by Sofia Martinez, Jan Naubert, Patrick Neumann on 2.12.2021
*/
public class Lamp extends DrawableObject {

    float h;
    float r;

    int sides = 20;

    float cableLength = 0.95;
    float cableWidth = 0.05;
    float shadeMin = 0.2;
    float bulbSize = 0.2;

    Cylinder cable;
    Cylinder lampshade;

    public Lamp(float lampHeight, float lampRadius) {
        this.h = lampHeight;
        this.r = lampRadius;

        cable = new Cylinder(sides, this.r * cableWidth, this.r * cableWidth, this.h * cableLength);
        lampshade = new Cylinder(sides, this.r, this.r * shadeMin, this.h * (1 - cableLength));
    }

    public void draw() {
        pushMatrix();
            translate(0, h, 0);
            spotLight(255, 240, 176, 0, -300, 0, 0, 200, 0, PI/2, 2);
        popMatrix();

        pushMatrix();
            
            // cable
            translate(0, cable.getH() / 2, 0);
            pushStyle();
            cableColor();
            cable.draw();
            popStyle();

            // lampshade
            translate(0, cable.getH() / 2 + lampshade.getH() / 2, 0);
            pushStyle();
            shadeColor();
            lampshade.draw();
            popStyle();
            
            // bulb
            translate(0, lampshade.getH() / 2, 0);
            pushStyle();
            noLights(); // disable lights to make it look like it shines
            bulbColor();
            sphere(r * bulbSize);

            // the actual light
            spotLight(255, 240, 176, 0, -300, 0, 0, 200, 0, PI/2, 2);
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
    * sets the color of the shade
    */
    private void shadeColor() {
        fill(20);
        shininess(10);
    }

    /**
    * sets the color of the cable
    */
    private void cableColor() {
        fill(20);
        shininess(10);
    }

    /**
    * sets the color of the bulb
    */
    private void bulbColor() {
        fill(255, 240, 176);
    }
}
