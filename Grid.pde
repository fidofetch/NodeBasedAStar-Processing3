public class Grid{
  private Tile[][] tiles;
  private int res;
  private int numX, numY;
  
  Grid(int res){
    this.res = res;
    this.numX = width/res;
    this.numY = height/res;
    tiles = new Tile[numX][numY];
    
    for(int y = 0; y<numY; y++){
      for(int x = 0; x<numX; x++){
        tiles[x][y] = new Tile(x, y);
      }
    }
    for(int y = 0; y<numY; y++){
      for(int x = 0; x<numX; x++){
        Tile curTile = tiles[x][y];
        if(x > 0) curTile.left = tiles[x-1][y];
        if(x < numX-1) curTile.right = tiles[x+1][y];
        if(y > 0) curTile.up = tiles[x][y-1];
        if(y < numY-1) curTile.down = tiles[x][y+1];
      }
    }
  }
  
  public void createPaths(){
    for(int y = 0; y<numY; y++){
      for(int x = 0; x<numX; x++){
        if(!tiles[x][y].hasNode) continue;
        tiles[x][y].buildPathRight();
        tiles[x][y].buildPathUp();
      }
    }
  }
  
  public void clearPaths(){
    for(int y = 0; y<numY; y++){
      for(int x = 0; x<numX; x++){
        tiles[x][y].clearNodes();
      }
    }
  }

  
  public Tile getTile(int x, int y){
    return tiles[x][y];
  }
  
  public Tile getTileAtMouse(int mX, int mY){
    int x = mX/res;
    int y = mY/res;
    if(x<0 || x>numX-1 || y<0 || y>numY-1) return null;
    return tiles[x][y];
  }
  
  public void render(){
    for(int y = 0; y<numY; y++){
      for(int x = 0; x<numX; x++){
        fill(255);
        if(tiles[x][y].isOpen()) fill(0);
        square(x*res, y*res, res);
        if(tiles[x][y].hasNode){
          fill(0, 255, 0);
          circle(x*res+res/2, y*res+res/2, res/2);  
        }
      }
    }
  }
}
