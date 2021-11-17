public class BarAnimations {

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


    public BarAnimations () {
        Mocap walkInMocap = new Mocap("mocap_data/person_walking_in.bvh");
        Mocap barKeeperMocap = new Mocap("mocap_data/barkeeper.bvh");
        Mocap personSittingRightMocap = new Mocap("mocap_data/person_sitting_right.bvh");
        Mocap personSittingLeftMocap = new Mocap("mocap_data/person_sitting_left.bvh");

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

}
