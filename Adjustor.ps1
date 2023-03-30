
function GPhoto-Adjust ([Switch]$HideDetails = $false) {
    # �J�����ƃf�B���N�g����json�t�@�C�����ċA�I�ɒT��
    forEach($file in (Get-ChildItem -Recurse | Where-Object {$_.Extension -eq '.json'})){

        # json�ɑΉ�����摜(����)�t�@�C���̗L�����m�F
        $picPath = $file.FullName.Substring(0, $file.FullName.Length - 5)
        if (-not (Test-Path $picPath -PathType Leaf)) {
            continue
        }

        # json�ɑΉ�����摜(����)�t�@�C�����擾
        $pic = Get-Item $picPath

        # json���p�[�X
        $json = Get-Content $file.FullName -Raw -Encoding UTF8 | ConvertFrom-Json
    
        # ��ʂɕύX�O�̍쐬�������o��
        if (-not $HideDetails) {
            Write-Host -NoNewline "$($pic.FullName)`t"
            Write-Host -NoNewline -ForegroundColor Yellow "$($pic.CreationTime)"
            Write-Host -NoNewline ' -> '
        }
    
        # �쐬�����ƍX�V���������^�f�[�^����ύX����
        $pic.CreationTimeUtc = $json.creationTime.formatted.Replace(' UTC', '')
        $pic.LastWriteTimeUtc = $json.creationTime.formatted.Replace(' UTC', '')
    
        # ��ʂɕύX��̍쐬�������o��
        if (-not $HideDetails) {
            Write-Host -ForegroundColor Cyan "$($pic.CreationTime)"
        }
    }
}