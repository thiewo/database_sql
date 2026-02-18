
CREATE TABLE Locatie(
    id_locatie NUMBER PRIMARY KEY,
    dimensiune VARCHAR2(50));

CREATE TABLE Client (
    id_client NUMBER PRIMARY KEY,
    nume_client VARCHAR2(100),
    adresa_client VARCHAR2(150));

CREATE TABLE Angajat (
    id_angajat NUMBER PRIMARY KEY,
    nume_angajat VARCHAR2(100),
    functie_angajat VARCHAR2(50));

CREATE TABLE Furnizor(
    id_furnizor NUMBER PRIMARY KEY,
    nume_furnizor VARCHAR2(20));


CREATE TABLE Eveniment (
    id_eveniment NUMBER PRIMARY KEY,
    denumire VARCHAR2(100),
    durata NUMBER,
    data_incepere DATE,
    id_locatie NUMBER NOT NULL,
    id_furnizor NUMBER,
    CONSTRAINT fk_eveniment_locatie FOREIGN KEY (id_locatie)
        REFERENCES Locatie(id_locatie),
    CONSTRAINT fk_eveniment_furnizor FOREIGN KEY (id_furnizor)
        REFERENCES Furnizor(id_furnizor));


INSERT INTO Locatie VALUES (1, 'Mare');
INSERT INTO Client VALUES (1, 'Popescu Ion', 'Bucuresti');
INSERT INTO Angajat VALUES (1, 'Ionescu Maria', 'Manager');
INSERT INTO Eveniment VALUES (1, 'Nunta', 8, TO_DATE('2024-06-15','YYYY-MM-DD'), 1, NULL);


CREATE TABLE Eveniment_Client (
    id_eveniment NUMBER,
    id_client NUMBER,
    CONSTRAINT pk_ev_client PRIMARY KEY (id_eveniment, id_client),
    CONSTRAINT fk_ev_client_ev FOREIGN KEY (id_eveniment)
        REFERENCES Eveniment(id_eveniment),
    CONSTRAINT fk_ev_client_cl FOREIGN KEY (id_client)
        REFERENCES Client(id_client));

INSERT INTO Eveniment_Client VALUES (1, 1);

SELECT * FROM Client WHERE id_client = 1;

INSERT INTO Locatie VALUES (1, 'Sala mare');

INSERT INTO Client (id_client, nume_client, adresa_client) 
VALUES (1, 'Popescu Ion', 'Bucuresti');

INSERT INTO Eveniment (id_eveniment, denumire, durata, data_incepere, id_locatie)
VALUES (1, 'Nunta', 8, TO_DATE('2024-06-15','YYYY-MM-DD'), 1);

INSERT INTO Eveniment_Client VALUES (1, 1);

DROP TABLE Eveniment_Angajat CASCADE CONSTRAINTS;
DROP TABLE Eveniment_Client CASCADE CONSTRAINTS;
DROP TABLE Eveniment CASCADE CONSTRAINTS;
DROP TABLE Angajat CASCADE CONSTRAINTS;
DROP TABLE Client CASCADE CONSTRAINTS;
DROP TABLE Furnizor CASCADE CONSTRAINTS;
DROP TABLE Locatie CASCADE CONSTRAINTS;

CREATE TABLE Locatie (
    id_locatie NUMBER PRIMARY KEY,
    dimensiune_locatie VARCHAR2(50) NOT NULL,
    adresa_locatie VARCHAR2(200),
    capacitate NUMBER,
    CONSTRAINT chk_capacitate CHECK (capacitate > 0)
);

CREATE TABLE Furnizor (
    id_furnizor NUMBER PRIMARY KEY,
    nume_furnizor VARCHAR2(100) NOT NULL,
    tip_serviciu VARCHAR2(50),
    telefon VARCHAR2(15),
    CONSTRAINT chk_telefon CHECK (LENGTH(telefon) >= 10)
);

CREATE TABLE Client (
    id_client NUMBER PRIMARY KEY,
    nume_client VARCHAR2(100) NOT NULL,
    adresa_client VARCHAR2(150),
    telefon_client VARCHAR2(15)
);

