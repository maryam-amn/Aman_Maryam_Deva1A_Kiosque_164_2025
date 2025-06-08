-- CRUD_Maryam_Aman_Classe.sql

-- =======================
-- Table : t_categorie
-- =======================

-- CREATE
INSERT INTO t_categorie (nom_categorie, description) VALUES ('Boissons', 'Boissons fraîches et chaudes');

-- READ
SELECT * FROM t_categorie;
SELECT * FROM t_categorie WHERE id_categorie = 1;

-- UPDATE
UPDATE t_categorie SET nom_categorie = 'Snacks', description = 'Snacks salés et sucrés' WHERE id_categorie = 1;

-- DELETE
DELETE FROM t_categorie WHERE id_categorie = 1;

-- =======================
-- Table : t_produit
-- =======================

-- CREATE
INSERT INTO t_produit (nom_produit, stock_actuel, prix_produit) VALUES ("Jus d\'orange", 50, 2.50);

-- READ
SELECT * FROM t_produit;
SELECT * FROM t_produit WHERE id_produit = 1;

-- UPDATE
UPDATE t_produit SET stock_actuel = 45, prix_produit = 2.30 WHERE id_produit = 1;

-- DELETE
DELETE FROM t_produit WHERE id_produit = 1;

-- =======================
-- Table : t_fournisseur
-- =======================

-- CREATE
INSERT INTO t_fournisseur (nom_entreprise, adresse_entreprise) VALUES ('Fournisseur Express', '12 rue du Marché, Paris');

-- READ
SELECT * FROM t_fournisseur;
SELECT * FROM t_fournisseur WHERE id_fournisseur = 1;

-- UPDATE
UPDATE t_fournisseur SET adresse_entreprise = '15 avenue Centrale, Paris' WHERE id_fournisseur = 1;

-- DELETE
DELETE FROM t_fournisseur WHERE id_fournisseur = 1;

-- =======================
-- Table : t_produit_catégorie
-- =======================

-- CREATE
INSERT INTO t_produit_catégorie (fk_produit, fk_categorie) VALUES (1, 2);

-- READ
SELECT * FROM t_produit_catégorie;
SELECT * FROM t_produit_catégorie WHERE id_produit_categorie = 1;

-- UPDATE
UPDATE t_produit_catégorie SET fk_categorie = 3 WHERE id_produit_categorie = 1;

-- DELETE
DELETE FROM t_produit_catégorie WHERE id_produit_categorie = 1;

-- =======================
-- Table : t_fournisseur_produit
-- =======================

-- CREATE
INSERT INTO t_fournisseur_produit (fk_fournisseur, fk_produit) VALUES (1, 1);

-- READ
SELECT * FROM t_fournisseur_produit;
SELECT * FROM t_fournisseur_produit WHERE id_fournisseur_produit = 1;

-- UPDATE
UPDATE t_fournisseur_produit SET fk_fournisseur = 2 WHERE id_fournisseur_produit = 1;

-- DELETE
DELETE FROM t_fournisseur_produit WHERE id_fournisseur_produit = 1;
