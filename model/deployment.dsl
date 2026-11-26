# Wdrożenie - chmura w EOG (region podstawowy + zapasowy) oraz placówki. Bez technologii (punkt 3).

prod = deploymentEnvironment "Produkcja" {
    primaryGroup = deploymentGroup "Region podstawowy"

    primary = deploymentNode "Region podstawowy (EOG)" "Chmura publiczna na terenie EOG (NFR-NIE-01, NFR-ZGO-04)." {
        lb = infrastructureNode "Równoważenie obciążenia" "Rozdziela ruch między strefy, filtruje ataki."
        web = deploymentNode "Hosting aplikacji webowych" "Pliki portalu i paneli udostępniane przez sieć CDN; aplikacje działają w przeglądarce." {
            containerInstance soz.patientPortal primaryGroup
            containerInstance soz.doctorPanel primaryGroup
            containerInstance soz.adminPanel primaryGroup
        }
        vpnHub = infrastructureNode "Brama VPN" "Szyfrowane połączenia z placówkami."

        az = deploymentNode "Strefy dostępności A, B, C" "Każda strefa ma pełny zestaw usług; awaria strefy nie przerywa pracy." "" "" 3 {
            cluster = deploymentNode "Klaster kontenerów" "Autoskalowanie, wdrożenia bez przestojów (NFR-SKA-03, NFR-DOS-05)." {
                gwInst = containerInstance soz.apiGateway primaryGroup
                idInst = containerInstance soz.identity primaryGroup
                intInst = containerInstance soz.integration primaryGroup
                queueInst = containerInstance soz.eventQueue primaryGroup
                services = deploymentNode "Usługi aplikacyjne" "Wizyty, Telekonsultacje, Dokumentacja, Zlecenia i wyniki, Rozliczenia, Powiadomienia." {
                    apptInst = containerInstance soz.appointments primaryGroup
                    containerInstance soz.telehealth primaryGroup
                    containerInstance soz.records primaryGroup
                    containerInstance soz.orders primaryGroup
                    containerInstance soz.billing primaryGroup
                    containerInstance soz.notifications primaryGroup
                }
            }
        }

        dbNode = deploymentNode "Baza relacyjna" "Węzeł główny w strefie A, repliki w strefach B i C." {
            dbInst = containerInstance soz.database primaryGroup
        }
        blobNode = deploymentNode "Magazyn obiektów" "Warstwy gorąca i zimna; dane szyfrowane." {
            blobInst = containerInstance soz.blobStore primaryGroup
        }
        dwNode = deploymentNode "Magazyn analityczny" "Oddzielony od baz operacyjnych (NFR-WYD-06)." {
            containerInstance soz.warehouse primaryGroup
        }
        auditNode = deploymentNode "Magazyn audytu" "Tylko dopisywanie, blokada modyfikacji WORM (NFR-BEZ-08)." {
            auditInst = containerInstance soz.auditLog primaryGroup
        }
        monitoring = deploymentNode "Monitorowanie i logi" "Usługa zarządzana: metryki, alerty, logi bez danych pacjentów (NFR-MON-01..04)." {
            monInst = containerInstance soz.monitoring primaryGroup
        }
    }

    dr = deploymentNode "Region zapasowy (EOG)" "Przejmuje pracę po awarii regionu: RPO ≤ 5 min, RTO 1-4 h (NFR-NIE-02/03)." {
        standby = infrastructureNode "Klaster w gotowości" "Usługi uruchamiane przy przełączeniu regionu."
        drDb = infrastructureNode "Replika bazy relacyjnej" "Gotowa do przejęcia roli bazy głównej."
        drBlob = infrastructureNode "Replika magazynu obiektów" "Kopia obrazów i dokumentów."
        backups = infrastructureNode "Kopie zapasowe" "Codzienne, szyfrowane, niemodyfikowalne (NFR-NIE-04)."
    }

    facility = deploymentNode "Placówka" "Każdy z 5 szpitali i 20 przychodni." "" "" 25 {
        hospitalSystems = deploymentNode "Systemy placówki" "Pozostają poza SOZ (FR-INT-01..03)." {
            softwareSystemInstance his primaryGroup
            softwareSystemInstance lis primaryGroup
        }
        edgeNode = infrastructureNode "Węzeł awaryjny" "Lista wizyt i dane pacjentów na bieżący dzień przy braku łączności (NFR-DOS-06)."
        facilityVpn = infrastructureNode "Router VPN" "Szyfrowany tunel do chmury."
    }

    users = deploymentNode "Urządzenia użytkowników" "Komputery i telefony pacjentów oraz personelu." {
        browser = infrastructureNode "Przeglądarka internetowa" "Uruchamia portal pacjenta i panele."
        mobileInst = containerInstance soz.mobileApp primaryGroup
    }

    # ---------- Relacje infrastrukturalne (tag "Infrastruktura" - jedyne relacje pokazywane w widokach wdrożenia) ----------
    primary.lb -> primary.az.cluster.gwInst "Kieruje ruch" {
        tags "Infrastruktura"
    }
    users.browser -> primary.web "Pobiera aplikacje webowe" {
        tags "Infrastruktura"
    }
    users.browser -> primary.lb "Wywołuje API" {
        tags "Infrastruktura"
    }
    users.mobileInst -> primary.lb "Wywołuje API" {
        tags "Infrastruktura"
    }
    primary.auditNode.auditInst -> dr.backups "Kopia zapasowa" {
        tags "Infrastruktura"
    }
    primary.dbNode.dbInst -> dr.drDb "Replikuje dane" {
        tags "Infrastruktura"
    }
    primary.blobNode.blobInst -> dr.drBlob "Replikuje obiekty" {
        tags "Infrastruktura"
    }
    primary.dbNode.dbInst -> dr.backups "Kopia zapasowa" {
        tags "Infrastruktura"
    }
    primary.lb -> dr.standby "Przełącza ruch po awarii regionu" {
        tags "Infrastruktura"
    }
    facility.facilityVpn -> primary.vpnHub "Tunel VPN" {
        tags "Infrastruktura"
    }
    primary.vpnHub -> primary.az.cluster.intInst "Przekazuje komunikaty placówki" {
        tags "Infrastruktura"
    }
    primary.az.cluster.services.apptInst -> facility.edgeNode "Przesyła plan dnia" {
        tags "Infrastruktura"
    }
}
