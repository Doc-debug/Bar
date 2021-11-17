class Joint {
    String name;
    int isRoot = 0;
    int isEndSite = 0;
    Joint parent;
    PVector offset = new PVector();
    //transformation types (CHANNELS):
    String[] rotationChannels = new String[3];
    //current transformation matrix applied to this joint's children:
    float[][] transMat = {{1., 0., 0.} ,{0., 1., 0.} ,{0., 0., 1.} };
    //list of PVector, xyz position at each frame:
    ArrayList<PVector> position = new ArrayList<PVector>();  
}