CREATE TABLE Angajat (
    id_angajat NUMBER PRIMARY KEY,
    nume_angajat VARCHAR2(100) NOT NULL,
    functie_angajat VARCHAR2(50),
    salariu NUMBER,
    data_angajare DATE DEFAULT SYSDATE,
    CONSTRAINT chk_salariu CHECK (salariu > 0)
);

CREATE TABLE Eveniment (
    id_eveniment NUMBER PRIMARY KEY,
    denumire_eveniment VARCHAR2(100) NOT NULL,
    durata_eveniment NUMBER,
    data_incepere DATE NOT NULL,
    id_locatie NUMBER NOT NULL,
    id_furnizor NUMBER,
    pret_total NUMBER,
    CONSTRAINT fk_eveniment_locatie FOREIGN KEY (id_locatie)
        REFERENCES Locatie(id_locatie),
    CONSTRAINT fk_eveniment_furnizor FOREIGN KEY (id_furnizor)
        REFERENCES Furnizor(id_furnizor),
    CONSTRAINT chk_durata CHECK (durata_eveniment > 0),
    CONSTRAINT chk_pret CHECK (pret_total >= 0)
);

CREATE TABLE Eveniment_Client (
    id_eveniment NUMBER,
    id_client NUMBER,
    tip_participare VARCHAR2(50) DEFAULT 'Organizator',
    CONSTRAINT pk_ev_client PRIMARY KEY (id_eveniment, id_client),
    CONSTRAINT fk_ev_client_ev FOREIGN KEY (id_eveniment)
        REFERENCES Eveniment(id_eveniment) ON DELETE CASCADE,
    CONSTRAINT fk_ev_client_cl FOREIGN KEY (id_client)
        REFERENCES Client(id_client) ON DELETE CASCADE
);

CREATE TABLE Eveniment_Angajat (
    id_eveniment NUMBER,
    id_angajat NUMBER,
    rol_eveniment VARCHAR2(50) DEFAULT 'Asistent',
    CONSTRAINT pk_ev_ang PRIMARY KEY (id_eveniment, id_angajat),
    CONSTRAINT fk_ev_ang_ev FOREIGN KEY (id_eveniment)
        REFERENCES Eveniment(id_eveniment) ON DELETE CASCADE,
    CONSTRAINT fk_ev_ang_ang FOREIGN KEY (id_angajat)
        REFERENCES Angajat(id_angajat) ON DELETE CASCADE
);

ALTER TABLE Client ADD email VARCHAR2(100);
ALTER TABLE Client ADD data_inregistrare DATE DEFAULT SYSDATE;

ALTER TABLE Angajat ADD email_angajat VARCHAR2(100);

ALTER TABLE Locatie ADD oras VARCHAR2(50) DEFAULT 'Bucuresti';


ALTER TABLE Angajat MODIFY functie_angajat VARCHAR2(100);
ALTER TABLE Furnizor MODIFY nume_furnizor VARCHAR2(150);

ALTER TABLE Client ADD CONSTRAINT unique_email_client UNIQUE(email);
ALTER TABLE Angajat ADD CONSTRAINT unique_email_angajat UNIQUE(email_angajat);

ALTER TABLE Eveniment DROP CONSTRAINT chk_pret;
ALTER TABLE Eveniment ADD CONSTRAINT chk_pret_nou CHECK (pret_total >= 500);

INSERT INTO Locatie VALUES (1, 'Salon mare', 'Str. Florilor nr. 10, Bucuresti', 200, 'Bucuresti');
INSERT INTO Locatie VALUES (2, 'Sala medie', 'Bd. Unirii nr. 45, Cluj', 100, 'Cluj');
INSERT INTO Locatie VALUES (3, 'Gradina exterioara', 'Str. Parcului nr. 3, Timisoara', 300, 'Timisoara');
INSERT INTO Locatie VALUES (4, 'Salon intim', 'Str. Libertatii nr. 22, Iasi', 50, 'Iasi');
INSERT INTO Locatie VALUES (5, 'Sala conferinte', 'Calea Victoriei nr. 100, Bucuresti', 150, 'Bucuresti');
INSERT INTO Locatie VALUES (6, 'Terasa panoramica', 'Str. Muntele nr. 5, Brasov', 80, 'Brasov');
INSERT INTO Locatie VALUES (7, 'Sala de bal', 'Bd. Revolutiei nr. 30, Constanta', 250, 'Constanta');
INSERT INTO Locatie VALUES (8, 'Curtea castelului', 'Str. Istoriei nr. 1, Sibiu', 180, 'Sibiu');
INSERT INTO Locatie VALUES (9, 'Pavilion', 'Aleea Parcului nr. 7, Oradea', 120, 'Oradea');
INSERT INTO Locatie VALUES (10, 'Salon VIP', 'Str. Elitei nr. 15, Bucuresti', 60, 'Bucuresti');

