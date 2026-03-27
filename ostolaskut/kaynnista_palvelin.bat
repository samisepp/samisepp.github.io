@echo off
echo Kaynnistetaan paikallinen palvelin...
echo Avaa selaimeen: http://localhost:8000/salon_ostolaskut_kartta.html
echo Sulje painamalla Ctrl+C
cd /d "%~dp0"
python -m http.server 8000
pause
