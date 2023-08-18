; Hephaestus v0.9.0
#Requires AutoHotkey v2.0
#SingleInstance

; Variables start
mousePosX := []
mousePosY := []
; Need to allow user to select amount of repetitions
repetitions := 40
; Variables end

; Making script work only with GW2 in focus
#HotIf WinActive("Guild Wars 2")

; Setting positions
F2::
{
  ; Need to add functions here
  ; Need to add error catching
  Loop 4
  {
    KeyWait "LButton", "D"
    KeyWait "LButton"
    MouseGetPos &xpos, &ypos
    mousePosX.Push(xpos)
    mousePosY.Push(ypos)
    ToolTip  "Item #" . A_Index, xpos - 28, ypos - 20, A_Index
  }
  KeyWait "LButton", "D"
  KeyWait "LButton"
  MouseGetPos &xpos, &ypos
  mousePosX.Push(xpos)
  mousePosY.Push(ypos)
  ToolTip "Button", xpos - 28, ypos - 20, 5
}

; Execute @ positions
F3::
{
  BlockInput "MouseMove"
  Loop repetitions
  {
    Loop 4
    MouseClick "Left", mousePosX[A_Index], mousePosY[A_Index], 2, 50
    
    MouseClick "Left", mousePosX[5], mousePosY[5], 2, 50
    SendInput "F"
    ; Waiting for Mystic Forge button to become active
    ; Needs testing to find out the smallest delay
    Sleep 500
  }
  BlockInput "MouseMoveOff"
  MsgBox "Finished", "!", "T3 icon!"
}

; See positions
F1::
{
  ; Needs a rework, too much clutter
  MsgBox "1st X: " . mousePosX[1] . 
  "`t1st Y: " . mousePosY[1] . 
  "`n2nd X: " . mousePosX[2] . 
  "`t2nd Y: " . mousePosY[2] . 
  "`n3rd X: " . mousePosX[3] . 
  "`t3rd Y: " . mousePosY[3] .
  "`n4th X: " . mousePosX[4] . 
  "`t4th Y: " . mousePosY[4] .
  "`n5th X: " . mousePosX[5] . 
  "`t5th Y: " . mousePosY[5]
  , "Interact Positions", "iconi"
}

F5:: Reload
F4:: ExitApp 0