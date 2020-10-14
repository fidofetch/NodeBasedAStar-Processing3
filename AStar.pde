import java.util.Collections;
//Modified From https://rosettacode.org/wiki/A*_search_algorithm#Java
// Node class for convienience
    class Node implements Comparable {
        public Node parent;
        public int x, y;
        public double g;
        public double h;
        Node(Node parent, int xpos, int ypos, double g, double h) {
            this.parent = parent;
            this.x = xpos;
            this.y = ypos;
            this.g = g;
            this.h = h;
       }
       // Compare by f value (g + h)
       @Override
       public int compareTo(Object o) {
           Node that = (Node) o;
           return (int)((this.g + this.h) - (that.g + that.h));
       }
   }

class AStar {
    private final ArrayList<Node> open;
    private final ArrayList<Node> closed;
    private final ArrayList<Node> path;
    private Node now;
    private int xstart;
    private int ystart;
    private int xend, yend;
    private final boolean diag;
 
    
 
    AStar(int xstart, int ystart, boolean diag) {
        this.open = new ArrayList<Node>();
        this.closed = new ArrayList<Node>();
        this.path = new ArrayList<Node>();
        this.now = new Node(null, xstart, ystart, 0, 0);
        this.xstart = xstart;
        this.ystart = ystart;
        this.diag = diag;
    }
    /*
    ** Finds path to xend/yend or returns null
    **
    ** @param (int) xend coordinates of the target position
    ** @param (int) yend
    ** @return (List<Node> | null) the path
    */
    public ArrayList<Node> findPath(int xstart, int ystart, int xend, int yend) {
        this.open.clear();
        this.closed.clear();
        this.path.clear();
        this.now = new Node(null, xstart, ystart, 0, 0);
        this.xstart = xstart;
        this.ystart = ystart;
        this.xend = xend;
        this.yend = yend;
        this.closed.add(this.now);
        addNeigborsToOpenList();
        while (this.now.x != this.xend || this.now.y != this.yend) {
            if (this.open.isEmpty()) { // Nothing to examine
                return null;
            }
            this.now = this.open.get(0); // get first node (lowest f score)
            this.open.remove(0); // remove it
            this.closed.add(this.now); // and add to the closed
            addNeigborsToOpenList();
        }
        this.path.add(0, this.now);
        while (this.now.x != this.xstart || this.now.y != this.ystart) {
            this.now = this.now.parent;
            this.path.add(0, this.now);
        }
        return this.path;
    }
    /*
    ** Looks in a given List<> for a node
    **
    ** @return (bool) NeightborInListFound
    */
    private boolean findNeighborInList(ArrayList<Node> array, Node node) {
      for(Node n : array){
        if(n.x == node.x && n.y == node.y) return true;
      }
      return false;
    }
    /*
    ** Calulate distance between this.now and xend/yend
    **
    ** @return (int) distance
    */
    private double distance(int dx, int dy) {
        if (this.diag) { // if diagonal movement is alloweed
            return Math.hypot(this.now.x + dx - this.xend, this.now.y + dy - this.yend); // return hypothenuse
        } else {
            return Math.abs(this.now.x + dx - this.xend) + Math.abs(this.now.y + dy - this.yend); // else return "Manhattan distance"
        }
    }
    private void addNeigborsToOpenList() {
        Node node;
        
        Tile tile = grid.getTile(now.x, now.y);
        if(tile == null) println("NULL TILE");
        if(tile.nodeLeft != null){
          node = new Node(this.now, tile.nodeLeft.posX, tile.nodeLeft.posY, this.now.g, this.distance(tile.nodeLeft.posX, tile.nodeLeft.posY));
          if(!findNeighborInList(open, node) && !findNeighborInList(closed, node)) open.add(node);
        }
        if(tile.nodeRight != null){
          node = new Node(this.now, tile.nodeRight.posX, tile.nodeRight.posY, this.now.g, this.distance(tile.nodeRight.posX, tile.nodeRight.posY));
          if(!findNeighborInList(open, node) && !findNeighborInList(closed, node)) open.add(node);
        }
        if(tile.nodeUp != null){
          node = new Node(this.now, tile.nodeUp.posX, tile.nodeUp.posY, this.now.g, this.distance(tile.nodeUp.posX, tile.nodeUp.posY));
          if(!findNeighborInList(open, node) && !findNeighborInList(closed, node)) open.add(node);
        }
        if(tile.nodeDown != null){
          node = new Node(this.now, tile.nodeDown.posX, tile.nodeDown.posY, this.now.g, this.distance(tile.nodeDown.posX, tile.nodeDown.posY));
          if(!findNeighborInList(open, node) && !findNeighborInList(closed, node)) open.add(node);
        }
        Collections.sort(open);
    }
}
