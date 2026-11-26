workspace "System Opieki Zdrowotnej (SOZ)" {
    !identifiers hierarchical

    model {
        # Kolejność ma znaczenie: relacje i wdrożenie odwołują się do wcześniej zdefiniowanych elementów.
        !include model/people.dsl
        !include model/external.dsl
        !include model/soz.dsl
        !include model/data_model.dsl
        !include model/relationships.dsl
        !include model/deployment.dsl
    }

    views {
        # Bez daty w podpisie diagramów (tytuł i opis zostają).
        properties {
            "structurizr.metadata" "false"
        }

        !include views/c4.dsl
        !include views/styles.dsl
    }
}
