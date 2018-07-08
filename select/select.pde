import toxi.geom.Vec3D;
import toxi.geom.*;
import toxi.geom.mesh.*;

MouseCamera mouseCamera;
TriangleMesh mesh;

int mode;
int max;
boolean flag = false;
int index = 0;

void setup() {
  size(600,600,P3D);
  mouseCamera = new MouseCamera(800.0, 0, 0, (height/2.0)/tan(PI*30.0/180.0), 0, 0, 0, 0, 1, 0); // MouseCameraの生成
  mesh=(TriangleMesh)new STLReader().loadBinary(sketchPath("Bunny-LowPoly.stl"),STLReader.TRIANGLEMESH).flipYAxis();
  mode = 0;
  max = mesh.getVertices().size();
  index = 0;
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
    
    switch(mode){
      case 0:
        break;
      case 1:
        break;
      case 2:       
        break;
      default:
        break;
    }
    
    if(mode == 2 && flag)
      stroke(255,255,0);
    else
      stroke(0,0,0);
    
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
    
    if(mode == 0){
      stroke(255,255,0);
      strokeWeight(5);
      tri = mesh.getFaces().get(index/3);
      switch(index%3){
      case 0:
        point(tri.a.x, tri.a.y, tri.a.z);
        break;
      case 1:
        point(tri.b.x, tri.b.y, tri.b.z);
        break;
      case 2:
        point(tri.c.x, tri.c.y, tri.c.z);
        break;
      default:
        break;
      }
    }
    
    if(mode == 1){
      stroke(255,255,0);
      strokeWeight(2);
      fill(255,255,0);
      beginShape(TRIANGLE);
      tri = mesh.getFaces().get(index);
      vertex(tri.a.x, tri.a.y, tri.a.z);
      vertex(tri.b.x, tri.b.y, tri.b.z);
      vertex(tri.c.x, tri.c.y, tri.c.z);
      endShape();
    }
    
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

void keyPressed(){
  if(keyCode == UP){
    flag = !flag;
    index = (max > index - 1)? index + 1 : 0;
  }else if(keyCode == DOWN){
    flag = !flag;
    index = (0 < index)? index - 1 : max - 1;
  }
  switch(key){
    case '0':
      mode = 0;
      max = mesh.getVertices().size();
      index = 0;
      break;
    case '1':
      mode = 1;
      max = mesh.getFaces().size();
      index = 0;
      break;
    case '2':
      mode = 2;
      flag = false;
      break;
    default:
      break;
  }
}