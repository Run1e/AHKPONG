Class BallEntity extends Entity {
	MaxBoostVel := Height
	
	Tick() {
		this.Move(this.Vel.1 * Delta, this.Vel.2 * Delta)
		
		for Index, Paddle in [Player, Enemy] {
			if this.Intersect(Paddle) {
				if (this.Vel.1 > 0 && A_Index = 1) || (this.Vel.1 < 0 && A_Index = 2)
					continue
				this.Vel.1 *= -1
				this.Vel.2 := ((Paddle.Pos.2 + (Paddle.Pos.4 / 2)) - (this.Pos.2 + (this.Pos.4 / 2))) / (Paddle.Pos.4 / 2) * this.MaxBoostVel * -1
			}
		}
		
		/*
			if (this.Pos.1 < 0)
				this.Vel.1 *= -1, this.Pos.1 := 0
			else if (this.Pos.1 + this.Pos.3 > Width)
				this.Vel.1 *= -1, this.Pos.1 := Width - this.Pos.3
		*/
		
		if (this.Pos.2 < 0)
			this.Vel.2 *= -1, this.Pos.2 := 0
		else if (this.Pos.2 + this.Pos.4 > Height)
			this.Vel.2 *= -1, this.Pos.2 := Height - this.Pos.4
	}
}