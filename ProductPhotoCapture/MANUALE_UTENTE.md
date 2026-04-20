# Manuale Utente – ProductPhotoCapture

## Introduzione

L'app **ProductPhotoCapture** permette di acquisire una foto direttamente dalla fotocamera del dispositivo (smartphone, tablet o PC con webcam) e di associarla all'immagine di un Articolo (prodotto) in Microsoft Dynamics 365 Business Central.

---

## Requisiti

- Business Central versione 24.0 o superiore.
- Dispositivo con fotocamera disponibile (smartphone, tablet o PC con webcam).
- Browser o app mobile Business Central con accesso alla fotocamera.

---

## Come acquisire una foto per un Articolo

### Passo 1 – Aprire la scheda Articolo

1. Dal menu principale di Business Central, selezionare **Articoli** (o cercare "Articoli" nella barra di ricerca).
2. Trovare e aprire l'articolo (prodotto) a cui si desidera associare la foto, facendo doppio clic sulla riga corrispondente o selezionando **Modifica**.

### Passo 2 – Avviare l'acquisizione dalla fotocamera

1. Nella scheda Articolo, individuare il gruppo **Elaborazione** nella barra delle azioni (ribbon).
2. Fare clic sul pulsante **Cattura foto articolo** (icona fotocamera).

   > **Nota:** Se il pulsante non è visibile, assicurarsi che la barra delle azioni mostri tutte le opzioni. Potrebbe essere necessario fare clic su **"…"** (Altro) per trovare il pulsante.

### Passo 3 – Scattare la foto

1. Il dispositivo aprirà la fotocamera integrata (o richiederà l'autorizzazione per accedervi).
2. Inquadrare il prodotto e scattare la foto.
3. Confermare l'acquisizione (a seconda del dispositivo potrebbe apparire un'anteprima con il pulsante di conferma).

### Passo 4 – Verifica del salvataggio

1. Dopo la conferma, apparirà un messaggio di avviso: **"Foto acquisita e salvata per l'articolo [numero articolo]."**
2. L'immagine verrà visualizzata nel riquadro **Immagine** nella scheda Articolo.

---

## Messaggi possibili

| Messaggio | Significato |
|-----------|-------------|
| *"Nessuna fotocamera disponibile su questo dispositivo."* | Il dispositivo in uso non ha una fotocamera riconosciuta dal browser/app. |
| *"Foto acquisita e salvata per l'articolo [N]."* | La foto è stata salvata correttamente come immagine dell'articolo. |

---

## Domande frequenti (FAQ)

**D: La foto sostituisce l'immagine precedente dell'articolo?**
R: Sì. L'immagine acquisita dalla fotocamera sostituisce l'immagine principale dell'articolo.

**D: Posso usare questa funzione dal browser sul PC?**
R: Sì, a condizione che il PC disponga di una webcam e il browser abbia i permessi per accedervi.

**D: Cosa succede se l'acquisizione viene annullata?**
R: Se si chiude la fotocamera senza scattare, nessuna modifica viene apportata all'articolo.

---

## Supporto

Per assistenza, contattare l'amministratore di sistema o il team di supporto di DeliveryExcellence.
