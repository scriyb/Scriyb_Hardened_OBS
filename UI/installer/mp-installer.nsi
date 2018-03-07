; Script generated with the Venis Install Wizard

Unicode true

; Define your application name
!define APPNAME "OBS Studio"

!ifndef APPVERSION
!define APPVERSION "20.1.3"
!define SHORTVERSION "20.1.3"
!endif

!define APPNAMEANDVERSION "OBS Studio ${SHORTVERSION}"
; !define FULL
!define REALSENSE_PLUGIN



; Additional script dependencies
!include WinVer.nsh
!include x64.nsh

; Main Install settings
Name "${APPNAMEANDVERSION}"
InstallDir "$PROGRAMFILES32\obs-studio"
InstallDirRegKey HKLM "Software\${APPNAME}" ""
!ifdef FULL
OutFile "OBS-Studio-${SHORTVERSION}-Full-Installer.exe"
!else
OutFile "OBS-Studio-${SHORTVERSION}-Small-Installer.exe"
!endif

; Use compression
SetCompressor /SOLID LZMA

; Need Admin
RequestExecutionLevel admin

; Modern interface settings
!include "MUI.nsh"

!define MUI_ABORTWARNING
!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_TEXT "Launch OBS Studio ${SHORTVERSION}"
!define MUI_FINISHPAGE_RUN_FUNCTION "LaunchOBS"

!define MUI_PAGE_CUSTOMFUNCTION_LEAVE PreReqCheck

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "new\core\data\obs-studio\license\gplv2.txt"
!insertmacro MUI_PAGE_DIRECTORY
!ifdef FULL
	!insertmacro MUI_PAGE_COMPONENTS
!endif
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

;!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_COMPONENTS
!insertmacro MUI_UNPAGE_INSTFILES

; Set languages (first is default language)
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_RESERVEFILE_LANGDLL

