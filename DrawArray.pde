import java.util.Arrays;

/**
* Draws an array of given drawableobjects on a given axis
*
* Created by Sofia Martinez, Jan Naubert, Patrick Neumann on 2.12.2021
*/
public class DrawArray {

    DrawableObject[] objects;
    float x;
    float y;
    float z;
    int amount;
    boolean random;
    PVector[] randVals;

    /**
    * uses default constructor with random disabled
    *
    * @param objects the array of objects
    * @param x the distance of each object on the x axis
    * @param y the distance of each object on the y axis
    * @param z the distance of each object on the z axis
    */
    public DrawArray (DrawableObject[] objects, float x, float y, float z) {
        this(objects, x, y, z, false);
    }

    /**
    * uses default constructor with randomness set to 1
    *
    * @param objects the array of objects
    * @param x the distance of each object on the x axis
    * @param y the distance of each object on the y axis
    * @param z the distance of each object on the z axis
    * @param random if there should be a random offset of each object
    */
    public DrawArray (DrawableObject[] objects, float x, float y, float z, boolean random) {
        this(objects, x, y, z, random, 1);
    }

    /**
    * the default constructor that sets all values
    *
    * @param objects the array of objects
    * @param x the distance of each object on the x axis
    * @param y the distance of each object on the y axis
    * @param z the distance of each object on the z axis
    * @param random if there should be a random offset of each object
    * @param randomness the maximum offsetratio if random is true
    */
    public DrawArray (DrawableObject[] objects, float x, float y, float z, boolean random, float randomness) {

        this.objects = objects;

        this.x = x;
        this.y = y;
        this.z = z;
        this.amount = objects.length;
        this.random = random;

        DrawableObject obj0 = objects[0];
        randVals = new PVector[amount];
        // if randomness is enabled saves all randomness values for each object
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
                }

                o.draw();
            }
        popMatrix();
    }

    /**
    * returns the object array
    */
    public DrawableObject[] getArray() {
        return objects;
    }

}
