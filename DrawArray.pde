import java.util.Arrays;


public class DrawArray {

    DrawableObject[] objects;
    float x;
    float y;
    float z;
    int amount;
    boolean random;
    PVector[] randVals;

    public DrawArray (DrawableObject[] objects, float x, float y, float z) {
        this(objects, x, y, z, false);
    }
    public DrawArray (DrawableObject[] objects, float x, float y, float z, boolean random) {
        this(objects, x, y, z, false, 1);
    }

    public DrawArray (DrawableObject[] objects, float x, float y, float z, boolean random, float randomness) {

        this.objects = objects;

        this.x = x;
        this.y = y;
        this.z = z;
        this.amount = objects.length;
        this.random = random;

        DrawableObject obj0 = objects[0];
        randVals = new PVector[amount];
        if(random) {
            for (int i = 0; i < randVals.length; ++i) {
                randVals[i] = new PVector(random(-obj0.getW() * randomness, obj0.getW() * randomness), random(-obj0.getH() * randomness, obj0.getH() * randomness), random(-obj0.getD() * randomness, obj0.getD() * randomness));
            }
        }
    }

    public void draw() {
        pushMatrix();
            // center array to current coordinate
            translate(-x * objects[0].getW() * amount / 2, -y * objects[0].getH() * amount / 2, -z * objects[0].getD() * amount / 2);
            for (int i = 0; i < objects.length; ++i) {
                DrawableObject o = objects[i];
                if(o == null) continue;
                if(i != 0)
                    translate(x * o.getW(), y * o.getH(), z * o.getD());
                if(random) {
                    translate(randVals[i].x, 0, randVals[i].z);
                    pushMatrix();
                    popMatrix();
                }

                o.draw();
            }
        popMatrix();
    }

    public DrawableObject[] getArray() {
        return objects;
    }

}
