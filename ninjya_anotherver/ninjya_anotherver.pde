//pdfにのってる英文の忍者ウイルスの模倣
//【参考】https://sites.google.com/site/gutugutu30/other/processingdehuamianquantinosukurinshottowocuoru
import java.awt.Dimension;
import java.awt.Toolkit;
import java.awt.Robot;
import java.awt.Rectangle;
import java.awt.image.*;

import java.awt.*;
import javax.swing.*;
PImage img;
PImage chara;
int posx, posy;
int ux, uy;
int dx, dy;
int count;

void setup() {
  size(displayWidth, displayHeight);
  img=screenshot();  
  chara=loadImage("character.png");
  posx=int(random(width-320));
  posy=int(random(height-450));
  ux=7;
  uy=20;
  dx=1;
  dy=1;
}

void draw() {
  background(255);
  image(img, 0, 0, width, height);
  if (count<20) {
    if (count>1) {
      for (int i=0; i<2; i++) {
        tint(255, 125);
        image(chara, posx-ux*i, posy-uy*i, 320, 450);
      }
    } else if (count>18) {
      for (int i=20-count; i>0; i--) {
        tint(255, 125);
        image(chara, posx-ux*i, posy-uy*i, 320, 450);
      }
    }
    posx+=ux;
    posy-=uy;
  } else if (count<22) {
    posx-=dx;
    posy+=dy;
  } else if (count==22) {
    delay(200);
    count=0;
  }
  noTint();
  image(chara, posx, posy, 320, 450);
  count++;
  if (posx<0) {
    ux=-ux;
    dx=-dx;
    posx=0;
  }
  if (posx+320>width) {
    ux=-ux;
    dx=-dx;
    posx=width-320;
  }
  if (posy<0) {
    uy=-uy;
    dy=-dy;
    posy=0;
  }
  if (posy+450>height) {
    uy=-uy;
    dy=-dy;
    posy=height-450;
  }
}

void mousePressed() {
  thread("popUpJPanel");
}

void popUpJPanel() {// pop up dialog
  JPanel panel = new JPanel();//JPanelっていうclassがもともとあるっぽい？
  panel.add(new JLabel("初期化してもよろしいでしょうか？"));//コメント
  int r = JOptionPane.showConfirmDialog(null, panel, "Feel Good", JOptionPane.YES_NO_OPTION, JOptionPane.QUESTION_MESSAGE);
  //JOptionPane.showConfirmDialod(null,JPanelを入れた名前,title,type,アイコン);
  //showConfirmDialog(Component parentComponent…
  //parentComponent - ダイアログを表示する Frame を指定する。 null の場合、または parentComponent が Frame を持たない場合、 デフォルトの Frame が使用される
  //とりまnull入れとけばいいのかな？
}


PImage screenshot() {//スクショをPImage型で保存
  try {
    Robot robot = new Robot();
    Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();//screensizeの値をここでとってるのか？
    BufferedImage img = robot.createScreenCapture(new Rectangle(screenSize));//もともとRobotclassにスクリーンキャプチャーの関数がる
    //Buffer型のImageはImageのRGBとかの値を保存してる型？
    return b2p(img);
  }
  catch(Exception e) {//決まり事
  }
  return null;//
}

PImage b2p(BufferedImage img1) {//BufferedImageをPImageに変更
  PImage img2 = createImage(img1.getWidth(), img1.getHeight(), ARGB);//YCbCrフレームをアプリケーション内で操作できるようにするには、フレームを ARGB に変換する必要があります。
  for (int i = 0; i < img2.width; i++) {
    for (int j = 0; j < img2.height; j++) {
      img2.pixels[i + j * img2.width] = img1.getRGB(i, j);
    }
  }
  return img2;
} 

