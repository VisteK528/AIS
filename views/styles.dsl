terminology {
    person "Osoba"
    softwareSystem "System"
    container "Kontener"
    component "Komponent"
    deploymentNode "Węzeł wdrożenia"
    infrastructureNode "Węzeł infrastruktury"
    relationship "Relacja"
}

styles {
    element "Element" {
        fontSize 24
        width 420
        height 260
    }
    element "Person" {
        shape Person
        background #a86a00
        color #ffffff
        stroke #7a4d00
    }
    element "Software System" {
        background #0e6b78
        color #ffffff
        stroke #094a53
    }
    element "Zewnętrzny" {
        background #7a7a7a
        color #ffffff
        stroke #555555
    }
    element "Container" {
        background #1b8a99
        color #ffffff
        stroke #0e6b78
    }
    element "Component" {
        background #5fb3bf
        color #ffffff
        stroke #1b8a99
    }
    element "Przeglądarka" {
        shape WebBrowser
    }
    element "Mobilna" {
        shape MobileDevicePortrait
        width 300
        height 420
    }
    element "Baza" {
        shape Cylinder
    }
    element "Kolejka" {
        shape Pipe
    }
    element "Deployment Node" {
        background #ffffff
        color #333333
        stroke #888888
    }
    element "Infrastructure Node" {
        background #e8e8e8
        color #333333
        stroke #888888
    }
    element "Encja" {
        shape Box
        background #eef3f4
        color #1d2b2e
        stroke #0e6b78
        width 380
        height 180
    }
    element "Group" {
        color #0e6b78
        border dashed
        fontSize 26
    }
    relationship "Relationship" {
        color #555555
        thickness 2
        fontSize 22
        style solid
    }
}
