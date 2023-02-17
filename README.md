# findvalue

### Opis zadania
Należy stworzyć aplikację, której głównym celem będzie wykrywanie wartości “odstającej” od
pozostałych.

### Opis algorytmu

Dostajesz tablicę (która będzie miała długość co najmniej 3, ale może być bardzo duża)
zawierającą liczby całkowite. Tablica jest albo w całości złożona z nieparzystych liczb
całkowitych, albo całkowicie składa się z parzystych liczb całkowitych, z wyjątkiem
pojedynczej liczby całkowitej N. Napisz metodę, która przyjmuje tablicę jako argument i
zwraca tę „wartość odstającą" N.

Przykład:

[2, 4, 0, 100, 4, 11, 2602, 36]

Powinno zwrócić: 11 (jedyna nieparzysta)

[160, 3, 1719, 19, 11, 13, -21]

Powinno zwrócić: 160 (jedyna parzysta)

Należy zwrócić szczególną uwagę na jakość rozwiązania (dobre praktyki, SOLID)

### Opis aplikacji

Należy stworzyć aplikację która będzie składać się z dwóch widżetów. W pierwszym
powinien znajdować się i się 1xinput i 1xbutton. W input będzie się wpisywało liczby po
przecinku np. 2,4,0,100,4,11,2602,36 button będzie miał opis “Wyszukaj”. Po kliknięciu
wyszukaj aplikacja uruchomi drugi widżet, na którym będzie wyświetlała się liczba 11,
ponieważ 11 jest jedyną liczbą nieparzystą w zbiorze.

## What else has been implemented?

W ćwiczeniu zastosowano walidator dla wpisywanej tablicy. Są to m.in. filtry takie jak:

- Uniemożliwienie wpisania na początku innej wartości niż liczba lub minus.
- Sprawdzanie pustych wartości po przecinkach oraz ich usuwanie z listy.
- Uniemożliwienie wpisania do całości liter/znaków poza minusem, przecinkiem oraz cyframi.
- Zamiana spacji pomiędzy cyframi w jedną liczbę, np. 4, 50 404, 5 zamienia w: 4, 50404, 5.
- Wykrywanie na bieżąco informacji czy są wpisane minimum 3 elementy oraz wysłanie informacji zwrotnej użytkownikowi.
- Informowanie o nieprawidłowo wpisanych liczbach (np. -4,2,3,5 , na tej podstawie nie da się wysnuć czy lista jest parzysta czy też nieparzysta)

Dodatkowo został zaimplementowany styl Cupertino dla użytkownika iOS.
