Tematem projektu była Wypożyczalnia Samochodów Sportowych. Autor: Kamil Wesołowski.

Projekt zawiera system logowania oraz rejestracji, hasła są zapisywane za pomocą algorytmu hashującego. 
Zalogowani użytkownicy mogą przeglądać oraz wypożyczać pojazdy, zmieniać dane swojego konta i przeglądać swoje poprzednie wynajmy.
Administrator posiada dodatkowo panel administracyjny, w którym może przeglądać wszystkie informacje na temat pojazdów, wynajmów oraz użytkowników oraz każde z tych danych zmieniać w systemie. Galeria samochodów prezentowana na stronie głównej jest dynamicznie pobierana z bazy i może być zmieniana przez administratora.
W skrypcie sql utworzonych zostało 250 użytkowników i 1000 wynajmów aby dobrze zobrazować działanie systemu, do stworzenia tych danych została wykorzystana strona Mockaroo oraz specjalnie utworzony kontroler hashujący hasła oraz wprowadzający dane na podstawie innych pól w tabeli.

Projekt został zrealizowany w framework'u Amelia. System wykorzystuje AJAX'a oraz stronicowanie. Dodatkowo dodana została klasa pomocnicza DBUtils wspomagająca operacje na bazach danych.