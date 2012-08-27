-------------------------------------------------
----本脚本为TurboX的粘合部分，包含了和系统交互的功能-----
--如果需要使用此脚本，需要修改"./TurboX.app"为具体路径--
----------------Author:lqik2004-------------------

property growlHelperAppName : ""
property growlAppName : "TurboX"
property allNotifications : {"General", "Error"}
property enabledNotifications : {"General"}
property iconApplication : "Alfred.app"

(* Begin notification code *)
on notify(alertName, alertTitle, alertText)
	--Call this to show a normal notification
	my notifyMain(alertName, alertTitle, alertText, false)
end notify

on notifyWithSticky(alertTitle, alertText)
	--Show a sticky Growl notification
	set alertName to "General"
	my notifyMain(alertName, alertTitle, alertText, true)
end notifyWithSticky

on IsGrowlRunning()
	tell application "System Events" to set GrowlRunning to (count of (every process where creator type is "GRRR")) > 0
	return GrowlRunning
end IsGrowlRunning

on dictToString(dict) --needed to encapsulate dictionaries in osascript
	set dictString to "{"
	repeat with i in dict
		if (length of dictString > 1) then set dictString to dictString & ", "
		set dictString to dictString & "\"" & i & "\""
	end repeat
	set dictString to dictString & "}"
	return dictString
end dictToString

on notifyWithGrowl(growlHelperAppName, alertName, alertTitle, alertText, useSticky)
	tell my application growlHelperAppName
		«event register» given «class appl»:growlAppName, «class anot»:allNotifications, «class dnot»:enabledNotifications, «class iapp»:iconApplication
		«event notifygr» given «class name»:alertName, «class titl»:alertTitle, «class appl»:growlAppName, «class desc»:alertText
	end tell
end notifyWithGrowl

on NotifyWithoutGrowl(alertText)
	
end NotifyWithoutGrowl

on notifyMain(alertName, alertTitle, alertText, useSticky)
	set GrowlRunning to my IsGrowlRunning() --check if Growl is running...
	if not GrowlRunning then --if Growl isn't running...
		set GrowlPath to "" --check to see if Growl is installed...
		try
			tell application "Finder" to tell (application file id "GRRR") to set strGrowlPath to POSIX path of (its container as alias) & name
		end try
		if GrowlPath is not "" then --...try to launch if so...
			do shell script "open " & strGrowlPath & " > /dev/null 2>&1 &"
			delay 0.5
			set GrowlRunning to my IsGrowlRunning()
		end if
	end if
	if GrowlRunning then
		tell application "Finder" to tell (application file id "GRRR") to set growlHelperAppName to name
		notifyWithGrowl(growlHelperAppName, alertName, alertTitle, alertText, useSticky)
	else
		NotifyWithoutGrowl(alertText)
	end if
end notifyMain
(* end notification code *)

on SDDownload(SDName, cookies, downloadurl)
	tell application SDName
		«event SpESAUrl» of downloadurl given «class Co_k»:"gdriveid=" & cookies & ";"
	end tell
end SDDownload

on alfred_script(q)
	--	register_growl()
	post_noti("TurboX正在启动，请稍候...")
	set downloadurl to "null" as text
	set cookies to "null" as text
	set currentPath to ""
	tell application "./TurboX.app"
		set cookies to gdriveid
		post_noti("正在解析地址") of me
		tell application "Finder" to get folder of (path to application "./TurboX.app") as Unicode text
		set currentPath to POSIX path of result
		if cookies is missing value then
			post_noti("正在重试解析，可能会需要更长一段时间") of me
			set cookies to gdriveid
		end if
		set originalurl to q
		set downloadurl to xunleiurl
		if downloadurl is missing value then
			set downloadurl to xunleiurl
			if downloadurl is missing value then
				post_noti("很遗憾，您需要下载的地址可能在迅雷离线上未完成，暂时无法下载，请稍候再试") of me
			end if
		else
			post_noti("正在下载,感谢使用，目前TurboX正在测试，有任何问题可以给我发邮件:lqik2004@gmail.com") of me
		end if
		quit
	end tell
	set sdpath to ""
	try
		tell application "Finder" to tell (application file id "com.yazsoft.SpeedDownload") to set sdpath to POSIX path of (its container as alias) & name
	end try
	if sdpath is not "" then --open SD
		tell application "Finder" to tell (application file id "com.yazsoft.SpeedDownload") to set SDName to name
		SDDownload(SDName, cookies, downloadurl)
	else
		--open aria2c
		
		set dURL to "./aria2c -c --file-allocation=none --dir ~/Downloads --header 'Cookie:gdriveid=" & cookies & ";' '" & downloadurl & "'"
		tell application "Terminal"
			activate
			set currentTab to do script "cd '" & currentPath & "'"
			do script dURL in currentTab
		end tell
	end if
end alfred_script



on post_noti(notitext)
	set os_version to do shell script "sw_vers -productVersion"
	set AppleScript's text item delimiters to "."
	set mainVersion to second text item of os_version
	if mainVersion < 8 then
		--growl
		notifyWithSticky("TurboX", notitext)
	else
		--nc
		tell application "Finder" to get folder of (path to application "./TurboX.app") as Unicode text
		set currentPath to POSIX path of result
		
		do shell script "cd '" & currentPath & "';./terminal-notifier.app/Contents/MacOS/terminal-notifier -message '" & notitext & "' -title 'TurboX' -open 'https://github.com/lqik2004/TurboX'"
	end if
end post_noti

alfred_script("ed2k://|file|%E7%A5%9E%E5%A5%87%E6%B5%B7%E7%9B%97%E5%9B%A2.The.Pirates.Band.of.Misfits.2012.BD-RMVB-%E4%BA%BA%E4%BA%BA%E5%BD%B1%E8%A7%86%E5%8E%9F%E5%88%9B%E7%BF%BB%E8%AF%91%E4%B8%AD%E8%8B%B1%E5%8F%8C%E8%AF%AD%E5%AD%97%E5%B9%95.rmvb|340540885|e260a5962793cd81f382886fe3410db1|h=fj2euwlkod6jkeuyocn2uxt3fugo5nri|/")