public class Tile{
  
  private boolean isOpen = false;
  int posX, posY;
  boolean hasNode = false;
  Tile up, right, down, left;
  Tile nodeUp, nodeRight, nodeDown, nodeLeft;
  Tile parent;
  int disUp, disRight, disDown, disLeft;
  
  public Tile(int posX, int posY){
    up = null;
    right = null;
    down = null;
    left = null;
    this.posX = posX;
    this.posY = posY;
  }
  
  public void setOpen(boolean b){
    isOpen = b;
    
    if(up != null && up.isOpen) up.nodeCheck();
    if(right != null && right.isOpen) right.nodeCheck();
    if(left != null && left.isOpen) left.nodeCheck();
    if(down != null && down.isOpen) down.nodeCheck();
    
    if(b==false){
      hasNode = false;
      
      return;
    }
    nodeCheck();
    
  }
  public boolean isOpen(){
    return isOpen;
  }
  
  public void nodeCheck(){
    if(!isOpen) return;
    hasNode = false;
    
    int count = 0;
    
    if(up != null && up.isOpen) count += 1;
    if(right != null && right.isOpen) count+=2;
    if(down != null && down.isOpen) count+= 4;
    if(left != null && left.isOpen) count+= 8;
    //Add a node for cases 1, 2, 3, 4, 6, 7, 8, 9, 11, 12, 13, 14, 15
    if(count != 0 && count != 5 && count != 10){
      hasNode = true;
    }
  }
  
  public void clearNodes(){
    nodeUp = null;
    nodeRight = null;
    nodeDown = null;
    nodeLeft = null;
    disUp = 0;
    disDown = 0;
    disLeft = 0;
    disRight = 0;
  }
  
  public Tile buildPathRight(){
    if(right != null && right.isOpen && hasNode){
      if(right.hasNode){
        nodeRight = right;
      }
      else{
        nodeRight = right.getNodeRight();
        
      }
      nodeRight.nodeLeft = this;
      disRight = nodeRight.posX-posX;
      nodeRight.disLeft = disRight;
    }
    
    return nodeRight;
  }
  
  public Tile buildPathUp(){
    if(up!= null && up.isOpen && hasNode){
      if(up.hasNode){
        nodeUp = up;
      }
      else{
        nodeUp = up.getNodeUp();
      }
      nodeUp.nodeDown = this;
      disUp = posY-nodeUp.posY;
      nodeUp.disDown = disUp;
    }
    
    return nodeUp;
  }
  
  public Tile getNodeRight(){
    if(hasNode) return this;
    return right.getNodeRight();
  }
  
  public Tile getNodeUp(){
    if(hasNode) return this;
    return up.getNodeUp();
  }
}
