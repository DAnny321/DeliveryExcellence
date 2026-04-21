# Manuale Funzionale – GithubCopilot

## Introduzione

L'app **GithubCopilot** estende Microsoft Dynamics 365 Business Central aggiungendo un nuovo campo Boolean alla scheda Articolo. Il campo viene impostato automaticamente a **TRUE** ogni volta che l'utente (o un'integrazione esterna) valida il campo **Nome** dell'articolo (tecnicamente denominato *Description* nella base dati).

---

## Cosa cambia per l'utente

### Nuovo campo: "Name Validated"

| Proprietà    | Valore                  |
|--------------|-------------------------|
| Nome tecnico | `ATC Name Validated`    |
| Etichetta UI | `Name Validated`        |
| Tipo         | Boolean (Sì/No)         |
| Valore di default | FALSE (non validato) |

Il campo indica se il campo **Nome** di un articolo è stato modificato o confermato almeno una volta dall'utente, da un'importazione o da un'integrazione.

---

## Comportamento funzionale

### Scenario 1 – Modifica manuale del Nome articolo

1. L'utente apre la scheda di un Articolo esistente in Business Central.
2. Modifica il campo **Nome** (Description) e sposta il cursore su un altro campo (o salva).
3. Il sistema intercetta l'evento di validazione e imposta **Name Validated = TRUE** automaticamente.
4. Il valore viene salvato insieme all'articolo.

### Scenario 2 – Creazione nuovo articolo

1. L'utente crea un nuovo articolo e inserisce il **Nome**.
2. Non appena esce dal campo (validazione), **Name Validated** diventa **TRUE**.

### Scenario 3 – Import / Integrazione

1. Un sistema esterno (es. import XML/CSV, API, RapidStart) imposta il campo **Description** tramite il meccanismo standard di Business Central (che invoca `Validate`).
2. Il campo **Name Validated** viene automaticamente impostato a **TRUE**, esattamente come accade tramite la UI.

---

## Note importanti

- Il campo **Name Validated** è di sola lettura dal punto di vista logico: non va modificato manualmente dagli utenti; viene gestito automaticamente dall'app.
- Il valore **non** viene reimpostato a FALSE se il Nome viene cancellato: indica semplicemente che il campo è stato validato almeno una volta.
- La logica non richiede modifiche agli oggetti standard Business Central.

---

## Test manuale

### Test 1 – Articolo esistente

1. Aprire Business Central e navigare in **Articoli**.
2. Aprire un articolo esistente.
3. Modificare il campo **Nome/Description**.
4. Uscire dal campo (Tab o clic su un altro campo).
5. Verificare che il campo **Name Validated** sia passato a **TRUE**.
6. Salvare l'articolo.

### Test 2 – Nuovo articolo

1. Creare un nuovo articolo tramite **Nuovo**.
2. Inserire un valore nel campo **Nome/Description**.
3. Spostarsi su un altro campo.
4. Verificare che **Name Validated** sia **TRUE**.

---

## Supporto

Per assistenza, contattare l'amministratore di sistema o il team di supporto di DeliveryExcellence.
