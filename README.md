# MakeLinks
NASに保存した動画ファイルを撮影日付で整理するスクリプトです。
元のファイルはそのまま、ハードリンクを作ることで、日付でのファイル名で管理できるようにします。

## TargetUser
以下のような人に役立ちます。
- カメラやビデオで撮影した動画ファイルを SDカードの中身そのままバックアップコピーしている
- Google TV等でSMB経由でNASにアクセスして動画を再生している
- ファイル名が 00001.MTS とかでわかりにくい！
- SDカードの中身そのままコピーしているのでファイル名を変えるのは嫌だ

## Usage
MakeLinks.sh をNASの適当な場所へ保存してください。
だいたいSambaを有効にしていると思うので、Windowsならエクスプローラーでぽいっと。
MakeLinks.sh の最初の方にある SRC と DST をそれぞれ、元のファイルがあるパス、整理後のパスに書き換えます。

SSH等でNASにログインし、保存してある MakeLinks.sh を実行してください。
あとは自動で年毎にフォルダを作り、日付のファイルをハードリンクとして作っていきます。

## Note
QNAP TS-230で動作確認済み。

## License
This software is released under the MIT License, see LICENSE.
