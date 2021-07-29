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
    * **user** - tabela zawierająca informacje o użytkownikacah
    * **user_role** - tabela zawierająca role użytkowników dostępne w systemie

  * Grupa **Car**
    * **car** - tabela zawierająca pojazdy i ich dane dostępnych do wypożyczenia
    * **car_price** - tabela zawierająca informacje o cenach wynajmu poszczególnych samochodów

  * Grupa **Rent**
    * **rent** - tabela zawierająca dane dotyczące poszczególnych wypożyczeń pojazdów
    * **rent_status** - tabela zawierająca informacje o statusie wynajmu pojazdu
