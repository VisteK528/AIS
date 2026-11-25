# Osoby. Identyfikatory wymagań w properties ("Wymagania") – widoczne w szczegółach elementu, nie na diagramie.

patient = person "Pacjent" "Umawia wizyty, przegląda dokumentację, odbywa teleporady. Także opiekun lub pełnomocnik." {
    properties {
        "Wymagania" "FR-WIZ-01/05, FR-TEL-01/09, FR-DOK-01, FR-ROZ-02, FR-IAM-01/04/05"
    }
}
doctor = person "Lekarz" "Prowadzi dokumentację, zleca badania, przegląda wyniki i obrazy." {
    properties {
        "Wymagania" "FR-DOK-03..06, FR-ZLE-01/02/07, FR-TEL-09"
    }
}
staff = person "Administracja" "Rejestracja, zarząd placówek i analitycy." {
    properties {
        "Wymagania" "FR-WIZ-06..08, FR-ROZ-01/06, FR-ANA-01..05, FR-IAM-02"
    }
}
