@echo off

ffmpeg.exe -i input_file.ext -c:a pcm_s16le -ar 44100 output_file.wav
pause