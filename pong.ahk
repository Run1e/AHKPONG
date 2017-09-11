#SingleInstance Force
#NoEnv
#Persistent

SetBatchLines -1

global MaxFPS := 0
	, Scale := 1
	, Width := 1280 * Scale
	, Height := 720 * Scale
	, BallSize := 15 ; in pixels at 1280x720
	, PaddleHeight := 130
	, PaddleWidth := 10
	, MinDeltaTime := 1/MaxFPS
	, Player, Enemy, Ball
	, Delta, FPSCounter := 0, CurrentTime

DllCall("QueryPerformanceFrequency", "Int64P", QPF)

Gui, Margin, 0, 0
Gui, Color, 000000
Gui, -MinimizeBox -Caption +Border
Gui, Show, % "w" Width " h" Height, PONG

Gui, Add, Text, % "x5 y5 cFFFFFF w" Width / 10 - 10

Ball := new BallEntity(BallSize * Scale, BallSize * Scale)

Player := new AIEntity(PaddleWidth * Scale, PaddleHeight * Scale)
Player.MoveTo(Width / 10, Height / 2 - Player.Pos.4 / 2)

Enemy := new AIEntity(PaddleWidth * Scale, PaddleHeight * Scale)
Enemy.MoveTo(Width / 10 * 9 - Enemy.Pos.3, Height / 2 - Enemy.Pos.4 / 2)

gosub FPSCounter
SetTimer, FPSCounter, 1000
DllCall("QueryPerformanceCounter", "Int64P", CurrentTime)

ResetGame()

; game loop
Loop {
	DllCall("QueryPerformanceCounter", "Int64P", NewTime)
	FrameTime := (NewTime - CurrentTime) / QPF
	CurrentTime := NewTime
	DeltaTime += FrameTime
	if (DeltaTime < MinDeltaTime)
		continue
	Delta := FrameTime > DeltaTime ? FrameTime : DeltaTime
	DeltaTime := 0
	
	if (Ball.Pos.1 > Width) || (Ball.Pos.1 + Ball.Pos.3 < 0) {
		ResetGame()
	}
	
	FPSCounter++
	
	if GetKeyState("Down", "P")
		Player.Down()
	else if GetKeyState("Up", "P")
		Player.Up()
	
	if (Ball.Pos.1 > Width / 5 * 3)
		Enemy.Calc()
	
	Player.Tick()
	Enemy.Tick()
	Ball.Tick()
}
return

ResetGame() {
	Ball.MoveTo(Width / 2 - Ball.Pos.3 / 2, Height / 2 - Ball.Pos.4 / 2)
	Ball.Vel := [0, 0]
	for Index, Paddle in [Player, Enemy] {
		Paddle.MoveTo(Paddle.Pos.1, Height / 2 - Paddle.Pos.4 / 2)
		Paddle.Vel.2 := 0
	}
	SetTimer, StartGame, -1000
}

StartGame:
Ball.Vel := [Width * 0.85 * (Random(0, 1) ? 1 : -1), Random(-Ball.MaxBoostVel, Ball.MaxBoostVel) / 2]
return

FPSCounter:
GuiControl,, Static1, FPS: %FPSCounter%
FPSCounter := 0
return

GuiEscape:
ExitApp

#Include lib\Class Entity.ahk
#Include lib\Class BallEntity.ahk
#Include lib\Class PaddleEntity.ahk
#Include lib\Class AIEntity.ahk
#Include lib\Functions.ahk
