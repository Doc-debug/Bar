public class BarAnimations {

    Mocap walkInMocap;
    Mocap barKeeperMocap;
    Mocap personSittingRightMocap;
    Mocap personSittingLeftMocap;

    MocapInstance walkInMocapInst;
    MocapInstance barKeeperMocapInst;
    MocapInstance personSittingRightMocapInst;
    MocapInstance personSittingLeftMocapInst;

    float mocapScale = -0.1;
    float heightOffset = 200;
    float strokeThickness = 50;
    color strokeColor = color(255, 255, 0);

    float[] walkInOffset =              new float[] {-170, heightOffset, 50};
    float[] barKeeperOffset =           new float[] { 100, heightOffset, 20};
    float[] personSittingRightOffset =  new float[] {-350, heightOffset, -200};
    float[] personSittingLeftOffset =   new float[] {-200, heightOffset, -200};

    int walkInTimeOffset =                0;
    int barKeeperTimeOffset =             2000;
    int personSittingRightTimeOffset =    1700;
    int personSittingLeftTimeOffset =     1700;

    // dynamic objects
    Glass glass_1 = new Glass(5);
    Glass glass_2 = new Glass(5);
    Bottle bottle = new Bottle(40);


    public BarAnimations () {
       walkInMocap = new Mocap("mocap_data/person_walking_in.bvh");
       barKeeperMocap = new Mocap("mocap_data/barkeeper.bvh");
       personSittingRightMocap = new Mocap("mocap_data/person_sitting_right.bvh");
       personSittingLeftMocap = new Mocap("mocap_data/person_sitting_left.bvh");

        walkInMocapInst =               new MocapInstance(walkInMocap, walkInTimeOffset, walkInOffset, mocapScale, strokeColor, strokeThickness);
        barKeeperMocapInst =            new MocapInstance(barKeeperMocap, barKeeperTimeOffset, barKeeperOffset, mocapScale, strokeColor, strokeThickness);
        personSittingRightMocapInst =   new MocapInstance(personSittingRightMocap, personSittingRightTimeOffset, personSittingRightOffset, mocapScale, strokeColor, strokeThickness);
        personSittingLeftMocapInst =    new MocapInstance(personSittingLeftMocap, personSittingLeftTimeOffset, personSittingLeftOffset, mocapScale, strokeColor, strokeThickness);
    }

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

    public void restart() {
        if(walkInMocapInst.isOver()) {
            walkInMocapInst.restart();
            barKeeperMocapInst.restart();
            personSittingRightMocapInst.restart();
            personSittingLeftMocapInst.restart();
        }
    }

    public void dynamicObjects() {
        pushMatrix();
        pushMatrix();
            translate(personSittingLeftOffset[0], personSittingLeftOffset[1], personSittingLeftOffset[2]);

            PVector glass_1_pos;
            if(personSittingLeftMocapInst.getFrame() > 4890 && personSittingLeftMocapInst.getFrame() < 5295) {
                glass_1_pos = personSittingLeftMocap.joints.get(15).position.get(personSittingLeftMocapInst.getFrame());

            } else { // set to initial position
                glass_1_pos = new PVector(565, 870, 182);
            }

            translate(glass_1_pos.x * mocapScale, glass_1_pos.y * mocapScale, glass_1_pos.z * mocapScale);
            glass_1.draw();
        popMatrix();

        pushMatrix();
            translate(personSittingRightOffset[0], personSittingRightOffset[1], personSittingRightOffset[2]);

            PVector glass_2_pos;
            if(personSittingLeftMocapInst.getFrame() > 4890 && personSittingLeftMocapInst.getFrame() < 5295) {
                glass_2_pos = personSittingRightMocap.joints.get(15).position.get(personSittingRightMocapInst.getFrame());
            } else if(personSittingLeftMocapInst.getFrame() > 3300 && personSittingLeftMocapInst.getFrame() < 3585) {
                glass_2_pos = personSittingRightMocap.joints.get(15).position.get(personSittingRightMocapInst.getFrame());
            } else { // set to initial position
                glass_2_pos = new PVector(-347, 870, -89);
            }

            translate(glass_2_pos.x * mocapScale, glass_2_pos.y * mocapScale, glass_2_pos.z * mocapScale);
            glass_2.draw();
        popMatrix();

        pushMatrix();

            int barKeepFrame = barKeeperMocapInst.getFrame();

            int bartenderGrab = 4150;
            int bartenderLetGo = 4740;
            int walkinGrab = 4980;
            int walkinLetGo = 6270;

            PVector bottle_pos;
            if(barKeepFrame < bartenderGrab) { // while the bottle is in the shelf
                translate(barKeeperOffset[0], barKeeperOffset[1], barKeeperOffset[2]);
                bottle_pos = new PVector(-892.71533, 1350, 276.6314);

            } else if(barKeepFrame >= bartenderGrab && barKeepFrame < bartenderLetGo) { // while the bottle is in the hand of the barkeeper
                translate(barKeeperOffset[0], barKeeperOffset[1], barKeeperOffset[2]);
                bottle_pos = barKeeperMocap.joints.get(15).position.get(barKeepFrame);

            } else if(barKeepFrame >= bartenderLetGo && barKeepFrame < walkinGrab) { // while the bottle is on the bartable
                translate(barKeeperOffset[0], barKeeperOffset[1], barKeeperOffset[2]);
                bottle_pos = new PVector(1000, 1176.4167, 60);

            } else if(barKeepFrame >= walkinGrab && barKeepFrame < walkinLetGo) { // while the bottle is in the hand of the main person
                translate(walkInOffset[0], walkInOffset[1], walkInOffset[2]);
                bottle_pos = walkInMocap.joints.get(10).position.get(walkInMocapInst.getFrame());

            } else { // after the main person but the bottle back on the bar table
                translate(walkInOffset[0], walkInOffset[1], walkInOffset[2]);
                bottle_pos = new PVector(-1600, 1196.7069, 650.9476);
            }

            translate(bottle_pos.x * mocapScale, bottle_pos.y * mocapScale, bottle_pos.z * mocapScale);
            bottle.draw();
        popMatrix();
        popMatrix();
    }

}
