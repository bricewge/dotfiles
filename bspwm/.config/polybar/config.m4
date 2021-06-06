; * bar
[bar/bspwm]
monitor = ${env:MONITOR:}
width = 100%
height = 30
fixed-center = true

background = COLOR_BACKGROUND
foreground = COLOR_FOREGROUND

line-size = 2
line-color = COLOR_SECONDARY

separator = %{`F'COLOR_FOREGROUND_DIM}|%{F-}
module-margin = 1
padding-right= 1

font-0 = MesloLGS Nerd Font:size=12;2
; font-1 = Noto Sans Symbols2:size=12;4
font-1 = Caudex:size=12:weight:bold;0
; Extra symbols: https://www.nerdfonts.com/cheat-sheet/

enable-ipc = true

# WAITING https://github.com/polybar/polybar/issues/1896
# modules-left = launcher mpv
modules-left = launcher
modules-center = bspwm
modules-right = volume battery date

tray-position = ${env:TRAY_POSITION:right}
tray-background = COLOR_BACKGROUND_ALT

wm-restack = bspwm
override-redirect = true

; * modules
; ** xwindow
[module/xwindow]
type = internal/xwindow
label = %title:0:30:...%

; ** bspwm
[module/bspwm]
type = internal/bspwm

; ᚠ ᚢ ᚦ ᚨ ᚱ ᚲ ᚷ ᚹ ᚺ ᚾ
;     ● ○
; ■ 🞐 ? □ ? ?

ws-icon-0 = 10;o
ws-icon-1 = 1;ᚠ
ws-icon-2 = 2;ᚢ
ws-icon-3 = 3;ᚦ
ws-icon-4 = 4;ᚨ
ws-icon-5 = 5;ᚱ
ws-icon-6 = 6;ᚲ
ws-icon-7 = 7;ᚹ
ws-icon-8 = 8;ᚺ
ws-icon-9 = 9;ᚾ
ws-icon-default = ■

; *** focused
label-focused-occupied = %icon%
label-focused-occupied-font = 2
label-focused-occupied-padding = 1
label-focused-occupied-background= COLOR_BACKGROUND_ALT
label-focused-empty = %icon%
label-focused-empty-font = 2
label-focused-empty-padding = 1
label-focused-empty-background = COLOR_BACKGROUND_ALT

; *** occupied
label-occupied = %icon%
label-occupied-font = 2
label-occupied-padding = 1
label-occupied-foreground = COLOR_FOREGROUND_ALT

; *** empty
label-empty = %icon%
label-empty-font = 2
label-empty-foreground = COLOR_FOREGROUND_ALT
label-empty-padding = 1

; *** urgent
; NOTE An urgent desktop is always occupied because it needs to contain an
; urgent window to be so.
label-urgent = %icon%
label-urgent-font = 2
label-urgent-foreground = COLOR_FOREGROUND_ALT
label-urgent-overline = COLOR_ALERT
label-urgent-padding = 1
label-focused-urgent = %icon%
label-focused-urgent-font = 2
label-focused-urgent-background = COLOR_BACKGROUND_ALT
label-focused-urgent-padding = 1
label-focused-urgent-overline= COLOR_ALERT

; ** mpd
[module/mpd]
type = internal/mpd

; Host where mpd is running (either ip or domain name)
; Can also be the full path to a unix socket where mpd is running.
host = 127.0.0.1
port = 6600
; password = mysecretpassword

; Seconds to sleep between progressbar/song timer sync
; Default: 1
interval = 2
format-online = %{A1:mpc toggle:} %{A3:mpc next:}<label-song> %{A} %{A}

label-song-foreground = COLOR_FOREGROUND_ALT

; ** date
[module/date]
type = internal/date
interval = 1

date =
time = %H:%M
date-alt = "%Y-%m-%d "
time-alt = %H:%M:%S
label = %date%%time%
format =  <label>

; ** volume
; TODO switch to https://github.com/marioortizmanero/polybar-pulseaudio-control
; TODO change bluetooth headset color when battery is low
[module/volume]
type = internal/pulseaudio
click-right = pkill -U $(id -u) pavucontrol || pavucontrol

format-volume = <ramp-volume> <label-volume>
format-muted = <label-muted>
label-volume = %percentage%%
label-muted = 婢 muted
label-muted-foreground = COLOR_FOREGROUND_ALT

ramp-volume-0 = 奄
ramp-volume-1 = 奔
ramp-volume-2 = 墳
ramp-headphones-0 = 

; ** battery
[module/battery]
type = internal/battery
battery = BAT0
adapter = AC
full-at = 98

label-full = %percentage%%
label-charging = %percentage%%
label-discharging = %percentage%%
format-full =  <label-full>
format-charging =  <label-charging>
format-discharging = <ramp-capacity> <label-discharging>%{F-}

ramp-capacity-0 = %{`F'COLOR_ALERT}
ramp-capacity-1 = 
ramp-capacity-2 = 
ramp-capacity-3 = 
ramp-capacity-4 = 

; ** launcher
[module/launcher]
; Indicate if sxhkd has began a chain and serve as a launcher
type = custom/ipc
hook-0 = echo  "%{`B'COLOR_FOREGROUND_ALT `F'COLOR_BACKGROUND}  %{B- F-}"
hook-1 = echo "%{`B'COLOR_PRIMARY `F'COLOR_BACKGROUND}  %{B- F-}"
initial = 1
click-left = rofi -show drun
click-right = rofi-power "bspc quit 1"

; ** mpv
[module/mpv]
type = custom/script
exec =  ~/.local/bin/mpvctl.sh
format-foreground = COLOR_FOREGROUND_ALT
tail = true
click-left = mpvctl toggle
click-right = mpvctl next
click-middle = mpvctl prev

; * settings
[settings]
screenchange-reload = true
;compositing-background = xor
;compositing-background = screen
;compositing-foreground = source
;compositing-border = over

[global/wm]
margin-top = 0
margin-bottom = 0
