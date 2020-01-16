﻿#LButton:: ;Win+左键双击打开鼠标所指进程的路径
if (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 300) ; 检测双击
{
MouseGetPos,,, winuid ;若脚本无管理员权限，可能无法获取管理员窗口的uid
;特别地，在Notepad3中Win+左键双击会打开当前文件的路径
WinGetTitle, notetitle, ahk_id %winuid%
WinGetClass, noteclass, ahk_id %winuid%
If ((noteclass = "Notepad3U" || noteclass = "Notepad3") && notetitle != "未命名 - Notepad3（管理员权限）" && notetitle != "未命名 - Notepad3")
{
StringSplit, notepath, notetitle, :
;处理文件目录
IfInString, notepath2, - Notepad3（管理员权限）
    StringTrimRight, notepath2, notepath2, 7
StringTrimRight, notepath2, notepath2, 12
IfInString, notepath2, 只读
    StringTrimRight, notepath2, notepath2, 5
StringRight, disk, notepath1, 1
notepath2= %disk%:%notepath2%`\
;处理文件名
IfInString, notepath1, *
    StringTrimLeft, notepath1, notepath1, 2
StringTrimRight, notepath1, notepath1, 3
notepath= %notepath2%%notepath1%
Run explorer /select`, %notepath%
return
}
WinGet, winpath, ProcessPath, ahk_id %winuid%
; WinGet, winname, ProcessName, ahk_id %winuid%
; StringGetPos, pos, winpath, \, R
; StringTrimRight, winpath, winpath, StrLen(winpath)-pos-1
; clipboard = %winpath%
; tooltip copied path of %winname%
; sleep 1000
; tooltip
Run explorer /select`, %winpath%
}
return
