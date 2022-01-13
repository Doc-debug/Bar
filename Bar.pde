
/**
* Main Class File
*
* Created by Sofia Martinez, Jan Naubert, Patrick Neumann on 12.10.2021
*/

// import peasy.*;          // uncomment if you want to use peasycam
// PeasyCam camera;         // uncomment if you want to use peasycam

BarScene scene;
BarAnimations animation;

void setup() {
    size(1920,1080,P3D);
    camera(-540, 0, -400, 0, 90, -429, 0, 1, 0);
    // camera = new PeasyCam(this, -250, 50, -420, 300);    // uncomment if you want to use peasycam
    // camera.rotateY(-PI/2);                               // uncomment if you want to use peasycam
    // camera.rotateX(PI/15);                               // uncomment if you want to use peasycam
    frameRate(60);
    randomSeed(1);
    
    scene = new BarScene();
    animation = new BarAnimations();
    
}

void draw() {
    background(0);
    defaultStyle();
    
    translate(0, 0, -500);
    scene.draw();
    
    directionalLight(126, 126, 126, 0, 0, -1);
    ambientLight(102, 102, 102);
    animation.draw();
}

/**
* sets defaults for lighting in the whole scene
*/
void defaultStyle() {
    noStroke();
    lightFalloff(1, 0.00104, 0);
    ambientLight(102, 102, 102);
    ambient(51, 26, 0);
    lightSpecular(204, 204, 204);
    specular(255);
}