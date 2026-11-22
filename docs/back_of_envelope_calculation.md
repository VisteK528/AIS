# Szacowanie skali systemu (back of the envelope)

Projekt: Digital Healthcare Platform (SOZ), kurs Architektura i Integracja Systemów

## Założenia

| Parametr | Założenie |
| --- | --- |
| Placówki | 5 szpitali, 20 przychodni |
| Łóżka szpitalne | 2000 (400 na szpital) |
| Lekarze | 1050 (300 w przychodniach, 750 w szpitalach) |
| Użytkownicy systemu (personel z kontem) | 2000 |
| Pacjenci z kontem | 500000, w tym 250000 aktywnych w roku |
| Użytkownicy portalu pacjenta | 100000 kont, 10000 aktywnych dziennie |
| Wizyty ambulatoryjne | 15 dziennie na lekarza w przychodni, 500 dziennie na szpital |
| Telemedycyna | 25% wizyt ambulatoryjnych |
| Dni pracy | 250 w roku |
| Wzrost wolumenu | 15% rocznie |
| Retencja | 5 lat (do potwierdzenia z wymogami prawnymi) |

## Wolumen dzienny

- Wizyty ambulatoryjne: 20 × 15 × 15 = 4500 w przychodniach i 5 × 500 = 2500 w szpitalach, razem 7000 dziennie (około 1.8 mln rocznie).
- Szpital: przyjęcia to 2000 × 0.8 / 5 = 320 dziennie, SOR około 750 zgłoszeń dziennie.
- Telemedycyna: 25% wizyt to 1800 konsultacji dziennie po 20 minut. W godzinie szczytu (15% dziennego ruchu) jest 270 konsultacji, czyli 270 × 20/60 = 90 równoległych sesji wideo. Z zapasem ×3 projektujemy na 300 sesji.
- Laboratoria: 0.5 zlecenia na wizytę (3500) plus 3 zlecenia dziennie na pacjenta szpitalnego (4800) daje 8300 zleceń dziennie. Przy 8 wynikach na zlecenie to około 65000 wyników dziennie.
- Obrazowanie: około 15% z 8100 kontaktów dziennie, czyli 1200 badań dziennie.

## Ruch

| Źródło | Obliczenie | RPS w szczycie |
| --- | --- | --- |
| Personel | 1200 aktywnych użytkowników (60% z 2000), 1 żądanie na 10 s | 120 |
| Portal pacjenta | 1500 użytkowników w godzinie szczytu, 20 żądań na sesję, skoki ×3 | 25 |
| Integracje | laboratoria, obrazowanie, systemy zewnętrzne | 30 |
| Razem |  | 175 |

Z zapasem ×2.5 projektujemy na około 450 RPS. Proporcja odczytu do zapisu to 90/10, czyli około 18 zapisów na sekundę. Przy 3 zapytaniach do bazy na żądanie daje to około 500 zapytań na sekundę, co mieści się w jednym klastrze PostgreSQL z replikami.

## Dane

Dokumentacja:
- Wizyty: 7000 dziennie × 250 dni = 1.75 mln rocznie, jedna wizyta zostawia ~50 KB tekstu i danych, 88 GB rocznie.
- Pobyty szpitalne: 320 × 365 = 117000 rocznie, każdy około 2 MB (więcej dokumentów niż przy wizycie), czyli 234 GB
Razem około 320 GB rocznie.

Wyniki laboratoryjne:
8300 zleceń dziennie × 100 KB (wynik razem z dokumentem PDF) × 365 dni = 303 GB rocznie.

Log audytowy:
Zapisujemy każdy dostęp do danych pacjenta (kto, kiedy, co). Połowa z około 4 mln żądań dziennie dotyczy danych pacjenta, czyli 2 mln wpisów po 500 B = 1 GB dziennie, 365 GB rocznie.

Obrazy:
1200 badań dziennie × średnio 65 MB = 78 GB dziennie (około 80 GB). Szpitale działają codziennie, więc × 365 daje 28.5 TB, czyli około 29 TB rocznie. 65 MB to uśredniony rozmiar badania ze wszystkich rodzajów.

| Dane | Wolumen |
| --- | --- | --- |
| Dokumentacja wizyt i pobytów | 320 GB rocznie |
| Wyniki laboratoryjne | 300 GB rocznie |
| Log audytowy | 365 GB rocznie |
| Obrazy | 29 TB rocznie |

Dane strukturalne (dokumentacja, wyniki, audyt) to około 1 TB rocznie, z indeksami 1.5 TB. W 5 lat daje to 8 TB na jedną kopię i 24 TB z dwiema replikami.

Obrazy to ponad 95% wszystkich danych. W 5 lat powstaje 146 TB, po kompresji bezstratnej (2:1) 73 TB, a po uwzględnieniu wzrostu 15% rocznie około 100 TB. Z kopią DR potrzeba około 200 TB.

Hurtownia danych to około 2 TB rocznie (10 TB w 5 lat). Nagrań telemedycyny nie przechowujemy. Logi techniczne to 10 GB dziennie przez 30 dni, czyli 300 GB.

## Sieć

- Wideo: 90 sesji × 2 strumienie × 1.5 Mbps = 270 Mbps w szczycie.
- Obrazowanie: 80 GB dziennie w oknie 8 godzin to 22 Mbps. Odczyt to około 2 razy więcej, a szczyt ×5, więc razem około 330 Mbps.
- Łącznie około 600 Mbps w szczycie, więc łącze do centrum danych powinno mieć 1 Gbps.

## Zasoby

| Warstwa | Szacunek |
| --- | --- |
| API | 100 do 150 RPS na instancję (4 vCPU), czyli 4 do 5 instancji na 500 RPS, 8 z redundancją |
| Baza danych | PostgreSQL, 1 primary i 2 repliki, 8-16 vCPU, 64 GB RAM, 8 TB dysku na węzeł |
| Telemedycyna | 3 instancje serwera mediów, po 100-150 uczestników |
| Obrazy | około 200 TB w magazynie obiektowym |
| Hurtownia danych | 8 vCPU, 32-64 GB RAM, 10 TB |
| Kolejka integracji | 3 węzły, około 0.5 mln komunikatów dziennie |

## Wnioski

1. Ruch jest umiarkowany (175 RPS w szczycie), więc wystarczy klasyczna architektura z replikami odczytu.
2. Obrazy to ponad 95% danych i potrzebują osobnego magazynu obiektowego z podziałem na warstwy gorącą i zimną.
3. Telemedycyna najbardziej obciąża sieć, więc warto skalować ją osobno.
4. Log audytowy ma wolumen porównywalny z dokumentacją kliniczną, więc trzymamy go w osobnym magazynie tylko do dopisywania.
5. Po 5 latach wolumen będzie około 2 razy większy. Dłuższa retencja zwiększa dane proporcjonalnie.