Function PreReqCheck
	; Abort on XP or lower
	${If} ${AtMostWinXP}
		MessageBox MB_OK|MB_ICONSTOP "Due to extensive use of DirectX 10 features, ${APPNAME} requires Windows Vista SP2 or higher and cannot be installed on this version of Windows."
		Quit
	${EndIf}

	; Vista specific checks
	${If} ${IsWinVista}
		; Check Vista SP2
		${If} ${AtMostServicePack} 1
			MessageBox MB_YESNO|MB_ICONEXCLAMATION "${APPNAME} requires Service Pack 2 when running on Vista. Would you like to download it?" IDYES sptrue IDNO spfalse
			sptrue:
				ExecShell "open" "http://windows.microsoft.com/en-US/windows-vista/Learn-how-to-install-Windows-Vista-Service-Pack-2-SP2"
			spfalse:
			Quit
		${EndIf}

		; Check Vista Platform Update
		nsexec::exectostack "$SYSDIR\wbem\wmic.exe qfe where HotFixID='KB971512' get HotFixID /Format:list"
		pop $0
		pop $0
		strcpy $1 $0 17 6
		strcmps $1 "HotFixID=KB971512" gotPatch
			MessageBox MB_YESNO|MB_ICONEXCLAMATION "${APPNAME} requires the Windows Vista Platform Update. Would you like to download it?" IDYES putrue IDNO pufalse
			putrue:
				; 32 bit
				ExecShell "open" "http://www.microsoft.com/en-us/download/details.aspx?id=3274"
			pufalse:
			Quit
		gotPatch:
	${EndIf}

	; 32 bit Visual Studio 2013 runtime check
	ClearErrors
	ReadRegDword $R1 HKLM "SOFTWARE\Wow6432Node\Microsoft\VisualStudio\12.0\VC\Runtimes\x86" "Installed"
	IfErrors vs2013Missing vs2013OK1
	vs2013Missing:
		SetOutPath $INSTDIR\Prerequisites
		MessageBox MB_YESNO|MB_ICONEXCLAMATION "Your system is missing runtime components that ${APPNAME} requires. Please make sure to install vcredist_x86. Would you like to install it now?" IDYES vs2013true IDNO vs2013false
		vs2013true:
			File "vcredist_x86.exe"
			ExecWait '"$INSTDIR\Prerequisites\vcredist_x86.exe" /q /norestart'
		vs2013false:
		; Quit
	vs2013OK1:
	ClearErrors

	; 32 bit Visual Studio 2015 runtime check
	ClearErrors
	ReadRegDword $R1 HKLM "SOFTWARE\Wow6432Node\Microsoft\VisualStudio\14.0\VC\Runtimes\x86" "Installed"
	IfErrors vs2015Missing vs2015OK1
	vs2015Missing:
		SetOutPath $INSTDIR\Prerequisites
		MessageBox MB_YESNO|MB_ICONEXCLAMATION "Your system is missing runtime components that ${APPNAME} requires. Please make sure to install vcredist2015_x86. Would you like to install it now" IDYES vs2015true IDNO vs2015false
		vs2015true:
			File "vc_redist2015_x86.exe"
			ExecWait '"$INSTDIR\Prerequisites\vc_redist2015_x86.exe" /q /norestart'
		vs2015false:
		; Quit
	vs2015OK1:
	ClearErrors

	; DirectX Version Check
	ClearErrors
	GetDLLVersion "D3DCompiler_33.dll" $R0 $R1
	IfErrors dxMissing33 dxOK
	dxMissing33:
	ClearErrors
	GetDLLVersion "D3DCompiler_34.dll" $R0 $R1
	IfErrors dxMissing34 dxOK
	dxMissing34:
	ClearErrors
	GetDLLVersion "D3DCompiler_35.dll" $R0 $R1
	IfErrors dxMissing35 dxOK
	dxMissing35:
	ClearErrors
	GetDLLVersion "D3DCompiler_36.dll" $R0 $R1
	IfErrors dxMissing36 dxOK
	dxMissing36:
	ClearErrors
	GetDLLVersion "D3DCompiler_37.dll" $R0 $R1
	IfErrors dxMissing37 dxOK
	dxMissing37:
	ClearErrors
	GetDLLVersion "D3DCompiler_38.dll" $R0 $R1
	IfErrors dxMissing38 dxOK
	dxMissing38:
	ClearErrors
	GetDLLVersion "D3DCompiler_39.dll" $R0 $R1
	IfErrors dxMissing39 dxOK
	dxMissing39:
	ClearErrors
	GetDLLVersion "D3DCompiler_40.dll" $R0 $R1
	IfErrors dxMissing40 dxOK
	dxMissing40:
	ClearErrors
	GetDLLVersion "D3DCompiler_41.dll" $R0 $R1
	IfErrors dxMissing41 dxOK
	dxMissing41:
	ClearErrors
	GetDLLVersion "D3DCompiler_42.dll" $R0 $R1
	IfErrors dxMissing42 dxOK
	dxMissing42:
	ClearErrors
	GetDLLVersion "D3DCompiler_43.dll" $R0 $R1
	IfErrors dxMissing43 dxOK
	dxMissing43:
	ClearErrors
	GetDLLVersion "D3DCompiler_47.dll" $R0 $R1
	IfErrors dxMissing47 dxOK
	dxMissing47:
	SetOutPath $INSTDIR\Prerequisites
	MessageBox MB_YESNO|MB_ICONEXCLAMATION "Your system is missing DirectX components that ${APPNAME} requires. Would you like to install them now?" IDYES dxtrue IDNO dxfalse
	dxtrue:
		; ExecShell "open" "https://obsproject.com/go/dxwebsetup"
		File "dxwebsetup.exe"
		ExecWait '"$INSTDIR\Prerequisites\dxwebsetup.exe" /Q'
	dxfalse:
	;Quit
	dxOK:
	ClearErrors

	; Check previous instance
	InitPluginsDir
	SetOutPath $PLUGINSDIR   
	File OBSInstallerUtils.dll
	System::Call 'OBSInstallerUtils::IsProcessRunning "obs32.exe" .R0'
	IntCmp $0 1 0 notRunning1
		MessageBox MB_OK|MB_ICONEXCLAMATION "${APPNAME} is already running. Please close it first before installing a new version." /SD IDOK
		Quit
	notRunning1:

	System::Call 'OBSInstallerUtils::AddInUseFileCheck "$INSTDIR\data\obs-plugins\win-capture\graphics-hook32.dll" .R0'
	System::Call 'OBSInstallerUtils::AddInUseFileCheck "$INSTDIR\data\obs-plugins\win-capture\graphics-hook64.dll" .R0'
	System::Call 'OBSInstallerUtils::GetAppNameForInUseFiles .R0'
	StrCmp $0 "" gameCaptureNotRunning
		MessageBox MB_OK|MB_ICONEXCLAMATION "Game Capture is still in use by the following applications:$\r$\n$\r$\n$R0$\r$\nPlease close these applications before installing a new version of OBS." /SD IDOK
		Quit
	gameCaptureNotRunning:
