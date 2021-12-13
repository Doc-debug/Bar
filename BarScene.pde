/**
* Draws all passive objects in the barscene
*
* Created by Sofia Martinez, Jan Naubert, Patrick Neumann on 26.10.2021
*/
public class BarScene {
    
    // load textures for the walls
    PImage backTex = loadImage("back.jpg");
    PImage entranceTex = loadImage("entrance.jpg");
    PImage floorTex = loadImage("floor.jpg");
    
    // initialize all needed objects
    Wall backWall = new Wall(675, 675, backTex, 500, 500);
    Wall frontWall = new Wall(675, 675, entranceTex, 500, 500);
    Wall entranceWall = new Wall(675, 675, entranceTex, 500, 500);
    Wall floor = new Wall(675, 675, floorTex, 500, 500);

    Shelf shelf = new Shelf(600, 300, 100);
    Lamp tableLamp = new Lamp(400, 30);
    
    BarTable tableMain = new BarTable(600, 100, 50);
    BarTable tableShort = new BarTable(150, 100, 50, false, true);
    
    RoundTable roundTable = new RoundTable(60, 80);
    Stool stoolRight = new Stool(50, 15);
    Stool stoolLeft = new Stool(50, 15);
    
    DrawArray lamps = new DrawArray(createLamps(3, 400, 30), 3, 0, 0);
    DrawArray stools = new DrawArray(createStools(5, 80), 2, 0, 0, true, 0.2);
    
    DrawArray glasses = new DrawArray(createGlasses(4, 5), 10, 0, 0, true, 1.2);
    
    Bottle bottle = new Bottle(40);
    
    /**
    * moves all objects to correct position and draws
    */
    public void draw() {
        pushMatrix();
        
        translate(0, 200, 0); // move everything a little lower
        
        // light
        pushMatrix();
        translate(0, -backWall.getH(), 0);
        lamps.draw();
        popMatrix();

        pointLight(255, 255, 255, -610, -1460, 1200);
        
        float shelfDist = -tableShort.getW() * 1.5; // distance from midpoint to the back wall (z direction)
        // set floor
        pushMatrix();
        translate( -entranceWall.getW() / 2 + tableMain.getW() / 2, 0, entranceWall.getW() / 2 + shelfDist - shelf.getD() / 2);
        rotateX(PI / 2);
        floor.draw();
        popMatrix();
        
        // wall entrance
        pushMatrix();
        translate(tableMain.getW() / 2, -entranceWall.getH() / 2, entranceWall.getW() / 2 + shelfDist - shelf.getD() / 2);
        rotateY(PI / 2);
        entranceWall.draw();
        popMatrix();
        
        // wall back
        pushMatrix();
        translate( -entranceWall.getW() / 2 + tableMain.getW() / 2, -entranceWall.getH() / 2, shelfDist - shelf.getD() / 2);
        backWall.draw();
        popMatrix();
        
        // wall front
        pushMatrix();
        translate( -entranceWall.getW() / 2 + tableMain.getW() / 2, -entranceWall.getH() / 2, shelfDist - shelf.getD() / 2 + floor.getW());
        backWall.draw();
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
        translate( -tableMain.getW() / 2 - tableShort.getD() / 2, 0, -tableShort.getW() / 2 + tableMain.getD() / 2);
        rotateY( -PI / 2);
        tableShort.draw();
        popMatrix();
        
        // fill table
        pushMatrix();
        DrawableObject glass = glasses.getArray()[0];
        translate(0, -tableMain.getH() - glass.getH() / 2, 0);
        glasses.draw();
        translate(-tableMain.getW() * 0.4, glass.getH() / 2 - bottle.getH() / 2, 0);
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
        translate( -200, -roundTable.getH(), 300 - 15);
        roundTable.draw();

        // lamp above round table
        pushMatrix();
        translate(0, -backWall.getH() + roundTable.getH(), 0);
        tableLamp.draw();
        popMatrix();
        
        // two stools next to the round table
        float chairDist = 80;
        translate(0, roundTable.getH() - stoolRight.getH() / 2, -chairDist);
        stoolRight.draw();
        translate(0, 0, chairDist * 2);
        stoolLeft.draw();
        
        popMatrix();
        
        popMatrix();
    }
    
    /**
    * Creates array of specified size containing stool objects
    * (there was a problem with creating a static mathod in the stool class so we put that here)
    */
    Stool[] createStools(int n, float stoolHeight) {
        Stool[] stools = new Stool[n];
        for (int i = 0; i < n; ++i) {
            stools[i] = new Stool(stoolHeight);
        }
        return stools;
    }
    
    /**
    * Creates array of specified size containing glass objects
    * (there was a problem with creating a static mathod in the glass class so we put that here)
    */
    Glass[] createGlasses(int n, float radius) {
        Glass[] glasses = new Glass[n];
        for (int i = 0; i < n; ++i) {
            glasses[i] = new Glass(radius);
        }
        return glasses;
    }
    
    /**
    * Creates array of specified size containing lamp objects
    * (there was a problem with creating a static mathod in the lamp class so we put that here)
    */
    Lamp[] createLamps(int n, float lampHeight, float radius) {
        Lamp[] lamps = new Lamp[n];
        for (int i = 0; i < n; ++i) {
            lamps[i] = new Lamp(lampHeight, radius);
        }
        return lamps;
    }
}
