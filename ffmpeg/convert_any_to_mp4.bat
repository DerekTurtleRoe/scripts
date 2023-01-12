@echo off

ffmpeg.exe -i input_file.ext -c:v libx264 -crf 18 -c:a aac -b:a 320k output_file.mp4
pause