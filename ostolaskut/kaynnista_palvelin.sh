#!/bin/bash
echo "Käynnistetään paikallinen palvelin..."
echo "Avaa selaimeen: http://localhost:8000/salon_ostolaskut_kartta.html"
echo "Sulje painamalla Ctrl+C"
cd "$(dirname "$0")"
python3 -m http.server 8000
