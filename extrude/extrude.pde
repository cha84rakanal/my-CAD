import toxi.geom.Vec3D;
import toxi.geom.*;
import toxi.geom.mesh.*;
import controlP5.*;

ControlP5 scale_x_slider;

MouseCamera mouseCamera;
TriangleMesh mesh;

int mode;
int max;
int index = 0;

int scale_x = 0;

PVector CreatePolygonNormal( PVector A, PVector B, PVector C ) {
  
  PVector AB = A.sub(B);
  PVector BC = C.sub(B);

  PVector normal = AB.cross(BC);  //AB BCの外積
  normal.normalize();//単位ベクトルにする

  return normal;
}

void setup() {
  size(600,600,P3D);
  mouseCamera = new MouseCamera(800.0, 0, 0, (height/2.0)/tan(PI*30.0/180.0), 0, 0, 0, 0, 1, 0); // MouseCameraの生成
  mesh=(TriangleMesh)new STLReader().loadBinary(sketchPath("box.stl"),STLReader.TRIANGLEMESH).flipYAxis();

  scale_x_slider = new ControlP5(this);
  scale_x_slider.addSlider("scale_x")
  .setLabel("scale_x")
  .setColorCaptionLabel(color(0,0,0))
  .setRange(1, 500)//0~100の間
  .setValue(100)//初期値
  .setPosition(10, 40 + 180)//位置
  .setSize(200, 20);//大きさ
  
  mode = 1;
  max = mesh.getFaces().size();
  index = 0;
  
  draw();
}

void draw() {

    
    pushMatrix();
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
    
    if(mode == 1){
      stroke(255,0,0);
      strokeWeight(2);
      fill(255,0,0);
      beginShape(TRIANGLE);
      tri = mesh.getFaces().get(index);
      vertex(tri.a.x, tri.a.y, tri.a.z);
      vertex(tri.b.x, tri.b.y, tri.b.z);
      vertex(tri.c.x, tri.c.y, tri.c.z);
      endShape();
      
      PVector normal = CreatePolygonNormal(new PVector(tri.a.x, tri.a.y, tri.a.z),new PVector(tri.b.x, tri.b.y, tri.b.z),new PVector(tri.c.x, tri.c.y, tri.c.z));
      
      noFill();
      beginShape(TRIANGLE);
      vertex(tri.a.x + normal.x*scale_x, tri.a.y + normal.y*scale_x, tri.a.z + normal.z*scale_x);
      vertex(tri.b.x + normal.x*scale_x, tri.b.y + normal.y*scale_x, tri.b.z + normal.z*scale_x);
      vertex(tri.c.x + normal.x*scale_x, tri.c.y + normal.y*scale_x, tri.c.z + normal.z*scale_x);
      endShape();
      
      line(tri.a.x, tri.a.y, tri.a.z,tri.a.x + normal.x*scale_x, tri.a.y + normal.y*scale_x, tri.a.z + normal.z*scale_x);
      line(tri.b.x, tri.b.y, tri.b.z,tri.b.x + normal.x*scale_x, tri.b.y + normal.y*scale_x, tri.b.z + normal.z*scale_x);
      line(tri.c.x, tri.c.y, tri.c.z,tri.c.x + normal.x*scale_x, tri.c.y + normal.y*scale_x, tri.c.z + normal.z*scale_x);
    }
    
    popMatrix();
}

// マウス操作に応じたMouseCameraの関数を呼び出す
void mousePressed() {
  if(!((0 < mouseX && mouseX < 210 ) &&( 0 < mouseY && mouseY < 300 )))
    mouseCamera.mousePressed();
}
void mouseDragged() {
  if(!((0 < mouseX && mouseX < 210 ) &&( 0 < mouseY && mouseY < 300 )))
    mouseCamera.mouseDragged();
}
void mouseWheel(MouseEvent event) {
  if(!((0 < mouseX && mouseX < 210 ) &&( 0 < mouseY && mouseY < 300 )))
    mouseCamera.mouseWheel(event);
}

void keyPressed(){
  if(keyCode == UP){
    index = (max - 1 > index)? index + 1 : 0;
  }else if(keyCode == DOWN){
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
    default:
      break;
  }
}