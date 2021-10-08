@(Get-ChildItem -File -Recurse -Filter *.webm).foreach({
    $pat = Split-Path ($_).FullName
    $codec = ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 ($_).FullName
    $vp9 = "$pat\$(($_).BaseName)_VP9.webm"
    If ($codec -eq "vp8") {
        ffmpeg -hide_banner -c:v libvpx -i "$(($_).FullName)" -pix_fmt yuva420p -c:v libvpx-vp9 -crf 0 -b:v 0 -lossless 1 -row-mt 1 -tile-columns 6 -tile-rows 2 -frame-parallel 1 -c:a libopus -b:a 96k "$vp9"
    }
})

@(Get-ChildItem -File -Recurse -Filter *.mov).foreach({
    $pat = Split-Path ($_).FullName
    $codec = ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 ($_).FullName
    $new = "$pat\$(($_).BaseName)_VP9.webm"
    ffmpeg -hide_banner -i "$(($_).FullName)" -pix_fmt yuva420p -c:v libvpx-vp9 -crf 0 -b:v 0 -lossless 1 -row-mt 1 -tile-columns 6 -tile-rows 2 -frame-parallel 1 -c:a libopus -b:a 96k "$new"
})

@(Get-ChildItem -File -Recurse -Filter *.mp4).foreach({
    $pat = Split-Path ($_).FullName
    $codec = ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 ($_).FullName
    $new = "$pat\$(($_).BaseName)_VP9.webm"
    ffmpeg -hide_banner -i "$(($_).FullName)" -pix_fmt yuva420p -c:v libvpx-vp9 -crf 0 -b:v 0 -lossless 1 -row-mt 1 -tile-columns 6 -tile-rows 2 -frame-parallel 1 -c:a libopus -b:a 96k "$new"
})