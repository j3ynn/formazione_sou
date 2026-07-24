-- Script per creare e popolare una tabella "utenti" con 20 utenze di test
-- Sintassi compatibile con MySQL/MariaDB (per PostgreSQL basta togliere AUTO_INCREMENT e usare SERIAL)

-- Creo la tabella se non esiste già
CREATE TABLE IF NOT EXISTS utenti (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL
);

-- Inserisco 20 utenze di prova
-- NB: queste password sono in chiaro solo per esercizio/test.
-- In un ambiente reale vanno SEMPRE salvate hashate (es. bcrypt), mai in chiaro!
INSERT INTO utenti (email, password) VALUES
('utente01@test.com', 'Password01!'),
('utente02@test.com', 'Password02!'),
('utente03@test.com', 'Password03!'),
('utente04@test.com', 'Password04!'),
('utente05@test.com', 'Password05!'),
('utente06@test.com', 'Password06!'),
('utente07@test.com', 'Password07!'),
('utente08@test.com', 'Password08!'),
('utente09@test.com', 'Password09!'),
('utente10@test.com', 'Password10!'),
('utente11@test.com', 'Password11!'),
('utente12@test.com', 'Password12!'),
('utente13@test.com', 'Password13!'),
('utente14@test.com', 'Password14!'),
('utente15@test.com', 'Password15!'),
('utente16@test.com', 'Password16!'),
('utente17@test.com', 'Password17!'),
('utente18@test.com', 'Password18!'),
('utente19@test.com', 'Password19!'),
('utente20@test.com', 'Password20!');
