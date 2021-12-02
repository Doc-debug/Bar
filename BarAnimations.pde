/**
* Contains all animations like dynamic objects and mocap drawing of the scene
*
* Created by Sofia Martinez, Jan Naubert, Patrick Neumann on 2.12.2021
*/
public class BarAnimations {

    Mocap walkInMocap;
    Mocap barKeeperMocap;
    Mocap personSittingRightMocap;
    Mocap personSittingLeftMocap;

    MocapInstance walkInMocapInst;
    MocapInstance barKeeperMocapInst;
    MocapInstance personSittingRightMocapInst;
    MocapInstance personSittingLeftMocapInst;

    float mocapScale = -0.1; // size of the mocap data
    float heightOffset = 200; // offset of the mocap data
    float strokeThickness = 50; // stroke size of the mocap data -> stroke is disabled this is just for debugging
    color strokeColor = color(255, 255, 0); // stroke color

    // positions offsets of the individual mocap data
    float[] walkInOffset =              new float[] {-170, heightOffset, 50};
    float[] barKeeperOffset =           new float[] { 100, heightOffset, 20};
    float[] personSittingRightOffset =  new float[] {-350, heightOffset, -200};
    float[] personSittingLeftOffset =   new float[] {-200, heightOffset, -200};

    // frame offset for individual mocap data
    int walkInTimeOffset =                0;
    int barKeeperTimeOffset =             2000;
    int personSittingRightTimeOffset =    1700;
    int personSittingLeftTimeOffset =     1700;

    // dynamic objects
    Glass glass_1 = new Glass(5);
    Glass glass_2 = new Glass(5);
    Bottle bottle = new Bottle(40);

    int lerpFrameOffset = 50; // eg when switching bottle from hand to position how many frames before and after are used to lerp position

    /**
    * initializes mocap objects
    */
    public BarAnimations () {
       walkInMocap = new Mocap("mocap_data/person_walking_in.bvh");
       barKeeperMocap = new Mocap("mocap_data/barkeeper.bvh");
       personSittingRightMocap = new Mocap("mocap_data/person_sitting_right.bvh");
       personSittingLeftMocap = new Mocap("mocap_data/person_sitting_left.bvh");

        walkInMocapInst =               new MocapInstance(walkInMocap, walkInTimeOffset, walkInOffset, mocapScale, strokeColor, strokeThickness);
        barKeeperMocapInst =            new MocapInstance(barKeeperMocap, barKeeperTimeOffset, barKeeperOffset, mocapScale, strokeColor, strokeThickness, 1);
        personSittingRightMocapInst =   new MocapInstance(personSittingRightMocap, personSittingRightTimeOffset, personSittingRightOffset, mocapScale, strokeColor, strokeThickness);
        personSittingLeftMocapInst =    new MocapInstance(personSittingLeftMocap, personSittingLeftTimeOffset, personSittingLeftOffset, mocapScale, strokeColor, strokeThickness);
    }

    /**
    * draws mocap data and dynamic objects
    */
    public void draw() {
        pushMatrix();
            rotateY(PI / 2);
            walkInMocapInst.drawMocap();
            barKeeperMocapInst.drawMocap();
            personSittingRightMocapInst.drawMocap();
            personSittingLeftMocapInst.drawMocap();
            dynamicObjects();
        popMatrix();
        restart();
    }

    /**
    * restarts all mocap frames when the scene is over
    */
    public void restart() {
        if(walkInMocapInst.isOver()) {
            walkInMocapInst.restart();
            barKeeperMocapInst.restart();
            personSittingRightMocapInst.restart();
            personSittingLeftMocapInst.restart();
        }
    }

