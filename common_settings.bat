rem ---------------------------- ユーザ設定 ------------------------------
rem 環境に合わせて下記を設定してください　ex: edmax,becky,thunderbird,…

rem ①使用するメーラ(edmax,becky,thunderbird,sylpheed,outlook,almail,hidemaru)
rem set mailer="thunderbird"
set mailer="sylpheed"

rem ②使用するメーラのパス(Program Files以下を確認すること)
rem 例："C:\Program Files\RimArts\B2\B2.exe"
rem set mailerpath="C:\Program Files (x86)\Mozilla Thunderbird\thunderbird.exe"
set mailerpath="C:\Users\ishib\Desktop\ツール\Sylpheed-3.5\sylpheed.exe"

rem ③圧縮後ファイルのファイル名を自動生成するかしないか
rem   ( 自動生成 … encrypted_yyyymmddhhnnss.zip ) をしない場合、rem を外して
rem   ください。ファイル名の毎回入力を求められます。　)
rem echo 圧縮ファイル名を入力してください.
rem set /p zip_file_name=

rem ④テンポラリフォルダをクリーニングするかしないか
rem 　毎回クリーニングする場合は rem を外してください。
set tmpclean="true"

rem ⑤クリップボードにPWを保存するかしないか
rem 　保存する場合は rem を外してください。
rem set clipboard="true"
rem ----------------------------------------------------------------------

