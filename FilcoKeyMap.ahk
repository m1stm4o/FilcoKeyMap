;这个脚本将按键映射为类似Filco air键盘的快捷键，用CapsLock代替Filco air的Fn键，双击CapsLock为原CapsLock功能
;UTF-8 with BOM instead of UTF-8

;设置双击托盘图标弹出按键映射说明窗口
Menu, Tray, Add, ShowTips, ShowTips ;增加一个菜单项，默认动作必须调用某个菜单项
Menu, Tray, Default, ShowTips ;设置默认动作为ShowTips菜单项
Menu, Tray, Add ;分割线
Menu, Tray, NoStandard ;移除标准菜单，Open/Exit等
Menu, Tray, Standard ;重新加回标准菜单，这样会把标准菜单放在后面

Menu, Tray, Tip, 将编辑键映射到主键盘区 ;托盘图标Tip

SetCapsLockState, AlwaysOff

; labels below ======================================================================

;如果用CapsLock & l::Send {Right}这样的形式，Ctrl+Capslock+l不能表现为Ctrl+Right
CapsLock & s::Left
CapsLock & f::Right
CapsLock & e::Up
CapsLock & d::Down

CapsLock & j::Ins
CapsLock & m::Del
CapsLock & k::Home
CapsLock & ,::End
CapsLock & l::PgUp
CapsLock & .::PgDn
CapsLock & `;::BS ;分号需要转义，`转义符

CapsLock & i::PrintScreen
CapsLock & o::ScrollLock

; ;双击切换大小写
; ;'~Capslock::'会在按下按键时开始计时，'CapsLock::'会在释放按键时计时
; CapsLock::
;     KeyWait, CapsLock, DT0.4 ;等待被按下
;     if ErrorLevel = 1
;         Return
;     KeyWait, CapsLock ;等待抬起
;     state := GetKeyState("Capslock", "T")
;     if state
;         SetCapsLockState, AlwaysOff
;     else
;         SetCapsLockState, AlwaysOn
; Return

~CapsLock::
    if (A_PriorHotkey <> "~CapsLock" or A_TimeSincePriorHotkey > 400)
    {
        ; Too much time between presses, so this isn't a double-press.
        KeyWait, CapsLock ;等待按键抬起，避免按键按下时持续触发
        return
    }
    ;KeyWait, CapsLock ;加上这句的话，会等待第二次按键抬起时才切换大小写
    state := GetKeyState("Capslock", "T")
    if state
        SetCapsLockState, AlwaysOff
    else
        SetCapsLockState, AlwaysOn
return

; ;原本想用Shift+CapsLock切换大小写，但这样用Shift+CapsLock+f模拟Shift+Right的时候Shift+CapsLock也会触发
; Shift & CapsLock::
;     state := GetKeyState("Capslock", "T")
;     if state
;         SetCapsLockState, AlwaysOff
;     else
;         SetCapsLockState, AlwaysOn
;     KeyWait, CapsLock ;按键抬起后才返回，阻止重入
; return

ShowTips:
    GUI, Destroy
    GUI, Add, Text, , 
    (
    CapsLock + s :    ←
    CapsLock + f :    →
    CapsLock + e :    ↑
    CapsLock + d :    ↓

    CapsLock + j :    Insert
    CapsLock + m :    Delete
    CapsLock + k :    Home
    CapsLock + , :    End
    CapsLock + l :    PageUp
    CapsLock + . :    PageDown
    CapsLock + ; :    Backspace

    CapsLock + i :    PrintScreen
    CapsLock + o :    ScrollLock

    双击CapsLock切换大小写
    )
    GUI, Show
Return