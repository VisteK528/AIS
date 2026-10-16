# Aktorzy
customer = person "Klient" "Kupuje produkty w sklepie internetowym."
admin = person "Administrator" "Zarządza katalogiem produktów."

# System główny
shop = softwareSystem "Sklep internetowy" "Umożliwia przeglądanie i zakup produktów." {
    web = container "Aplikacja webowa" "Interfejs dla klientów." "React"
    api = container "API" "Logika biznesowa sklepu." "Java / Spring Boot"
    db = container "Baza danych" "Produkty, zamówienia, klienci." "PostgreSQL" {
        tags "Database"
    }

    web -> api "Wywołuje" "JSON/HTTPS"
    api -> db "Czyta i zapisuje" "JDBC"
}

# Systemy zewnętrzne
group "Systemy zewnętrzne" {
    payments = softwareSystem "Bramka płatności" "Obsługuje płatności kartą." {
        tags "External"
    }
    email = softwareSystem "System e-mail" "Wysyła powiadomienia." {
        tags "External"
    }
}

# Relacje
customer -> shop.web "Przegląda produkty i składa zamówienia" "HTTPS"
admin -> shop.web "Zarządza katalogiem" "HTTPS"
shop.api -> payments "Zleca płatność" "HTTPS"
shop.api -> email "Wysyła potwierdzenia zamówień" "SMTP"