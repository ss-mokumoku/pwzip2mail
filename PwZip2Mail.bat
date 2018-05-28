@echo off

echo *******************************************************************
echo PwZip2Mail.bat                           v1.05
echo.
echo �p�X���[�h�t��ZIP���쐬�����[�����N������c�[��
echo.
echo *******************************************************************
echo.
SETLOCAL ENABLEDELAYEDEXPANSION
SET LF=^%%0D%%0A
SET ROOT=%~dp0
SET TMP=%~dp0tmp\

set tmpclean="false"
set clipboard="false"

echo.���V�X�e�����j���[��
echo �ݒ�t�@�C���̊m�F���� `open` �����
echo �ݒ�t�@�C���̍쐬���� `new [name]` �����
echo �ݒ�t�@�C���̕ҏW���� `edit [name]` �����
echo ���k�t�@�C���쐬�̂ݎ��� Enter ������
echo.
echo.
echo ���[���̑��t�����͂��Ă�������
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
set /p SENDTO="���t�� >"

rem ���ʐݒ�v�o�b�`�����s���Đݒ���e���擾����
CALL common_settings.bat

if %tmpclean% == "true" (
  del %TMP%*.zip
  del %TMP%*.txt
)

rem ���k�̂�(NoMail)�̏ꍇ
if "%SENDTO%" == ""          goto ziponly1

rem �c�[���̃f�B���N�g�����J��
if "%SENDTO%" == "open"    goto open

rem �V�K�쐬�ƕҏW��
for /F "tokens=1" %%a in ('echo %SENDTO: = %') do set cmd=%%a
for /F "tokens=1-2" %%a in ('echo %SENDTO: = %') do set val=%%b

if "%cmd%" == "new"    goto new
if "%cmd%" == "edit"   goto edit
rem echo %cmd%
rem echo %val%

rem �ʐݒ�p�̃o�b�`�����s���Đݒ���e���擾����
CALL .\settings\"%SENDTO%.bat

:ziponly1

rem �p�X���[�h�̒�����ݒ�
set /a pwd_len=16

rem ���k���t�@�C�����̃v���t�B�b�N�X�i�@encrypted_20111020143540.zip�@���Lzip���k�t�@�C���i�[�p�X�ɕۑ��@�j
set default_out_file_name=encrypted

rem zip���k�t�@�C���i�[�p�X�i�@Def.�@%~dp0[���Y�X�N���v�g�ݒu�p�X]tmp\�@�j
set output_path=%~dp0tmp\

rem ���s�R�[�h�i�@Becky,Thunderbird�ŗL���@�j
set br=%%0D%%0A

rem �Z���p�X���擾
for %%I in (%mailerpath%) do set mail_bin=%%~sI


rem ���k�̂�(NoMail)�̏ꍇ
if "%SENDTO%" == ""          goto main



rem ----------- ���[���\�t�g�ɂ��ʐݒ�
IF %mailer%=="edmax" goto edmax_ini
IF %mailer%=="becky" goto becky_ini
IF %mailer%=="thunderbird" goto thunderbird_ini
IF %mailer%=="sylpheed" goto sylpheed_ini
IF %mailer%=="outlook" goto outlook_ini
IF %mailer%=="almail" goto almail_ini
IF %mailer%=="hidemaru" goto hidemaru_ini

echo �g�p���郁�[���̑I�����s���ł��B
pause

rem ���[���\�t�g�ɂ��Ⴂ���L�q
rem �G�h�}�b�N�X
:edmax_ini
	set br=�@
	start %mail_bin%
	goto main

rem �x�b�L�[
:becky_ini
	start %mail_bin%
	goto main

rem �T���_�[�o�[�h
:thunderbird_ini
	start %mail_bin%
	goto main

rem �V���t�B�[�h
:sylpheed_ini
	set br=!LF!
	start %mail_bin%
	goto main

rem �A�E�g���b�N�i�o�[�W�����ɂ���ăp�X�قȂ�ג��Ӂj
:outlook_ini
	rem outlook�̂Q�d�N���������
	TASKLIST | FIND "OUTLOOK.EXE" > NUL
	IF NOT ERRORLEVEL 1  (
		echo OUTLOOK�͋N�����Ă��܂��B
		GOTO OUTLOOK_READY
	) ELSE (
		echo OUTLOOK���N�����Ă��܂���B
		GOTO OUTLOOK_START
	)
	:OUTLOOK_START
		echo OUTLOOK �N�����܂�
		START %mail_bin%
		GOTO OUTLOOK_READY
	:OUTLOOK_READY
	goto main

rem �A�����[��
:almail_ini
	rem almail�̂Q�d�N���������
	TASKLIST | FIND "almail.exe" > NUL
	IF NOT ERRORLEVEL 1  (
		echo almail�͋N�����Ă��܂��B
		GOTO almail_READY
	) ELSE (
		echo almail���N�����Ă��܂���B
		GOTO almail_START
	)
	:almail_START
		echo almail �N�����܂�
		START %mail_bin%
		GOTO almail_READY
	:almail_READY
	set br=
	goto main

rem �G�ۃ��[��
:hidemaru_ini
	start %mail_bin%
	set br=�@
	goto main


:main

rem ���ڋN������(�t�@�C���h���b�O���Ȃ�)�ꍇ�c���k������SKIP
IF "%~1"=="" goto skip_zip


rem  ----------- ���C�������J�n�@���͐ݒ�
rem ���[�������@�i�G�h�}�b�N�X�́~�j
set mail_pw_subject=�p�X���[�h�̂��A��

rem ���[���{�f�B�[�@�i�@Becky,Thunderbird�ȊO��Interface���Ȃ����߁A���旓�ɃZ�b�g�@�j
set mail_body=��قǂ����肵���Y�t�t�@�C���̃p�X���[�h(%pwd_len%��)�͉��L�ɂȂ�܂��B%br%%br%

rem �p�X���[�h�̍\��������ݒ�@��seed�ɋL���Ȃǂ��܂߂�ۂ͗v���Ӂi�g���Ȃ��������\����j
set seed=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890

rem ----------- �ϐ�������'
set i=0
set foo=
set psw=
set bar=
set psw_all=

rem ���s�p�X
cd %~dp0
set time2=%time: =0%


rem ----------- �p�X���[�h����
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
	rem ���[�v����
	IF %i%==%pwd_len% GOTO :drop_chr_loop
	set /a i+=1
	goto chr_loop
:drop_chr_loop
	echo �p�X���[�h���������F%psw_all%

rem ----------- �p�X���[�h�̃N���b�v�{�[�h�ւ̕ۑ�
	echo %psw_all% > !TMP!passwd.txt
	if %clipboard% == "true" (
		IF not %psw_all%=="" clip < !TMP!passwd.txt
	)


rem ----------- �t�@�C�����̓���
echo ���k��̃t�@�C��������͂��Ă��������B(Def:%default_out_file_name%.zip)
IF "%zip_file_name%"=="" set zip_file_name=%default_out_file_name%_%date:~-10,4%%date:~-5,2%%date:~-2,2%%time2:~0,2%%time2:~3,2%%time2:~6,2%

del /P "%output_path%%zip_file_name%.zip"

rem ----------- ���k�����̃��[�v
:loop
	echo %1
	call "7za.exe" a -tzip -p%psw_all% "%output_path%%zip_file_name%" %1
	shift
	if not "%~1" == "" goto loop

rem ���k�̂�(NoMail)�̏ꍇ
if "%SENDTO%" == "" goto         open_zip_folder


	rem echo %output_path%%zip_file_name%.zip
	echo %mail_client% "%output_path%%zip_file_name%.zip"
	echo ���[���\�t�g���N��

:skip_zip


rem ���[���\�t�g�ɂ�镪��
IF %mailer%=="edmax" goto edmax_exec
IF %mailer%=="becky" goto becky_exec
IF %mailer%=="thunderbird" goto thunderbird_exec
IF %mailer%=="sylpheed" goto sylpheed_exec
IF %mailer%=="outlook" goto outlook_exec
IF %mailer%=="almail" goto almail_exec
IF %mailer%=="hidemaru" goto hidemaru_exec


rem �G�h�}�b�N�X
:edmax_exec
rem	echo %mail_pw_subject% > c:\_tmp_body_char
rem	echo; >> c:\_tmp_body_char
rem	echo %mail_body% >> c:\_tmp_body_char
rem	echo; >> c:\_tmp_body_char
rem	echo %psw_all% >> c:\_tmp_body_char
rem	%mail_bin% c:\_tmp_body_char
	%mail_bin% /A=%mail_pw_subject%�@%mail_body%�@%psw_all%
	%mail_bin% /E "%output_path%%zip_file_name%.zip"
	goto label10

rem �x�b�L�[
:becky_exec
	%mail_bin% "mailto:?subject=%mail_pw_subject%&body=%mail_body%%psw_all%"
	rem �Y�t�t�@�C���Ȃ�����2�ʖڍ쐬���Ȃ�
	IF not %psw_all%=="" %mail_bin% "%output_path%%zip_file_name%.zip"

	rem --- sleep start ---
	rem �����ƓY�t����Ȃ����Ƃ�����̂�Sleep����
	set i=0
	:label03
	IF %i%==1000 GOTO :label05
	set /a i+=1
	goto label03
	:label05
	rem --- sleep e n d ---

	rem rem �t�@�C�����폜�i�܂��͑ޔ��j���ďI��
	rem del "%output_path%%zip_file_name%.zip"
	goto label10

rem �T���_�[�o�[�h
:thunderbird_exec

	rem 2015/11/11�@�΋��@Bug�C��
	rem PW���t�p�̏ꍇ�ATo�̃��[���A�h���X�Z�p���[�^���@, �� ; �ɒu������
	set mail_to_static_semi=%mail_to_static:,=;%

	%mail_bin% -compose "mailto:%mail_to_static%?subject=%mail_subject_static%%mail_pw_subject%&body=%mail_body_head_static%%mail_body%%psw_all%%mail_body_foot_static%&cc=%mail_cc_static%"
	rem �Y�t�t�@�C���Ȃ�����2�ʖڍ쐬���Ȃ�
	IF not %psw_all%=="" %mail_bin% -compose to=%mail_to_static_semi%,subject=%mail_subject_static%,body=%mail_body_head_static%%mail_body_pwmsg%%mail_body_foot_static%,cc='%mail_cc_static%',attachment='%output_path%%zip_file_name%.zip'
	goto label10

rem �V���t�B�[�h
:sylpheed_exec

	rem --- sleep start ---
	rem �����Ɨ����邱�Ƃ�����̂�Sleep����
	set i=0
	:label20
	IF %i%==1000 GOTO :label21
	set /a i+=1
	goto label20
	:label21
	rem --- sleep e n d ---

	rem %mail_bin% --compose %mail_pw_subject%�@%mail_body%�@%psw_all%
	%mail_bin% --compose "mailto:%mail_to_static%?subject=%mail_subject_static%%mail_pw_subject%&body=%mail_body_head_static%%mail_body%%psw_all%%mail_body_foot_static%&cc=%mail_cc_static%"
	rem �Y�t�t�@�C���Ȃ�����2�ʖڍ쐬���Ȃ�
	IF not %psw_all%=="" %mail_bin% --compose "mailto:%mail_to_static%?subject=%mail_subject_static%&body=%mail_body_head_static%%mail_body_pwmsg%%mail_body_foot_static%&cc=%mail_cc_static%" --attach "%output_path%%zip_file_name%.zip"
	goto label10

rem �A�E�g���b�N
:outlook_exec
	%mail_bin% /c ipm.note /m "mailto:?subject=%mail_pw_subject%&body=%mail_body%%psw_all%"
	rem �Y�t�t�@�C���Ȃ�����2�ʖڍ쐬���Ȃ�
	IF not %psw_all%=="" %mail_bin% /a "%output_path%%zip_file_name%.zip"
	goto label10

rem �A�����[��
:almail_exec
	echo %mail_pw_subject% > c:\_tmp_body_char
	echo; >> c:\_tmp_body_char
	echo %mail_body% >> c:\_tmp_body_char
	echo; >> c:\_tmp_body_char
	echo %psw_all% >> c:\_tmp_body_char
	%mail_bin% /send /file:c:\_tmp_body_char
rem	%mail_bin% /send /subject:%mail_pw_subject%�@%mail_body%�@%psw_all%
	rem �Y�t�t�@�C���Ȃ�����2�ʖڍ쐬���Ȃ�
	IF not %psw_all%=="" %mail_bin% /send /attach:"%output_path%%zip_file_name%.zip"
del c:\_tmp_body_char
	goto label10

rem �G�ۃ��[��
:hidemaru_exec
	%mail_bin% newmail Subject=%mail_pw_subject% Body="%mail_body%%psw_all%"
	rem �Y�t�t�@�C���Ȃ�����2�ʖڍ쐬���Ȃ�
	IF not %psw_all%=="" %mail_bin% "%output_path%%zip_file_name%.zip"
	goto label10



rem ----------- ����I��
:label10
	exit


rem ----------- �G���[����
:error
explorer %output_path%
	echo �������s���ł��B
	echo ���k�������t�@�C�����h���b�v���Ďg�p���Ă��������B
	echo.
rem	pause
	exit


rem ----------------------------------------
rem �֐����������擾����
rem �g�p�@ call :GET_STRLEN (�Ώۂ̕�����)
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
rem Explorer��Zip�t�@���_���J��
rem ----------------------------------------
:open_zip_folder

mshta vbscript:execute("a=InputBox(""�t�@�C�����k�̂ݎ��s���܂����B���L�̃p�X���[�h���R�s�y���Ă����p���������BOK���N���b�N����ƈ��k�t�@�C�����\������܂��B"", ""�p�X���[�h"", ""%psw_all%""):close")
explorer !TMP!


exit

rem ----------------------------------------
rem Explorer�Ńt�@���_���J��
rem ----------------------------------------
:open
explorer !ROOT!

exit

rem ----------------------------------------
rem �G�f�B�^�ŐV�K�쐬
rem ----------------------------------------
:new
copy .\settings\@tmplate_file .\settings\%val%.txt
.\settings\%val%.txt
copy .\settings\%val%.txt .\settings\%val%.bat
del .\settings\%val%.txt

exit

rem ----------------------------------------
rem �G�f�B�^�ŕҏW
rem ----------------------------------------
:edit

copy .\settings\%val%.bat .\settings\%val%.txt
.\settings\%val%.txt
copy .\settings\%val%.txt .\settings\%val%.bat
del .\settings\%val%.txt

exit