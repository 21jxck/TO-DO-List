# TODO LIST: MINECRAFT

## DESCRIZIONE

**Minecraft TODO List** è un'applicazione Flutter che permette di gestire liste di attività (TODO) con un'estetica ispirata a Minecraft.

L'interfaccia dell'app mostra:
- La schermata **Liste** con le tue liste di attività,
- La schermata **Dettagli Lista** per visualizzare e aggiungere task,
- La schermata **Statistiche** con grafici e metriche di efficienza,
- Salvataggio automatico dei dati tramite **SharedPreferences**.

## FUNZIONAMENTO

L'app utilizza un sistema di **gestione dati locale** con SharedPreferences per salvare liste e task.

**Funzionalità principali**:
- Creazione di nuove liste di attività,
- Aggiunta di task alle liste,
- Marcatura di task come completati (✅),
- Eliminazione di task tramite swipe (← →),
- Eliminazione di liste,
- Visualizzazione statistiche globali e per lista:
  - Totale task,
  - Task completati,
  - Task da fare,
  - Percentuale di efficienza con barra di progresso,
- Salvataggio automatico e persistenza dei dati anche dopo chiusura dell'app,
- Interfaccia a tema **Minecraft** con colori e stili caratteristici.

## STRUTTURA DEL PROGETTO

Il progetto si basa su diverse classi principali riunite in 3 cartelle:

**Models**
- **TodoItem** → modello dati per un task singolo (id, title, isCompleted, createdAt).
- **TodoList** → modello dati per una lista (id, name, items).
- **TodoManager** → gestisce lo stato globale delle liste, comunica con StorageService e StatisticsService.

**Services**
- **StorageService** → gestisce il salvataggio e caricamento dati da SharedPreferences in formato JSON.
- **StatisticsService** → calcola le statistiche globali e per lista (totali, completati, efficienza).

**UI Components**
- **MyApp** → StatelessWidget, configura tema, colori Minecraft e route principali.
- **MainScreen** → StatefulWidget, gestisce la navigazione tra **ListsScreen** e **StatsScreen** tramite BottomNavigationBar.
- **ListsScreen** → mostra tutte le liste, permette creazione e eliminazione liste.
- **ListDetailScreen** → mostra i task di una lista, permette aggiunta e eliminazione task.
- **StatsScreen** → visualizza statistiche globali e per singola lista con barre di progresso.
- **MinecraftButton** → widget personalizzato per bottoni stilizzati Minecraft.

## REQUISITI DELL'APP

Per eseguire il progetto servono:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installato,
- **Dart SDK** (incluso in Flutter),
- Un editor come **Android Studio** o **Visual Studio Code**,
- Un emulatore o dispositivo fisico per il test.

Le dipendenze richieste:
- **shared_preferences** → per il salvataggio locale dei dati.

## ALL'AVVIO

Dopo aver clonato o copiato il progetto:

```bash
flutter pub get
flutter run
```

## AUTORE

Sviluppo del progetto a cura di **Jacopo Olivo**, 5IB ITIS C. Zuccante - TPSIT 2025/26
