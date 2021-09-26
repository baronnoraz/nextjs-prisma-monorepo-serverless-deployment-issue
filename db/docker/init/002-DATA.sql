insert into users (id, name, email, updated_at)
values (UUID(), 'Jane Austen', 'jane.austen@mansfieldpark.com', current_timestamp(3))
     , (UUID(), 'Salvor Hardin', 'salvorh@terminuscity.gov', current_timestamp(3));