public class BarScene {
    Wall wallRight = new Wall(1000, 1000);
    Wall wallLeft = new Wall(1000, 1000);
    Wall floor = new Wall(1000, 1000);

    Shelf shelf = new Shelf(600, 300, 100);

    BarTable tableMain = new BarTable(600, 100, 50);
    BarTable tableShort = new BarTable(150, 100, 50, false, true);

    RoundTable roundTable = new RoundTable(60, 80);
    Stool stoolRight = new Stool(50, 15);
    Stool stoolLeft = new Stool(50, 15);

    DrawArray stools = new DrawArray(createStools(5, 80), 2, 0, 0, true, 0.2);

    DrawArray glasses = new DrawArray(createGlasses(4, 5), 10, 0, 0, true, 1.2);

    Bottle bottle = new Bottle(40);

    BodyRig testBody = new BodyRig(10, 50, new PVector(-50, 0, 0),  new PVector(-50, 50, -50), new PVector(-50, 100, 0), 
                                        new PVector(50, 0, 0),   new PVector(50, 50, -50),  new PVector(50, 100, 0),
                                        new PVector(-15, 80, 0), new PVector(-15, 130, 30), new PVector(-15, 180, 0),
                                        new PVector(15, 80, 0),  new PVector(15, 130, 30),  new PVector(15, 180, 0));


    public BarScene () {
        
    }

    public void draw() {
        pushMatrix();

        pushMatrix();
            translate(0, -100, -100);
        popMatrix();
        
        translate(0, 200, 0); // move everything a little lower :)
        
        // light
        pushMatrix();
            pointLight(255, 255, 255, -610, -1460, 1200);
        popMatrix();

        float shelfDist = -tableShort.getW() * 1.5;
        // set floor
        pushMatrix();
            translate(-wallRight.getW() / 2 + tableMain.getW() / 2, 0, wallRight.getW() / 2 + shelfDist - shelf.getD() / 2);
            rotateX(PI/2);
            floor.draw();
        popMatrix();

        // wall right
        pushMatrix();
            translate(tableMain.getW() / 2, -wallRight.getH() / 2, wallRight.getW() / 2 + shelfDist - shelf.getD() / 2);
            rotateY(PI/2);
            wallRight.draw();
        popMatrix();

        // wall left
        pushMatrix();
            translate(-wallRight.getW() / 2 + tableMain.getW() / 2, -wallRight.getH() / 2, shelfDist - shelf.getD() / 2);
            wallLeft.draw();
        popMatrix();

        // set shelf
        pushMatrix();
            translate(0, -shelf.getH() / 2, shelfDist);
            shelf.draw();
        popMatrix();

        // set table
        pushMatrix();
            translate(0, -tableMain.getH() / 2, 0);
            tableMain.draw();
            translate(-tableMain.getW() / 2 - tableShort.getD() / 2, 0, -tableShort.getW() / 2 + tableMain.getD() / 2);
            rotateY(-PI / 2);
            tableShort.draw();
        popMatrix();

        // fill table
        pushMatrix();
            DrawableObject glass = glasses.getArray()[0];
            translate(0, -tableMain.getH() - glass.getH() / 2, 0);
            glasses.draw();
            translate(0, glass.getH() / 2 - bottle.getH() / 2, 0);
            bottle.draw();
        popMatrix();

        // set stools
        pushMatrix();
            DrawableObject stool = stools.getArray()[0];
            translate(0, -stool.getH() / 2, stool.getD() * 1.5);
            stools.draw();
        popMatrix();

        // round table where the two people are sitting
        pushMatrix();
            translate(-200, -roundTable.getH(), 300 - 15);
            roundTable.draw();

            float chairDist = 80;
            translate(0, roundTable.getH() - stoolRight.getH() / 2, -chairDist);
            stoolRight.draw();
            translate(0, 0, chairDist * 2);
            stoolLeft.draw();

        popMatrix();

        popMatrix();
    }

    Stool[] createStools(int n, float stoolHeight) {
        Stool[] stools = new Stool[n];
        for (int i = 0; i < n; ++i) {
            stools[i] = new Stool(stoolHeight);
        }
        return stools;
    }

    Glass[] createGlasses(int n, float radius) {
        Glass[] glasses = new Glass[n];
        for (int i = 0; i < n; ++i) {
            glasses[i] = new Glass(radius);
        }
        return glasses;
    }

}
