# Roof Analyzer – katon pinta-ala laserkeilausaineistosta

Roof Analyzer on QGIS-lisäosa, joka laskee rakennuksen katon todellisen pinta-alan, kaltevuuden ja kattolappeet Maanmittauslaitoksen laserkeilausaineistosta. Tuloksesta saa PDF-raportin.

![QGIS](https://img.shields.io/badge/QGIS-3.28%E2%80%934.x-green) ![Tila](https://img.shields.io/badge/tila-kokeellinen-orange)

---

## Sisällys

1. [Taustaa](#taustaa)
2. [Mitä lisäosa tekee](#mitä-lisäosa-tekee)
3. [Vaatimukset](#vaatimukset)
4. [Asennus](#asennus)
5. [Laserkeilausaineiston hankinta](#laserkeilausaineiston-hankinta)
6. [Käyttö vaihe vaiheelta](#käyttö-vaihe-vaiheelta)
7. [Tulosten tulkinta](#tulosten-tulkinta)
8. [Varoitukset ja vianetsintä](#varoitukset-ja-vianetsintä)
9. [Rajoitukset](#rajoitukset)
10. [Aineiston käyttöehdot](#aineiston-käyttöehdot)

---

## Taustaa

Lisäosa on tehty maanmittausinsinööriopiskelijan omaan tarpeeseen. Hän halusi tarkistaa katon pinta-alan ja verrata tulosta siihen, mitä kattomaalaustarjousten jättäjät olivat mitanneet tai arvioineet.

Tulokset ovat laskennallisia arvioita (ks. [Rajoitukset](#rajoitukset)).

---

## Mitä lisäosa tekee

1. Lukee laserpisteet rajaamaltasi alueelta.
2. Erottaa kattopisteet maasta, kasvillisuudesta ja muista kohteista.
3. Muodostaa katon ulkoreunan laserpisteiden perusteella.
4. Laskee katon kaltevuuden 0,5 m × 0,5 m ruuduittain.
5. Laskee katon **todellisen pinta-alan** kaltevuus huomioiden.
6. Tunnistaa kattolappeet sekä niiden väliset harjat ja taitteet.
7. Piirtää tulokset kartalle ja tekee PDF-raportin.

---

## Vaatimukset

### Ohjelmistot

| Vaatimus | Huomio |
|---|---|
| QGIS 3.28 tai uudempi | Testattu QGIS 4.0:lla Windowsissa |
| Python-kirjastot `laspy` ja `lazrs` | Asennetaan erikseen, ks. [Asennus](#asennus) |
| Python-kirjastot `scipy`, `shapely`, `reportlab` | Osa on yleensä valmiina QGIS:ssä |

### Aineistovaatimukset

Lisäosa on testattu **Maanmittauslaitoksen Laserkeilausaineisto 5 p** -aineistolla. Se täyttää kaikki alla olevat vaatimukset sellaisenaan.

Jos käytät muuta aineistoa, sen on täytettävä nämä vähimmäisvaatimukset:

| Vaatimus | Selitys |
|---|---|
| Tiedostomuoto LAS tai LAZ | Muita pistepilvimuotoja ei tueta. |
| Koordinaattijärjestelmä ETRS-TM35FIN (EPSG:3067) | Lisäosa olettaa pisteiden olevan tässä järjestelmässä. QGIS-projektisi koordinaattijärjestelmä saa olla mikä tahansa. |
| Maanpintapisteet luokassa 2 | Tarvitaan, jotta katto voidaan erottaa maasta. Jos maanpintapisteitä ei ole, lisäosa arvioi maanpinnan ja antaa varoituksen. |
| Kattopisteet luokassa 1, 5 tai 6 | MML:n aineistossa katot ovat luokassa 5 (”korkea kasvillisuus”), koska aineistossa ei ole erillistä rakennusluokkaa. |
| Pistetiheys katolla vähintään noin 3 pistettä/m² | Harvemmalla aineistolla lisäosa antaa varoituksen, ja tulos on epäluotettava. |

> ⚠️ **Avoin 0,5 p -aineisto ei sovellu.** Maanmittauslaitoksen maksuton laserkeilausaineisto (0,5 pistettä/m²) on liian harva: pisteiden väli on noin 1,4 m, eikä katon reunaa tai kaltevuutta saada luotettavasti.

Maanmittauslaitoksen tiheämmän 20 p -aineiston (keilattu vuodesta 2026 alkaen) pitäisi toimia, mutta sitä ei ole testattu.

---

## Asennus

Asennuksessa on kaksi vaihetta:

1. Asenna Python-kirjastot. Tämä tehdään vain kerran.
2. Asenna itse lisäosa.

Ohje on kirjoitettu Windowsille. Linux- ja macOS-ohjeet ovat [vaiheen 1 lopussa](#linux-ja-macos).

### Vaihe 1: Python-kirjastojen asennus (Windows)

Lisäosa tarvitsee laserpisteiden lukemiseen kirjastoja, joita QGIS:ssä ei ole valmiina.

1. **Sulje QGIS.**
2. Avaa Windowsin **Käynnistä**-valikko ja kirjoita hakuun `OSGeo4W Shell`.
   - Ohjelma asentuu QGIS:n mukana. Se löytyy yleensä myös Käynnistä-valikosta QGIS-kansion alta.
3. Napsauta **OSGeo4W Shelliä** hiiren oikealla painikkeella ja valitse **Suorita järjestelmänvalvojana**.
   - Järjestelmänvalvojan oikeuksia tarvitaan, jos QGIS on asennettu kansioon `C:\Program Files`.
4. Avautuu musta komentoikkuna. Kopioi siihen tämä rivi ja paina Enter:

   ```
   python -m pip install "laspy[lazrs]" scipy shapely reportlab
   ```

   - Kirjoita komento juuri näin, alkaen sanalla `python -m pip`. Pelkkä `pip install` voi antaa virheen *”Fatal error in launcher”*.
   - Asennus voi kestää muutaman minuutin. Odota, kunnes rivin alkuun palaa kehote (`C:\...>`).
5. Sulje komentoikkuna.

**Tarkista asennus:**

1. Avaa QGIS.
2. Avaa Python-konsoli: **Lisäosat → Python-konsoli** (tai pikanäppäin **Ctrl+Alt+P**).
3. Kirjoita konsolin alariville tämä ja paina Enter:

   ```python
   import laspy, lazrs, scipy, shapely, reportlab; print("OK")
   ```

4. Jos konsoliin tulostuu `OK`, kirjastot ovat kunnossa.
   - Jos tulee virhe `ModuleNotFoundError`, katso [Vianetsintä](#varoitukset-ja-vianetsintä).

#### Linux ja macOS

Asenna samat kirjastot sillä Python-tulkilla, jota QGIS käyttää. Linuxissa se on yleensä järjestelmän Python:

```
python3 -m pip install --user "laspy[lazrs]" scipy shapely reportlab
```

Linux- ja macOS-asennuksia ei ole testattu.

### Vaihe 2: Lisäosan asennus

1. Lataa lisäosan zip-tiedosto tämän repositorion **Releases**-osiosta (oikea reunapalkki → *Releases* → uusin versio → `roof_analyzer.zip`).
   - ⚠️ **Älä käytä** vihreää *Code → Download ZIP* -painiketta. Siitä tuleva zip-tiedosto ei asennu QGIS:iin, koska kansiorakenne on väärä.
   - Älä pura zip-tiedostoa.
2. Avaa QGIS.
3. Valitse valikosta **Lisäosat → Hallitse ja asenna lisäosia…**
4. Valitse vasemmalta välilehti **Asenna ZIP-tiedostosta** (englanninkielisessä QGIS:ssä *Install from ZIP*).
5. Valitse ladattu `roof_analyzer.zip` ja paina **Asenna lisäosa**.
6. Lisäosa näkyy nyt valikossa **Lisäosat → Roof Analyzer** ja painikkeena työkalurivillä.

**Päivittäminen uuteen versioon:**

1. Valitse **Lisäosat → Hallitse ja asenna lisäosia… → Asennettu**.
2. Valitse Roof Analyzer ja paina **Poista lisäosa**.
3. Sulje QGIS ja avaa se uudelleen.
4. Asenna uusi zip-tiedosto kuten edellä.

QGIS:n uudelleenkäynnistys on tärkeä, koska muuten QGIS voi käyttää vanhaa versiota muistista.

---

## Laserkeilausaineiston hankinta

Laserkeilausaineisto 5 p on maksullinen ja vaatii käyttöluvan.

1. Mene Maanmittauslaitoksen **Karttapaikkaan**: <https://asiointi.maanmittauslaitos.fi/karttapaikka>
2. Valitse **Lataa paikkatietoaineistoja**.
3. Valitse **Käyttörajoitetut aineistot: Laserkeilausaineisto 5p** ja kirjaudu vahvalla tunnistautumisella (pankkitunnukset tai mobiilivarmenne).
4. Valitse kartalta karttalehti, jolla rakennus sijaitsee, ja tilaa se.
5. Saat latauslinkin ja käyttölisenssin sähköpostiin.

Aineisto toimitetaan LAZ-tiedostoina, ja yksi tiedosto kattaa noin 1 km × 1 km alueen. Jos rakennus on kahden karttalehden rajalla, tilaa molemmat.

**Opiskelijoille:** Maanmittauslaitos tarjoaa maksuttomat 5 p -näyteaineistot Forssan, Nurmijärven, Nuuksion, Pieksämäen ja Suomutunturin alueilta. Niillä voit kokeilla lisäosaa ennen kuin tilaat oman alueesi. Lisätietoa: <https://www.maanmittauslaitos.fi/laserkeilausaineistot>

---

## Käyttö vaihe vaiheelta

### 1. Valmistele karttanäkymä

1. Avaa QGIS ja luo uusi projekti.
2. Lisää taustakartaksi **ilmakuva** (ortokuva), jotta näet rakennukset.
3. Lisää laserkeilausaineisto karttaan **pistepilvitasona**:
   - Vedä LAZ-tiedosto hiirellä QGIS-ikkunaan, tai
   - valitse **Taso → Lisää taso → Lisää pistepilvitaso…**
   - Ensimmäisellä kerralla QGIS indeksoi tiedoston, mikä voi kestää minuutin tai pari. Indeksi tallentuu tiedoston viereen, joten seuraavilla kerroilla taso avautuu nopeasti.
4. Jätä näkyviin vain luokka, jossa katot ovat:
   - QGIS näyttää pistepilven valmiiksi luokittain väritettynä, ja luokat näkyvät tasoluettelossa pistepilvitason alla.
   - Poista valinta kaikista muista luokista paitsi **High Vegetation** (korkea kasvillisuus, luokka 5).
   - MML:n aineistossa katot ovat tässä luokassa. Kartalla näkyvät nyt vain katot ja puut, ja maanpinta sekä matala kasvillisuus piiloutuvat.

Pistepilvitasosta on suurta hyötyä rajauksen piirtämisessä (ks. [kohta 3](#3-rajaa-rakennus)).

### 2. Avaa lisäosa ja valitse LAZ-tiedostot

1. Avaa lisäosa: **Lisäosat → Roof Analyzer → Roof Analyzer** tai työkalurivin painikkeesta.
2. Kohdassa **1. Laserkeilausaineisto** valitse aineisto:
   - **Tiedostot…** – valitse yksi tai useampi LAZ-tiedosto, tai
   - **Kansio…** – valitse kansio. Lisäosa ottaa mukaan kaikki kansion ja sen alikansioiden LAZ/LAS-tiedostot.

Lisäosa lukee aina vain ne tiedostot, jotka osuvat rakennuksen kohdalle, joten koko kansion valitseminen ei hidasta laskentaa. Valinta muistetaan seuraavalla käyttökerralla.

### 3. Rajaa rakennus

Rakennuksen voi rajata kahdella tavalla. **Ensisijainen tapa on piirtää rajaus käsin.**

#### Tapa A (suositeltu): Piirrä rajaus käsin

1. Paina kohdassa **2. Rakennus** painiketta **✏️ Piirrä rajaus**.
2. Piirrä rajaus katon ympäri:
   - **Vasen hiiren painike** lisää kulmapisteen.
   - **Oikea hiiren painike** tai **kaksoisklikkaus** sulkee rajauksen.
   - **Backspace** poistaa viimeisen pisteen.
   - **Esc** peruu koko piirron.
3. Kun rajaus on valmis, se näkyy kartalla oranssina, ja lisäosan ikkunaan tulee teksti *”Piirretty rajaus – käytetään sellaisenaan (puskuri 0 m)”*.

Piirretty rajaus on **ehdoton raja**. Lisäosa ei katso pisteitä rajauksen ulkopuolelta (hakualueen puskuri on automaattisesti 0 m).

**Piirrä rajaus pistepilven, älä ilmakuvan, mukaan**

Pidä pistepilvitaso näkyvissä ilmakuvan päällä, kun piirrät rajausta. Näin saat rakennuksen rajattua tarkasti, eivätkä esimerkiksi aivan katon vieressä kasvavat puut tule mukaan. Syitä on kaksi:

- **Ilmakuvassa katot ovat usein siirtyneet sivuun.** Ilmakuvauskamera näkee rakennukset hieman sivulta, joten korkealla oleva katto voi näkyä kuvassa jopa puoli metriä sivussa todellisesta paikastaan. Laserpisteet ovat oikeassa paikassa.
- **Pistepilvessä katon reuna näkyy selvästi.** Kun näkyvissä on vain High Vegetation -luokka, maanpinnan pisteet eivät peitä näkymää, ja katon pisteet päättyvät selvään reunaan. Puut näkyvät katon vieressä erillisinä, epäsäännöllisinä pisteryhminä.

Näin piirrät rajauksen pistepilven avulla:

1. Lähennä karttaa niin, että rakennus täyttää suurimman osan näkymästä.
2. Katso, missä katon pisteet päättyvät, ja piirrä rajaus niiden ulkoreunaa pitkin.
3. **Puiden puolella** piirrä rajaus tiukasti katon reunaan, jotta puun pisteet jäävät ulkopuolelle.
4. **Muilla sivuilla** voit jättää 0,2–0,3 m väljyyttä. Lisäosa määrittää katon reunan pisteistä rajauksen sisäpuolelta, joten pieni väljyys ei kasvata tulosta.
5. Älä rajaa mukaan erillisiä rakennuksia, kuten varastoja tai autokatoksia, jos et halua niitä tulokseen.

#### Tapa B: Valitse valmis rakennuspolygoni kartalta

Jos kartalla on valmis rakennusaineisto polygonitasona (esimerkiksi Maastotietokannan rakennukset tai kunnan rakennusaineisto), voit valita rakennuksen klikkaamalla.

1. Lisää rakennustaso karttaan ja varmista, että se on näkyvissä.
2. Paina **👆 Valitse kartalta**.
3. Klikkaa rakennusta kartalla.

Lisäosa etsii kattopisteitä polygonin ympäriltä **hakualueen puskurin** verran (oletuksena 1 m). Puskurin arvoa voi muuttaa kohdasta **Hakualueen puskuri**.

**Miksi tämä ei ole ensisijainen tapa?** Valmiissa rakennuspolygonissa on omat ongelmansa:

- **Polygoni voi kuvata seinälinjaa, ei räystäslinjaa.** Räystäät ulottuvat seinän ulkopuolelle, joten ne jäävät pois, jos puskuri on liian pieni.
- **Polygonin sijainnissa voi olla virhettä**, tai se voi olla vanhentunut. Esimerkiksi myöhemmin rakennettu laajennus voi puuttua.
- **Puskuri tuo mukaan myös ympäristöä.** Rakennuksen vieressä olevat puut voivat tulla mukaan, kun hakualue ulottuu polygonin ulkopuolelle.
- **Rivitaloissa ja kiinni toisissaan olevissa rakennuksissa** katto jatkuu polygonin yli, eikä raja ole laserpisteistä nähtävissä.

Valmis polygoni sopii nopeaan alustavaan arvioon. Kun tarvitset luotettavan tuloksen, piirrä rajaus käsin.

### 4. Laske

1. Kirjoita halutessasi kohteen osoite kenttään **Kohteen osoite (PDF:ään)**. Se tulee PDF-raportin otsikkoon.
2. Paina **🔍 Laske kattopinta-ala**.
3. Laskenta kestää yleensä muutaman sekunnin.

### 5. Tarkista tulos kartalta

Kartalle ilmestyy tasoryhmä **Roof Analyzer**, jossa on kolme tasoa:

| Taso | Mitä näyttää |
|---|---|
| **Katon reuna** | Laserpisteistä muodostettu katon ulkoreuna (oranssi viiva) |
| **Kattolappeet** | Tunnistetut lappeet eri väreillä ja numeroituina |
| **Harjat ja taitteet** | Lappeiden väliset rajat (musta viiva) |

**Tarkista aina, että katon reuna seuraa todellista katon reunaa.** Jos reuna ulottuu puuhun tai naapurirakennukseen, tai jos osa katosta puuttuu, korjaa rajaus ja laske uudelleen.

### 6. Tallenna tulos

- **📄 PDF-raportti** – tallentaa raportin, jossa on karttakuva, pinta-alat ja lappeiden tiedot.
- **📊 Lisää CSV-lokiin** – lisää tuloksen rivinä CSV-tiedostoon. Lokiin voi kirjata myös vertailuarvoja, esimerkiksi tarjouksissa ilmoitetut pinta-alat.
- **🗑 Tyhjennä** – poistaa rajauksen ja tulostasot kartalta.

---

## Tulosten tulkinta

| Tulos | Merkitys |
|---|---|
| **Katon todellinen pinta-ala** | Katon pinnan ala kaltevuus huomioiden. **Tätä lukua verrataan kattomaalaus- tai katemateriaalitarjouksiin.** |
| **Katon projektiopinta-ala** | Katon ala ylhäältä katsottuna, eli kuin katto olisi litteä. Aina pienempi kuin todellinen pinta-ala, jos katto on kalteva. |
| **Katon keskimääräinen kaltevuus** | Koko katon keskimääräinen kallistuskulma asteina. |
| **Kattolappeet** | Jokaisen lappeen pinta-ala, kaltevuus ja ilmansuunta. Lappeiden numerot vastaavat kartan numerointia. |

**Esimerkki:** 30° kaltevalla katolla todellinen pinta-ala on noin 15 % suurempi kuin projektiopinta-ala, ja 45° katolla noin 41 % suurempi.

### Tarkkuus

- Laskentaa on testattu katoilla, joiden todellinen pinta-ala tunnetaan (harjakatto, aumakatto, L-muotoinen katto, tasakatto). Pinta-alan virhe oli niissä tyypillisesti 0–3 %.
- Laskentaa on kokeiltu myös useilla todellisilla katoilla MML:n 5 p -aineistolla. Laajaa vertailua mitattuihin kattoihin ei ole tehty.
- Maanmittauslaitoksen mukaan 5 p -aineiston korkeustarkkuuden keskivirhe on enintään 10 cm ja tasotarkkuuden keskivirhe enintään 45 cm yksiselitteisillä kohteilla.

### Diagnostiikka

Valitse tuloksista **Näytä diagnostiikka**, niin näet laskennan välivaiheet: pisteiden määrät, pistetiheyden katolla, ohitetut kohteet ja käytetyt tiedostot. Tiedoista on apua, jos tulos näyttää oudolta.

---

## Varoitukset ja vianetsintä

### Lisäosan antamat varoitukset

| Varoitus | Mitä se tarkoittaa | Mitä tehdä |
|---|---|---|
| *Pistetiheys vain X p/m² – tulos epäluotettava* | Aineisto on liian harva. | Tarkista, ettet käytä avointa 0,5 p -aineistoa. |
| *Kattopisteitä on hakualueen reunalla X % kehästä* | Kartalta valitun rakennuksen hakualue saattaa leikata kattoa. Tulee vain tavalla B. | Kasvata puskuria esim. 2 metriin ja laske uudelleen. Jos pinta-ala kasvaa, raja leikkasi kattoa. Jos ei, varoitus oli aiheeton (katto loppui juuri hakualueen rajalle). |
| *Rajauksen sisältä ohitettiin X erillistä kohdetta* | Rajauksen sisällä oli pääkatosta erillään olevia kohteita, esim. varasto, pensasaita tai puu. Niitä ei laskettu mukaan. | Jos jokin ohitetuista kuului mitattavaan kattoon, mittaa se erikseen omalla rajauksella. |
| *Lape X on pääosin rajauksen ulkopuolella* | Mukaan on tullut jotain rajauksen ulkopuolelta. | Tarkista kartalta, onko lape viereinen rakennelma, ja korjaa rajaus. |
| *Maanpintapisteitä ei löytynyt* | Aineistossa ei ole luokan 2 pisteitä rakennuksen ympäriltä. | Tarkista aineisto. Tulos voi olla epätarkka. |

### Yleisiä ongelmia

| Ongelma | Ratkaisu |
|---|---|
| *Puuttuva kirjasto: No module named 'laspy'* | Python-kirjastot puuttuvat tai ne on asennettu väärään Pythoniin. Tee [vaihe 1](#vaihe-1-python-kirjastojen-asennus-windows) uudelleen OSGeo4W Shellissä järjestelmänvalvojana ja käynnistä QGIS uudelleen. |
| *Lisäosa ei ole yhteensopiva tämän QGIS-version kanssa* | QGIS on liian vanha. Päivitä vähintään versioon 3.28. |
| *Mikään valituista LAZ-tiedostoista ei kata rakennuksen aluetta* | Valitsemasi tiedostot ovat eri alueelta kuin rakennus. Tarkista, että tilasit oikean karttalehden ja valitsit oikean tiedoston. |
| *Alueelta ei löytynyt yhtään laserpistettä* | Rajaus ei osu aineiston alueelle, tai aineisto ei ole ETRS-TM35FIN-koordinaatistossa. |
| Lisäosa ei näy valikossa asennuksen jälkeen | Tarkista **Lisäosat → Hallitse ja asenna lisäosia… → Asennettu**, että Roof Analyzerin valintaruutu on valittuna. |
| Muutokset eivät näy uuden version asennuksen jälkeen | Poista vanha versio, käynnistä QGIS uudelleen ja asenna uusi. |
| Pistepilvitaso ei näy kartalla | Odota, että QGIS on indeksoinut tiedoston (edistyminen näkyy QGIS:n alareunassa). |

---

## Rajoitukset

- **Räystäskouruja ei erotella.** Laserpisteitä osuu myös kouruihin, ja katon reuna muodostetaan uloimpien pisteiden mukaan. Pinta-ala voi siksi sisältää kourujen leveyden osittain tai kokonaan.
- **Piiput, kattoikkunat ja kattoluukut** sisältyvät pinta-alaan, koska ne ovat katon reunan sisällä. Vähennä ne tarvittaessa itse.
- **Taloon kiinni olevat katot** (kuisti, katos, siipirakennus) tulevat mukaan, jos ne ovat rajauksen sisällä. Ne näkyvät omina lappeinaan omalla kaltevuudellaan. Jos et halua niitä mukaan, rajaa ne pois.
- **Kattoa koskettavat puut** voivat tulla osittain mukaan. Paras keino on tarkka käsin piirretty rajaus pistepilven avulla.
- **Aineisto kuvaa keilaushetken tilannetta.** Jos rakennusta on muutettu keilauksen jälkeen, muutokset eivät näy.
- **Hyvin monimutkaiset katot** (kupolit, kaarevat katot, paljon pieniä kattolyhtyjä) voivat tuottaa epätarkan lappeiden jaon. Kokonaispinta-ala on niissäkin yleensä käyttökelpoinen.
- Tulos on **laskennallinen arvio**. Tarkista mitat ennen materiaalitilausta tai sopimuksen tekemistä.

---

## Aineiston käyttöehdot

Laserkeilausaineisto 5 p on Maanmittauslaitoksen aineistoa, ja sen käyttö edellyttää käyttöehtojen hyväksymistä. Tutustu käyttöehtoihin: <https://www.maanmittauslaitos.fi/laserkeilausaineistot/kayttoehdot>

Muista erityisesti:

- Laserkeilausaineistoa **ei saa jakaa eteenpäin** sellaisenaan. Älä siis lisää LAZ-tiedostoja tähän tai muihin repositorioihin.
- Kun julkaiset aineistosta tehtyjä tuotteita, esimerkiksi raportteja, mainitse lähde käyttöehtojen mukaisesti. Lähdemaininta on muotoa *”sisältää Maanmittauslaitoksen Laserkeilausaineisto 5p -aineistoa vuodelta 20XX”*.

Lisäosa itse ei sisällä laserkeilausaineistoa. Jokainen käyttäjä hankkii aineiston omalla käyttöluvallaan.
