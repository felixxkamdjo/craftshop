import sqlite3
from functools import wraps
from datetime import datetime
from flask import Flask, render_template, request, redirect, url_for, session, flash, jsonify, abort
from werkzeug.security import check_password_hash

app = Flask(__name__)
app.secret_key = "craftshop_secret_minimal_key_2026"
DB_FILE = "projet.db"

def get_db():
    conn = sqlite3.connect(DB_FILE)
    conn.row_factory = sqlite3.Row
    conn.execute("PRAGMA foreign_keys = ON;")
    return conn

def connexion_requise(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if "admin_id" not in session:
            flash("Veuillez vous connecter pour accéder à l'espace administration.", "error")
            return redirect(url_for("admin_login"))
        return f(*args, **kwargs)
    return decorated_function

# ----------------- ROUTES PUBLIQUES -----------------

@app.route("/")
def index():
    categorie_id = request.args.get("categorie", type=int)
    tri = request.args.get("tri", default="nom_asc")
    recherche = request.args.get("q", default="").strip()

    conn = get_db()
    categories = conn.execute("SELECT * FROM categories ORDER BY nom ASC;").fetchall()

    sql = "SELECT p.*, c.nom as categorie_nom FROM produits p JOIN categories c ON p.categorie_id = c.id WHERE p.actif = 1"
    params = []

    if categorie_id:
        sql += " AND p.categorie_id = ?"
        params.append(categorie_id)

    if recherche:
        sql += " AND (p.nom LIKE ? OR p.description LIKE ?)"
        params.extend([f"%{recherche}%", f"%{recherche}%"])

    if tri == "prix_asc":
        sql += " ORDER BY p.prix ASC"
    elif tri == "prix_desc":
        sql += " ORDER BY p.prix DESC"
    else:
        sql += " ORDER BY p.nom ASC"

    produits = conn.execute(sql, params).fetchall()
    conn.close()
    return render_template("catalogue.html", produits=produits, categories=categories,
                           selected_cat=categorie_id, tri=tri, recherche=recherche)

@app.route("/produit/<int:produit_id>")
def produit_detail(produit_id):
    conn = get_db()
    produit = conn.execute(
        "SELECT p.*, c.nom as categorie_nom FROM produits p JOIN categories c ON p.categorie_id = c.id WHERE p.id = ?",
        (produit_id,)
    ).fetchone()
    conn.close()
    if not produit:
        abort(404)
    return render_template("produit.html", produit=produit)

@app.route("/panier")
def panier():
    return render_template("panier.html")

@app.route("/commander", methods=["POST"])
def commander():
    nom = request.form.get("nom", "").strip()
    telephone = request.form.get("telephone", "").strip()
    adresse = request.form.get("adresse", "").strip()
    mode_paiement = request.form.get("mode_paiement", "").strip()
    items_raw = request.form.get("items_json", "[]")

    if not nom or not telephone or not adresse or mode_paiement not in ['Mobile Money', 'À la livraison']:
        flash("Tous les champs sont requis avec des informations valides.", "error")
        return redirect(url_for("panier"))

    import json
    try:
        items = json.loads(items_raw)
        if not items:
            flash("Votre panier est vide.", "error")
            return redirect(url_for("panier"))
    except Exception:
        flash("Format de panier invalide.", "error")
        return redirect(url_for("panier"))

    conn = get_db()
    try:
        conn.execute("BEGIN IMMEDIATE;")
        total_calcule = 0
        lignes_a_inserer = []

        for item in items:
            p_id = int(item.get("id", 0))
            quantite = int(item.get("quantite", 0))
            if quantite <= 0:
                continue

            prod = conn.execute("SELECT id, prix, stock, actif FROM produits WHERE id = ?", (p_id,)).fetchone()
            if not prod or prod["actif"] == 0:
                raise ValueError("Le produit sélectionné n'est plus disponible.")
            if prod["stock"] < quantite:
                raise ValueError(f"Stock insuffisant pour un des articles ({prod['stock']} restants).")

            total_calcule += quantite * prod["prix"]
            lignes_a_inserer.append((p_id, quantite, prod["prix"]))
            conn.execute("UPDATE produits SET stock = stock - ? WHERE id = ?", (quantite, p_id))

        date_actuelle = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        cur = conn.execute(
            """INSERT INTO commandes (client_nom, client_telephone, adresse, date, mode_paiement, statut, total)
               VALUES (?, ?, ?, ?, ?, 'reçue', ?)""",
            (nom, telephone, adresse, date_actuelle, mode_paiement, total_calcule)
        )
        cmd_id = cur.lastrowid

        for p_id, qte, prix_u in lignes_a_inserer:
            conn.execute(
                """INSERT INTO lignes_commande (commande_id, produit_id, quantite, prix_unitaire)
                   VALUES (?, ?, ?, ?)""",
                (cmd_id, p_id, qte, prix_u)
            )

        conn.commit()
    except Exception as e:
        conn.rollback()
        conn.close()
        flash(f"Erreur lors de la validation : {str(e)}", "error")
        return redirect(url_for("panier"))

    conn.close()
    return redirect(url_for("confirmation", commande_id=cmd_id))

@app.route("/confirmation/<int:commande_id>")
def confirmation(commande_id):
    conn = get_db()
    commande = conn.execute("SELECT * FROM commandes WHERE id = ?", (commande_id,)).fetchone()
    if not commande:
        conn.close()
        abort(404)
    lignes = conn.execute(
        """SELECT l.*, p.nom, p.artisan 
           FROM lignes_commande l 
           JOIN produits p ON l.produit_id = p.id 
           WHERE l.commande_id = ?""",
        (commande_id,)
    ).fetchall()
    conn.close()
    return render_template("confirmation.html", commande=commande, lignes=lignes)

# ----------------- API JSON -----------------

@app.route("/api/produits")
def api_produits():
    conn = get_db()
    produits = conn.execute("SELECT id, nom, prix, stock, artisan FROM produits WHERE actif = 1;").fetchall()
    conn.close()
    return jsonify([dict(p) for p in produits])

@app.route("/api/statistiques")
@connexion_requise
def api_statistiques():
    conn = get_db()
    ca_par_mois = conn.execute("""
        SELECT strftime('%Y-%m', date) as mois, SUM(total) as ca
        FROM commandes
        WHERE statut = 'livrée'
        GROUP BY mois
        ORDER BY mois DESC
        LIMIT 6;
    """).fetchall()

    top_produits = conn.execute("""
        SELECT p.nom, SUM(l.quantite) as total_vendu
        FROM lignes_commande l
        JOIN produits p ON l.produit_id = p.id
        JOIN commandes c ON l.commande_id = c.id
        WHERE c.statut != 'annulée'
        GROUP BY p.id
        ORDER BY total_vendu DESC
        LIMIT 5;
    """).fetchall()

    panier_moyen = conn.execute("""
        SELECT AVG(total) as moyenne FROM commandes WHERE statut != 'annulée';
    """).fetchone()["moyenne"] or 0

    repartition_paiements = conn.execute("""
        SELECT mode_paiement, COUNT(*) as nombre
        FROM commandes
        GROUP BY mode_paiement;
    """).fetchall()

    conn.close()
    return jsonify({
        "ca_par_mois": [dict(r) for r in ca_par_mois],
        "top_produits": [dict(r) for r in top_produits],
        "panier_moyen": round(panier_moyen, 2),
        "repartition_paiements": [dict(r) for r in repartition_paiements]
    })

# ----------------- ADMINISTRATION -----------------

@app.route("/admin/login", methods=["GET", "POST"])
def admin_login():
    if request.method == "POST":
        login = request.form.get("login")
        password = request.form.get("password")
        conn = get_db()
        admin = conn.execute("SELECT * FROM administrateurs WHERE login = ?", (login,)).fetchone()
        conn.close()

        if admin and check_password_hash(admin["empreinte"], password):
            session["admin_id"] = admin["id"]
            session["admin_login"] = admin["login"]
            flash("Connexion réussie.", "success")
            return redirect(url_for("admin_dashboard"))
        flash("Identifiant ou mot de passe incorrect.", "error")
    return render_template("admin_login.html")

@app.route("/admin/logout", methods=["POST"])
def admin_logout():
    session.clear()
    flash("Vous êtes déconnecté.", "info")
    return redirect(url_for("admin_login"))

@app.route("/admin/dashboard")
@connexion_requise
def admin_dashboard():
    statut_filtre = request.args.get("statut", "")
    conn = get_db()

    sql_commandes = "SELECT * FROM commandes"
    params = []
    if statut_filtre in ['reçue', 'préparée', 'livrée', 'annulée']:
        sql_commandes += " WHERE statut = ?"
        params.append(statut_filtre)
    sql_commandes += " ORDER BY date DESC LIMIT 20;"
    commandes = conn.execute(sql_commandes, params).fetchall()

    produits_alerte = conn.execute("SELECT * FROM produits WHERE stock < 5 AND actif = 1;").fetchall()
    categories = conn.execute("SELECT * FROM categories ORDER BY nom;").fetchall()
    produits = conn.execute("SELECT p.*, c.nom as categorie_nom FROM produits p JOIN categories c ON p.categorie_id = c.id ORDER BY p.id DESC;").fetchall()
    conn.close()

    return render_template("admin_dashboard.html",
                           commandes=commandes,
                           produits_alerte=produits_alerte,
                           produits=produits,
                           categories=categories,
                           statut_filtre=statut_filtre)

@app.route("/admin/produit/ajouter", methods=["POST"])
@connexion_requise
def admin_produit_ajouter():
    nom = request.form.get("nom")
    cat_id = request.form.get("categorie_id", type=int)
    description = request.form.get("description")
    prix = request.form.get("prix", type=int)
    stock = request.form.get("stock", type=int)
    artisan = request.form.get("artisan")

    if nom and cat_id and prix is not None and stock is not None:
        conn = get_db()
        conn.execute(
            """INSERT INTO produits (nom, categorie_id, description, prix, stock, image, artisan, actif)
               VALUES (?, ?, ?, ?, ?, 'placeholder.svg', ?, 1)""",
            (nom, cat_id, description, prix, stock, artisan)
        )
        conn.commit()
        conn.close()
        flash("Produit ajouté avec succès.", "success")
    return redirect(url_for("admin_dashboard"))

@app.route("/admin/produit/toggle/<int:produit_id>", methods=["POST"])
@connexion_requise
def admin_produit_toggle(produit_id):
    conn = get_db()
    conn.execute("UPDATE produits SET actif = CASE WHEN actif = 1 THEN 0 ELSE 1 END WHERE id = ?", (produit_id,))
    conn.commit()
    conn.close()
    flash("Statut du produit mis à jour.", "info")
    return redirect(url_for("admin_dashboard"))

@app.route("/admin/commande/statut/<int:commande_id>", methods=["POST"])
@connexion_requise
def admin_commande_statut(commande_id):
    nouveau_statut = request.form.get("statut")
    if nouveau_statut in ['reçue', 'préparée', 'livrée', 'annulée']:
        conn = get_db()
        conn.execute("BEGIN IMMEDIATE;")
        anc = conn.execute("SELECT statut FROM commandes WHERE id = ?", (commande_id,)).fetchone()
        
        if anc and anc["statut"] != 'annulée' and nouveau_statut == 'annulée':
            lignes = conn.execute("SELECT produit_id, quantite FROM lignes_commande WHERE commande_id = ?", (commande_id,)).fetchall()
            for l in lignes:
                conn.execute("UPDATE produits SET stock = stock + ? WHERE id = ?", (l["quantite"], l["produit_id"]))

        conn.execute("UPDATE commandes SET statut = ? WHERE id = ?", (nouveau_statut, commande_id))
        conn.commit()
        conn.close()
        flash("Statut de la commande actualisé.", "success")
    return redirect(url_for("admin_dashboard"))

@app.errorhandler(404)
def page_non_trouvee(e):
    return render_template("404.html"), 404

if __name__ == "__main__":
    app.run(debug=False)
