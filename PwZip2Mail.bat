@echo off

echo *******************************************************************
echo PwZip2Mail.bat                           v1.05
echo.
echo パスワード付きZIPを作成しメーラを起動するツール
echo.
echo *******************************************************************
echo.
SETLOCAL ENABLEDELAYEDEXPANSION
SET LF=^%%0D%%0A
SET ROOT=%~dp0
SET TMP=%~dp0tmp\

set tmpclean="false"
set clipboard="false"

echo.＜システムメニュー＞
echo 設定ファイルの確認時は `open` を入力
echo 設定ファイルの作成時は `new [name]` を入力
echo 設定ファイルの編集時は `edit [name]` を入力
echo 圧縮ファイル作成のみ時は Enter を押下
echo.
echo.
echo メールの送付先を入力してください
echo.

rem dir /B /W .\settings\*.bat

cd .\settings
for %%a in (*.bat) do (
  SET fn=%%a  
  SET /P X=!fn:.bat=!<NUL
rem  SET /P X=!fn:~4,-4!<NUL
)
cd ..\

echo.
set /p SENDTO="送付先 >"

rem 共通設定要バッチを実行して設定内容を取得する
CALL common_settings.bat

if %tmpclean% == "true" (
  del %TMP%*.zip
  del %TMP%*.txt
)

rem 圧縮のみ(NoMail)の場合
if "%SENDTO%" == ""          goto ziponly1

rem ツールのディレクトリを開く
if "%SENDTO%" == "open"    goto open

rem 新規作成と編集へ
for /F "tokens=1" %%a in ('echo %SENDTO: = %') do set cmd=%%a
for /F "tokens=1-2" %%a in ('echo %SENDTO: = %') do set val=%%b

if "%cmd%" == "new"    goto new
if "%cmd%" == "edit"   goto edit
rem echo %cmd%
rem echo %val%

rem 個別設定用のバッチを実行して設定内容を取得する
CALL .\settings\"%SENDTO%.bat

:ziponly1

rem パスワードの長さを設定
set /a pwd_len=16

rem 圧縮元ファイル名のプリフィックス（　encrypted_20111020143540.zip　下記zip圧縮ファイル格納パスに保存　）
set default_out_file_name=encrypted

rem zip圧縮ファイル格納パス（　Def.　%~dp0[当該スクリプト設置パス]tmp\　）
set output_path=%~dp0tmp\

rem 改行コード（　Becky,Thunderbirdで有効　）
set br=%%0D%%0A

rem 短いパスを取得
for %%I in (%mailerpath%) do set mail_bin=%%~sI


rem 圧縮のみ(NoMail)の場合
if "%SENDTO%" == ""          goto main



rem ----------- メールソフトによる個別設定
IF %mailer%=="edmax" goto edmax_ini
IF %mailer%=="becky" goto becky_ini
IF %mailer%=="thunderbird" goto thunderbird_ini
IF %mailer%=="sylpheed" goto sylpheed_ini
IF %mailer%=="outlook" goto outlook_ini
IF %mailer%=="almail" goto almail_ini
IF %mailer%=="hidemaru" goto hidemaru_ini

echo 使用するメーラの選択が不正です。
pause

rem メールソフトによる違いを記述
rem エドマックス
:edmax_ini
	set br=　
	start %mail_bin%
	goto main

rem ベッキー
:becky_ini
	start %mail_bin%
	goto main

rem サンダーバード
:thunderbird_ini
	start %mail_bin%
	goto main

rem シルフィード
:sylpheed_ini
	set br=!LF!
	start %mail_bin%
	goto main

rem アウトルック（バージョンによってパス異なる為注意）
:outlook_ini
	rem outlookの２重起動回避処理
	TASKLIST | FIND "OUTLOOK.EXE" > NUL
	IF NOT ERRORLEVEL 1  (
		echo OUTLOOKは起動しています。
		GOTO OUTLOOK_READY
	) ELSE (
		echo OUTLOOKが起動していません。
		GOTO OUTLOOK_START
	)
	:OUTLOOK_START
		echo OUTLOOK 起動します
		START %mail_bin%
		GOTO OUTLOOK_READY
	:OUTLOOK_READY
	goto main

rem アルメール
:almail_ini
	rem almailの２重起動回避処理
	TASKLIST | FIND "almail.exe" > NUL
	IF NOT ERRORLEVEL 1  (
		echo almailは起動しています。
		GOTO almail_READY
	) ELSE (
		echo almailが起動していません。
		GOTO almail_START
	)
	:almail_START
		echo almail 起動します
		START %mail_bin%
		GOTO almail_READY
	:almail_READY
	set br=
	goto main

