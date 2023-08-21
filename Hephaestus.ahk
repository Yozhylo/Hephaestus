; Hephaestus v1.0.0

;@Ahk2Exe-AddResource icon.ico, RT_GROUP_ICON
;@Ahk2Exe-SetMainIcon icon.ico
;@Ahk2Exe-SetLanguage 0x0009
;@Ahk2Exe-SetVersion 1.0.0
;@Ahk2Exe-SetName Hephaestus
;@Ahk2Exe-SetDescription GW2 Mystic Forge macro

#Requires AutoHotkey v2.0
#SingleInstance

; Variables start
mousePosX := []
mousePosY := []
; Need to allow user to select amount of repetitions
repetitions := 40
; Variables end
; Functions start
setPosition(tooltipTitle, tooltipIndex)
{
  KeyWait "LButton", "D"
  KeyWait "LButton"
  MouseGetPos &xpos, &ypos
  mousePosX.Push(xpos)
  mousePosY.Push(ypos)
  ToolTip  tooltipTitle, xpos - 28, ypos - 20, tooltipIndex
}
; Functions end
; Making script work only with GW2 in focus
#HotIf WinActive("Guild Wars 2")

; Setting positions
F2::
{
  Loop 4
  setPosition("Item #" . A_Index, A_Index)
  setPosition("Button", 5)
}

; rem: MAKE YOUR OWN INPUT WITH GUI OBJECT
; INSTEAD OF USING THIS CRUTCH
!F3::
{
  global repetitions := InputBox("Enter the number of repetitions").Value
}

; Execute @ positions
F3::
{
  If (mousePosX.Length = 5 && mousePosY.Length = 5)
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
  Else
  {
    MsgBox "Please set the positions to continue", "WARNING", "icon!"
  }
}

; See positions
F1::
{
  If (mousePosX.Length = 5 && mousePosY.Length = 5)
  {
    ; Needs a rework, too much clutter
    MsgBox "The positions of interaction:" .
    "`n`n1st X: " . mousePosX[1] . 
    "`tY: " . mousePosY[1] . 
    "`n2nd X: " . mousePosX[2] . 
    "`tY: " . mousePosY[2] . 
    "`n3rd X: " . mousePosX[3] . 
    "`tY: " . mousePosY[3] .
    "`n4th X: " . mousePosX[4] . 
    "`tY: " . mousePosY[4] .
    "`n5th X: " . mousePosX[5] . 
    "`tY: " . mousePosY[5]
    , "Interact Positions", "iconi"
  }
  Else
  {
    MsgBox "Please set the positions to continue", "WARNING", "icon!"
  }
}

ESC:: Reload
F4:: ExitApp 0