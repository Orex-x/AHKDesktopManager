GetDesktopCount() {
    return DllCall("VirtualDesktopAccessor\GetDesktopCount", "Int")
}

GetCurrentDesktopNumber() {
    return DllCall("VirtualDesktopAccessor\GetCurrentDesktopNumber")
}

CreateDesktop(){
    return DllCall("VirtualDesktopAccessor\CreateDesktop", "Int") 
}

MoveCurrentWindowToDesktop(desktopNumber){
    hwnd := WinExist("A")   
    DllCall("VirtualDesktopAccessor\MoveWindowToDesktopNumber", "Ptr", hwnd, "Int", desktopNumber, "Int")
    DllCall("VirtualDesktopAccessor\GoToDesktopNumber", "Int", desktopNumber, "Int")
}

MoveCurrentWindowToNewDesktop() {
    createdDesktopNumber := CreateDesktop()
    MoveCurrentWindowToDesktop(createdDesktopNumber)
}

MoveCurrentWindowToNewDesktopFullScreen() {
    MoveCurrentWindowToNewDesktop()
    WinGet, activeWindow, ID, A 
    WinMaximize, ahk_id %activeWindow%
}

MoveCurrentWindowToLeft(){
    currentDesktopNumber := DllCall("VirtualDesktopAccessor\GetCurrentDesktopNumber")
    desktopCount := GetDesktopCount()

    if(currentDesktopNumber == 0)
    {
        MoveCurrentWindowToDesktop(desktopCount - 1)
    }
    else
    {
        MoveCurrentWindowToDesktop(currentDesktopNumber - 1)
    }
}

MoveCurrentWindowToRigth(){
    currentDesktopNumber := DllCall("VirtualDesktopAccessor\GetCurrentDesktopNumber")
    desktopCount := GetDesktopCount()

    if(currentDesktopNumber == desktopCount - 1)
    {
        MoveCurrentWindowToDesktop(0)
    }
    else
    {
        MoveCurrentWindowToDesktop(currentDesktopNumber + 1)
    }
}

RemoveDesktop(){
    desktopCount := GetDesktopCount()
    if(desktopCount > 1)
    {
        currentDesktopNumber := DllCall("VirtualDesktopAccessor\GetCurrentDesktopNumber")
        DllCall("VirtualDesktopAccessor\RemoveDesktop", "Int", currentDesktopNumber, "Int", currentDesktopNumber - 1, "Int")
    }
}

^n::MoveCurrentWindowToNewDesktop()

^+n::MoveCurrentWindowToNewDesktopFullScreen()

^m::RemoveDesktop()

^+#Left::MoveCurrentWindowToLeft()

^+#Right::MoveCurrentWindowToRigth()