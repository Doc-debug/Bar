public class Stool extends DrawableObject {

    float h;
    float r;
    int sides = 10;

    float footRatio = 0.05;
    float legWidth = 0.2;
    float legRatio = 0.80;
    float seatSupportRatio = 0.05;
    float seatRatio = 0.1;

    Cylinder foot;
    Cylinder leg;
    Cylinder seatSupport;
    Cylinder seat;

    public Stool (float stoolHeight) {
        this(stoolHeight, stoolHeight * 0.3);
    }

    public Stool (float stoolHeight, float stoolRadius) {
        this.h = stoolHeight;
        this.r = stoolRadius;

        foot = new Cylinder(sides, r, r, h * footRatio);
        leg = new Cylinder(sides, r * legWidth, r * legWidth, h * legRatio);
        seatSupport = new Cylinder(sides, r, r, h * seatSupportRatio);
        seat = new Cylinder(sides, r, r, h * seatRatio);
    }

    public void draw() {
        pushMatrix();
        pushStyle();
            setColorMetal();
            // foot
            translate(0, h / 2 - foot.getH() / 2, 0);
            foot.draw();
            // leg
            translate(0, - foot.getH() / 2 - leg.getH() / 2, 0);
            leg.draw();
            // seatSupport
            translate(0, - leg.getH() / 2 - seatSupport.getH() / 2, 0);
            seatSupport.draw();
        popStyle();

        pushStyle();
            setColorSeat();
            // seat
            translate(0, - seatSupport.getH() / 2 - seat.getH() / 2, 0);
            seat.draw();
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

    private void setColorSeat() {
        fill(0);
        shininess(10);
    }

    private void setColorMetal() {
        fill(220);
        shininess(35);
    }

}