FunctionEnd

Function filesInUse
	MessageBox MB_OK|MB_ICONEXCLAMATION "Some files were not able to be installed. If this is the first time you are installing OBS, please disable any anti-virus or other security software and try again. If you are re-installing or updating OBS, close any applications that may be have been hooked, or reboot and try again."  /SD IDOK
FunctionEnd

Function LaunchOBS
	Exec '"$WINDIR\explorer.exe" "$SMPROGRAMS\OBS Studio\OBS Studio (32bit).lnk"'
FunctionEnd

Var outputErrors

Section "OBS Studio" SecCore

	; Set Section properties
	SectionIn RO
	SetOverwrite on
	AllowSkipFiles off

	SetShellVarContext all

	; Set Section Files and Shortcuts
	SetOutPath "$INSTDIR"
	System::Call 'OBSInstallerUtils::KillProcess "obs-plugins\32bit\cef-bootstrap.exe" .R0'
	System::Call 'OBSInstallerUtils::KillProcess "obs-plugins\64bit\cef-bootstrap.exe" .R0'
	File /r "new\core\data"
	SetOutPath "$INSTDIR\bin"
	File /r "new\core\bin\32bit"
	SetOutPath "$INSTDIR\obs-plugins"
	File /r "new\core\obs-plugins\32bit"

	ClearErrors

	IfErrors 0 +2
		StrCpy $outputErrors "yes"

	WriteUninstaller "$INSTDIR\uninstall.exe"

	; Delete Old "Multiplatform" Shortcuts
	Delete "$DESKTOP\OBS Multiplatform.lnk"
	Delete "$SMPROGRAMS\OBS Multiplatform\OBS Multiplatform (32bit).lnk"
	Delete "$SMPROGRAMS\OBS Multiplatform\Uninstall.lnk"

	SetOutPath "$INSTDIR\bin\32bit"
	CreateShortCut "$DESKTOP\OBS Studio.lnk" "$INSTDIR\bin\32bit\obs32.exe"
	SetOutPath "$INSTDIR\bin\32bit"
	CreateDirectory "$SMPROGRAMS\OBS Studio"
	CreateShortCut "$SMPROGRAMS\OBS Studio\OBS Studio (32bit).lnk" "$INSTDIR\bin\32bit\obs32.exe"
	CreateShortCut "$SMPROGRAMS\OBS Studio\Uninstall.lnk" "$INSTDIR\uninstall.exe"

	SetOutPath "$INSTDIR\bin\32bit"

	StrCmp $outputErrors "yes" 0 +2
		Call filesInUse
SectionEnd

