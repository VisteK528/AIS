# Dziennik zmian modelu C4

Każdy wpis: data, co zmieniono i dlaczego. Najnowsze wpisy na górze. Drobne poprawki (literówki, etykiety) można pomijać.

---

## 2026-11-26 - Uzupełnienie modelu o wymagania zadania i raportu

Poprawki po porównaniu modelu z zadaniem (punkt 2) i raportem (`docs/report.md`).

### Zmiany

| Zmiana | Pliki | Uzasadnienie |
|---|---|---|
| Relacje usług z bazą relacyjną bez tagu `Szczegół` | `model/relationships.dsl` | baza była w przeglądzie L2 bez żadnej strzałki |
| NFZ, Integracja i baza w widoku `02a` | `views/c4.dsl` | NFZ był tylko na L1, a to punkt integracji |
| Rozliczenia → Integracja („Przekazuje sprawozdania NFZ”) | `model/relationships.dsl` | FR-ROZ-05 |
| Baza w widoku `02b` | `views/c4.dsl` | widać zapis dokumentacji i wyników |
| Nowy kontener „Monitorowanie i logi” w warstwie infrastruktury | `model/soz.dsl`, `model/deployment.dsl` | punkt 5 zadania widoczny także na L2 (NFR-MON-01..04) |
| Hosting aplikacji webowych i urządzenia użytkowników na diagramie wdrożenia | `model/deployment.dsl`, `views/c4.dsl` | warstwa prezentacji nie występowała we wdrożeniu |
| Nowy kontener „Dziennik audytu” (append-only, WORM) w warstwie danych, z kopią zapasową | `model/soz.dsl`, `model/deployment.dsl` | raport 1.4.4, FR-IAM-06, NFR-BEZ-08 |
| Panel lekarza → Magazyn obrazów („Wyświetla obrazy diagnostyczne”) | `model/relationships.dsl` | FR-ZLE-07, NFR-WYD-05 |
| Osoba „Lekarz” → „Personel medyczny” (lekarze, pielęgniarki, położne) | `model/people.dsl` | raport 1.1.2 - pielęgniarki to najliczniejsza grupa |
| FR-WIZ-10 (gabinety, sprzęt) w usłudze Wizyty i komponencie Grafiki | `model/soz.dsl` | brakujące wymaganie |
| Encja „Zasób” i jej relacje z Placówką i Grafikiem | `model/data_model.dsl` | FR-WIZ-10 |
| FR-DOK-07 w Dokumentacji i Powiadomieniach | `model/soz.dsl` | brakujące wymaganie |
| Tag `Infrastruktura` na relacjach Tożsamość → Dziennik audytu i Brama API → Monitorowanie | `model/relationships.dsl` | Structurizr nie pozwala na jawne relacje między instancjami kontenerów; tag pokazuje je w widoku `04a` |

### Świadomie pominięte

- Serwery mediów telekonsultacji (raport 1.4.7) nie są osobnym kontenerem - to szczegół technologiczny (punkt 3).
- Monitorowanie ma jedną strzałkę (od Bramy API), która reprezentuje telemetrię wszystkich usług, żeby nie zagęszczać diagramów.

---

## 2026-11-26 - Podłączenie modelu SOZ do workspace

### Zmiany

| Zmiana | Pliki | Uzasadnienie |
|---|---|---|
| `workspace.dsl` dołącza `model/*.dsl`, `views/c4.dsl` i `views/styles.dsl` zamiast przykładu sklepu | `workspace.dsl` | Structurizr pokazywał przykład zamiast modelu SOZ |

### Świadomie pominięte

- `model/example.dsl` pozostaje w repozytorium, ale nie jest już używany.
