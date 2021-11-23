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
            translate(0, cable.getH() / 2, 0);
            pushStyle();
            cableColor();
            cable.draw();
            popStyle();
            translate(0, cable.getH() / 2 + lampshade.getH() / 2, 0);
            pushStyle();
            shadeColor();
            lampshade.draw();
            popStyle();
            translate(0, lampshade.getH() / 2, 0);
            pushStyle();
            noLights(); // disable lights to make it look like it shines
            bulbColor();
            sphere(r * bulbSize);
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

    private void shadeColor() {
        fill(20);
        shininess(10);
    }

    private void cableColor() {
        fill(20);
        shininess(10);
    }

    private void bulbColor() {
        fill(255, 240, 176);
    }

    

}
