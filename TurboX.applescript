on alfred_script(q)
	-- your script here
	set AppleScript's text item delimiters to " "
	
	if ((text item 1 of q) is "config") then
		--display dialog (text item 2 of q)
		tell application "Terminal"
		end tell
	else if ((text item 1 of q) is "ss") then
		set config to "byebye"
		--display dialog (text item 2 of q)
		tell application "Terminal"
		end tell
	else
		--display dialog (text item 1 of q)
	end if
end alfred_script