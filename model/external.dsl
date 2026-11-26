# Systemy zewnętrzne. HIS, LIS i PACS pozostają poza SOZ - SOZ integruje się z nimi (FR-INT-01..03).

his = softwareSystem "Systemy szpitalne" "HIS i PACS szpitali: ruch chorych, dokumentacja, obrazy." {
    tags "Zewnętrzny"
    properties {
        "Wymagania" "FR-INT-01, FR-INT-03"
    }
}
lis = softwareSystem "Laboratoria" "Systemy LIS: przyjmują zlecenia, odsyłają wyniki." {
    tags "Zewnętrzny"
    properties {
        "Wymagania" "FR-INT-02, FR-ZLE-03"
    }
}
p1 = softwareSystem "Platforma P1" "Centrum e-Zdrowia: zdarzenia medyczne, e-recepty, e-skierowania." {
    tags "Zewnętrzny"
    properties {
        "Wymagania" "FR-INT-04, NFR-IOP-02"
    }
}
nfz = softwareSystem "NFZ" "Weryfikacja uprawnień (eWUŚ) i sprawozdawczość." {
    tags "Zewnętrzny"
    properties {
        "Wymagania" "FR-INT-05, FR-ROZ-05"
    }
}
nationalNode = softwareSystem "Węzeł Krajowy" "Potwierdzanie tożsamości pacjentów (login.gov.pl)." {
    tags "Zewnętrzny"
    properties {
        "Wymagania" "FR-IAM-01"
    }
}
paymentGateway = softwareSystem "Bramka płatności" "Płatności online i zwroty." {
    tags "Zewnętrzny"
    properties {
        "Wymagania" "FR-ROZ-02/03"
    }
}
messaging = softwareSystem "Dostawcy SMS / e-mail" "Doręczają powiadomienia i przypomnienia." {
    tags "Zewnętrzny"
    properties {
        "Wymagania" "FR-WIZ-02, FR-TEL-02, FR-ZLE-05/06"
    }
}
externalFacilities = softwareSystem "Placówki spoza sieci" "Wymiana dokumentacji i skierowań (HL7 FHIR)." {
    tags "Zewnętrzny"
    properties {
        "Wymagania" "FR-INT-06, NFR-IOP-01"
    }
}
