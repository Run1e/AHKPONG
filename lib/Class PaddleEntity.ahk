Class PaddleEntity extends Entity {
	Force := 125000
	Weight := 10
	
	Tick() {
		this.Vel.2 += -this.Vel.2 / this.Weight * Delta * 100
		if (this.Pos.2 < 0)
			this.Vel.2 := 0, this.Pos.2 := 0
		if (this.Pos.2 + this.Pos.4 > Height)
			this.Vel.2 := 0, this.Pos.2 := Height - this.Pos.4
		this.Move(0, this.Vel.2 * Delta)
	}
	
	Up() {
		this.Vel.2 -= this.Force / this.Weight * Delta * Scale
	}
	
	Down() {
		this.Vel.2 += this.Force / this.Weight * Delta * Scale
	}
}