# Crisfiit

**Crisfiit** is a Flutter application designed to calculate **nutritional food equivalences** quickly and easily.

The app allows users to search for foods, select a food and input a quantity in grams to obtain equivalent portions of other foods with similar nutritional value.

---

## Features

* 🔎 **Food search** with instant filtering
* ⚖️ **Nutritional equivalence calculator**
* ⭐ **Favorites system**
* 🕘 **Search history**
* 🌙 **Dark mode support**
* 🗄️ **Local encrypted database (SQLite SQLCipher)**
* 📱 **Android and iOS support**
* 💻 **Windows support**

### Food selection and equivalences

The search screen allows users to filter and select foods from the database.

Once a food and quantity are selected, Crisfiit displays the corresponding nutritional equivalences. The interface adapts to the available screen space so that food selection and equivalence results are displayed appropriately.

---

## Example

If a user selects:

```text
Heura – 100 g
```

The app may show:

```text
Flan PROU – 150 g
```

Meaning both portions provide a **nutritionally equivalent serving** according to the equivalence rules used by Crisfiit.

---

## Project Structure

```text
lib/
 ├── models/
 │   └── food.dart
 │
 ├── screens/
 │   ├── home_screen.dart
 │   ├── search_screen.dart
 │   ├── results_screen.dart
 │   ├── favorites_screen.dart
 │   └── history_screen.dart
 │
 ├── services/
 │   ├── database_service.dart
 │   ├── equivalence_service.dart
 │   ├── favorites_service.dart
 │   ├── food_service.dart
 │   └── history_service.dart
 │
 ├── utils/
 │   ├── category_icon.dart
 │   ├── equivalence_calculator.dart
 │   └── text_utils.dart
 │
 ├── widgets/
 │   └── crisfiit_logo.dart
 │
 └── main.dart

assets/
 └── data/
     └── foods.json

firebase_options.dart
pubspec.yaml
```

---

## Database

The application uses:

* **SQLite**
* **SQLCipher encryption**

Food data is stored in:

```text
assets/data/foods.json
```

and imported into the local database during the first launch.

The database is stored locally on the device and is used for food searches, favorites, history and equivalence calculations.

---

## Technologies

* Flutter
* Dart
* SQLite
* SQLCipher
* sqflite
* sqflite_common_ffi
* Firebase / Firebase Crashlytics

---

## Installation

Clone the repository:

```bash
git clone https://github.com/crisfiit/crisfiit
```

Install dependencies:

```bash
flutter pub get
```

Run the project:

```bash
flutter run
```

---

## Releases

Crisfiit is distributed through the official app stores.

The current release is:

**Version 1.0.9 — 2026**

---

## Roadmap

Future improvements may include:

* Advanced nutritional equivalence engine
* Cloud synchronization
* Expanded food database
* Barcode scanner
* Further improvements to food search and usability

---

## Authors

Created by

**aru_baro & crisfiit**

---

## License

This project is for non-profit use.