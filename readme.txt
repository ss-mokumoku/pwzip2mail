
PwZip2Mail.bat	Ver1.05
=======================


PwZip2Mail.bat�́A�C�ӂ̃t�H���_�A�t�@�C�����p�X���[�h�t����Zip�t�@�C��
�ɂĈ��k���A�w��̃��[���ɂĐV�K���[�����쐬����c�[���ł��B


�����t�@�C���Q
--------------
settings�@�t�H���_	- ���[�����M��^�\��^�{���̐ݒ�t�@�C�����i�[
tmp�@�t�H���_		- ���k�Y�t�t�@�C���ۑ���t�H���_
7za.exe             - is a standalone command line version of 7-Zip.
7z_License.txt      - 7z License file ( GNU LGPL )
7z_readme.txt       - 7z Readme file
readme.txt          - This file
common_settings.bat	- ���ʐݒ�t�@�C���i�g�p���郁�[���̐ݒ�p�j
PwZip2Mail.bat      - This Application file


�g�p���@
--------
�𓀂������Y�t�@�C���Q��C�ӂ̃t�H���_�ɐݒu���APwZip2Mail.bat�܂���
PwZip2Mail.bat�̃V���[�g�J�b�g�Ɉ��k�������t�@�C���܂��̓t�H���_��
�h���b�O�h���b�v���Asample�i�ݒ�o�b�`�t�@�C������sample.bat�̏ꍇ�j
�Ɠ��͂��AEnter���������܂��B

�e���[���N���C�A���g�\�t�g�̐V�K���[����ʂ��Q�J����܂��̂ŁA�����
�Í������ꂽ�t�@�C�����Y�t����Ă��邱�ƁA��������Ƀp�X���[�h���L�q
����Ă��邱�Ƃ��m�F���Ă��������B

�����[���\�t�g�̎�ނɂ���ẮA���旓�Ɏ����������ꂽ�p�X���[�h��
�@�Z�b�g�������̂�����܂����A����́A���[���\�t�g�̋N���I�v�V������
�@�Ή����Ă��Ȃ����߂ŁA�ُ�ł͂���܂���B���̏ꍇ�́A���Ƃɂ�
�@���[���{���ɃR�s�[�y�[�X�g���Ă����p���������B


�ݒ���@
--------
�P�D[�K�{] �ŏ��ɁAcommon_settings.bat���G�f�B�^���̓������ŊJ���A���L��
	�@�A�̐ݒ�����g�p�̃��[���N���C�A���g�\�t�g�ɂ��킹�ĕύX���Ă��������B
	���A�́A���[���[�̃V���[�g�J�b�g���E�N���b�N�˃v���p�e�B���A�m�F�ł��܂��B

�Q�D�Y�t���鈳�k�t�@�C�����������Ő����������Ȃ��ꍇ�́A�B��rem ���폜����
	�������B����A�t�@�C�����̓��͂��w��ł���悤�ɂȂ�܂��B

    [��]becky���g�p���Ă���ꍇ

	rem ---------------------------- ���[�U�ݒ� ------------------------------
	rem ���ɍ��킹�ĉ��L��ݒ肵�Ă��������@ex: edmax,becky,thunderbird,�c

	rem �g�p���郁�[��
	set mailer="thunderbird"							���@

	rem �g�p���郁�[���̃p�X
	set mailerpath="C:\Program Files (x86)\Mozilla Thunderbird\thunderbird.exe"	���A

	rem ���k�t�@�C��������������(�蓮���͂���ꍇ�͉��L�� rem ���O���Ă��������B)
	echo ���k�t�@�C��������͂��Ă�������.
	rem set /p zip_file_name=							���B
	rem ----------------------------------------------------------------------

�R�D[�K�{] settings �t�H���_���� sample.bat ���R�s�[�������̂��A�G�f�B�^����
	�������ŊJ���A���L�̇@�`�E��ݒ肵�ĉ������B
	���K�X�A�K�v�ɉ����ĕ����� bat �t�@�C����p�ӂ��܂��B

	��sample.bat �̗၄
	rem �����Č��p�@���[���ݒ�
	rem --------------------------------------------------------------------------------------
	rem ����ito�j
	set mail_to_static="hoge@fuga.com.jp"
	rem ����icc�j
	set mail_cc_static="hoge1@fuga.com.jp,hoge2@fuga.com.jp,hoge3@fuga.com.jp"
	rem �\��
	set mail_subject_static="�y�����Č��z�c���^���t�@"
	rem �{��
	set mail_body_head_static="��������!LF!Cc:�֌W�e��!LF!!LF!�����b�ɂȂ��Ă���܂��B�ق��ق��ł��B!LF!!LF!!LF!"
	set mail_body_pwmsg="!LF!#�@�p�X���[�h�͕ʓr���t�������܂�"
	set mail_body_foot_static="!LF!!LF!!LF!�ȏ�A��낵�����肢���܂��B"
	rem --------------------------------------------------------------------------------------

	�s���ӎ����t

	�E���s�́@!LF!�@�ŕ\�����Ă��܂�
	�Eto�Acc �̐ݒ�́A, (�J���}) �ŕ�������̎w�肪�\�ł�
	�ETAB�͎g�p���Ȃ��ŉ�����

�����̑��A��{�̓o�b�`�t�@�C���ł��̂ŁA�g���₷���悤�ɓK���ɃJ�X�^�}�C�Y
�@���Ă���������΂Ǝv���܂��B
�@��F�p�X���[�h�����ύX�A�p�X���[�h�������ύX�A���k�`���̕ύX�i7z�Ƃ��j


�Ή����郁�[��
--------------
edmax           �G�h�}�b�N�X
becky           �x�b�L�[
thunderbird     �T���_�[�o�[�h
sylpheed        �V���t�B�[�h
outlook         �A�E�g���b�N
almail          �A�����[��
hidemaru        �G�ۃ��[���i���ߋT���[���j


�A���C���X�g�[�����@
--------------------
PwZip2Mail.bat���A���C���X�g�[������ꍇ�́A���Y�ݒu�t�H���_���ƍ폜
���܂��B�f�X�N�g�b�v���ɃV���[�g�J�b�g���쐬�����ꍇ�́A���l�ɍ폜��
�s�Ȃ��Ă��������B


���C�Z���X
--------------------------------
PwZip2Mail.bat Copyright (C) 2018 �V�X�e���\�t�g���ȉ�@�΋�
PwZip2Mail.bat file are under the BSD License.


���C����
--------
Date		Ver		Detail
2011-10-01	1.00	�V�K�쐬���܂����B
2011-10-31	1.01	�����p�X�`���ɑΉ����܂���
2013-03-14	1.02	BugFix:�H�ɉ𓀂ł��Ȃ���
2015-04-23	1.03	Thunderbird�Ɋ��S�Ή�
					���ڎ��s�Œʏ탁�[���쐬�@�\�ǉ�
2018-05-28	1.05	���k�t�@�C���쐬�݂̂�NoMail�@�\�ǉ�
					�e���|�����̃N���[�j���O�L���̐ݒ�ǉ�
					PW�̃N���b�v�{�[�h�ۑ��L���̐ݒ�ǉ�


�ȏ�
