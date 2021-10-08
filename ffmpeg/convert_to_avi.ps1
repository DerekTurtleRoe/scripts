@(Get-ChildItem -File -Recurse -Filter *.webm).foreach({
    $pat = Split-Path ($_).FullName
    $codec = ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 ($_).FullName
    $new = "$pat\$(($_).BaseName)_RAWVIDEO.avi"
    If ($codec -eq "vp8") {
        ffmpeg -hide_banner -c:v libvpx -i "$(($_).FullName)" -pix_fmt rgba -c:v rawvideo -c:a aac -q:a 5 "$new"
    }ElseIf
        ffmpeg -hide_banner -c:v libvpx-vp9 -i "$(($_).FullName)" -pix_fmt rgba -c:v rawvideo -c:a aac -q:a 5 "$new"
    }
})

@(Get-ChildItem -File -Recurse -Filter *.mov).foreach({
    $pat = Split-Path ($_).FullName
    $new = "$pat\$(($_).BaseName)_RAWVIDEO.avi"
    ffmpeg -hide_banner -i "$(($_).FullName)" -pix_fmt rgba -c:v rawvideo -c:a aac -q:a 5 "$new"
})

@(Get-ChildItem -File -Recurse -Filter *.mp4).foreach({
    $pat = Split-Path ($_).FullName
    $new = "$pat\$(($_).BaseName)_RAWVIDEO.avi"
    ffmpeg -hide_banner -i "$(($_).FullName)" -pix_fmt rgba -c:v rawvideo -c:a aac -q:a 5 "$new"
})