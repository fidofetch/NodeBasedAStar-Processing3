Grid grid;
AStar aStar;
ArrayList<Node> path;

void setup(){
  size(800, 800);
  grid = new Grid(10);
  aStar = new AStar(0,0, false);
}

void draw(){
  background(0);
  grid.render();
  drawPath();
}

void mousePressed(){
  setTile();
}
void mouseDragged(){
  setTile();
}

void keyReleased(){
  if(key == ' '){
    grid.clearPaths();
    grid.createPaths();
    path = aStar.findPath(0, 0, grid.tiles.length-1, grid.tiles[0].length-1);
  }
}

public void setTile(){
  if(mouseButton == LEFT){
    Tile curTile = grid.getTileAtMouse(mouseX,mouseY);
    if(curTile!=null) curTile.setOpen(true);
  }
  if(mouseButton == RIGHT){
    Tile curTile = grid.getTileAtMouse(mouseX,mouseY);
    if(curTile!=null) curTile.setOpen(false);
  }
}

public void drawPath(){
    if(path!=null){
      for(Node n : path){
        strokeWeight(grid.res/4);
        stroke(255, 0, 0);
        if(n.parent!=null)line(n.x*grid.res+grid.res/2, n.y*grid.res+grid.res/2, n.parent.x*grid.res+grid.res/2, n.parent.y*grid.res+grid.res/2);
        strokeWeight(1);
        stroke(0);
       }
   }
}
