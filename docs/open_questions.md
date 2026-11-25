# Otwarte kwestie

Kwestie, których model **nie rozstrzyga**, bo wymagania są niejednoznaczne, sprzeczne albo decyzja wykracza poza zakres modelu. Elementy modelu oznaczone „(do decyzji)” odsyłają do tej listy.

## OQ-01. Retencja: 5 czy 20 lat
- **Problem:** szacunki (`docs/back_of_envelope_calculation.md`) zakładają retencję 5 lat. NFR-ZGO-02 wymaga przechowywania dokumentacji przez 20 lat od końca roku ostatniego wpisu.
- **Wpływ:** wolumen rośnie mniej więcej proporcjonalnie. Same obrazy to ~29 TB rocznie przed kompresją. Przy 20 latach i wzroście 15% r/r magazyn obrazów zwiększy się wielokrotnie względem ~100 TB (i ~200 TB z DR). Potrzebna jest warstwa archiwalna (np. cold/archive storage z czasem odtworzenia w godzinach). Trzeba wtedy też sprawdzić, czy NFR-WYD-05 (pierwszy obraz w ≤3 s) dotyczy badań archiwalnych.
- **Do ustalenia:**
  - czy obrazy i log audytu podlegają tej samej retencji co dokumentacja,
  - polityka przenoszenia między warstwami,
  - ponowne przeliczenie back-of-envelope.

## OQ-02. Hosting i technologie (punkt 3 projektu)
- **Stan:** model celowo nie wskazuje technologii.
- **Do decyzji w punkcie 3:**
  - dostawca chmury i konkretne regiony w EOG (NFR-NIE-01, NFR-ZGO-04),
  - stos frontendu i backendu, broker zdarzeń, bazy danych i narzędzie analityczne.

## OQ-03. Klasa usług dla kontenerów przekrojowych
- **Problem:** NFR „Klasy usług” wymienia usługi domenowe, ale nie klasyfikuje Bramy API, usługi Tożsamość i dostęp, Kolejki zdarzeń ani warstwy danych.
- **W modelu:** klasa jest zapisana we właściwości „Klasa usług” elementu. Elementy przekrojowe nie mają przypisanej klasy. Ponieważ zależą od nich usługi K1, powinny spełniać wymagania K1 (99,95%, RTO 1 h). Trzeba to potwierdzić.

## OQ-04. Powiadomienia: K2 czy K1
- **Problem:** NFR przypisuje powiadomienia do K2 (99,9%, RTO 4 h). Tymczasem alert o wyniku krytycznym (FR-ZLE-06, NFR-WYD-03, ≤60 s) jest częścią przepływu klinicznego K1.
- **Do wyboru:**
  - podnieść usługę do K1,
  - wydzielić kanał alertów krytycznych jako osobną usługę K1,
  - zaakceptować ryzyko.
- **W modelu:** kontener ma klasę K2 i jest pokazany także w widoku klinicznym (02b).

## OQ-05. Rozliczenia: K2 czy K3
- **Problem:** płatności są w K2, a rozliczenia z NFZ w K3.
- **W modelu:** jeden kontener „Rozliczenia” (K2 dla płatności, K3 dla rozliczeń z NFZ). Komunikacja z NFZ idzie przez warstwę integracji.
- **Do decyzji:** czy rozdzielić usługę na „Płatności” (K2) i „Rozliczenia NFZ” (K3).

## OQ-06. eWUŚ w procesie rezerwacji
- **Problem:** weryfikacja uprawnień (FR-INT-05) idzie przez warstwę integracji do NFZ, a rezerwacja wizyty to K2. Zgodnie z NFR-IOP-05 niedostępność NFZ nie może blokować rezerwacji.
- **W modelu:** wynik jest buforowany, a weryfikacja ponawiana asynchronicznie.
- **Do ustalenia:**
  - co się dzieje z wizytą NFZ przy negatywnej weryfikacji po fakcie (oświadczenie pacjenta, zmiana na płatną),
  - czy eWUŚ dotyczy także wizyt prywatnych.

## OQ-07. Analityka: dane pseudonimizowane a raporty
- **Problem:** FR-ANA-06 i NFR-ZGO-06 wymagają danych zagregowanych lub pseudonimizowanych. Tymczasem FR-ANA-03 (ponowne hospitalizacje w 30 dni) wymaga łączenia pobytów tego samego pacjenta.
- **Do ustalenia:**
  - sposób tworzenia stabilnego pseudonimu i kto zarządza jego kluczem,
  - czy analityk dostaje bezpośredni dostęp do hurtowni (w modelu panele i raporty idą przez Bramę API).

## OQ-08. Zakres węzła awaryjnego placówki
- **Problem:** NFR-DOS-06 wymaga listy wizyt i „podstawowych danych pacjentów” na bieżący dzień. Nie jest określone:
  - które dane wchodzą w skład (np. alergie z podsumowania FR-DOK-05?),
  - czy węzeł pozwala na zapis (np. rejestracja nowej wizyty) i późniejszą synchronizację,
  - jak często odświeżać snapshot.
- **W modelu:** węzeł jest tylko do odczytu.

## OQ-09. Szacunek ~200 TB i zakres replikacji DR
- **Problem:** back-of-envelope podaje ~200 TB łącznie z kopią DR.
- **W modelu:** ~100 TB w regionie podstawowym i ~100 TB w DR.
- **Do ustalenia:** czy kopia zapasowa (NFR-NIE-04, odrębna lokalizacja, niemodyfikowalna) to dodatkowa kopia poza repliką DR. Jeśli tak, potrzeba ~300 TB.

## OQ-10. Rozbieżność szacunków ruchu
- **Problem:** back-of-envelope liczy ~175 RPS w szczycie i projektuje na ~450 RPS (×2,5). NFR-SKA-01 wymaga obsługi 3× średniego obciążenia dziennego, a NFR-SKA-05 2× wzrostu w 5 lat. Nie jest jasne, czy zapas ×2,5 pokrywa oba wymagania naraz.
- **W modelu:** autoskalowanie w trzech strefach dostępności (NFR-SKA-03). Liczbę instancji ustalimy w punkcie 3.

## OQ-11. Interesariusze
- **Problem:** `docs/stakeholders.md` jest pusty.
- **W modelu:** są trzy osoby (Pacjent, Lekarz, Administracja), wynikające z wymagań FR. Trzeba je potwierdzić z dokumentem interesariuszy, gdy powstanie.

## OQ-12. Placówki bez HIS/PACS
- **Problem:** wymagania mówią o HIS szpitali (FR-INT-01). Nie jest jasne, czy przychodnie mają własne LIS/PACS, czy korzystają z laboratoriów szpitalnych lub zewnętrznych.
- **W modelu:** jeden szablon wdrożenia placówki (×25). W przychodniach część systemów może nie występować.
