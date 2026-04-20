# Manuale Tecnico – ProductPhotoCapture

## Panoramica

**ProductPhotoCapture** è un'estensione per Microsoft Dynamics 365 Business Central che aggiunge la funzionalità di acquisizione foto da fotocamera alla scheda Articolo. L'immagine acquisita viene salvata come immagine principale dell'articolo nel campo `Picture` (tipo `MediaSet`) della tabella `Item`.

---

## Struttura del progetto

```
ProductPhotoCapture/
├── app.json                          # Manifest dell'applicazione
├── ItemCardPhotoExt.PageExt.al       # Estensione della pagina Item Card
├── ProductPhotoCapture.Codeunit.al   # Codeunit helper per l'acquisizione foto
├── MANUALE_UTENTE.md                 # Manuale utente
└── MANUALE_TECNICO.md                # Questo documento
```

---

## Dettagli dell'applicazione (app.json)

| Proprietà      | Valore                                   |
|----------------|------------------------------------------|
| ID             | `0368bf07-51d3-40d2-8c8b-206f761df309`  |
| Nome           | `ProductPhotoCapture`                    |
| Publisher      | `DeliveryExcellence`                     |
| Versione       | `1.0.0.0`                               |
| Platform       | `1.0.0.0`                               |
| Application    | `24.0.0.0`                              |
| Runtime        | `12.0`                                  |
| ID Range       | `50250` – `50299`                        |
| Dipendenze     | Nessuna                                  |

---

## Oggetti AL

### Codeunit 50250 – `Product Photo Capture`

**File:** `ProductPhotoCapture.Codeunit.al`

**Scopo:** Racchiude la logica di acquisizione foto dal dispositivo e il salvataggio dell'immagine nell'articolo.

#### Procedura pubblica

| Procedura | Firma | Descrizione |
|-----------|-------|-------------|
| `CapturePhotoForItem` | `procedure CapturePhotoForItem(var Item: Record Item)` | Verifica la disponibilità della fotocamera, acquisisce la foto e la salva nel campo `Picture` dell'articolo. |

#### Flusso di esecuzione

1. Verifica la presenza di una fotocamera tramite `Camera.HasCamera()`.
2. Se nessuna fotocamera è disponibile, mostra un messaggio informativo e termina.
3. Crea un `OutStream` tramite un `TempBlob` e invoca `Camera.GetPicture(OutStr)`.
4. Se l'acquisizione ha successo, converte lo stream in `InStream` e lo importa nel campo `Item.Picture` tramite `ImportStream`.
5. Salva le modifiche sull'articolo con `Item.Modify(true)`.
6. Mostra un messaggio di conferma all'utente.

#### Label utilizzate

| Label | Valore |
|-------|--------|
| `NoCameraLbl` | `'No camera is available on this device.'` |
| `PhotoSavedLbl` | `'Photo captured and saved to item %1.'` (Comment: `%1 = Item No.`) |

---

### PageExtension 50250 – `Item Card Photo Ext`

**File:** `ItemCardPhotoExt.PageExt.al`

**Oggetto esteso:** `Item Card` (pagina standard BC)

**Scopo:** Aggiunge un'azione nella barra delle azioni della scheda Articolo per avviare l'acquisizione foto.

#### Azioni aggiunte

| Proprietà | Valore |
|-----------|--------|
| Nome interno | `CaptureItemPhoto` |
| Caption | `'Capture Item Photo'` |
| Image | `Camera` |
| Promoted | `true` |
| PromotedCategory | `Process` |
| ApplicationArea | `All` |

L'azione richiama `Codeunit "Product Photo Capture".CapturePhotoForItem(Rec)`.

---

## Integrazione nel workspace

### `.AL-Go/settings.json`

Il folder `ProductPhotoCapture` è stato aggiunto alla lista `appFolders` per includere l'app nel processo di CI/CD di AL-Go:

```json
"appFolders": [
  "CustomerTest",
  "test",
  "Management",
  "ProductPhotoCapture"
]
```

### `al.code-workspace`

Il folder `ProductPhotoCapture` è stato aggiunto alla sezione `folders` del workspace Visual Studio Code:

```json
{
  "path": "ProductPhotoCapture"
}
```

---

## Intervallo ID oggetti

| Range | Applicazione |
|-------|-------------|
| 50100 – 50149 | CustomerTest |
| 50200 – 50249 | Management |
| **50250 – 50299** | **ProductPhotoCapture** |

---

## Dipendenze esterne

L'app utilizza le seguenti funzionalità standard di Business Central (nessuna dipendenza esterna aggiuntiva):

- **`Codeunit Camera`** – fornisce l'accesso alla fotocamera del dispositivo (`HasCamera`, `GetPicture`).
- **`Codeunit "Temp Blob"`** – gestisce lo stream temporaneo per l'immagine acquisita.
- **`Record Item`** – tabella standard BC per gli articoli; il campo `Picture` (tipo `MediaSet`) viene usato per salvare l'immagine.

---

## Note di deployment

- Ambiente di deploy: **DEV** (configurato in `.AL-Go/settings.json` tramite `CICDPushBranches` che include `DEV`).
- L'app è compatibile con BC 24.0 e runtime 12.0.
- Non richiede licenze speciali aggiuntive oltre alla licenza BC standard.
- La fotocamera deve essere accessibile dal browser/client BC (permessi di sistema necessari).

---

## Test e verifica

Per verificare il corretto funzionamento dell'app dopo il deploy:

1. Aprire Business Central nell'ambiente DEV.
2. Navigare a **Articoli** e aprire un qualsiasi articolo.
3. Nella barra delle azioni, verificare la presenza del pulsante **Cattura foto articolo**.
4. Fare clic sul pulsante e verificare l'apertura della fotocamera.
5. Scattare una foto e verificare che venga visualizzata nel riquadro immagine dell'articolo.
