import random
import sqlite3
from datetime import datetime, timedelta
from werkzeug.security import generate_password_hash

DB_FILE = "projet.db"
random.seed(42)

CATEGORIES = [
    ("Sculptures", "Masques et statues traditionnels en bois noble."),
    ("Vannerie", "Paniers, corbeilles et sacs tressés en raphia."),
    ("Textiles & Tissus", "Tissus Ndop, pagnes tissés et tentures traditionnelles."),
    ("Bijouterie artisanale", "Colliers, perles royales et bracelets en bronze."),
    ("Poterie & Céramique", "Vases, cruches et objets décoratifs en terre cuite."),
]

ARTISANS = [
    "Atelier Fon Kouamé (Foumban)",
    "Coopérative Nso Raphia (Bamenda)",
    "Maître Nji Oumarou (Foumban)",
    "Tissage Che & Fils (Bamenda)",
    "Poterie Royale de Noun (Foumban)",
]

NOMS_CLIENTS = [
    "Samuel Eto'o", "Aïcha Diallo", "Marc Atangana", "Therese Ngo",
    "Ibrahim Bello", "Carine Tchoupo", "Félix Mbarga", "Béatrice Ekane"
]

VILLES_ADRESSES = [
    "Bonapriso, Douala", "Akwa, Douala", "Bastos, Yaoundé", 
    "Omnisports, Yaoundé", "Up Station, Bamenda", "Centre-ville, Foumban"
]

def init_db():
    conn = sqlite3.connect(DB_FILE)
    conn.execute("PRAGMA foreign_keys = ON;")
    with open("schema.sql", "r", encoding="utf-8") as f:
        conn.executescript(f.read())
    
    conn.execute(
        "INSERT INTO administrateurs (login, empreinte) VALUES (?, ?)",
        ("admin", generate_password_hash("Admin!2026"))
    )

    cat_ids = []
    for nom, desc in CATEGORIES:
        cur = conn.execute("INSERT INTO categories (nom, description) VALUES (?, ?)", (nom, desc))
        cat_ids.append(cur.lastrowid)

    produits_crees = []
    for c_id in cat_ids:
        cat_nom = CATEGORIES[c_id - 1][0]
        for i in range(1, 9):
            p_nom = f"{cat_nom[:-1]} - Modèle {i:02d}"
            desc = "Pièce artisanale authentique faite main. Finition soignée."
            prix = random.randint(3500, 45000)
            stock = random.randint(2, 25)
            artisan = random.choice(ARTISANS)
            image = "placeholder.svg"
            cur = conn.execute(
                """INSERT INTO produits (categorie_id, nom, description, prix, stock, image, artisan, actif)
                   VALUES (?, ?, ?, ?, ?, ?, ?, 1)""",
                (c_id, p_nom, desc, prix, stock, image, artisan)
            )
            produits_crees.append({"id": cur.lastrowid, "prix": prix})

    statuts = ["reçue", "préparée", "livrée", "annulée"]
    modes = ["Mobile Money", "À la livraison"]
    start_date = datetime.now() - timedelta(days=60)

    lignes_totales = 0
    for cmd_idx in range(1, 61):
        client = random.choice(NOMS_CLIENTS)
        tel = f"6{random.randint(70000000, 99999999)}"
        adresse = random.choice(VILLES_ADRESSES)
        date_cmd = (start_date + timedelta(days=random.randint(0, 59), hours=random.randint(0, 23))).strftime("%Y-%m-%d %H:%M:%S")
        mode = random.choice(modes)
        statut = random.choices(statuts, weights=[20, 20, 50, 10])[0]

        nb_articles = random.randint(2, 4)
        produits_choisis = random.sample(produits_crees, nb_articles)

        total_commande = 0
        lignes = []
        for prod in produits_choisis:
            qte = random.randint(1, 3)
            prix_unit = prod["prix"]
            total_commande += qte * prix_unit
            lignes.append((prod["id"], qte, prix_unit))
            lignes_totales += 1

        cur = conn.execute(
            """INSERT INTO commandes (client_nom, client_telephone, adresse, date, mode_paiement, statut, total)
               VALUES (?, ?, ?, ?, ?, ?, ?)""",
            (client, tel, adresse, date_cmd, mode, statut, total_commande)
        )
        cmd_id = cur.lastrowid

        for p_id, qte, prix_unit in lignes:
            conn.execute(
                """INSERT INTO lignes_commande (commande_id, produit_id, quantite, prix_unitaire)
                   VALUES (?, ?, ?, ?)""",
                (cmd_id, p_id, qte, prix_unit)
            )

    conn.commit()
    conn.close()
    print("Base projet.db initialisée.")

if __name__ == "__main__":
    init_db()
