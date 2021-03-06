
PwZip2Mail.bat	Ver1.05
=======================


PwZip2Mail.batは、任意のフォルダ、ファイルをパスワード付きのZipファイル
にて圧縮し、指定のメーラにて新規メールを作成するツールです。


同梱ファイル群
--------------
* settings (Folder)　…　Mail Templates folder
* tmp (Folder)　…　Temporary Directory
* 7za.exe　…　This is a standalone command line version of 7-Zip.
* 7z_License.txt　…　7z License file ( GNU LGPL )
* 7z_readme.txt　…　7z Readme file
* README.md　…　This file
* common_settings.ba　…　Settings File
* PwZip2Mail.bat　…　This Application file


使用方法
--------
解凍した当該ファイル群を任意のフォルダに設置し、PwZip2Mail.batまたは
PwZip2Mail.batのショートカットに圧縮したいファイルまたはフォルダを
ドラッグドロップし、sample（設定バッチファイル名がsample.batの場合）
と入力し、Enterを押下します。

各メールクライアントソフトの新規メール画面が２つ開かれますので、一方に
暗号化されたファイルが添付されていること、もう一方にパスワードが記述
されていることを確認してください。

※メールソフトの種類によっては、宛先欄に自動生成されたパスワードが
  セットされるものもありますが、これは、メールソフトの起動オプションが
  対応していないためで、異常ではありません。この場合は、手作業にて
  メール本文にコピーペーストしてご利用ください。


設定方法
--------
1. [必須] 最初に、common_settings.batをエディタ又はメモ帳で開き、下記の
	�@�Aの設定をご使用のメールクライアントソフトにあわせて変更してください。
	※�Aは、メーラーのショートカットを右クリック⇒プロパティより、確認できます。

1. 添付する圧縮ファイル名を自動で生成したくない場合は、�Bのrem を削除して
	下さい。毎回、ファイル名の入力を指定できるようになります。

	    [例]beckyを使用している場合
	
		rem ---------------------------- ユーザ設定 ------------------------------
		rem 環境に合わせて下記を設定してください　ex: edmax,becky,thunderbird,…
	
		rem 使用するメーラ
		set mailer="thunderbird"							←�@
	
		rem 使用するメーラのパス
		set mailerpath="C:\Program Files (x86)\Mozilla Thunderbird\thunderbird.exe"	←�A
	
		rem 圧縮ファイル名を自動生成(手動入力する場合は下記の rem を外してください。)
		echo 圧縮ファイル名を入力してください.
		rem set /p zip_file_name=							←�B
		rem ----------------------------------------------------------------------

1. [必須] settings フォルダ内の sample.bat をコピーしたものを、エディタ又は
	メモ帳で開き、下記の�@〜�Eを設定して下さい。
	※適宜、必要に応じて複数の bat ファイルを用意します。

	＜sample.bat の例＞

		rem ○○案件用　メール設定
		rem --------------------------------------------------------------------------------------
		rem 宛先（to）
		set mail_to_static="hoge@fuga.com.jp"
		rem 宛先（cc）
		set mail_cc_static="hoge1@fuga.com.jp,hoge2@fuga.com.jp,hoge3@fuga.com.jp"
		rem 表題
		set mail_subject_static="【○○案件】議事録送付　"
		rem 本文
		set mail_body_head_static="○○さま!LF!Cc:関係各位!LF!!LF!お世話になっております。ほげほげです。!LF!!LF!!LF!"
		set mail_body_pwmsg="!LF!#　パスワードは別途送付いたします"
		set mail_body_foot_static="!LF!!LF!!LF!以上、よろしくお願いします。"
		rem --------------------------------------------------------------------------------------

	《注意事項》

	* 改行は　!LF!　で表現しています
	* to、cc の設定は、, (カンマ) で複数宛先の指定が可能です
	* TABは使用しないで下さい

	※その他、基本はバッチファイルですので、使いやすいように適当にカスタマイズ
	　していただければと思います。
	　例：パスワード桁数変更、パスワード文字列を変更、圧縮形式の変更（7zとか）


対応するメーラ
--------------
* edmax           エドマックス
* becky           ベッキー
* thunderbird     サンダーバード
* sylpheed        シルフィード
* outlook         アウトルック
* almail          アルメール
* hidemaru        秀丸メール（旧鶴亀メール）


アンインストール方法
--------------------
PwZip2Mail.batをアンインストールする場合は、当該設置フォルダごと削除
します。デスクトップ等にショートカットを作成した場合は、同様に削除を
行なってください。


ライセンス
--------------------------------
PwZip2Mail.bat Copyright (C) 2018 システムソフト分科会　石橋

PwZip2Mail.bat file are under the BSD License.


改修履歴
--------

Date|Ver|Detail
--|--|--
2011-10-01|1.00|新規作成しました。
2011-10-31|1.01|長いパス形式に対応しました
2013-03-14|1.02|BugFix:稀に解凍できない件
2015-04-23|1.03|Thunderbirdに完全対応
||直接実行で通常メール作成機能追加
2018-05-28|1.05|圧縮ファイル作成のみのNoMail機能追加
||テンポラリのクリーニング有無の設定追加
||PWのクリップボード保存有無の設定追加


以上
