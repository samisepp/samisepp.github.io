# samisepp.github.io

Henkilökohtainen verkkosivu ja interaktiivisia visualisointiprojekteja Suomesta.

## 📂 Projektit

### 1. **Salon ostolaskut 2024** (`ostolaskut/`)
Interaktiivinen karttavisualisointi Salon kaupungin ostolaskuista vuonna 2024.

**Ominaisuudet:**
- 🗺️ **Interaktiivinen kartta** – Leaflet.js-pohjainen visualisointi yritysostoista
- 📍 **Markkeriryhmittely** – Samalla alueella olevat ostot ryhmitellään älykkäästi
- 📊 **Suodatus ja haku** – Paina ostajien ja ostojen kesken
- 🏢 **Yritystiedot** – Koordinaatit, ostojen kokonaissumma ja sijainnin tarkkuustieto
- 📱 **Responsiivinen** – Toimii sekä pöytäkoneen että mobiiliselaimissa



**Lähde:** Avoindata.suomi.fi, CC BY 4.0

---

### 2. **QGIS2Threejs Plugin Demo** (`plugindemo/`)
Esittelydemo QGIS2Threejs-lisäosalle, joka visualisoi QGIS-projekteja 3D-muodossa.
https://samisepp.github.io/plugindemo/

**Ominaisuudet:**
- 🎯 **3D-visualisointi** – Three.js-pohjainen 3D-renderöinti kartta- ja maastotiedoista
- 🔄 **Interaktiivinen navigaatio** – OrbitControls-ohjaus 3D-scenen liikuttamiseen
- 🎨 **Layer-hallinta** – Kerrosten näkyvyyden säätäminen
- 📐 **Pohjoisen suunta** – Kartan orientaation näyttäminen
- ✨ **Smooth animaatiot** – Tween.js-pohjaisia liikkeitä ja transitioita



---

### 3. **Roof Analyzer – QGIS-lisäosa** (`roof_analyzer/`)
QGIS-lisäosa, joka laskee rakennuksen katon todellisen pinta-alan Maanmittauslaitoksen laserkeilausaineistosta. Tehty katon pinta-alan tarkistamiseen ja vertailuun kattomaalaustarjouksissa ilmoitettuihin pinta-aloihin.

Asennus- ja käyttöohje: [roof_analyzer/README.md](roof_analyzer/README.md)

**Ominaisuudet:**
- ✏️ **Rakennuksen rajaus** – Piirrä rajaus käsin tai valitse rakennus valmiilta polygonitasolta
- 📐 **Kaltevuus huomioiden** – Katon todellinen pinta-ala lasketaan 0,5 m ruuduittain kaltevuuden mukaan
- 🏠 **Kattolappeet** – Lappeiden tunnistus sekä harjat ja taitteet kartalle
- 📄 **PDF-raportti** – Karttakuva, pinta-alat, keskimääräinen kaltevuus ja lappeiden tiedot
- 📊 **CSV-loki** – Tulosten kirjaus vertailua varten
- 🔄 **QGIS 3 ja 4** – Toimii QGIS 3.28:sta alkaen, testattu QGIS 4.0:lla

**Aineisto:** Maanmittauslaitoksen Laserkeilausaineisto 5 p. Aineisto ei sisälly repositorioon, ja sen käyttö vaatii Maanmittauslaitoksen käyttöluvan.

---

**Päivitetty:** 2026
