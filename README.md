# findvalue

W ćwiczeniu zastosowano walidator dla wpisywanej tablicy. Są to m.in. filtry takie jak:

- Uniemożliwienie wpisania na początku innej wartości niż liczba lub minus.
- Sprawdzanie pustych wartości po przecinkach oraz ich usuwanie z listy.
- Uniemożliwienie wpisania do całości liter/znaków poza minusem, przecinkiem oraz cyframi.
- Zamiana spacji pomiędzy cyframi w jedną liczbę, np. 4, 50 404, 5 zamienia w: 4, 50404, 5.
- Wykrywanie na bieżąco informacji czy są wpisane minimum 3 elementy oraz wysłanie informacji zwrotnej użytkownikowi.
- Informowanie o nieprawidłowo wpisanych liczbach (np. -4,2,3,5 , na tej podstawie nie da się wysnuć czy lista jest parzysta czy też nieparzysta)

Dodatkowo został zaimplementowany styl Cupertino dla użytkownika iOS.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
