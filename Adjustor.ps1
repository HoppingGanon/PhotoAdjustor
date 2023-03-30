
function GPhoto-Adjust ([Switch]$HideDetails = $false) {
    # カレンとディレクトリのjsonファイルを再帰的に探索
    forEach($file in (Get-ChildItem -Recurse | Where-Object {$_.Extension -eq '.json'})){

        # jsonに対応する画像(動画)ファイルの有無を確認
        $picPath = $file.FullName.Substring(0, $file.FullName.Length - 5)
        if (-not (Test-Path $picPath -PathType Leaf)) {
            continue
        }

        # jsonに対応する画像(動画)ファイルを取得
        $pic = Get-Item $picPath

        # jsonをパース
        $json = Get-Content $file.FullName -Raw -Encoding UTF8 | ConvertFrom-Json
    
        # 画面に変更前の作成日時を出力
        if (-not $HideDetails) {
            Write-Host -NoNewline "$($pic.FullName)`t"
            Write-Host -NoNewline -ForegroundColor Yellow "$($pic.CreationTime)"
            Write-Host -NoNewline ' -> '
        }
    
        # 作成日時と更新日時をメタデータから変更する
        $pic.CreationTimeUtc = $json.creationTime.formatted.Replace(' UTC', '')
        $pic.LastWriteTimeUtc = $json.creationTime.formatted.Replace(' UTC', '')
    
        # 画面に変更後の作成日時を出力
        if (-not $HideDetails) {
            Write-Host -ForegroundColor Cyan "$($pic.CreationTime)"
        }
    }
}