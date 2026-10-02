CREATE DATABASE WayneTech;
Go 
USE WayneTech;
Go

CREATE TABLE Divisions (
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Nom NVARCHAR(100) NOT NULL UNIQUE
);
GO

CREATE TABLE Projets(
	Id INT IDENTITY (1,1) PRIMARY KEY,
	Nom NVARCHAR(150) NOT NULL,
	Description NVARCHAR(MAX),
	Statut NVARCHAR(50) NOT NULL DEFAULT 'En cours',
	NiveauAcces INT NOT NULL DEFAULT 1,
	DivisionId INT NOT NULL,
	CONSTRAINT FK_Projets_Divisions 
		FOREIGN KEY (DivisionId) REFERENCES Divisions(Id)
);
GO

CREATE TABLE Clients(
	Id INT IDENTITY (1,1) PRIMARY KEY,
	Nom NVARCHAR(100) NOT NULL,
	Prenom NVARCHAR(100) NOT NULL,
	Email NVARCHAR(255) NOT NULL UNIQUE,
	MotDePasseHash NVARCHAR(255) NOT NULL,
	Rue NVARCHAR(100),
	Numero NVARCHAR(5),
	CodePostal NVARCHAR(10),
	Ville NVARCHAR(100),
	Pays NVARCHAR(100),
	DateInscription DATETIME2 NOT NULL DEFAULT SYSDATETIME()
);
GO

CREATE TABLE Personnel (
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Nom NVARCHAR(100) NOT NULL,
	Prenom NVARCHAR(100) NOT NULL, 
	Email NVARCHAR(255) NOT NULL UNIQUE,
	MotDePasseHash NVARCHAR(255) NOT NULL,
	Role NVARCHAR(30) NOT NULL DEFAULT 'Employe',--'Admin', 'Employe'...
	NiveauAcces INT NOT NULL DEFAULT 1,
	Actif BIT NOT NULL DEFAULT 1 
);
GO

CREATE TABLE Produits (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nom NVARCHAR(150) NOT NULL,
    Description NVARCHAR(MAX),
    Prix DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL DEFAULT 0,
    DivisionId INT NOT NULL,
    CONSTRAINT FK_Produits_Divisions
        FOREIGN KEY (DivisionId) REFERENCES Divisions(Id)
);

CREATE TABLE Commandes (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    ClientId INT NOT NULL,
    DateCommande DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    Statut NVARCHAR(30) NOT NULL DEFAULT 'En attente',
    CONSTRAINT FK_Commandes_Clients
        FOREIGN KEY (ClientId) REFERENCES Clients(Id)
);

CREATE TABLE LignesCommande (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    CommandeId INT NOT NULL,
    ProduitId INT NOT NULL,
    Quantite INT NOT NULL CHECK (Quantite > 0),
    PrixUnitaire DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_Lignes_Commandes
        FOREIGN KEY (CommandeId) REFERENCES Commandes(Id),
    CONSTRAINT FK_Lignes_Produits
        FOREIGN KEY (ProduitId) REFERENCES Produits(Id)
);
GO

INSERT INTO Divisions (Nom) VALUES(N'Aerospace'), (N'Biotech'), (N'Civiltech'),(N'Mobility'), (N'Seculink');
Go

SELECT * FROM Divisions;

INSERT INTO Projets (Nom, Description, Statut, NiveauAcces, DivisionId) VALUES 
	(N'Falcon G-01', N'Prototype de vol furtif', N'En cours', 3, 4),
	(N'Exo-Tissus', N'Tissus intelligent renforcer', N'Terminé', 4,2),
	(N'Aegis-17', N'Taser de dernière génération', N'Terminé', 4, 5);
GO

INSERT INTO Projets (Nom,Description,Statut,NiveauAcces,DivisionId) VALUES
	(N'Aeromat-A-01',N'Drone de reconnaissance',N'Phase expérimentale',4,1),
	(N'Hexa-C6-412', N'Drone de soutien',N'Terminé',4,1),
	(N'Warden', N'Véhicule intervention', N'Terminé', 4,4),
	(N'Jet WT', N'Jet privé', N'Terminé', 1, 4),
	(N'Stride', N'Exo-squelette', N'Phase expérimentale',1,2),
	(N'Laptop', N'Ordinateur portable', N'Terminé',1,3),
	(N'Beacon-Compact', N'porte clé alarme de défense', N'Terminé', 1, 3),
	(N'Nest', N' Assitant DOM', N'Terminé', 1, 3);
GO

SELECT * FROM Projets;

UPDATE Projets SET DivisionId = 1 WHERE Nom = N'Falcon G-01';

