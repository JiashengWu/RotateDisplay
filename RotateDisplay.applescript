------------------------------------------------------------
-- Parameters
------------------------------------------------------------
set externalDisplay to "Acer CB281HK"
set landscapeKey to "Standard"
set portraitKey to "90"

------------------------------------------------------------
-- Toggle landscape/portrait view of external display 
------------------------------------------------------------
tell application "System Preferences"
	reveal anchor "displaysDisplayTab" of pane id "com.apple.preference.displays"
end tell
tell application "System Events"
	tell process "System Preferences"
		set frontmost to true
		tell window externalDisplay
			set _rotation to pop up button "Rotation:" of tab group 1
			if value of _rotation contains landscapeKey then
				log "Currently in landscape display."
				click _rotation
				keystroke portraitKey & return
				set _confirmed to false
				repeat until _confirmed
					try
						tell sheet 1
							click button "Confirm"
							set _confirmed to true
						end tell
					on error _errorMessage
						log _errorMessage
						delay 1
					end try
				end repeat
			else
				log "Currently in portrait display"
				click _rotation
				keystroke landscapeKey & return
			end if
		end tell
	end tell
end tell
quit application "System Preferences"