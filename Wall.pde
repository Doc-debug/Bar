public class Wall extends DrawableObject{
    float w;
    float h;
    float d;

    public Wall (float shelfWidth, float shelfHeight, float shelfDepth) {
        this.w = shelfWidth;
        this.h = shelfHeight;
        this.d = shelfDepth;
    }

    public void draw() {
        pushMatrix();
        pushStyle();
            setColorWall();
            box(w,h,d);
        popStyle();
        popMatrix();
    }

    public float getH() {
        return h;
    }

    public float getW() {
        return w;
    }

    public float getD() {
        return d;
    }

    private void setColorWall() {
        fill(230);
        shininess(100);
    }

}
