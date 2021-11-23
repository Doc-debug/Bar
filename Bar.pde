import processing.opengl.*;
import peasy.*;

PeasyCam camera;

BarScene scene;
BarAnimations animation;

void setup() {
    size(1920,1080,P3D);
    camera = new PeasyCam(this, -300, 50, -350, 300);
    camera.rotateY(-PI/2);
    camera.rotateX(PI/15);
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

void defaultStyle() {
    noStroke();
    ambientLight(102, 102, 102);
    ambient(51, 26, 0);
    lightSpecular(204, 204, 204);
    specular(255);
}