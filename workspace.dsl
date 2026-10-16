workspace "Sklep" {
    !identifiers hierarchical

    model {
        !include model/example.dsl
    }

    views {
        systemContext shop "01-kontekst" {
            include *
        }

        container shop "02-kontenery" {
            include *
        }

        styles {
            element "Person" {
                shape Person
                background #08427b
                color #ffffff
            }
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "Container" {
                background #438dd5
                color #ffffff
            }
            element "Database" {
                shape Cylinder
            }
            element "External" {
                background #999999
            }
        }
    }
}