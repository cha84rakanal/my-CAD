import toxi.geom.Vec3D;
import toxi.geom.*;
import toxi.geom.mesh.*;

MouseCamera mouseCamera;
TriangleMesh mesh;

void setup() {
  size(600,600,P3D);
  mouseCamera = new MouseCamera(800.0, 0, 0, (height/2.0)/tan(PI*30.0/180.0), 0, 0, 0, 0, 1, 0); // MouseCameraの生成
  mesh=(TriangleMesh)new STLReader().loadBinary(sketchPath("Bunny-LowPoly.stl"),STLReader.TRIANGLEMESH).flipYAxis();
  draw();
}
void draw() {
    mouseCamera.update(); // MouseCameraのアップデート
    background(255);
    
    pushStyle();
    stroke(255,0,0);
    line(0,0,0,100,0,0);
    stroke(0,255,0);
    line(0,0,0,0,100,0);
    stroke(0,0,255);
    line(0,0,0,0,0,100);
    popStyle();
    
    noFill();
    stroke(0);
    strokeWeight(1);
    Face tri;
    beginShape(TRIANGLES);
    for(int i=0; i<mesh.getFaces().size(); i++){
      tri = mesh.getFaces().get(i);
      vertex(tri.a.x, tri.a.y, tri.a.z);
      vertex(tri.b.x, tri.b.y, tri.b.z);
      vertex(tri.c.x, tri.c.y, tri.c.z);
    }
    endShape();
}

// マウス操作に応じたMouseCameraの関数を呼び出す
void mousePressed() {
    mouseCamera.mousePressed();
}
void mouseDragged() {
    mouseCamera.mouseDragged();
}
void mouseWheel(MouseEvent event) {
    mouseCamera.mouseWheel(event);
}