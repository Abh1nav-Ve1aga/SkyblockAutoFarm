#Requires AutoHotkey v2.0
#SingleInstance force

toggle := false
F1:: {
	offset := 0
	global toggle := !toggle
	while(toggle){
		if toggle {
			; always break crops
			Send("{q down}")
		
			; transition into "wa" path
			Send("{a down}")
			Sleep(50)
			Send("{a up}")
			
			loop 6 {
				; "wa" path
				Send("{a down}")
				Send("{w down}")
				offset := Random(0 , 200)
				Sleep(72000+offset)
				Send("{a up}")
				Send("{w up}")

				; "wd: path
				Send("{d down}")
				Send("{w down}")
				offset := Random(0 , 200)
				Sleep(72000+offset)
				Send("{d up}")
				Send("{w up}")
			}
			
			; down path
			Send("{s down}")
			offset := Random(0 , 200)
			Sleep(3800+offset)
			Send("{s up}")
		}			
	}
	else{
		Send("{q up}")
		Send("{w up}")
		Send("{a up}")
		Send("{s up}")
	}
}
