# Widoki C4 (punkt 2 projektu). Wszystkie z autoLayout; technologia celowo pominięta.

systemContext soz "01-kontekst" "C4 poziom 1 - System Opieki Zdrowotnej i jego otoczenie." {
    include *
    autoLayout tb 160 90
}

container soz "02-kontenery-przeglad" "C4 poziom 2 - przegląd kontenerów w pięciu warstwach, w tym jedyny widok warstwy danych. Szczegółowe relacje i systemy zewnętrzne w widokach 02a i 02b." {
    include patient doctor staff
    include "element.parent==soz"
    exclude "relationship.tag==Szczegół"
}

container soz "02a-kontenery-pacjent" "C4 poziom 2 - obsługa pacjenta: wizyty, teleporady, płatności, powiadomienia. Bez warstwy danych (zob. 02)." {
    include patient
    include soz.patientPortal soz.mobileApp soz.apiGateway soz.identity
    include soz.appointments soz.telehealth soz.billing soz.notifications soz.eventQueue
    include soz.integration
    include nationalNode paymentGateway messaging nfz
}

container soz "02b-kontenery-klinika" "C4 poziom 2 - obsługa kliniczna: dokumentacja, zlecenia, wyniki i integracja z laboratoriami i szpitalami. Bez warstwy danych (zob. 02)." {
    include doctor
    include soz.doctorPanel soz.apiGateway soz.records soz.orders soz.notifications
    include soz.eventQueue soz.integration
    include his lis p1 externalFacilities
}

component soz.appointments "03-komponenty-wizyty" "C4 poziom 3 - komponenty usługi Wizyty." {
    include *
    # pomijamy relacje między sąsiednimi kontenerami - widok skupia się na komponentach
    exclude "soz.apiGateway -> soz.identity"
    exclude "soz.apiGateway -> soz.billing"
    exclude "soz.billing -> soz.eventQueue"
    exclude "soz.billing -> soz.database"
    exclude "soz.billing -> soz.integration"
    exclude "soz.identity -> soz.database"
    exclude "soz.integration -> soz.eventQueue"
    autoLayout tb 160 90
}

deployment soz prod "04a-wdrozenie-chmura" "Wdrożenie - urządzenia użytkowników, region podstawowy z trzema strefami dostępności i region zapasowy w EOG." {
    include prod.users prod.primary prod.dr
    exclude prod.facility
    exclude "relationship.tag!=Infrastruktura"
    autoLayout tb 160 90
}

deployment soz prod "04b-wdrozenie-placowka" "Wdrożenie - placówka i jej połączenie z chmurą." {
    include prod.facility
    include prod.primary.vpnHub prod.primary.az.cluster.intInst prod.primary.az.cluster.services.apptInst
    autoLayout tb 160 90
}

custom "05-model-danych" "Model danych" "Diagram encji - główne dane systemu i relacje między nimi." {
    include "element.tag==Encja"
    autoLayout tb 160 90
}
