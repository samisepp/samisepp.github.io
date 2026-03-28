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

**Tiedostot:**
- `index.html` – Pääsivu ja interaktiivinen kartta
- `salon_ostolaskut_kartta.html` – Vaihtoehtoinen karttanäkymä
- `debug_kartta.html` – Kehitysversion kartta debuggausta varten
- `yritykset.json` – Ostotiedot JSON-muodossa (yid, nimi, ostojen summa, sijainti)
- `kaynnista_palvelin.sh / .bat` – Paikallisen palvelimen käynnistysskriptit

**Lähde:** Avoindata.suomi.fi, CC BY 4.0

---

### 2. **QGIS2Threejs Plugin Demo** (`plugindemo/`)
Esittelydemo QGIS2Threejs-lisäosalle, joka visualisoi QGIS-projekteja 3D-muodossa.

**Ominaisuudet:**
- 🎯 **3D-visualisointi** – Three.js-pohjainen 3D-renderöinti kartta- ja maastotiedoista
- 🔄 **Interaktiivinen navigaatio** – OrbitControls-ohjaus 3D-scenen liikuttamiseen
- 🎨 **Layer-hallinta** – Kerrosten näkyvyyden säätäminen
- 📐 **Pohjoisen suunta** – Kartan orientaation näyttäminen
- ✨ **Smooth animaatiot** – Tween.js-pohjaisia liikkeitä ja transitioita

**Tiedostot:**
- `index.html` – Pääsivu 3D-näkymille
- `Qgis2threejs.js` – Päälogiikka ja kontrollerit
- `Qgis2threejs.css` – UI-tyylit
- `threejs/` – Three.js-kirjasto ja kontrollit (OrbitControls, ViewHelper)
- `tweenjs/` – Tween.js-animaatiokirjasto
- `data/` – 3D-mallin ja karttadatan tiedostot

---

## 🚀 Käyttö

### Ostolaskut-projekti
1. Avaa selaimessa: `ostolaskut/index.html`
2. Tutustu kartassa näkyviin yritysostoihin
3. Käytä sivupalkissa olevia suodattimia ja hakua

**Paikallinen palvelin:**
```bash
# Linux/macOS
./ostolaskut/kaynnista_palvelin.sh

# Windows
ostolaskut/kaynnista_palvelin.bat
```

### 3D-Plugin Demo
1. Avaa selaimessa: `plugindemo/index.html`
2. Navigoi 3D-sceneä hiirellä ja näppäimillä
3. Säädä kerrosten näkyvyyttä layer-paneelista

---

## 💾 Tekniikka

| Projekti | Teknologia | Kuvaus |
|----------|-----------|--------|
| **Ostolaskut** | Leaflet.js, Markercluster, JSON | Interaktiivinen web-kartta |
| **3D-Demo** | Three.js, QGIS2Threejs, WebGL | 3D-grafiikka ja visualisointi |
| **Frontend** | HTML5, CSS3, Vanilla JS | Moderni web-stack |

---

## 📝 Lisenssit

- **Ostolaskut-data:** CC BY 4.0 (Avoindata.suomi.fi)
- **Koodi:** Oletuksena oikeudet pidätetään, ellei toisin ilmoiteta

---

## 🔗 Linkit

- [QGIS2Threejs Plugin](https://github.com/minorua/qgis2threejs) – Alkuperäinen lisäosa
- [Avoindata.suomi.fi](https://avoindata.suomi.fi/) – Julkisen hallinnon avoimen datan portaali
- [Leaflet.js](https://leafletjs.com/) – Interaktiivinen karttakirjasto
- [Three.js](https://threejs.org/) – 3D-grafiikkakirjasto

---

## 📞 Yhteystiedot

GitHub: [@samisepp](https://github.com/samisepp)

---

**Päivitetty:** 2024
