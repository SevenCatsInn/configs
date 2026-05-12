#Requires AutoHotkey v2-

; Close the current active window
#q:: 
{
    Title := WinGetTitle("A")
    WinClose(Title)
}


>!n::Run "firefox.exe -new-window"

; Remap Capslock to Ctrl:
Capslock::Ctrl  

; Remap CAPS to ESC, to toggle Capslock use Esc + Capslock
Capslock Up::{
    Send "{Ctrl Up}"
    If (A_PriorKey = "Capslock") ; if Capslock was pressed alone
        Send "{Esc}"
}
