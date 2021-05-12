# PHP_JPDSI_Projekt
PHP JPDSI/PBAW Projekt

* **Temat:** Wypożyczalnia samochodów sportowych
* **Diagram bazy:** 

![DB Diagram](/sql/diagram.png)
## Opis projektu
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