-- Furnizor
INSERT INTO Furnizor VALUES (1, 'Catering Deluxe SRL', 'Catering', '0722123456');
INSERT INTO Furnizor VALUES (2, 'Floraria Iris', 'Decoratiuni florale', '0733234567');
INSERT INTO Furnizor VALUES (3, 'Sound & Light Pro', 'Sonorizare', '0744345678');
INSERT INTO Furnizor VALUES (4, 'Photo Perfect Studio', 'Fotografie', '0755456789');
INSERT INTO Furnizor VALUES (5, 'Decor Events', 'Decoratiuni', '0766567890');
INSERT INTO Furnizor VALUES (6, 'Music Band Live', 'Muzica live', '0777678901');
INSERT INTO Furnizor VALUES (7, 'Sweet Cakes', 'Cofetarie', '0788789012');
INSERT INTO Furnizor VALUES (8, 'Rent a Car Luxury', 'Transport', '0799890123');
INSERT INTO Furnizor VALUES (9, 'Animation Kids', 'Animatori copii', '0721901234');
INSERT INTO Furnizor VALUES (10, 'Video Production', 'Filmare', '0732012345');
INSERT INTO Furnizor VALUES (11, 'LED Screen Rental', 'Ecrane LED', '0743123456');
INSERT INTO Furnizor VALUES (12, 'Bartender Pro', 'Bar & Cocktailuri', '0754234567');

