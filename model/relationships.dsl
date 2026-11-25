# Relacje – krótkie etykiety, bez technologii.
# Tag "Szczegół": relacje pomijane w widoku przeglądowym L2, widoczne w widokach szczegółowych.
# Relacje L1 (system <-> otoczenie) są wyprowadzane automatycznie z relacji kontenerów.

# ---------- Osoby ----------
patient -> soz.patientPortal "Umawia wizyty, przegląda wyniki"
patient -> soz.mobileApp "Umawia wizyty, odbiera powiadomienia"
doctor -> soz.doctorPanel "Prowadzi leczenie"
staff -> soz.adminPanel "Zarządza placówkami, analizuje dane"

# ---------- Prezentacja -> infrastruktura ----------
soz.patientPortal -> soz.apiGateway "Wywołuje API"
soz.mobileApp -> soz.apiGateway "Wywołuje API"
soz.doctorPanel -> soz.apiGateway "Wywołuje API"
soz.adminPanel -> soz.apiGateway "Wywołuje API"
soz.apiGateway -> soz.identity "Weryfikuje dostęp"

# ---------- Brama -> usługi ----------
soz.apiGateway -> soz.appointments "Przekazuje żądania"
soz.apiGateway -> soz.telehealth "Przekazuje żądania"
soz.apiGateway -> soz.records "Przekazuje żądania"
soz.apiGateway -> soz.orders "Przekazuje żądania"
soz.apiGateway -> soz.billing "Przekazuje żądania"
soz.apiGateway -> soz.warehouse "Udostępnia raporty" {
    tags "Szczegół"
}

# ---------- Teleporady ----------
soz.patientPortal -> soz.telehealth "Łączy wideo i czat" {
    tags "Szczegół"
}
soz.mobileApp -> soz.telehealth "Łączy wideo i czat" {
    tags "Szczegół"
}
soz.doctorPanel -> soz.telehealth "Łączy wideo i czat" {
    tags "Szczegół"
}

# ---------- Komunikacja zdarzeniowa ----------
soz.appointments -> soz.eventQueue "Publikuje zdarzenia" {
    tags "Szczegół"
}
soz.records -> soz.eventQueue "Publikuje zdarzenia" {
    tags "Szczegół"
}
soz.orders -> soz.eventQueue "Publikuje zdarzenia" {
    tags "Szczegół"
}
soz.billing -> soz.eventQueue "Publikuje zdarzenia" {
    tags "Szczegół"
}
soz.eventQueue -> soz.records "Dostarcza wyniki i dokumenty" {
    tags "Szczegół"
}
soz.eventQueue -> soz.notifications "Dostarcza zdarzenia"
soz.eventQueue -> soz.warehouse "Zasila danymi (pseudonimizacja)"
soz.integration -> soz.eventQueue "Wymienia komunikaty"

# ---------- Współpraca usług ----------
soz.appointments -> soz.billing "Zleca płatność i zwrot" {
    tags "Szczegół"
}
soz.appointments -> soz.integration "Weryfikuje uprawnienia NFZ" {
    tags "Szczegół"
}
soz.notifications -> soz.doctorPanel "Wysyła pilne alerty" {
    tags "Szczegół"
}

# ---------- Dane ----------
soz.appointments -> soz.database "Zapisuje dane" {
    tags "Szczegół"
}
soz.telehealth -> soz.database "Zapisuje dane" {
    tags "Szczegół"
}
soz.records -> soz.database "Zapisuje dane" {
    tags "Szczegół"
}
soz.orders -> soz.database "Zapisuje dane" {
    tags "Szczegół"
}
soz.billing -> soz.database "Zapisuje dane" {
    tags "Szczegół"
}
soz.notifications -> soz.database "Zapisuje dane" {
    tags "Szczegół"
}
soz.identity -> soz.database "Zapisuje dane" {
    tags "Szczegół"
}
soz.records -> soz.blobStore "Przechowuje dokumenty" {
    tags "Szczegół"
}
soz.orders -> soz.blobStore "Przechowuje wyniki PDF" {
    tags "Szczegół"
}
soz.integration -> soz.blobStore "Archiwizuje obrazy"

# ---------- Systemy zewnętrzne ----------
soz.identity -> nationalNode "Potwierdza tożsamość pacjenta"
soz.billing -> paymentGateway "Obsługuje płatności i zwroty"
soz.notifications -> messaging "Wysyła SMS i e-mail"
his -> soz.integration "Przesyła pobyty, dokumenty i obrazy"
soz.integration -> lis "Przesyła zlecenia, odbiera wyniki"
soz.integration -> p1 "Raportuje zdarzenia medyczne"
soz.integration -> nfz "Weryfikuje uprawnienia, sprawozdaje"
externalFacilities -> soz.integration "Wymienia dokumentację i skierowania"

# ---------- L3: komponenty usługi Wizyty ----------
soz.apiGateway -> soz.appointments.requestHandler "Przekazuje żądania"
soz.appointments.requestHandler -> soz.identity "Sprawdza uprawnienia"
soz.appointments.requestHandler -> soz.appointments.slotSearch "Szuka terminów"
soz.appointments.requestHandler -> soz.appointments.booking "Rezerwuje"
soz.appointments.requestHandler -> soz.appointments.cancellation "Odwołuje"
soz.appointments.requestHandler -> soz.appointments.schedules "Zmienia grafik"
soz.appointments.schedules -> soz.appointments.slotSearch "Aktualizuje wolne terminy"
soz.appointments.booking -> soz.appointments.eligibility "Sprawdza uprawnienia NFZ"
soz.appointments.eligibility -> soz.integration "Pyta eWUŚ"
soz.appointments.booking -> soz.billing "Zleca płatność"
soz.appointments.cancellation -> soz.billing "Zleca zwrot"
soz.appointments.schedules -> soz.database "Zapisuje grafiki"
soz.appointments.booking -> soz.database "Zapisuje rezerwacje"
soz.appointments.cancellation -> soz.database "Zapisuje odwołania"
soz.appointments.booking -> soz.appointments.eventPublisher "Zgłasza zdarzenie"
soz.appointments.cancellation -> soz.appointments.eventPublisher "Zgłasza zdarzenie"
soz.appointments.reminders -> soz.database "Czyta nadchodzące wizyty"
soz.appointments.reminders -> soz.appointments.eventPublisher "Zgłasza przypomnienie"
soz.appointments.eventPublisher -> soz.eventQueue "Publikuje zdarzenia"
