//pdfにのってる英文の忍者ウイルスの模倣
//【参考】https://sites.google.com/site/gutugutu30/other/processingdehuamianquantinosukurinshottowocuoru
import java.awt.Dimension;
import java.awt.Toolkit;
import java.awt.Robot;
import java.awt.Rectangle;
import java.awt.image.*;

import java.awt.*;//popupの部分
import javax.swing.*;
PImage img;
PImage chara;
int posx, posy;
int disx, disy;

void setup() {
  size(displayWidth, displayHeight);
  img=screenshot();  
  chara=loadImage("character.png");
  posx=int(random(width-320));
  posy=int(random(height-450));
  disx=10;
  disy=10;
}

void draw() {
  background(255);
  image(img, 0, 0, width, height);
  for (int i=0; i<3; i++) {
    tint(255, 255-255/3*(i+1));
    image(chara, posx-disx*i, posy-disy*i, 320, 450);
  }
  posx+=disx;
  posy+=disy;
  noTint();
  image(chara, posx, posy, 320, 450);
if (posx<0) {
   disx=-disx;
    posx=0;
  }
  if (posx+320>width) {
   disx=-disx;
    posx=width-320;
  }
  if (posy<0) {
     disy=-disy;
    posy=0;
  }
  if (posy+450>height) {
     disy=-disy;
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