    /**
    * Moves "dynamic objects" at specific vectors on specific frames
    */
    public void dynamicObjects() {
        pushMatrix();
            int leftSittingFrame = personSittingLeftMocapInst.getFrame();

            PVector glass_1_pos;
            // local vector (from mocap data) * mocap scale + absolute vector(to mocap data)
            PVector glass1Hand = personSittingLeftMocap.joints.get(15).position.get(personSittingLeftMocapInst.getFrame()).copy().mult(mocapScale).add(new PVector(personSittingLeftOffset[0], personSittingLeftOffset[1], personSittingLeftOffset[2]));
            PVector glass1Table = new PVector(565, 870, 182).mult(mocapScale).add(new PVector(personSittingLeftOffset[0], personSittingLeftOffset[1], personSittingLeftOffset[2]));

            if(leftSittingFrame > 4890 && leftSittingFrame < 5295) {
                glass_1_pos = glass1Hand;
                translate(glass_1_pos.x, glass_1_pos.y, glass_1_pos.z);
            } else { // set to initial position
                glass_1_pos = glass1Table;
                translate(glass_1_pos.x, glass_1_pos.y, glass_1_pos.z);
            }

            glass_1.draw();
        popMatrix();

        pushMatrix();

            int rightSittingFrame = personSittingRightMocapInst.getFrame();

            PVector glass_2_pos;
            // local vector (from mocap data) * mocap scale + absolute vector(to mocap data)
            PVector glass2Hand = personSittingRightMocap.joints.get(15).position.get(personSittingRightMocapInst.getFrame()).copy().mult(mocapScale).add(new PVector(personSittingRightOffset[0], personSittingRightOffset[1], personSittingRightOffset[2]));
            PVector glass2Table = new PVector(-347, 870, -89).mult(mocapScale).add(new PVector(personSittingRightOffset[0], personSittingRightOffset[1], personSittingRightOffset[2]));

            if(rightSittingFrame > 4890 && rightSittingFrame < 5295) {
                glass_2_pos = PVector.lerp(glass2Table, glass2Hand, min((float) (rightSittingFrame - 4890) / lerpFrameOffset, 1)); // lerp starts when bottle is grabbed
                translate(glass_2_pos.x, glass_2_pos.y, glass_2_pos.z);
                personSittingRightMocapInst.setLimbRotation(15, new PVector(1, 0, 0));
            } else if(rightSittingFrame > 3300 && rightSittingFrame < 3585) {
                glass_2_pos = PVector.lerp(glass2Table, glass2Hand, min((float) (rightSittingFrame - 3300) / lerpFrameOffset, 1)); // lerp starts when bottle is grabbed
                translate(glass_2_pos.x, glass_2_pos.y, glass_2_pos.z);
                personSittingRightMocapInst.setLimbRotation(15, new PVector(1, 0, 0));
            } else { // set to initial position
                glass_2_pos = glass2Table; // lerp starts when bottle is grabbed
                translate(glass_2_pos.x, glass_2_pos.y, glass_2_pos.z);
            }

            glass_2.draw();
        popMatrix();

        pushMatrix();

            int barKeepFrame = barKeeperMocapInst.getFrame();

            int bartenderGrab = 4150;
            int bartenderLetGo = 4740;
            int walkinGrab = 4980;
            int walkinLetGo = 6270;

            // local vector (from mocap data) * mocap scale + absolute vector(to mocap data)
            PVector bottleInShelf = new PVector(-892.71533, 1350, 276.6314).mult(mocapScale).add(barKeeperOffset[0], barKeeperOffset[1], barKeeperOffset[2]);
            PVector bottleInKeeper = barKeeperMocap.joints.get(15).position.get(barKeepFrame).copy().mult(mocapScale).add(barKeeperOffset[0], barKeeperOffset[1], barKeeperOffset[2]);
            PVector bottleOnTable = new PVector(1000, 1176.4167, 60).mult(mocapScale).add(new PVector(barKeeperOffset[0], barKeeperOffset[1], barKeeperOffset[2]));
            PVector bottleInDrunk = walkInMocap.joints.get(10).position.get(walkInMocapInst.getFrame()).copy().add(new PVector(-100, 0, 0)).mult(mocapScale).add(new PVector(walkInOffset[0], walkInOffset[1], walkInOffset[2]));
            PVector bottleOnTable2 = new PVector(-1600, 1196.7069, 650.9476).mult(mocapScale).add(new PVector(walkInOffset[0], walkInOffset[1], walkInOffset[2]));

            PVector bottle_pos;
            if(barKeepFrame < bartenderGrab) { // while the bottle is in the shelf
                bottle_pos = bottleInShelf;            
                translate(bottle_pos.x, bottle_pos.y, bottle_pos.z);
            } else if(barKeepFrame >= bartenderGrab && barKeepFrame < bartenderLetGo) { // while the bottle is in the hand of the barkeeper
                bottle_pos = PVector.lerp(bottleInShelf, bottleInKeeper, min((float) (barKeepFrame - bartenderGrab) / lerpFrameOffset, 1)); // lerp starts when bottle is grabbed
                translate(bottle_pos.x, bottle_pos.y, bottle_pos.z);
            } else if(barKeepFrame >= bartenderLetGo && barKeepFrame < walkinGrab) { // while the bottle is on the bartable
                bottle_pos = PVector.lerp(bottleInKeeper, bottleOnTable, min((float) (barKeepFrame - bartenderLetGo) / lerpFrameOffset, 1));
                translate(bottle_pos.x, bottle_pos.y, bottle_pos.z);
            } else if(barKeepFrame >= walkinGrab && barKeepFrame < walkinLetGo) { // while the bottle is in the hand of the main person
                bottle_pos = PVector.lerp(bottleOnTable, bottleInDrunk, min((float) (barKeepFrame - walkinGrab) / lerpFrameOffset, 1));
                translate(bottle_pos.x, bottle_pos.y, bottle_pos.z);
                walkInMocapInst.setLimbRotation(10, new PVector(1, 0, 0));
            } else { // after the main person but the bottle back on the bar table
                bottle_pos = PVector.lerp(bottleInDrunk, bottleOnTable2, min((float) (barKeepFrame - walkinLetGo) / lerpFrameOffset, 1));
                translate(bottle_pos.x, bottle_pos.y, bottle_pos.z);
            }
            
            spotLight(255, 240, 176, 0, bottle.getH(), 0, 0, -200, 0, PI/2, 2);
            bottle.draw();

        popMatrix();
    }

}