SELECT * FROM Projets;
GO

INSERT INTO Projets (Nom, Description,Statut,NiveauAcces,DivisionId) VALUES
	(N'Viper', N'Voiture tout-terrain', N'Terminé', 4, 4),
	(N'Métro', N'Nouveau projet de réhabilitaion du métro', N'A venir', 2,4),
	(N'Secours S-18', N'Trousse de secours amélioré', N'A venir', 1, 2),
	(N'Evacuation S-18', N' Sac d''évaécuation d''urgence', N'A venir', 1, 2);
GO

SELECT * FROM Projets;

UPDATE Projets SET NiveauAcces = 4 WHERE Nom = N'Falcon G-01'; 

SELECT * FROM Projets;
GO

UPDATE Projets SET NiveauAcces = 2 WHERE Nom = N'Jet WT';
SELECT * FROM Projets;
GO


INSERT INTO Produits (Nom, Description, Prix, Stock, DivisionId) VALUES
    (N'Falcon', N'Avion de combat lourdement modifiée, blindée, ultra-rapide et entièrement connectée pour les opérations nocturnes et l''infiltration urbaine.', 12500000.00, 2, 1),
    (N'Viper', N'Buggy tout-terrain d''intervention lourdement modifiée, ultra-rapide et entièrement connectée pour les opérations sur tout types de terrains.', 4800000.00, 3, 4),
    (N'Warden', N'SUV blindé d''intervention lourdement modifiée, blindée, ultra-rapide et entièrement connectée pour les opérations nocturnes et l''infiltration urbaine.', 2900000.00, 5, 5),
    (N'Aegis', N'Taser lourdement modifiée, ultra-rapide et entièrement connectée.', 6500000.00, 2, 5),
    (N'Exo', N'Combinaison tactique légère, pare-balles, anti-lames et ignifugée, offrant une assistance musculaire passive pour les opérations d''infiltration urbaine et de sauvetage extrême.', 850000.00, 8, 2),
    (N'Aeromat', N'Drone tactique autonome à décollage et atterrissage verticaux (VTOL) pour la cartographie 3D en temps réel, l''analyse thermique et le repérage d''objectifs de nuit.', 2400.00, 200, 1),
    (N'Hexa', N'Drone tactique autonome à décollage et atterrissage verticaux (VTOL) pour la livraison de materiel médicale, de nourritures et fournitures essentielles.', 350000.00, 10, 3),
    (N'Laptop', N'Ordinateur portable ultra-sécurisé de WayneTech, conçu pour protéger vos données où que vous soyez. Accessible à tous.', 1899.00, 150, 5),
    (N'Beacon compact', N'Porte-clés alarme compact qui déclenche une alerte sonore et signale votre position en cas de danger.', 249.00, 300, 5),
    (N'Nest', N'Assistant domotique connecté qui veille sur votre maison, gère vos appareils et vous protège en toute discrétion.', 599.00, 120, 3),
    (N'Stride', N'Exo squelette aidant à la mobilité de la jambe.', 4500.00, 60, 2),
    (N'Secours S-18', N'Trousse de secours amélioré. ', 89.00, 500, 2),
    (N'Evacuation S-18', N'Sac à dos d''évacuation renforcer permettant de survivre ~72h. ', 129.00, 400, 2);
 GO

SELECT * FROM Produits;

ALTER TABLE Clients ADD Telephone NVARCHAR(20) NULL; 

SELECT * FROM Clients;

GO

INSERT INTO Clients (Nom, Prenom, Email,MotDePasseHash,Rue,Numero,CodePostal,Ville,Pays,Telephone) VALUES (N'Polovski', N'Alexander', N'alex.P@mail.com', N'A123', N'Rue du Chat', N'12C', N'69875', N'StarCity', N'USA',N'0598653245');
GO

SELECT * FROM Clients;
GO

CREATE TABLE Allies (
	Id INT IDENTITY (1,1) PRIMARY KEY, 
	Alias NVARCHAR(100) NOT NULL UNIQUE,
	NomReel NVARCHAR(100) NULL,
	Role NVARCHAR(100) NULL,
	NiveauAcces INT NOT NULL DEFAULT 1,
	Actif BIT NOT NULL DEFAULT 1
);
GO

SELECT * FROM Clients;
SELECT * FROM Produits;

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Produits';
GO


ALTER TABLE Produits
ADD ProjetId INT NULL
    CONSTRAINT FK_Produits_Projets FOREIGN KEY REFERENCES Projets(Id);
GO

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Produits';
GO

UPDATE p
SET p.ProjetId = pr.Id
FROM Produits p
JOIN Projets pr ON pr.Nom LIKE p.Nom + N'%';
GO

