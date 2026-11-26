terminology {
    person "Osoba"
    softwareSystem "System"
    container "Kontener"
    component "Komponent"
    deploymentNode "Węzeł wdrożenia"
    infrastructureNode "Węzeł infrastruktury"
    relationship "Relacja"
}

# Paleta: indygo (system, kontenery, komponenty), bursztyn (osoby), szary (systemy zewnętrzne).
# Duże czcionki względem bloków, żeby tekst był czytelny po zmniejszeniu diagramu do szerokości strony A4.
styles {
    element "Element" {
        fontSize 44
        width 600
        height 380
        strokeWidth 4
    }
    element "Person" {
        shape Person
        background #b45309
        color #ffffff
        stroke #7c3a06
        fontSize 64
        width 900
        height 640
    }
    element "Software System" {
        background #312e81
        color #ffffff
        stroke #1e1b4b
        fontSize 64
        width 900
        height 640
    }
    element "Zewnętrzny" {
        background #6b7280
        color #ffffff
        stroke #4b5563
    }
    element "Container" {
        background #4338ca
        color #ffffff
        stroke #312e81
        fontSize 50
        width 720
        height 450
    }
    element "Component" {
        background #c7d2fe
        color #1e1b4b
        stroke #4338ca
    }
    element "Przeglądarka" {
        shape WebBrowser
    }
    element "Mobilna" {
        shape MobileDevicePortrait
        width 450
        height 600
    }
    element "Baza" {
        shape Cylinder
    }
    element "Kolejka" {
        shape Pipe
    }
    element "Deployment Node" {
        background #ffffff
        color #1f2937
        stroke #6b7280
    }
    element "Infrastructure Node" {
        background #f3f4f6
        color #1f2937
        stroke #6b7280
    }
    element "Encja" {
        shape Box
        background #eef2ff
        color #1e1b4b
        stroke #4338ca
        width 580
        height 280
    }
    element "Group" {
        color #312e81
        border dashed
        strokeWidth 4
        fontSize 46
    }
    # Tytuł i opis widoku w lewym dolnym rogu.
    element "Diagram:Title" {
        fontSize 0
    }
    element "Diagram:Description" {
        fontSize 0
    }
    relationship "Relationship" {
        color #4b5563
        thickness 6
        fontSize 64
        width 600
        style solid
    }
}
