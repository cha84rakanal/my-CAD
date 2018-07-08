import toxi.geom.Vec3D;
import toxi.geom.*;
import toxi.geom.mesh.*;
import controlP5.*;

ControlP5 pos_x_slider;
ControlP5 pos_y_slider;
ControlP5 pos_z_slider;
int pos_x;
int pos_y;
int pos_z;

ControlP5 rot_x_slider;
ControlP5 rot_y_slider;
ControlP5 rot_z_slider;
int rot_x;
int rot_y;
int rot_z;

ControlP5 scale_x_slider;
ControlP5 scale_y_slider;
ControlP5 scale_z_slider;
int scale_x;
int scale_y;
int scale_z;

MouseCamera mouseCamera;
TriangleMesh mesh;

void setup() {
  size(600,600,P3D);
  mouseCamera = new MouseCamera(800.0, 0, 0, (height/2.0)/tan(PI*30.0/180.0), 0, 0, 0, 0, 1, 0); // MouseCameraの生成
  mesh=(TriangleMesh)new STLReader().loadBinary(sketchPath("Bunny-LowPoly.stl"),STLReader.TRIANGLEMESH).flipYAxis();
  
  pos_x_slider = new ControlP5(this);
  pos_x_slider.addSlider("pos_x")
  .setLabel("pos_x")
  .setColorCaptionLabel(color(0,0,0))
  .setRange(-500, 500)//0~100の間
  .setValue(0)//初期値
  .setPosition(10, 40)//位置
  .setSize(200, 20);//大きさ
  
  pos_y_slider = new ControlP5(this);
  pos_y_slider.addSlider("pos_y")
  .setLabel("pos_y")
  .setColorCaptionLabel(color(0,0,0))
  .setRange(-500, 500)//0~100の間
  .setValue(0)//初期値
  .setPosition(10, 40 + 30)//位置
  .setSize(200, 20);//大きさ
  
  pos_z_slider = new ControlP5(this);
  pos_z_slider.addSlider("pos_z")
  .setLabel("pos_z")
  .setColorCaptionLabel(color(0,0,0))
  .setRange(-500, 500)//0~100の間
  .setValue(0)//初期値
  .setPosition(10, 40 + 60)//位置
  .setSize(200, 20);//大きさ
  
  rot_x_slider = new ControlP5(this);
  rot_x_slider.addSlider("rot_x")
  .setLabel("rot_x")
  .setColorCaptionLabel(color(0,0,0))
  .setRange(-170, 170)//0~100の間
  .setValue(0)//初期値
  .setPosition(10, 40 + 90)//位置
  .setSize(200, 20);//大きさ
  
  rot_y_slider = new ControlP5(this);
  rot_y_slider.addSlider("rot_y")
  .setLabel("rot_y")
  .setColorCaptionLabel(color(0,0,0))
  .setRange(-170, 170)//0~100の間
  .setValue(0)//初期値
  .setPosition(10, 40 + 120)//位置
  .setSize(200, 20);//大きさ
  
  rot_z_slider = new ControlP5(this);
  rot_z_slider.addSlider("rot_z")
  .setLabel("rot_z")
  .setColorCaptionLabel(color(0,0,0))
  .setRange(-170, 170)//0~100の間
  .setValue(0)//初期値
  .setPosition(10, 40 + 150)//位置
  .setSize(200, 20);//大きさ
  
  scale_x_slider = new ControlP5(this);
  scale_x_slider.addSlider("scale_x")
  .setLabel("scale_x")
  .setColorCaptionLabel(color(0,0,0))
  .setRange(1, 500)//0~100の間
  .setValue(100)//初期値
  .setPosition(10, 40 + 180)//位置
  .setSize(200, 20);//大きさ
  
  scale_y_slider = new ControlP5(this);
  scale_y_slider.addSlider("scale_y")
  .setLabel("scale_y")
  .setColorCaptionLabel(color(0,0,0))
  .setRange(1, 500)//0~100の間
  .setValue(100)//初期値
  .setPosition(10, 40 + 210)//位置
  .setSize(200, 20);//大きさ
  
  scale_z_slider = new ControlP5(this);
  scale_z_slider.addSlider("scale_z")
  .setLabel("scale_z")
  .setColorCaptionLabel(color(0,0,0))
  .setRange(1, 500)//0~100の間
  .setValue(100)//初期値
  .setPosition(10, 40 + 240)//位置
  .setSize(200, 20);//大きさ
  
  draw();
}

void draw() {
  
    println(pos_x);
    
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
    
    translate(pos_x,pos_y,pos_z);
    
    rotateX(radians(rot_x));
    rotateY(radians(rot_y));
    rotateZ(radians(rot_z));

    
    noFill();
    stroke(0);
    strokeWeight(1);
    Face tri;
    beginShape(TRIANGLES);
    for(int i=0; i<mesh.getFaces().size(); i++){
      tri = mesh.getFaces().get(i);
      vertex(tri.a.x * scale_x/100.0, tri.a.y * scale_y/100.0, tri.a.z * scale_z/100.0);
      vertex(tri.b.x * scale_x/100.0, tri.b.y * scale_y/100.0, tri.b.z * scale_z/100.0);
      vertex(tri.c.x * scale_x/100.0, tri.c.y * scale_y/100.0, tri.c.z * scale_z/100.0);
    }
    endShape();
    
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