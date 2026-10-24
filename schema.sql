PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS lignes_commande;
DROP TABLE IF EXISTS commandes;
DROP TABLE IF EXISTS produits;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS administrateurs;

CREATE TABLE administrateurs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    login TEXT NOT NULL UNIQUE,
    empreinte TEXT NOT NULL
);

CREATE TABLE categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nom TEXT NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE produits (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    categorie_id INTEGER NOT NULL,
    nom TEXT NOT NULL,
    description TEXT,
    prix INTEGER NOT NULL CHECK (prix >= 0),
    stock INTEGER NOT NULL CHECK (stock >= 0),
    image TEXT NOT NULL,
    artisan TEXT NOT NULL,
    actif INTEGER NOT NULL DEFAULT 1 CHECK (actif IN (0, 1)),
    FOREIGN KEY (categorie_id) REFERENCES categories (id) ON DELETE RESTRICT
);

CREATE TABLE commandes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    client_nom TEXT NOT NULL,
    client_telephone TEXT NOT NULL,
    adresse TEXT NOT NULL,
    date TEXT NOT NULL,
    mode_paiement TEXT NOT NULL CHECK (mode_paiement IN ('Mobile Money', 'À la livraison')),
    statut TEXT NOT NULL DEFAULT 'reçue' CHECK (statut IN ('reçue', 'préparée', 'livrée', 'annulée')),
    total INTEGER NOT NULL CHECK (total >= 0)
);

CREATE TABLE lignes_commande (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    commande_id INTEGER NOT NULL,
    produit_id INTEGER NOT NULL,
    quantite INTEGER NOT NULL CHECK (quantite > 0),
    prix_unitaire INTEGER NOT NULL CHECK (prix_unitaire >= 0),
    FOREIGN KEY (commande_id) REFERENCES commandes (id) ON DELETE CASCADE,
    FOREIGN KEY (produit_id) REFERENCES produits (id) ON DELETE RESTRICT
);
