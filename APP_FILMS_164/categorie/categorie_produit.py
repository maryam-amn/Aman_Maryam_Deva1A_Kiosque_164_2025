"""
    Fichier : categorie_produit.py
    Auteur : OM 2021.03.22
    Gestion des catégories
"""
from flask import redirect, url_for, flash, render_template, request
from APP_FILMS_164 import app
from APP_FILMS_164.database.database_tools import DBconnection
from APP_FILMS_164.categorie.categorie_produit_wtf_forms import FormWTFAjouterCategorie
from flask import session

@app.route("/categories_afficher")
def categories_afficher():
    try:
        with DBconnection() as mc:
            mc.execute("SELECT * FROM t_categorie ORDER BY id_categorie ASC;")
            categories = mc.fetchall()
        return render_template("categorie/categories_afficher.html", categories=categories)
    except Exception as e:
        return f"Erreur lors de la récupération des catégories : {e}"

@app.route("/categories_add", methods=['GET', 'POST'])
def categories_add():
    form = FormWTFAjouterCategorie()
    if request.method == "POST":
        try:
            if form.validate_on_submit():
                nom_categorie = form.nom_categorie.data
                description = form.description.data

                valeurs_insertion = {
                    "value_nom_categorie": nom_categorie,
                    "value_description": description
                }
                strsql_insert_categorie = """
                    INSERT INTO t_categorie (nom_categorie, description)
                    VALUES (%(value_nom_categorie)s, %(value_description)s)
                """
                with DBconnection() as mconn_bd:
                    mconn_bd.execute(strsql_insert_categorie, valeurs_insertion)

                flash("Catégorie ajoutée avec succès !", "success")
                return redirect(url_for('categories_afficher'))
        except Exception as e:
            flash(f"Erreur lors de l'ajout : {e}", "danger")

    return render_template(
        "categorie/categories_add.html",
        form=form
    )

@app.route("/categories_update/<int:id_categorie>", methods=['GET', 'POST'])
def categories_update(id_categorie):
    form = FormWTFAjouterCategorie()
    if request.method == "GET":
        try:
            with DBconnection() as mc:
                mc.execute("SELECT * FROM t_categorie WHERE id_categorie = %s", (id_categorie,))
                categorie = mc.fetchone()
                if categorie:
                    form.nom_categorie.data = categorie["nom_categorie"]
                    form.description.data = categorie["description"]
                else:
                    flash("Catégorie introuvable.", "danger")
                    return redirect(url_for('categories_afficher'))
        except Exception as e:
            flash(f"Erreur lors de la récupération : {e}", "danger")
            return redirect(url_for('categories_afficher'))

    if request.method == "POST":
        try:
            if form.validate_on_submit():
                nom_categorie = form.nom_categorie.data
                description = form.description.data

                valeurs_update = {
                    "value_nom_categorie": nom_categorie,
                    "value_description": description,
                    "value_id_categorie": id_categorie
                }
                strsql_update_categorie = """
                    UPDATE t_categorie
                    SET nom_categorie = %(value_nom_categorie)s,
                        description = %(value_description)s
                    WHERE id_categorie = %(value_id_categorie)s
                """
                with DBconnection() as mconn_bd:
                    mconn_bd.execute(strsql_update_categorie, valeurs_update)

                flash("Catégorie modifiée avec succès !", "success")
                return redirect(url_for('categories_afficher'))
        except Exception as e:
            flash(f"Erreur lors de la modification : {e}", "danger")

    return render_template(
        "categorie/categories_update.html",  # tu peux créer un categories_update.html si tu veux
        form=form
    )

@app.route("/categories_delete/<int:id_categorie>", methods=['GET', 'POST'])
def categories_delete(id_categorie):
    from APP_FILMS_164.categorie.categorie_produit_wtf_forms import FormWTFDeleteCategorie
    form = FormWTFDeleteCategorie()
    btn_submit_del = False
    data_produits_associes = None

    try:
        if request.method == "POST":
            if form.submit_btn_annuler.data:
                return redirect(url_for("categories_afficher"))

            if form.submit_btn_conf_del.data:
                # Affiche la liste des produits associés avant suppression définitive
                str_sql_produits_associes = """
                    SELECT DISTINCT p.id_produit, p.nom_produit, p.stock_actuel, p.prix_produit
                    FROM t_produit_catégorie pc
                    INNER JOIN t_produit p ON pc.fk_produit = p.id_produit
                    WHERE pc.fk_categorie = %(value_id_categorie)s
                """
                with DBconnection() as conn:
                    conn.execute(str_sql_produits_associes, {"value_id_categorie": id_categorie})
                    data_produits_associes = conn.fetchall()
                session['data_produits_associes'] = data_produits_associes
                btn_submit_del = True

            if form.submit_btn_del.data:
                # Suppression des associations puis de la catégorie
                with DBconnection() as conn:
                    conn.execute("DELETE FROM t_produit_catégorie WHERE fk_categorie = %(value_id_categorie)s", {"value_id_categorie": id_categorie})
                    conn.execute("DELETE FROM t_categorie WHERE id_categorie = %(value_id_categorie)s", {"value_id_categorie": id_categorie})
                flash("Catégorie supprimée avec succès !", "success")
                return redirect(url_for('categories_afficher'))

        if request.method == "GET" or not btn_submit_del:
            # Pré-remplir le champ de la catégorie
            with DBconnection() as conn:
                conn.execute("SELECT * FROM t_categorie WHERE id_categorie = %s", (id_categorie,))
                categorie = conn.fetchone()
                if categorie:
                    form.categorie_delete_wtf.data = categorie["nom_categorie"]
                else:
                    flash("Catégorie introuvable.", "danger")
                    return redirect(url_for('categories_afficher'))

            # Afficher les produits associés dès le départ (optionnel)
            str_sql_produits_associes = """
                SELECT DISTINCT p.id_produit, p.nom_produit, p.stock_actuel, p.prix_produit
                FROM t_produit_catégorie pc
                INNER JOIN t_produit p ON pc.fk_produit = p.id_produit
                WHERE pc.fk_categorie = %(value_id_categorie)s
            """
            with DBconnection() as conn:
                conn.execute(str_sql_produits_associes, {"value_id_categorie": id_categorie})
                data_produits_associes = conn.fetchall()

        # Si on est en mode confirmation (après avoir cliqué sur "Confirmer"), on récupère les produits associés depuis la session
        if btn_submit_del:
            data_produits_associes = session.get('data_produits_associes')

    except Exception as e:
        flash(f"Erreur lors de la suppression : {e}", "danger")
        return redirect(url_for('categories_afficher'))

    return render_template(
        "categorie/categories_delete.html",
        form=form,
        btn_submit_del=btn_submit_del,
        data_produits_associes=data_produits_associes
    )
