@echo off

set project_path=%~dp0

rem "D: msys64" is the msys2 path, please replace it yourself
set "MSYS2_PATH_TYPE=inherit" & set "MSYSTEM=MINGW64" & D:\msys64\usr\bin\bash --login -i -c 'sh "%~dp0/build_win.sh"'