class BrushSystem{

	ArrayList<Brush> particles;
	PVector origin;
	int n_particles = 1000;


	BrushSystem(){
		this.particles = new ArrayList<Brush>();
		this.origin=new PVector(width/2, height/2);
		for(int p=0; p<this.n_particles; p++){
			this.addParticle();
		}

	}

	void addParticle(){
		PVector pos = new PVector(random(0, size), random(0, size));
		float lifespan = random(0.1, 0.3);
		float radius = random(1, 2);
		color col = img_cover.get(int(pos.x/size*img_cover.width), int(pos.y/size*img_cover.height));
		this.particles.add(new BrushCircle(pos, radius, lifespan, col));   
	}

	void update(){
		Brush p;
		for(int i=0; i<this.particles.size(); i++){
			p=this.particles.get(i);
			PVector force = new PVector(random(-0.2, 0.2),random(-0.1, -0.1));
			p.applyForce(force);
			p.update();
		}
	}

	void draw(){ 
		Brush p;
		for (int i = this.particles.size() - 1; i >= 0; i--) {
			p=this.particles.get(i);
			p.draw();
			p.current_lifespan -= 1.0/frame_rate;
			if(p.isDead()){
				particles.remove(i);
				this.addParticle();
			}
		}
	}

}
