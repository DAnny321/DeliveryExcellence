# Manuale Tecnico – GithubCopilot

## Panoramica

**GithubCopilot** è un'estensione per Microsoft Dynamics 365 Business Central che aggiunge il campo Boolean `ATC Name Validated` alla tabella **Item** (Articolo, Table 27). Il campo viene impostato a `true` automaticamente ogni volta che il campo **Description** (Nome articolo) viene validato, tramite un EventSubscriber dedicato.

---

## Struttura del progetto

```
GithubCopilot/
├── app.json                                              # Manifest dell'applicazione
├── .vscode/
│   ├── launch.json                                       # Configurazione di lancio VS Code
│   └── settings.json                                     # Impostazioni analizzatori AL
├── src/
│   ├── TableExtensions/
│   │   └── ATCItem.TableExt.al                           # TableExtension su Item
│   └── Codeunits/
│       └── ATCItemSubscribers.Codeunit.al                # EventSubscriber
└── docs/
    ├── Functional-Manual.md                              # Manuale funzionale
    └── Technical-Manual.md                              # Questo documento
```

---

## Dettagli dell'applicazione (app.json)

| Proprietà      | Valore                                   |
|----------------|------------------------------------------|
| ID             | `a1b2c3d4-e5f6-7890-abcd-ef1234567890`  |
| Nome           | `GithubCopilot`                          |
| Publisher      | `DeliveryExcellence`                     |
| Versione       | `1.0.0.0`                               |
| Platform       | `1.0.0.0`                               |
| Application    | `24.0.0.0`                              |
| Runtime        | `12.0`                                  |
| ID Range       | `50300` – `50349`                        |
| Dipendenze     | Nessuna                                  |

---

## Oggetti AL

### TableExtension 50300 – `ATC Item Ext.`

**File:** `src/TableExtensions/ATCItem.TableExt.al`

**Tabella estesa:** `Item` (Table 27)

Aggiunge il seguente campo:

| Proprietà          | Valore                  |
|--------------------|-------------------------|
| ID Campo           | `50300`                 |
| Nome tecnico       | `ATC Name Validated`    |
| Tipo               | `Boolean`               |
| Caption            | `Name Validated`        |
| DataClassification | `CustomerContent`       |
| Default            | `false`                 |

---

### Codeunit 50300 – `ATC Item Subscribers`

**File:** `src/Codeunits/ATCItemSubscribers.Codeunit.al`

**Scopo:** Intercetta la validazione del campo **Description** (Nome) della tabella Item e imposta `ATC Name Validated` a `true`.

#### EventSubscriber

```al
[EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterValidateEvent', 'Description', false, false)]
local procedure OnAfterValidateItemDescription(var Rec: Record Item; var xRec: Record Item; CurrFieldNo: Integer)
begin
    Rec."ATC Name Validated" := true;
end;
```

#### Parametri dell'attributo

| Parametro              | Valore                         | Descrizione                                      |
|------------------------|--------------------------------|--------------------------------------------------|
| ObjectType             | `Table`                        | Tipo oggetto che pubblica l'evento               |
| ObjectId               | `Database::Item`               | Riferimento alla tabella Item (27)               |
| EventName              | `'OnAfterValidateEvent'`       | Evento post-validazione standard BC              |
| ElementName            | `'Description'`                | Campo che scatena l'evento                       |
| SkipOnMissingLicense   | `false`                        | Non saltare se licenza mancante                  |
| SkipOnMissingPermission| `false`                        | Non saltare se permessi mancanti                 |

#### Note: campo "Name" vs "Description"

In Business Central, il campo mostrato all'utente come **Nome** dell'articolo (Item) è tecnicamente il campo **`Description`** (Field 3, Table 27). Non esiste un campo `Name` nella tabella Item. La scelta di `Description` come campo da intercettare è quindi corretta e copre sia la modifica tramite UI che tramite importazioni/integrazioni che invocano `Validate`.

L'assegnazione diretta `Rec."ATC Name Validated" := true` (senza `Rec.Validate`) evita qualsiasi rischio di ricorsione o side effect indesiderato.

---

## Intervallo ID oggetti

| Range           | Applicazione             |
|-----------------|--------------------------|
| 50100 – 50149   | CustomerTest             |
| 50200 – 50249   | Management               |
| 50250 – 50299   | ProductPhotoCapture      |
| **50300 – 50349** | **GithubCopilot**      |

---

## Integrazione nel workspace

### `.AL-Go/settings.json`

Il folder `GithubCopilot` è stato aggiunto alla lista `appFolders` per includere l'app nel processo di CI/CD di AL-Go:

```json
"appFolders": [
  "ProductPhotoCapture",
  "GithubCopilot"
]
```

### `al.code-workspace`

Il folder `GithubCopilot` è stato aggiunto alla sezione `folders` del workspace Visual Studio Code.

---

## Come testare

### Test manuale

#### Test 1 – Articolo esistente

1. Aprire Business Central nell'ambiente DEV.
2. Navigare in **Articoli** e aprire un articolo esistente.
3. Modificare il campo **Nome** (Description).
4. Spostarsi su un altro campo o premere Tab.
5. Verificare che il campo **Name Validated** mostri **TRUE** (Sì).
6. Salvare l'articolo e riaprirlo per confermare la persistenza del valore.

#### Test 2 – Nuovo articolo

1. Creare un nuovo articolo tramite **Nuovo**.
2. Inserire un valore nel campo **Nome/Description**.
3. Spostarsi su un altro campo.
4. Verificare che **Name Validated** sia **TRUE**.

#### Test 3 – Import / Integrazione

1. Importare un articolo tramite RapidStart, XML Port o Web Service che invoca `Validate` sul campo Description.
2. Dopo l'import, verificare che `ATC Name Validated` sia `true` per gli articoli importati.

### Verifica con debugger AL

1. Impostare un breakpoint nel metodo `OnAfterValidateItemDescription` della codeunit `ATC Item Subscribers`.
2. Modificare il campo Description di un articolo dalla UI.
3. Il breakpoint deve scattare, confermando che il subscriber è attivo.

---

## Dipendenze esterne

Nessuna dipendenza aggiuntiva. L'app utilizza esclusivamente oggetti standard di Business Central:

- **Table Item** (27) – tabella articoli standard BC
- **OnAfterValidateEvent** – evento di integrazione standard pubblicato dalla tabella Item

---

## Note di deployment

- Ambiente di deploy: **DEV** (configurato in `.AL-Go/settings.json` tramite `CICDPushBranches` che include `DEV`).
- L'app è compatibile con BC 24.0 e runtime 12.0.
- Non richiede licenze speciali aggiuntive oltre alla licenza BC standard.
- Non modifica oggetti base, utilizza solo estensioni e subscriber.
