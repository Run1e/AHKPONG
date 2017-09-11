Class AIEntity extends PaddleEntity {
	Calc() {
		if (Ball.Pos.2 + (Ball.Pos.4 / 2) > this.Pos.2 + (this.Pos.4 / 2))
			this.Down()
		else
			this.Up()
	}
}