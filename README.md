# PHP_JPDSI_Projekt

Sports car rental website made using Amelia PHP framework and Smarty template engine

![Project image](/project_images/img_1.png)

**[More images](project_images/)**

## Inspiration

Main page design inspired by [MPC](https://dribbble.com/shots/9840938-UX-UI-Car-rental-website) 

## Opis projektu

* **Temat:** Wypożyczalnia samochodów sportowych
* **Diagram bazy:** 

![DB Diagram](/sql/diagram.png)

Projekt aplikacji bazodanowej dla wypożyczalni samochodów sportowych.
  * Grupa **User**
    * **user** - tabela zawierająca informacje o użytkownikach
    * **user_role** - tabela zawierająca role użytkowników dostępne w systemie

  * Grupa **Car**
    * **car** - tabela zawierająca pojazdy i ich dane dostępnych do wypożyczenia
    * **car_price** - tabela zawierająca informacje o cenach wynajmu poszczególnych samochodów

  * Grupa **Rent**
    * **rent** - tabela zawierająca dane dotyczące poszczególnych wypożyczeń pojazdów
    * **rent_status** - tabela zawierająca informacje o statusie wynajmu pojazdu

Projekt zawiera system logowania oraz rejestracji, hasła są zapisywane za pomocą algorytmu hashującego. 
Zalogowani użytkownicy mogą przeglądać oraz wypożyczać pojazdy, zmieniać dane swojego konta i przeglądać swoje poprzednie wynajmy.
Administrator posiada dodatkowo panel administracyjny, w którym może przeglądać wszystkie informacje na temat pojazdów, wynajmów oraz użytkowników oraz każde z tych danych zmieniać w systemie. Galeria samochodów prezentowana na stronie głównej jest dynamicznie pobierana z bazy i może być zmieniana przez administratora.
W skrypcie sql utworzonych zostało 250 użytkowników i 1000 wynajmów aby dobrze zobrazować działanie systemu, do stworzenia tych danych została wykorzystana strona Mockaroo oraz specjalnie utworzony kontroler hashujący hasła oraz wprowadzający dane na podstawie innych pól w tabeli.

Projekt został zrealizowany w framework'u Amelia. System wykorzystuje AJAX'a oraz stronicowanie. Dodatkowo dodana została klasa pomocnicza DBUtils wspomagająca operacje na bazach danych.