--Client
INSERT INTO Client VALUES (1, 'Popescu Ion', 'Str. Mihai Viteazu nr. 12, Bucuresti', '0721111111', 'ion.popescu@email.com', TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO Client VALUES (2, 'Ionescu Maria', 'Bd. Carol nr. 34, Cluj', '0732222222', 'maria.ionescu@email.com', TO_DATE('2023-02-20', 'YYYY-MM-DD'));
INSERT INTO Client VALUES (3, 'Georgescu Andrei', 'Str. Libertatii nr. 56, Timisoara', '0743333333', 'andrei.georgescu@email.com', TO_DATE('2023-03-10', 'YYYY-MM-DD'));
INSERT INTO Client VALUES (4, 'Popa Elena', 'Calea Nationala nr. 78, Iasi', '0754444444', 'elena.popa@email.com', TO_DATE('2023-04-05', 'YYYY-MM-DD'));
INSERT INTO Client VALUES (5, 'Dumitru Cristian', 'Str. Pacii nr. 90, Brasov', '0765555555', 'cristian.dumitru@email.com', TO_DATE('2023-05-12', 'YYYY-MM-DD'));
INSERT INTO Client VALUES (6, 'Stan Alexandra', 'Bd. Independentei nr. 23, Constanta', '0776666666', 'alexandra.stan@email.com', TO_DATE('2023-06-18', 'YYYY-MM-DD'));
INSERT INTO Client VALUES (7, 'Marin Gabriel', 'Str. Unirii nr. 45, Sibiu', '0787777777', 'gabriel.marin@email.com', TO_DATE('2023-07-22', 'YYYY-MM-DD'));
INSERT INTO Client VALUES (8, 'Constantinescu Ana', 'Calea Victoriei nr. 67, Oradea', '0798888888', 'ana.constantinescu@email.com', TO_DATE('2023-08-30', 'YYYY-MM-DD'));
INSERT INTO Client VALUES (9, 'Radu Mihai', 'Str. Primaverii nr. 89, Bucuresti', '0721999999', 'mihai.radu@email.com', TO_DATE('2023-09-14', 'YYYY-MM-DD'));
INSERT INTO Client VALUES (10, 'Vasile Ioana', 'Bd. Eroilor nr. 101, Cluj', '0732101010', 'ioana.vasile@email.com', TO_DATE('2023-10-25', 'YYYY-MM-DD'));
INSERT INTO Client VALUES (11, 'Stoica Daniel', 'Str. Republicii nr. 13, Timisoara', '0743121212', 'daniel.stoica@email.com', TO_DATE('2023-11-08', 'YYYY-MM-DD'));
INSERT INTO Client VALUES (12, 'Florea Carmen', 'Calea Moldovei nr. 27, Iasi', '0754131313', 'carmen.florea@email.com', TO_DATE('2023-12-03', 'YYYY-MM-DD'));

--Angajat
INSERT INTO Angajat VALUES (1, 'Ionescu Maria', 'Manager evenimente', 5000, TO_DATE('2020-01-10', 'YYYY-MM-DD'), 'maria.ionescu@company.com');
INSERT INTO Angajat VALUES (2, 'Popescu Andrei', 'Coordinator logistica', 3500, TO_DATE('2020-03-15', 'YYYY-MM-DD'), 'andrei.popescu@company.com');
INSERT INTO Angajat VALUES (3, 'Dumitrescu Elena', 'Designer evenimente', 4000, TO_DATE('2020-06-20', 'YYYY-MM-DD'), 'elena.dumitrescu@company.com');
INSERT INTO Angajat VALUES (4, 'Vasilescu George', 'Asistent organizare', 2500, TO_DATE('2021-02-10', 'YYYY-MM-DD'), 'george.vasilescu@company.com');
INSERT INTO Angajat VALUES (5, 'Marinescu Ana', 'Responsabil clienti', 3200, TO_DATE('2021-04-22', 'YYYY-MM-DD'), 'ana.marinescu@company.com');
INSERT INTO Angajat VALUES (6, 'Stanciu Mihai', 'Tehnician audio-video', 3000, TO_DATE('2021-07-15', 'YYYY-MM-DD'), 'mihai.stanciu@company.com');
INSERT INTO Angajat VALUES (7, 'Constantinescu Laura', 'Decorator', 2800, TO_DATE('2021-09-30', 'YYYY-MM-DD'), 'laura.constantinescu@company.com');
INSERT INTO Angajat VALUES (8, 'Radu Cristian', 'Fotograf', 3500, TO_DATE('2022-01-12', 'YYYY-MM-DD'), 'cristian.radu@company.com');
INSERT INTO Angajat VALUES (9, 'Popa Ioana', 'Coordonator catering', 2900, TO_DATE('2022-03-25', 'YYYY-MM-DD'), 'ioana.popa@company.com');
INSERT INTO Angajat VALUES (10, 'Georgescu Daniel', 'Asistent tehnic', 2400, TO_DATE('2022-06-18', 'YYYY-MM-DD'), 'daniel.georgescu@company.com');
INSERT INTO Angajat VALUES (11, 'Stoica Alexandra', 'Manager operatiuni', 4500, TO_DATE('2022-09-05', 'YYYY-MM-DD'), 'alexandra.stoica@company.com');
INSERT INTO Angajat VALUES (12, 'Florea Gabriel', 'Specialist marketing', 3300, TO_DATE('2023-01-20', 'YYYY-MM-DD'), 'gabriel.florea@company.com');

-- Eveniment
INSERT INTO Eveniment VALUES (1, 'Nunta Popescu-Ionescu', 8, TO_DATE('2024-06-15', 'YYYY-MM-DD'), 1, 1, 15000);
INSERT INTO Eveniment VALUES (2, 'Conferinta IT 2024', 5, TO_DATE('2024-09-20', 'YYYY-MM-DD'), 5, 3, 8000);
INSERT INTO Eveniment VALUES (3, 'Petrecere corporate', 4, TO_DATE('2024-12-10', 'YYYY-MM-DD'), 7, 6, 12000);
INSERT INTO Eveniment VALUES (4, 'Botez familia Georgescu', 6, TO_DATE('2024-05-25', 'YYYY-MM-DD'), 3, 2, 7000);
INSERT INTO Eveniment VALUES (5, 'Aniversare 50 ani', 5, TO_DATE('2024-08-08', 'YYYY-MM-DD'), 6, 7, 6500);
INSERT INTO Eveniment VALUES (6, 'Eveniment caritabil', 3, TO_DATE('2024-11-15', 'YYYY-MM-DD'), 8, 5, 5000);
INSERT INTO Eveniment VALUES (7, 'Lansare produs', 4, TO_DATE('2024-07-22', 'YYYY-MM-DD'), 5, 11, 9000);
INSERT INTO Eveniment VALUES (8, 'Nunta Stan-Marin', 10, TO_DATE('2024-10-05', 'YYYY-MM-DD'), 7, 1, 18000);
INSERT INTO Eveniment VALUES (9, 'Petrecere copii', 3, TO_DATE('2024-04-30', 'YYYY-MM-DD'), 9, 9, 3500);
INSERT INTO Eveniment VALUES (10, 'Gala de premiere', 6, TO_DATE('2024-12-20', 'YYYY-MM-DD'), 10, 12, 11000);
INSERT INTO Eveniment VALUES (11, 'Team building', 4, TO_DATE('2025-03-15', 'YYYY-MM-DD'), 3, 8, 7500);
INSERT INTO Eveniment VALUES (12, 'Cocktail party', 3, TO_DATE('2025-05-10', 'YYYY-MM-DD'), 6, 12, 5500);

-- Eveniment_Client
INSERT INTO Eveniment_Client VALUES (1, 1, 'Organizator principal');
INSERT INTO Eveniment_Client VALUES (1, 2, 'Co-organizator');
INSERT INTO Eveniment_Client VALUES (2, 3, 'Sponsor');
INSERT INTO Eveniment_Client VALUES (3, 4, 'Organizator principal');
INSERT INTO Eveniment_Client VALUES (4, 5, 'Organizator principal');
INSERT INTO Eveniment_Client VALUES (5, 6, 'Organizator principal');
INSERT INTO Eveniment_Client VALUES (6, 7, 'Organizator principal');
INSERT INTO Eveniment_Client VALUES (7, 8, 'Organizator principal');
INSERT INTO Eveniment_Client VALUES (8, 9, 'Organizator principal');
INSERT INTO Eveniment_Client VALUES (8, 10, 'Co-organizator');
INSERT INTO Eveniment_Client VALUES (9, 11, 'Organizator principal');
INSERT INTO Eveniment_Client VALUES (10, 12, 'Organizator principal');

--Eveniment_Angajat
INSERT INTO Eveniment_Angajat VALUES (1, 1, 'Manager eveniment');
INSERT INTO Eveniment_Angajat VALUES (1, 3, 'Designer');
INSERT INTO Eveniment_Angajat VALUES (2, 2, 'Coordinator logistica');
INSERT INTO Eveniment_Angajat VALUES (2, 6, 'Tehnician AV');
INSERT INTO Eveniment_Angajat VALUES (3, 5, 'Responsabil clienti');
INSERT INTO Eveniment_Angajat VALUES (4, 7, 'Decorator');
INSERT INTO Eveniment_Angajat VALUES (5, 9, 'Coordonator catering');
INSERT INTO Eveniment_Angajat VALUES (6, 11, 'Manager operatiuni');
INSERT INTO Eveniment_Angajat VALUES (7, 12, 'Specialist marketing');
INSERT INTO Eveniment_Angajat VALUES (8, 1, 'Manager eveniment');
INSERT INTO Eveniment_Angajat VALUES (8, 8, 'Fotograf');
INSERT INTO Eveniment_Angajat VALUES (9, 4, 'Asistent organizare');
INSERT INTO Eveniment_Angajat VALUES (10, 10, 'Asistent tehnic');

UPDATE Client 
SET telefon_client = '0721111112' 
WHERE id_client = 1;

UPDATE Eveniment 
SET pret_total = pret_total * 1.1 
WHERE durata_eveniment > 5;

UPDATE Angajat 
SET salariu = salariu * 1.15 
WHERE id_angajat IN (
    SELECT id_angajat 
    FROM Eveniment_Angajat 
    GROUP BY id_angajat 
    HAVING COUNT(*) >= 2
);

UPDATE Locatie l
SET l.capacitate = l.capacitate + 20
WHERE l.oras = 'Bucuresti';

UPDATE Furnizor 
SET tip_serviciu = 'Servicii multiple' 
WHERE id_furnizor IN (1, 5, 10);

CREATE TABLE Test_Backup AS SELECT * FROM Client;

DROP TABLE Test_Backup;

FLASHBACK TABLE Test_Backup TO BEFORE DROP;

SELECT * FROM Test_Backup;

DROP TABLE Test_Backup PURGE;

SELECT * FROM Eveniment;

SELECT denumire_eveniment, data_incepere, pret_total 
FROM Eveniment 
ORDER BY data_incepere DESC, pret_total DESC;


SELECT e.denumire_eveniment, e.data_incepere, l.dimensiune_locatie, l.oras
FROM Eveniment e
INNER JOIN Locatie l ON e.id_locatie = l.id_locatie;


SELECT c.nume_client, c.email, e.denumire_eveniment
FROM Client c
LEFT JOIN Eveniment_Client ec ON c.id_client = ec.id_client
LEFT JOIN Eveniment e ON ec.id_eveniment = e.id_eveniment;


SELECT e.denumire_eveniment, l.oras, f.nume_furnizor, f.tip_serviciu, e.pret_total
FROM Eveniment e
INNER JOIN Locatie l ON e.id_locatie = l.id_locatie
LEFT JOIN Furnizor f ON e.id_furnizor = f.id_furnizor
WHERE e.pret_total > 7000;

SELECT 
    COUNT(*) AS total_evenimente,
    SUM(pret_total) AS venit_total,
    AVG(pret_total) AS pret_mediu,
    MIN(pret_total) AS pret_minim,
    MAX(pret_total) AS pret_maxim
FROM Eveniment;

SELECT l.oras, COUNT(e.id_eveniment) AS numar_evenimente, AVG(e.pret_total) AS pret_mediu
FROM Locatie l
LEFT JOIN Eveniment e ON l.id_locatie = e.id_locatie
GROUP BY l.oras
HAVING COUNT(e.id_eveniment) >= 1
ORDER BY numar_evenimente DESC;

SELECT 
    denumire_eveniment,
    pret_total,
    ROUND(pret_total * 1.19, 2) AS pret_cu_tva,
    TRUNC(pret_total / 100) * 100 AS pret_rotunjit,
    MOD(pret_total, 1000) AS rest_impartire,
    POWER(durata_eveniment, 2) AS durata_la_patrat
FROM Eveniment;

SELECT 
    denumire_eveniment, 
    pret_total,
    DECODE(
        SIGN(pret_total - 10000),
        1, 'Premium',
        0, 'Standard',
        -1, DECODE(
            SIGN(pret_total - 5000),
            1, 'Standard',
            'Economic'
        )
    ) AS categorie_pret
FROM Eveniment;

SELECT id_furnizor AS id, nume_furnizor AS nume, 'Furnizor' AS tip, telefon AS contact
FROM Furnizor
UNION
SELECT id_client, nume_client, 'Client', telefon_client
FROM Client
ORDER BY tip, nume;

SELECT id_client, nume_client
FROM Client
MINUS
SELECT c.id_client, c.nume_client
FROM Client c
INNER JOIN Eveniment_Client ec ON c.id_client = ec.id_client;

SELECT denumire_eveniment, pret_total
FROM Eveniment
WHERE pret_total > (SELECT AVG(pret_total) FROM Eveniment)
ORDER BY pret_total DESC;


SELECT denumire_eveniment, pret_total
FROM Eveniment
WHERE pret_total > ALL (
    SELECT pret_total
    FROM Eveniment
    WHERE pret_total < 6000
);

SELECT denumire_eveniment, pret_total
FROM Eveniment
WHERE pret_total > ANY (
    SELECT pret_total
    FROM Eveniment
    WHERE pret_total < 7000
)
ORDER BY pret_total;

SELECT * FROM (
    SELECT denumire_eveniment, pret_total, data_incepere
    FROM Eveniment
    ORDER BY pret_total DESC
)
WHERE ROWNUM <= 5;


CREATE SYNONYM Ev FOR Eveniment;

CREATE SYNONYM Cl FOR Client;

CREATE SYNONYM Ang FOR Angajat;
