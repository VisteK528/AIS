# Wymagania funkcjonalne (FR) systemu SOZ
## Interesariusze / aktorzy oraz obszary wymagań
1. Pacjenci
2. Lekarze
3. Laboratoria
4. Zewnętrzne placówki (integracja przez systemi HL7 i FHIR)
5. Administracja placówki

Na podstawie wymagań interesariuszy oraz głównych założeń systemu zdefiniowano następujące obszary dla wymagań funkcjonalnych:
1. Wizyty
2. Telekonsultacje
3. Dokumentacja medyczna
4. Zlecenia i wyniki
5. Integracje zewnętrzne
6. Rozliczenia
7. Analityka i raportowanie
8. Tożsamość, uprawnienia, zgody, audyt

## Wymagania funkcjonalne dot. obszaru `Wizyty` (FR-WIZ-XX)
1. **FR-WIZ-01**: Pacjent musi mieć możliwość umówienia wizyty przez stronę internetową lub aplikację.
2. **FR-WIZ-02**: System musi wysłać pacjentowi przypomnienie na 24h przed wizytą.
3. **FR-WIZ-03**: System musi wyświetlić aktualny grafik lekarza przy umawianiu wizyty.
4. **FR-WIZ-04**: System musi zarezerwować wybrany termin w chwili potwierdzenia wizyty i uniemożliwić jego ponowną rezerwację przez innego pacjenta.
5. **FR-WIZ-05**: Pacjent musi mieć możliwość odwołania wizyty przez stronę internetową lub aplikację.
6. **FR-WIZ-06**: System musi umożliwiać wprowadzenie wizyty przez personel placówki w przypadku umówienia wizyty telefonicznie lub w placówce.
7. **FR-WIZ-07**: System musi umożliwiać odwołanie wizyty przez personel placówki (np. lekarza).
8. **FR-WIZ-08**: System musi umożliwiać zarządzanie grafikiem lekarza poprzez wprowadzanie jego godzin pracy.
9. **FR-WIZ-09**: System musi udostępniać na aktualne dane o statusie wizyt na potrzeby analityki.

## Wymagania funkcjonalne dot. obszaru `Telekonsultacje` (FR-TEL-XX)
1. **FR-TEL-01**: Pacjent musi mieć możliwość umówienia telekonsultacji przez stronę internetową lub aplikację.
2. **FR-TEL-02**: System musi wysłać pacjentowi przypomnienie na 24h przez teleporadą lub na 1h przed jeżeli wizyta jest umawiana tego samego dnia.
3. **FR-TEL-03**: System musi wyświetlić aktualny grafik lekarza przy umawianiu teleporady.
4. **FR-TEL-04**: Pacjent musi mieć możliwość odwołania teleporady przez stronę internetową lub aplikację.
5. **FR-TEL-05**: System musi umożliwiać odwołanie teleporady przez personel placówki (np. lekarza)
6. **FR-TEL-06**: System musi umożliwiać przesyłanie dokumentacji medycznej w trakcie teleporady w sposób bezpieczny.
7. **FR-TEL-07**: System musi umożliwiać zarządzanie grafikiem lekarza przez wprowadzenie jego godzin pracy przeznaczonych na teleporady.
8. **FR-TEL-08**: System musi udostępniać na aktualne dane o statusie teleporad na potrzeby analityki.
9. **FR-TEL-09**: System musi umożliwiać przeprowadzenie teleporady poprzez połączenie wideo lub czat w aplikacji lub stronie internetowej.

## Wymagania funkcjonalne dot. obszaru `Dokumentacja medyczna` (FR-DOK-XX)
1. **FR-DOK-01**: System musi umożliwiać pacjentowi dostęp do jego dokumentacji medycznej poprzez stronę internetową lub aplikację.
2. **FR-DOK-02**: System musi prowadzić jedną kartotekę pacjenta i rozpoznawać pacjenta zarejestrowanego wcześniej w innej placówce (np. po numerze PESEL).
3. **FR-DOK-03**: System musi umożliwiać lekarzowi dostęp do dokumentacji medycznej pacjenta i dodawanie do niej nowych wpisów.
4. **FR-DOK-04**: System musi umożliwiać lekarzowi tworzenie dokumentacji (np. karta wizyty, zlecenia) i podpisywanie jej cyfrowo.
5. **FR-DOK-05**: System musi przedstawiać lekarzowi podsumowanie informacji na temat pacjenta, zawierajace m.in. informacje o alergiach, chorobach przewlekłych i lekach przyjmowanych na stałe.
6. **FR-DOK-06**: System musi umożliwiać lekarzowi wprowadzanie korekt do dokumentacji medycznej, jednocześnie przechowując informacje o historii zmian.

## Wymagania funkcjonalne dot. obszaru `Zlecenia i wyniki` (FR-ZLE-XX)
1. **FR-ZLE-01**: System musi umożliwiać lekarzowi wystawienie zlecenia badania laboratoryjnego i przekazanie go do laboratorium.
2. **FR-ZLE-02**: System musi umożliwiać lekarzowi wystawienie zlecenia badania obrazowego (np. RTG, TK, MRI).
3. **FR-ZLE-03**: System musi umożliwiać laboratorium przyjęcie zlecenia, przesłanie wyniku badania oraz jego korektę, z zachowaniem poprzedniej wersji wyniku.
4. **FR-ZLE-04**: System musi umożliwiać lekarzowi oraz pacjentowi śledzenie statusu zlecenia.
5. **FR-ZLE-05**: System musi powiadamiać lekarza zlecającego oraz pacjenta o dostępności wyniku badania. Wyniki wybranych rodzajów badań (np. histopatologicznych) są udostępniane pacjentowi dopiero po zatwierdzeniu przez lekarza.
6. **FR-ZLE-06**: System musi niezwłocznie powiadomić lekarza zlecającego w trybie pilnym o wyniku oznaczonym przez laboratorium jako krytyczny.
7. **FR-ZLE-07**: System musi umożliwiać lekarzowi przeglądanie wyników badań laboratoryjnych, obrazów oraz opisów badań obrazowych, w tym porównanie wyników tego samego badania w czasie.

