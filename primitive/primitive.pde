import toxi.geom.Vec3D;
import toxi.geom.*;
import toxi.geom.mesh.*;

MouseCamera mouseCamera;

void setup() {
  size(600,600,P3D);
  mouseCamera = new MouseCamera(800.0, 0, 0, (height/2.0)/tan(PI*30.0/180.0), 0, 0, 0, 0, 1, 0); // MouseCameraの生成
  draw();
}
void draw() {
    mouseCamera.update(); // MouseCameraのアップデート
    background(255);
    
    pushStyle();
    stroke(255,0,0);
    line(0,0,0,300,0,0);
    stroke(0,255,0);
    line(0,0,0,0,300,0);
    stroke(0,0,255);
    line(0,0,0,0,0,300);
    popStyle();
    
    sphere(100);
    pushMatrix();
      translate(300,0);
      torus(100, 50, 60, 30);
    popMatrix();
    pushMatrix();
      translate(-200,0);
      box(100);
    popMatrix();
    pushMatrix();
      translate(-400,0);
      cylinder(50,50,50,200);
    popMatrix();
    pushMatrix();
      translate(-600,0);
      cylinder(50,50,0,200);
    popMatrix();
}

void torus(float R, float r, int countS, int countT) {
    for (int s=0; s<countS; s++) {
        float theta1 = map(s, 0, countS, 0, 2*PI);
        float theta2 = map(s+1, 0, countS, 0, 2*PI);
        beginShape(TRIANGLE_STRIP);
        // beginShape(QUAD_STRIP);
        for (int t=0; t<=countT; t++) {
            float phi = map(t, 0, countT, 0, 2*PI);
            vertex((R+r*cos(phi))*cos(theta1), (R+r*cos(phi))*sin(theta1), r*sin(phi));
            vertex((R+r*cos(phi))*cos(theta2), (R+r*cos(phi))*sin(theta2), r*sin(phi));
        }
        endShape();
    }
}

void cylinder( int sides, float r1, float r2, float h){
    float angle = 360 / sides;
    float halfHeight = h / 2;
    // top
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r1;
        float y = sin( radians( i * angle ) ) * r1;
        vertex( x, y, -halfHeight);
    }
    endShape(CLOSE);
    // bottom
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r2;
        float y = sin( radians( i * angle ) ) * r2;
        vertex( x, y, halfHeight);
    }
    endShape(CLOSE);
    // draw body
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sides + 1; i++) {
        float x1 = cos( radians( i * angle ) ) * r1;
        float y1 = sin( radians( i * angle ) ) * r1;
        float x2 = cos( radians( i * angle ) ) * r2;
        float y2 = sin( radians( i * angle ) ) * r2;
        vertex( x1, y1, -halfHeight);
        vertex( x2, y2, halfHeight);
    }
    endShape(CLOSE);
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