SELECT p.Id, p.Nom AS Produit, pr.Nom AS Projet
FROM Produits p
LEFT JOIN Projets pr ON pr.Id = p.ProjetId;
GO

UPDATE Produits
SET ProjetId = (SELECT Id FROM Projets WHERE Nom = N'Beacon-Compact')
WHERE Nom = N'Beacon compact';
GO

SELECT p.Id, p.Nom AS Produit, pr.Nom AS Projet
FROM Produits p
LEFT JOIN Projets pr ON pr.Id = p.ProjetId;
GO

UPDATE p
SET p.DivisionId = pr.DivisionId
FROM Produits p
JOIN Projets pr ON pr.Id = p.ProjetId;
GO

SELECT p.Nom AS Produit, pr.Nom AS Projet, p.DivisionId AS DivisionProduit, pr.DivisionId AS DivisionProjet
FROM Produits p
JOIN Projets pr ON pr.Id = p.ProjetId;
GO

UPDATE Produits SET Prix = 6500.00 WHERE Nom = N'Aegis';
GO

UPDATE Produits SET Description = RTRIM(Description);
GO

SELECT Nom, Prix, LEN(Description) AS Longueur, Description
FROM Produits
WHERE Nom IN (N'Aegis', N'Secours S-18', N'Evacuation S-18');
GO

ALTER TABLE Divisions ADD Slug NVARCHAR(50) NULL;
GO

UPDATE Divisions SET Slug = N'aerospace' WHERE Nom = N'Aerospace';
UPDATE Divisions SET Slug = N'biotech'   WHERE Nom = N'Biotech';
UPDATE Divisions SET Slug = N'civiltech' WHERE Nom = N'Civiltech';
UPDATE Divisions SET Slug = N'mobility'  WHERE Nom = N'Mobility';
UPDATE Divisions SET Slug = N'securelink' WHERE Nom = N'Seculink';
GO

SELECT Id, Nom, Slug FROM Divisions;
GO

ALTER TABLE Projets ADD Slug NVARCHAR(100) NULL;
GO

UPDATE Projets SET Slug = N'falcon-g-01'     WHERE Nom = N'Falcon G-01';
UPDATE Projets SET Slug = N'exo-tissu'       WHERE Nom = N'Exo-Tissus';
UPDATE Projets SET Slug = N'aegis-17'        WHERE Nom = N'Aegis-17';
UPDATE Projets SET Slug = N'aeromat-a-01'    WHERE Nom = N'Aeromat-A-01';
UPDATE Projets SET Slug = N'hexa-c6-412'     WHERE Nom = N'Hexa-C6-412';
UPDATE Projets SET Slug = N'warden'          WHERE Nom = N'Warden';
UPDATE Projets SET Slug = N'jet-wt'          WHERE Nom = N'Jet WT';
UPDATE Projets SET Slug = N'stride'          WHERE Nom = N'Stride';
UPDATE Projets SET Slug = N'laptop'          WHERE Nom = N'Laptop';
UPDATE Projets SET Slug = N'beacon'          WHERE Nom = N'Beacon-Compact';
UPDATE Projets SET Slug = N'nest'            WHERE Nom = N'Nest';
UPDATE Projets SET Slug = N'viper'           WHERE Nom = N'Viper';
UPDATE Projets SET Slug = N'metro'           WHERE Nom = N'Métro';
UPDATE Projets SET Slug = N'secours-s-18'    WHERE Nom = N'Secours S-18';
UPDATE Projets SET Slug = N'evacuation-s-18' WHERE Nom = N'Evacuation S-18';
GO

SELECT Nom, Slug FROM Projets WHERE Slug IS NULL;
GO

ALTER TABLE Divisions ALTER COLUMN Slug NVARCHAR(50) NOT NULL;
ALTER TABLE Divisions ADD CONSTRAINT UQ_Divisions_Slug UNIQUE (Slug);
GO

ALTER TABLE Projets ALTER COLUMN Slug NVARCHAR(100) NOT NULL;
ALTER TABLE Projets ADD CONSTRAINT UQ_Projets_Slug UNIQUE (Slug);
GO

SELECT name FROM sys.key_constraints WHERE name LIKE 'UQ_%Slug';
GO

SELECT DISTINCT Statut FROM Projets;
GO

ALTER TABLE Projets ADD CONSTRAINT CK_Projets_Statut
    CHECK (Statut IN (N'En cours', N'Terminé', N'Phase expérimentale', N'A venir'));
GO

UPDATE Projets SET Statut = N'Nimporte quoi' WHERE Nom = N'Nest';
GO