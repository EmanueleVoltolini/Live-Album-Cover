class BrushCircle extends Brush {
  float radius;
    BrushCircle(PVector pos, float radius, float lifespan, color col){
        super(pos, lifespan, col);
        this.radius = radius;
    }

    void draw(){
        super.draw();
    }
}
