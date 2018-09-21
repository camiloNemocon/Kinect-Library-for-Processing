//-----------------------Librerias-------------------
import SimpleOpenNI.*;

//------------------------Variables-------------------
SimpleOpenNI  context;

////////////////////////kinect
PVector com = new PVector();                                   
PVector com2d = new PVector();   

 
 float manoIzqX;
 float manoIzqY;
 float manoIzqz; 
 
 float manoDerX;
 float manoDerY;
 float manoDerz; 
 
 float torsoX;
 float torsoY;
 float torsoZ;
 
 
 //------------------------Setup-------------------
void setup() 
{
  size(500,400);
  frameRate(30);
  
  noCursor();

  //kinect
  context = new SimpleOpenNI(this);
   
  if(context.isInit() == false)
  {
     println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
     exit();
     return;  
  }
  
  // enable depthMap generation 
  context.enableDepth();
   
  // enable skeleton generation for all joints
  context.enableUser();
}

//------------------------Draw-------------------
void draw() 
{
  
  //kinect
  // update the cam
  context.update();
  
  // draw depthImageMap
  image(context.depthImage(),0,0,400,300);
  //image(context.userImage(),0,300,400,300);
  
  int[] userList = context.getUsers();
  
  for(int i=0;i<userList.length;i++)
  {
    //dibuja los circulos a partir de las ubicaciones del esqueleto
    if(context.isTrackingSkeleton(userList[i]))
    {
      drawSkeleton(userList[i]);
    }
    
    // dibuja el centro de masa
    if(context.getCoM(userList[i],com))
    {
      context.convertRealWorldToProjective(com,com2d);
    }
  }   
  
  ellipse(manoIzqX,manoIzqY,15,15);
  ellipse(manoDerX,manoDerY,15,15);
  ellipse(torsoX,torsoY,15,15);


}
 
  
void onNewUser(SimpleOpenNI curContext, int userId)
{
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");
  
  curContext.startTrackingSkeleton(userId);
}

void onLostUser(SimpleOpenNI curContext, int userId)
{
  println("onLostUser - userId: " + userId);
}

void onVisibleUser(SimpleOpenNI curContext, int userId)
{
  //println("onVisibleUser - userId: " + userId);
}


  
// draw the skeleton with the selected joints
void drawSkeleton(int userId)
{
  PVector TorsoPos = new PVector();
  println(com2d.x);
  torsoX = com2d.x;
  torsoY = com2d.y;
  
  
  PVector manoIzqPos = new PVector();
  context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_HAND,manoIzqPos);
  //println(manoIzqPos.y);
  manoIzqX = manoIzqPos.x;
  manoIzqY = manoIzqPos.y;
  manoIzqz = manoIzqPos.z;
  
  
  PVector manoDerPos = new PVector();
  context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_HAND,manoDerPos);
  //println(manoDerPos.x);
  manoDerX = manoDerPos.x;
  manoDerY = manoDerPos.y;
  manoDerz = manoDerPos.z;  
  //println(manoDerz);

    
 /*
  context.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);

  context.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);

  context.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);

  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);

  context.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
  context.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);

  context.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
  context.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);  
  */
  
}
