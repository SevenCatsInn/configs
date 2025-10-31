#Requires AutoHotkey v2-

; Close the current active window
#q:: 
{
    Title := WinGetTitle("A")
    WinClose(Title)
}

; Home and end keys, with selecting capabilities using shift
<!,::
{
    Send "{Home}"
}

<!+,::
{
    Send "+{Home}"
}

<!.::
{
    Send "{End}"
}

<!+.::
{
    Send "+{End}"
}

; Page Up and Page Down
<!d::
{
    Send "{PgDn}"
}

<!u::
{
    Send "{PgUp}"
}

; Move between words (like Ctrl+L/R) using b and w keys, with selection capabilities
<!b::
{
    send "^{left}"
}

+<!b::
{
    Send "+^{Left}"
}

<!w::
{
    send "^{right}"
}

+<!w::
{
    Send "^+{Right}"
}


; Map hjkl to vim-like arrow keys, with selection capabilities
<!j::
{
    Send "{Down}"
}


<!k::
{
    Send "{Up}"
}

<!h::
{
    Send "{Left}"
}


<!l::
{
    Send "{Right}"
}

+<!j::
{
    Send "+{Down}"
}


+<!k::
{
    Send "+{Up}"
}

+<!h::
{
    Send "+{Left}"
}


+<!l::
{
    Send "+{Right}"
}


; Delete using x like in vim
<!x::
{
    Send "{DEL}"
}



; Remap Capslock to Ctrl:
Capslock::Ctrl  

; Remap CAPS to ESC, to toggle Capslock use Esc + Capslock
Capslock Up::{
    Send "{Ctrl Up}"
    If (A_PriorKey = "Capslock") ; if Capslock was pressed alone
        Send "{Esc}"
}

; Original Esc key works normally except when presseed with CapsLock
; in that case trigger the actual capslock
~Esc::Send "{Esc}"
Esc & Capslock::Capslock


; Media Controls
; Alt+[ = Previous Track
>^[:: Send "{Media_Prev}"

; Alt+] = Next Track
>^]:: Send "{Media_Next}"

; Alt+\ = Play/Pause
>^\:: Send "{Media_Play_Pause}"
