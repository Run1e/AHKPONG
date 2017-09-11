Class Entity {
	__New(w, h, Color := "FFFFFF") {
		Gui, Add, Progress, % "hwndcontrolhwnd Background" Color " w" w " h" h
		ControlGetPos, x, y,,, controlhwnd
		this.Pos := [0, 0, w, h]
		this.Vel := [0, 0]
		this.Color := Color
		this.hwnd := controlhwnd
	}
	
	Move(x := 0, y := 0) {
		this.MoveTo(this.Pos.1 + x, this.Pos.2 + y)
	}
	
	MoveTo(x, y) {
		this.Pos.1 := x
		this.Pos.2 := y
		GuiControl, Move, % this.hwnd, % "x" x " y" y
	}
	
	Intersect(with) {
		if (this.Pos.1 < with.Pos.1 + with.Pos.3)
		&& (this.Pos.1 + this.Pos.3 > with.Pos.1)
		&& (this.Pos.2 < with.Pos.2 + with.Pos.4)
		&& (this.Pos.2 + this.Pos.4 > with.Pos.2)
			return true
		return false
	}
}