rem 秀丸メール
:hidemaru_ini
	start %mail_bin%
	set br=　
	goto main


:main

rem 直接起動した(ファイルドラッグしない)場合…圧縮処理をSKIP
IF "%~1"=="" goto skip_zip


rem  ----------- メイン処理開始　文章設定
rem メール件名　（エドマックスは×）
set mail_pw_subject=パスワードのご連絡

rem メールボディー　（　Becky,Thunderbird以外はInterfaceがないため、宛先欄にセット　）
set mail_body=先ほどお送りした添付ファイルのパスワード(%pwd_len%桁)は下記になります。%br%%br%

rem パスワードの構成文字を設定　※seedに記号などを含める際は要注意（使えない文字結構あり）
set seed=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890

rem ----------- 変数初期化'
set i=0
set foo=
set psw=
set bar=
set psw_all=

rem 実行パス
cd %~dp0
set time2=%time: =0%


rem ----------- パスワード生成
:chr_loop
	set rnd_number=%RANDOM%
	call :FUNC_GET_STRLEN %seed%
	set /a r=%rnd_number%*%strlen%/32768
	rem echo %r%
	rem call echo %%seed:~%r%,1%%

	for /F "USEBACKQ" %%a in (`echo "%%seed:~%r%,1%%"`) do (
	  set foo=%%a
	  IF not "%foo%"=="" set bar=%foo:~1,1%
	)
	set psw_all=%psw%%bar%
	set psw=%psw_all%
	rem echo %psw_all%
	rem echo %i%
	rem ループ抜け
	IF %i%==%pwd_len% GOTO :drop_chr_loop
	set /a i+=1
	goto chr_loop
:drop_chr_loop
	echo パスワード生成完了：%psw_all%

rem ----------- パスワードのクリップボードへの保存
	echo %psw_all% > !TMP!passwd.txt
	if %clipboard% == "true" (
		IF not %psw_all%=="" clip < !TMP!passwd.txt
	)


rem ----------- ファイル名の入力
echo 圧縮後のファイル名を入力してください。(Def:%default_out_file_name%.zip)
IF "%zip_file_name%"=="" set zip_file_name=%default_out_file_name%_%date:~-10,4%%date:~-5,2%%date:~-2,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%

del /P "%output_path%%zip_file_name%.zip"

rem ----------- 圧縮処理のループ
:loop
	echo %1
	call "7za.exe" a -tzip -p%psw_all% "%output_path%%zip_file_name%" %1
	shift
	if not "%~1" == "" goto loop

rem 圧縮のみ(NoMail)の場合
if "%SENDTO%" == "" goto         open_zip_folder


	rem echo %output_path%%zip_file_name%.zip
	echo %mail_client% "%output_path%%zip_file_name%.zip"
	echo メールソフトを起動

:skip_zip


rem メールソフトによる分岐
IF %mailer%=="edmax" goto edmax_exec
IF %mailer%=="becky" goto becky_exec
IF %mailer%=="thunderbird" goto thunderbird_exec
IF %mailer%=="sylpheed" goto sylpheed_exec
IF %mailer%=="outlook" goto outlook_exec
IF %mailer%=="almail" goto almail_exec
IF %mailer%=="hidemaru" goto hidemaru_exec


rem エドマックス
:edmax_exec
rem	echo %mail_pw_subject% > c:\_tmp_body_char
rem	echo; >> c:\_tmp_body_char
rem	echo %mail_body% >> c:\_tmp_body_char
rem	echo; >> c:\_tmp_body_char
rem	echo %psw_all% >> c:\_tmp_body_char
rem	%mail_bin% c:\_tmp_body_char
	%mail_bin% /A=%mail_pw_subject%　%mail_body%　%psw_all%
	%mail_bin% /E "%output_path%%zip_file_name%.zip"
	goto label10

rem ベッキー
:becky_exec
	%mail_bin% "mailto:?subject=%mail_pw_subject%&body=%mail_body%%psw_all%"
	rem 添付ファイルなし時は2通目作成しない
	IF not %psw_all%=="" %mail_bin% "%output_path%%zip_file_name%.zip"

	rem --- sleep start ---
	rem 早いと添付されないことがあるのでSleepする
	set i=0
	:label03
	IF %i%==1000 GOTO :label05
	set /a i+=1
	goto label03
	:label05
	rem --- sleep e n d ---

	rem rem ファイルを削除（または退避）して終了
	rem del "%output_path%%zip_file_name%.zip"
	goto label10

