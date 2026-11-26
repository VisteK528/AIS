# System Opieki Zdrowotnej (SOZ) - kontenery logiczne w 5 warstwach (punkt 2 projektu) i komponenty usługi Wizyty.
# Bez technologii (wybór technologii to punkt 3). Wymagania i klasa usług (K1/K2/K3, NFR "Klasy usług") w properties.

soz = softwareSystem "System Opieki Zdrowotnej (SOZ)" "Łączy pacjentów, lekarzy i laboratoria sieci 5 szpitali i 20 przychodni." {

    group "Warstwa prezentacji" {
        patientPortal = container "Portal pacjenta" "Wizyty, teleporady, dokumentacja, wyniki i płatności w przeglądarce." {
            tags "Przeglądarka"
            properties {
                "Klasa usług" "K2"
                "Wymagania" "FR-WIZ-01/05, FR-TEL-01/04, FR-DOK-01, FR-ROZ-02/04, FR-IAM-04/05, NFR-UZY-01..03"
            }
        }
        mobileApp = container "Aplikacja mobilna" "Funkcje portalu pacjenta na telefonie." {
            tags "Mobilna"
            properties {
                "Klasa usług" "K2"
                "Wymagania" "FR-WIZ-01, FR-TEL-09, NFR-UZY-02"
            }
        }
        doctorPanel = container "Panel lekarza" "Panel personelu medycznego: dokumentacja, zlecenia, wyniki, obrazy i teleporady." {
            tags "Przeglądarka"
            properties {
                "Klasa usług" "K1"
                "Wymagania" "FR-DOK-03..06, FR-ZLE-01/02/07, FR-TEL-09, NFR-UZY-04"
            }
        }
        adminPanel = container "Panel administracji" "Rejestracja, grafiki, cenniki, konta i panele analityczne." {
            tags "Przeglądarka"
            properties {
                "Klasa usług" "K3"
                "Wymagania" "FR-WIZ-06..08, FR-ROZ-01/06, FR-ANA-01..05, FR-IAM-02"
            }
        }
    }

    group "Warstwa aplikacji" {
        appointments = container "Wizyty" "Grafiki lekarzy, zasoby placówek, wolne terminy, rezerwacje, odwołania i przypomnienia." {
            properties {
                "Klasa usług" "K2"
                "Wymagania" "FR-WIZ-01..10, FR-TEL-01..05/07, NFR-WYD-01"
            }

            requestHandler = component "Obsługa żądań" "Przyjmuje żądania pacjentów i rejestracji, sprawdza uprawnienia." {
                properties {
                    "Wymagania" "FR-WIZ-01/05/06/07, NFR-BEZ-03, NFR-IOP-06"
                }
            }
            schedules = component "Grafiki lekarzy" "Godziny pracy, przypisane gabinety i sprzęt, podział na terminy wizyt i teleporad." {
                properties {
                    "Wymagania" "FR-WIZ-08/10, FR-TEL-07, NFR-SKA-04"
                }
            }
            slotSearch = component "Wyszukiwanie terminów" "Szybki podgląd aktualnych wolnych terminów." {
                properties {
                    "Wymagania" "FR-WIZ-03, FR-TEL-03, NFR-WYD-01"
                }
            }
            booking = component "Rezerwacja terminu" "Rezerwuje termin tak, by nie mógł zająć go nikt inny." {
                properties {
                    "Wymagania" "FR-WIZ-04, FR-WIZ-01/06, FR-TEL-01"
                }
            }
            cancellation = component "Odwołania i zwroty" "Odwołuje wizytę i zleca zwrot wg regulaminu placówki." {
                properties {
                    "Wymagania" "FR-WIZ-05/07, FR-TEL-04/05, FR-ROZ-03"
                }
            }
            reminders = component "Przypomnienia" "Planuje przypomnienia 24 h (lub 1 h) przed wizytą." {
                properties {
                    "Wymagania" "FR-WIZ-02, FR-TEL-02"
                }
            }
            eligibility = component "Weryfikacja uprawnień NFZ" "Sprawdza ubezpieczenie pacjenta, nie blokując rezerwacji." {
                properties {
                    "Wymagania" "FR-INT-05, NFR-IOP-05"
                }
            }
            eventPublisher = component "Publikacja zdarzeń" "Niezawodnie publikuje zmiany wizyt dla innych usług i analityki." {
                properties {
                    "Wymagania" "NFR-NIE-06, FR-WIZ-09, FR-TEL-08"
                }
            }
        }
        telehealth = container "Telekonsultacje" "Bezpieczne połączenia wideo i czat, przesyłanie dokumentów." {
            properties {
                "Klasa usług" "K2"
                "Wymagania" "FR-TEL-06/09, NFR-WYD-04, NFR-BEZ-06"
            }
        }
        records = container "Dokumentacja medyczna" "Jedna kartoteka pacjenta, wpisy z historią zmian i podpisem." {
            properties {
                "Klasa usług" "K1"
                "Wymagania" "FR-DOK-01..07, FR-INT-01, NFR-WYD-02, NFR-ZGO-02/03"
            }
        }
        orders = container "Zlecenia i wyniki" "Zlecenia badań, statusy, wyniki z korektami, wyniki krytyczne." {
            properties {
                "Klasa usług" "K1"
                "Wymagania" "FR-ZLE-01..07, NFR-WYD-03"
            }
        }
        billing = container "Rozliczenia" "Cenniki, płatności, zwroty, paragony i świadczenia NFZ." {
            properties {
                "Klasa usług" "K2 (płatności), K3 (rozliczenia NFZ)"
                "Wymagania" "FR-ROZ-01..06"
            }
        }
        notifications = container "Powiadomienia" "Przypomnienia, nowe zalecenia i wpisy, informacje o wynikach, pilne alerty dla lekarzy." {
            properties {
                "Klasa usług" "K2"
                "Wymagania" "FR-WIZ-02, FR-TEL-02, FR-DOK-07, FR-ZLE-05/06, NFR-WYD-03"
            }
        }
    }

    group "Warstwa integracji" {
        integration = container "Integracja HL7 / FHIR" "Wymiana danych z HIS, LIS, PACS, P1, NFZ i placówkami spoza sieci." {
            properties {
                "Klasa usług" "K1"
                "Wymagania" "FR-INT-01..06, NFR-IOP-01..05"
            }
        }
        eventQueue = container "Kolejka zdarzeń" "Asynchroniczna komunikacja usług bez utraty i duplikatów komunikatów." {
            tags "Kolejka"
            properties {
                "Klasa usług" "K1"
                "Wymagania" "NFR-NIE-06, NFR-IOP-05, NFR-DOS-04"
            }
        }
    }

    group "Warstwa danych" {
        database = container "Baza relacyjna" "Dane ustrukturyzowane, osobny schemat dla każdej usługi." {
            tags "Baza"
            properties {
                "Wymagania" "NFR-BEZ-05, NFR-NIE-02, NFR-ZGO-02/04"
            }
        }
        blobStore = container "Magazyn obrazów i dokumentów" "Obrazy diagnostyczne (DICOM), skany i dokumenty PDF." {
            tags "Baza"
            properties {
                "Wymagania" "FR-INT-03, NFR-IOP-03, NFR-WYD-05, NFR-ZGO-02"
            }
        }
        warehouse = container "Hurtownia analityczna" "Pseudonimizowane dane do paneli i raportów." {
            tags "Baza"
            properties {
                "Klasa usług" "K3"
                "Wymagania" "FR-ANA-01..06, NFR-WYD-06, NFR-ZGO-06"
            }
        }
        auditLog = container "Dziennik audytu" "Niemodyfikowalny magazyn tylko do dopisywania: kto, kiedy i do jakich danych miał dostęp." {
            tags "Baza"
            properties {
                "Wymagania" "FR-IAM-06, NFR-BEZ-04/08, NFR-ZGO-05"
            }
        }
    }

    group "Warstwa infrastruktury" {
        apiGateway = container "Brama API" "Jedno wejście do usług: routing, ochrona, limity." {
            properties {
                "Wymagania" "NFR-BEZ-03/05, NFR-IOP-06, NFR-SKA-02"
            }
        }
        identity = container "Tożsamość i dostęp" "Logowanie, MFA, role, zgody i upoważnienia; rejestruje dostęp do danych pacjentów." {
            properties {
                "Wymagania" "FR-IAM-01..06, NFR-BEZ-01..04/09"
            }
        }
        monitoring = container "Monitorowanie i logi" "Metryki, rozproszone śledzenie, alerty i centralne logi bez danych pacjentów." {
            properties {
                "Wymagania" "NFR-MON-01..04, NFR-BEZ-09"
            }
        }
    }
}
