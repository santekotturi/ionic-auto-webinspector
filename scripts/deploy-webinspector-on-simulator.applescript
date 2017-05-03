#!/usr/bin/osascript

--AppleScript to automatically compile Cordova and open the Safari debugger

set maxWait to 1000                 	-- you can decrease this if you want. if you have a long build process you might need to increase this. 
set hasClicked to false
set x to 0
set device_name to "Simulator"
set initial_view to "Home"				-- see README for instructions. It's whatever your initial state is. Or index.html for ionic v1 apps. 

log "Starting auto-deploy webinspector to iOS Simulator"

--in case the app is already open, go back to the home screen. if you dont, it could launch the inspector on the older running version of your app. 
tell application "Simulator"
	activate
	tell application "System Events" to keystroke "h" using {shift down, command down}
end tell

delay 2

-- open safari and wait for the ios app to become available for debugging
tell application "Safari"
	activate
	repeat until hasClicked or x > (maxWait)
		try
			log "Looking for app. Will continue looking"
			tell application "System Events"
				click menu item initial_view of menu device_name of menu item device_name of menu "Develop" of menu bar item "Develop" of menu bar 1 of application process "Safari"
				-- AUTO-REFRESH! remove the next two lines if you dont want this. can tweak delay depending on how fast your system is. 				
				delay 2
				tell application "System Events" to keystroke "r" using {command down}
			end tell
			set hasClicked to true
		on error foo
			delay 0.1
			set x to x + 1
		end try
	end repeat
	if hasClicked = false then
		display dialog "Unable to connect to Simulator - is your app running? Try increasing the maxWait if your app is still building." buttons {"OK"} default button 1
	end if
end tell