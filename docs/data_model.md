# Model danych SOZ

Diagram encji jest w Structurizr: elementy niestandardowe w `model/data_model.dsl`, widok **`05-model-danych`**. Nie jest częścią C4. Pokazuje główne elementy danych i ich relacje.

## Encje

| Encja | Kluczowe atrybuty | Usługa (właściciel) | Wymagania |
| --- | --- | --- | --- |
| Pacjent | PESEL, dane osobowe, kontakt | Dokumentacja medyczna (kartoteka) | FR-DOK-02 |
| Placówka | nazwa, typ, adres, cennik | Wizyty (konfiguracja) | NFR-SKA-04, FR-ROZ-01 |
| Pracownik | nr PWZ, specjalizacja, role | Tożsamość i dostęp | FR-IAM-02 |
| Grafik | godziny pracy, tryb wizyt | Wizyty | FR-WIZ-08, FR-TEL-07 |
| Termin | początek, koniec, status | Wizyty | FR-WIZ-03/04 |
| Wizyta | typ, status, finansowanie (NFZ / prywatne) | Wizyty | FR-WIZ-01..09, FR-ROZ-05 |
| Telekonsultacja | tryb (wideo / czat), status | Telekonsultacje | FR-TEL-06/09 |
| Dokument medyczny | treść, rozpoznania, wersja, podpis | Dokumentacja medyczna | FR-DOK-03..06, NFR-ZGO-03 |
| Zlecenie | rodzaj badania, status | Zlecenia i wyniki | FR-ZLE-01/02/04 |
| Wynik badania | wartość, flaga krytyczna, wersja | Zlecenia i wyniki | FR-ZLE-03/05/06 |
| Badanie obrazowe | modalność, obrazy, opis | Zlecenia i wyniki (obrazy w magazynie obiektów) | FR-ZLE-02/07, FR-INT-03 |
| Zgoda / Upoważnienie | rodzaj, zakres, ważność | Tożsamość i dostęp | FR-IAM-04/05 |
| Płatność | kwota, status, zwrot | Rozliczenia | FR-ROZ-02..04 |
| Wpis audytu | kto, kiedy, jakie dane | Tożsamość i dostęp (dziennik audytu) | FR-IAM-06, NFR-BEZ-08 |

## Relacje

| Relacja | Krotność |
| --- | --- |
| Pacjent umawia Wizytę | 1 : N |
| Pacjent udziela Zgody / Upoważnienia | 1 : N |
| Pacjent posiada Dokument medyczny | 1 : N |
| Placówka prowadzi Grafik | 1 : N |
| Pracownik pracuje wg Grafiku | 1 : N |
| Grafik dzieli się na Terminy | 1 : N |
| Termin rezerwowany przez Wizytę | 1 : 0..1 |
| Wizyta odbywa się jako Telekonsultacja | 1 : 0..1 |
| Wizyta opłacana przez Płatność | 1 : N |
| Wizyta dokumentowana w Dokumencie medycznym | 1 : N |
| Wizyta skutkuje Zleceniem | 1 : N |
| Pracownik podpisuje Dokument medyczny | 1 : N |
| Zlecenie ma Wyniki badania | 1 : N |
| Zlecenie realizowane jako Badanie obrazowe | 1 : 0..1 |
| Wpis audytu dotyczy Pacjenta | N : 1 |

## Uproszczenia
- **Rola** jest atrybutem Pracownika; nie ma osobnej encji. Pracownik może mieć wiele ról i placówek (FR-IAM-02).
- **Świadczenie NFZ** jest reprezentowane przez źródło finansowania Wizyty. Dane sprawozdawcze dla NFZ powstają z wizyt finansowanych przez NFZ (FR-ROZ-05).
- **Wersje:** Dokument medyczny i Wynik badania są wersjonowane. Korekta tworzy nową wersję, a poprzednia zostaje zachowana (FR-DOK-06, FR-ZLE-03).
