#!/usr/bin/osascript

--AppleScript to automatically compile Cordova and open the Safari debugger

set maxWait to 1000                 -- you can decrease this if you want. if you have a long build process you might need to increase this. 
set hasClicked to false
set x to 0
set device_name to "YOUR_DEVICE_NAME"

log "Starting auto-deploy webinspector to iOS Device"

--delay fix for yosemite
on delay duration
	set endTime to (current date) + duration
	repeat while (current date) is less than endTime
		log "in delay loop"
		tell AppleScript to delay duration
	end repeat
end delay

--in case the app is already open, go back to the home screen. if you dont, it could launch the inspector on the older running version of your app. 
tell application "Simulator"
	activate
	tell application "System Events" to keystroke "h" using {shift down, command down}
end tell

delay 5

-- open safari and wait for the ios app to become available for debugging
tell application "Safari"
	activate
	repeat until hasClicked or x > (maxWait)
		try
			log "Looking for device. Will continue looking..."
			tell application "System Events"
				click menu item "YOUR_INITIAL_VIEW" of menu device_name of menu item device_name of menu "Develop" of menu bar item "Develop" of menu bar 1 of application process "Safari"
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

