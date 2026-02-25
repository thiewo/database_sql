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

