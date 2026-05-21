#!/bin/sh

# 元フォルダ（サブフォルダも含めて検索）
SRC="/share/Backup/HandyCam"

# ハードリンクを作る親フォルダ
DST="/share/Multimedia/Videos"

# MTS ファイルを検索（NASの自動生成フォルダを除外）
find "$SRC" -type f -name "*.MTS" \
    ! -path "*/.@__thumb/*" \
    ! -path "*/.@__transcode/*" \
    ! -path "*/.@Recycle/*" \
| while read FILE; do

    # 元ファイルの inode を取得
    INO=$(stat -c %i "$FILE")

    # すでに同じ inode のファイルが DST に存在するか確認
    if find "$DST" -inum "$INO" | grep -q .; then
        echo "Skip (already linked): $FILE"
        continue
    fi

    # 撮影日時（mtime を使用）
    DATE=$(stat -c %y "$FILE" | cut -d' ' -f1)
    YEAR=$(echo "$DATE" | cut -d'-' -f1)

    # 年フォルダ
    DST_YEAR="$DST/$YEAR"
    mkdir -p "$DST_YEAR"

    # 連番（同じ日付のファイル数＋1）
    COUNT=$(ls "$DST_YEAR" | grep "^${DATE}_" | wc -l)
    NUM=$(printf "%03d" $((COUNT + 1)))

    # 新しいファイル名
    NEWNAME="${DATE}_${NUM}.MTS"
    NEWPATH="$DST_YEAR/$NEWNAME"

    # すでに存在する場合はスキップ
    if [ -e "$NEWPATH" ]; then
        echo "Skip (exists): $NEWPATH"
        continue
    fi

    # ハードリンク作成
    ln "$FILE" "$NEWPATH"
    echo "Created: $NEWPATH"

done

echo "Complete!"
