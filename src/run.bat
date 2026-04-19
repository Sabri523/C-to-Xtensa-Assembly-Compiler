@echo off
echo Step 1: Assembling
xtensa-lx106-elf-as -o blink.o blink2.s
if errorlevel 1 goto error

echo Step 2: Linking
xtensa-lx106-elf-ld -T esp8266.ld -o blink.elf blink.o
if errorlevel 1 goto error

echo Step 3: Creating firmware image
python -m esptool --chip esp8266 elf2image --flash-mode dio --flash-freq 40m --flash-size 4MB --output blink blink.elf
if errorlevel 1 goto error

echo Step 4: Erasing flash
python -m esptool --port COM3 --baud 115200 --chip esp8266 erase-flash
if errorlevel 1 goto error

echo Step 5: Flashing firmware
python -m esptool --port COM3 --baud 115200 --chip esp8266 write-flash 0x00000 blink0x00000.bin
if errorlevel 1 goto error

echo.
echo ✅ Done! Firmware flashed successfully.
goto end

:error
echo.
echo ❌ Error occurred at the step above. Fix it and try again.

:end
pause