rem サンダーバード
:thunderbird_exec

	rem 2015/11/11　石橋　Bug修正
	rem PW送付用の場合、Toのメールアドレスセパレータを　, を ; に置換する
	set mail_to_static_semi=%mail_to_static:,=;%

	%mail_bin% -compose "mailto:%mail_to_static%?subject=%mail_subject_static%%mail_pw_subject%&body=%mail_body_head_static%%mail_body%%psw_all%%mail_body_foot_static%&cc=%mail_cc_static%"
	rem 添付ファイルなし時は2通目作成しない
	IF not %psw_all%=="" %mail_bin% -compose to=%mail_to_static_semi%,subject=%mail_subject_static%,body=%mail_body_head_static%%mail_body_pwmsg%%mail_body_foot_static%,cc='%mail_cc_static%',attachment='%output_path%%zip_file_name%.zip'
	goto label10

rem シルフィード
:sylpheed_exec

	rem --- sleep start ---
	rem 早いと落ちることがあるのでSleepする
	set i=0
	:label20
	IF %i%==1000 GOTO :label21
	set /a i+=1
	goto label20
	:label21
	rem --- sleep e n d ---

	rem %mail_bin% --compose %mail_pw_subject%　%mail_body%　%psw_all%
	%mail_bin% --compose "mailto:%mail_to_static%?subject=%mail_subject_static%%mail_pw_subject%&body=%mail_body_head_static%%mail_body%%psw_all%%mail_body_foot_static%&cc=%mail_cc_static%"
	rem 添付ファイルなし時は2通目作成しない
	IF not %psw_all%=="" %mail_bin% --compose "mailto:%mail_to_static%?subject=%mail_subject_static%&body=%mail_body_head_static%%mail_body_pwmsg%%mail_body_foot_static%&cc=%mail_cc_static%" --attach "%output_path%%zip_file_name%.zip"
	goto label10

rem アウトルック
:outlook_exec
	%mail_bin% /c ipm.note /m "mailto:?subject=%mail_pw_subject%&body=%mail_body%%psw_all%"
	rem 添付ファイルなし時は2通目作成しない
	IF not %psw_all%=="" %mail_bin% /a "%output_path%%zip_file_name%.zip"
	goto label10

rem アルメール
:almail_exec
	echo %mail_pw_subject% > c:\_tmp_body_char
	echo; >> c:\_tmp_body_char
	echo %mail_body% >> c:\_tmp_body_char
	echo; >> c:\_tmp_body_char
	echo %psw_all% >> c:\_tmp_body_char
	%mail_bin% /send /file:c:\_tmp_body_char
rem	%mail_bin% /send /subject:%mail_pw_subject%　%mail_body%　%psw_all%
	rem 添付ファイルなし時は2通目作成しない
	IF not %psw_all%=="" %mail_bin% /send /attach:"%output_path%%zip_file_name%.zip"
del c:\_tmp_body_char
	goto label10

rem 秀丸メール
:hidemaru_exec
	%mail_bin% newmail Subject=%mail_pw_subject% Body="%mail_body%%psw_all%"
	rem 添付ファイルなし時は2通目作成しない
	IF not %psw_all%=="" %mail_bin% "%output_path%%zip_file_name%.zip"
	goto label10



rem ----------- 正常終了
:label10
	exit


rem ----------- エラー処理
:error
explorer %output_path%
	echo 処理が不正です。
	echo 圧縮したいファイルをドロップして使用してください。
	echo.
rem	pause
	exit


rem ----------------------------------------
rem 関数文字長を取得する
rem 使用法 call :GET_STRLEN (対象の文字列)
rem ----------------------------------------
:FUNC_GET_STRLEN
	set s=%1
	set strlen=0
	:LOOP_HEAD
	if defined s (
	set s=%s:~1%
	set /A strlen+=1
	goto :LOOP_HEAD
	)
exit /b


rem ----------------------------------------
rem ExplorerでZipファルダを開く
rem ----------------------------------------
:open_zip_folder

mshta vbscript:execute("a=InputBox(""ファイル圧縮のみ実行しました。下記のパスワードをコピペしてご利用ください。OKをクリックすると圧縮ファイルが表示されます。"", ""パスワード"", ""%psw_all%""):close")
explorer !TMP!


exit

rem ----------------------------------------
rem Explorerでファルダを開く
rem ----------------------------------------
:open
explorer !ROOT!

exit

rem ----------------------------------------
rem エディタで新規作成
rem ----------------------------------------
:new
copy .\settings\@tmplate_file .\settings\%val%.txt
.\settings\%val%.txt
copy .\settings\%val%.txt .\settings\%val%.bat
del .\settings\%val%.txt

exit

rem ----------------------------------------
rem エディタで編集
rem ----------------------------------------
:edit

copy .\settings\%val%.bat .\settings\%val%.txt
.\settings\%val%.txt
copy .\settings\%val%.txt .\settings\%val%.bat
del .\settings\%val%.txt

exit