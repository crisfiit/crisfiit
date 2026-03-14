# Crisfiit

**Crisfiit** is a Flutter application designed to calculate **nutritional food equivalences** quickly and easily.

The app allows users to select a food and input a quantity in grams to obtain equivalent portions of other foods with similar nutritional value.

---

## Features

* 🔎 **Food search** with instant filtering
* ⚖️ **Nutritional equivalence calculator**
* ⭐ **Favorites system**
* 🕘 **Search history**
* 🌙 **Dark mode support**
* 🗄️ **Local encrypted database (SQLite SQLCipher)**
* 🖥️ **Cross-platform support** (Windows / Android / iOS ready)

---

## Example

If a user selects:

```
Heura – 100g
```

The app may show:

```
Flan PROU – 150g
```

Meaning both portions provide a **nutritionally equivalent serving**.

---

## Project Structure

```
lib/
 ├── models/
 │   └── food.dart
 │
 ├── screens/
 │   ├── home_screen.dart
 │   └── search_screen.dart
 │
 ├── services/
 │   ├── database_service.dart
 │   ├── equivalence_service.dart
 │   ├── favorites_service.dart
 │   └── history_service.dart
 │
 ├── utils/
 │   └── category_icon.dart
 │
 └── main.dart
```

---

## Database

The application uses:

* **SQLite**
* **SQLCipher encryption**

Food data is imported from:

```
assets/data/foods.json
```

during the first launch.

---

## Technologies

* Flutter
* Dart
* SQLite
* SQLCipher
* sqflite_common_ffi

---

## Installation

Clone the repository:

```
git clone https://github.com/crisfiit/crisfiit
```

Install dependencies:

```
flutter pub get
```

Run the project:

```
flutter run
```

---

## Roadmap

Future improvements planned:

* Advanced nutritional equivalence engine
* Cloud synchronization
* Expanded food database
* Barcode scanner

---

## Authors

Created by

**aru_baro & crisfiit**

Version **1.0.0 — 2026**

---

## License

This project is for non profit use.