!ifdef FULL
SectionGroup /e "Plugins" SecPlugins
	Section "Browser Source" SecPlugins_Browser
		; Set Section properties
		SetOverwrite on
		AllowSkipFiles off
		SetShellVarContext all

		SetOutPath "$INSTDIR\obs-plugins"
		System::Call 'OBSInstallerUtils::KillProcess "32bit\cef-bootstrap.exe" .R0'
		File /r "new\obs-browser\obs-plugins\32bit"

		SetOutPath "$INSTDIR\bin\32bit"
	SectionEnd

	!ifdef REALSENSE_PLUGIN
	Section /o "Realsense Source" SecPlugins_Realsense
		SetOverwrite on
		AllowSkipFiles off
		SetShellVarContext all

		SetOutPath "$INSTDIR\obs-plugins"
		File /r "new\realsense\obs-plugins\32bit"

		SetOutPath "$INSTDIR\data\obs-plugins"
		File /r "new\realsense\data\obs-plugins\win-ivcam"

		ExecWait '"$INSTDIR\data\obs-plugins\win-ivcam\seg_service.exe" /UnregServer'
		ExecWait '"$INSTDIR\data\obs-plugins\win-ivcam\seg_service.exe" /RegServer'

		ReadRegStr $0 HKLM "Software\Intel\RSSDK\Dispatch" "Core"
		${if} ${Errors}
			ReadRegStr $0 HKLM "Software\Intel\RSSDK\v10\Dispatch" "Core"
		${endif}

		${if} ${Errors}
			InitPluginsDir
			SetOutPath "$PLUGINSDIR\realsense"

			File "intel_rs_sdk_runtime_websetup_10.0.26.0396.exe"
			ExecWait '"$PLUGINSDIR\realsense\intel_rs_sdk_runtime_websetup_10.0.26.0396.exe" --finstall=personify --fnone=all'
		${endif}

		SetOutPath "$INSTDIR\bin\32bit"
	SectionEnd
	!endif
SectionGroupEnd
!endif

Section -FinishSection

	WriteRegStr HKLM "Software\${APPNAME}" "" "$INSTDIR"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "DisplayName" "${APPNAME}"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "UninstallString" "$INSTDIR\uninstall.exe"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "ProductID" "d16d2409-3151-4331-a9b1-dfd8cf3f0d9c"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "DisplayIcon" "$INSTDIR\bin\32bit\obs32.exe"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "Publisher" "OBS Project"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "HelpLink" "https://obsproject.com"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "DisplayVersion" "${APPVERSION}"

SectionEnd

; Modern install component descriptions
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
	!insertmacro MUI_DESCRIPTION_TEXT ${SecCore} "Core OBS Studio files"
!insertmacro MUI_FUNCTION_DESCRIPTION_END

;Uninstall section
Section "un.obs-studio Program Files" UninstallSection1

	SectionIn RO

	;Remove from registry...
	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}"
	DeleteRegKey HKLM "SOFTWARE\${APPNAME}"

	; Delete self
	Delete "$INSTDIR\uninstall.exe"

	; Delete Shortcuts
	Delete "$DESKTOP\OBS Studio.lnk"
	Delete "$SMPROGRAMS\OBS Studio\OBS Studio (32bit).lnk"
	Delete "$SMPROGRAMS\OBS Studio\Uninstall.lnk"

	IfFileExists "$INSTDIR\data\obs-plugins\win-ivcam\seg_service.exe" UnregisterSegService SkipUnreg
	UnregisterSegService:
	ExecWait '"$INSTDIR\data\obs-plugins\win-ivcam\seg_service.exe" /UnregServer'
	SkipUnreg:

	; Clean up OBS Studio
	RMDir /r "$INSTDIR\bin"
	RMDir /r "$INSTDIR\data"
	RMDir /r "$INSTDIR\obs-plugins"
	RMDir "$INSTDIR"

	; Remove remaining directories
	RMDir "$SMPROGRAMS\OBS Studio"
	RMDir "$INSTDIR\OBS Studio"
SectionEnd

Section /o "un.User Settings" UninstallSection2
	RMDir /R "$APPDATA\obs-studio"
SectionEnd

!insertmacro MUI_UNFUNCTION_DESCRIPTION_BEGIN
	!insertmacro MUI_DESCRIPTION_TEXT ${UninstallSection1} "Remove the OBS program files."
	!insertmacro MUI_DESCRIPTION_TEXT ${UninstallSection2} "Removes all settings, plugins, scenes and sources, profiles, log files and other application data."
!insertmacro MUI_UNFUNCTION_DESCRIPTION_END

; Version information
VIProductVersion "${APPVERSION}.0"
VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductName" "OBS Studio"
VIAddVersionKey /LANG=${LANG_ENGLISH} "CompanyName" "obsproject.com"
VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalCopyright" "(c) 2012-2016"
; FileDescription is what shows in the UAC elevation prompt when signed
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileDescription" "OBS Studio"
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileVersion" "1.0"

; eof