## Wymagania funkcjonalne dot. obszaru `Integracje zewnętrzne` (FR-INT-XX)
1. **FR-INT-01**: System musi odbierać z systemów HIS szpitali informacje o przyjęciach i wypisach pacjentów oraz dokumentację medyczną powstałą w HIS.
2. **FR-INT-02**: System musi przekazywać zlecenia badań do systemów LIS laboratoriów oraz odbierać z nich wyniki badań.
3. **FR-INT-03**: System musi odbierać z systemów PACS placówek obrazy i opisy badań obrazowych i przechowywać je w centralnym archiwum dostępnym dla wszystkich placówek sieci.
4. **FR-INT-04**: System musi przekazywać do krajowej platformy e-zdrowia (P1) informacje o zdarzeniach medycznych, e-recepty i e-skierowania.
5. **FR-INT-05**: System musi weryfikować w systemach NFZ uprawnienia pacjenta do świadczeń finansowanych ze środków publicznych oraz przekazywać dane rozliczeniowe do NFZ.
6. **FR-INT-06**: System musi umożliwiać wymianę dokumentacji medycznej i skierowań z placówkami spoza sieci z wykorzystaniem standardów HL7 i FHIR.

## Wymagania funkcjonalne dot. obszaru `Rozliczenia` (FR-ROZ-XX)
1. **FR-ROZ-01**: System musi umożliwiać administracji placówek zarządzanie cennikiem usług płatnych (wizyty, teleporady, badania), z możliwością różnicowania cen między placówkami.
2. **FR-ROZ-02**: System musi umożliwiać pacjentowi opłacenie wizyty prywatnej online podczas jej umawiania lub w placówce.
3. **FR-ROZ-03**: System musi automatycznie zlecać zwrot płatności w przypadku odwołania opłaconej wizyty zgodnie z regulaminem placówki.
4. **FR-ROZ-04**: System musi wystawiać pacjentowi dokument sprzedaży (paragon lub fakturę) za opłaconą usługę i udostępniać go w portalu pacjenta.
5. **FR-ROZ-05**: System musi rejestrować świadczenia udzielone w ramach NFZ i przygotowywać na ich podstawie dane sprawozdawcze do przekazania do NFZ.
6. **FR-ROZ-06**: System musi umożliwiać administracji przeglądanie zestawień przychodów i rozliczeń z podziałem na placówki, okresy i źródło finansowania (NFZ, prywatne).

## Wymagania funkcjonalne dot. obszaru `Analityka i raportowanie` (FR-ANA-XX)
1. **FR-ANA-01**: System musi udostępniać zarządowi i administracji placówek panel operacyjny z informacjami o liczbie wizyt, obłożeniu gabinetów i łóżek oraz czasie oczekiwania na wizytę, z podziałem na placówki.
2. **FR-ANA-02**: System musi prezentować statystyki wizyt odwołanych oraz nieodbytych z powodu nieobecności pacjenta.
3. **FR-ANA-03**: System musi prezentować wskaźniki wyników leczenia, np. odsetek ponownych hospitalizacji w ciągu 30 dni od wypisu.
4. **FR-ANA-04**: System musi umożliwiać filtrowanie danych w panelach według placówki, okresu i specjalizacji oraz eksport raportów.
5. **FR-ANA-05**: System musi automatycznie generować raporty cykliczne i udostępniać je uprawnionym odbiorcom.
6. **FR-ANA-06**: System musi prezentować dane analityczne wyłącznie w postaci zagregowanej lub pseudonimizowanej, bez danych umożliwiających identyfikację pacjenta.

## Wymagania funkcjonalne dot. obszaru `Tożsamość, uprawnienia, zgody, audyt` (FR-IAM-XX)
1. **FR-IAM-01**: System musi umożliwiać pacjentowi założenie konta i logowanie z potwierdzeniem tożsamości (np. przez krajowy węzeł identyfikacji elektronicznej).
2. **FR-IAM-02**: System musi umożliwiać administratorowi zarządzanie kontami personelu oraz przypisywanie im ról (np. lekarz, pielęgniarka, rejestracja, laborant, analityk, administrator) i placówek.
3. **FR-IAM-03**: System musi udzielać personelowi medycznemu dostępu do dokumentacji tylko tych pacjentów, którym udziela on świadczeń.
4. **FR-IAM-04**: System musi umożliwiać pacjentowi upoważnienie innych osób do dostępu do jego dokumentacji oraz odwołanie upoważnienia, a opiekunowi prawnemu działanie w imieniu podopiecznego.
5. **FR-IAM-05**: System musi umożliwiać pacjentowi składanie i wycofywanie zgód oraz oświadczeń (np. zgody na teleporadę, na kanały powiadomień).
6. **FR-IAM-06**: System musi rejestrować każdy dostęp do dokumentacji medycznej oraz udostępniać pacjentowi historię dostępu do jego dokumentacji.
