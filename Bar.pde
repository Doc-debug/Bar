
/**
* Main Class File
*
* Created by Sofia Martinez, Jan Naubert, Patrick Neumann on 12.10.2021
*/

BarScene scene;
BarAnimations animation;

void setup() {
    size(1920,1080,P3D);
    camera(-540, 0, -400, 0, 90, -429, 0, 1, 0);
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