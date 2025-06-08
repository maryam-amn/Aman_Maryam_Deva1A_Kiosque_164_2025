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
    form_delete = FormWTFDeleteCategorie()
    data_produits_associes = None
    btn_submit_del = False

    try:
        if request.method == "POST" and form_delete.validate_on_submit():

            if form_delete.submit_btn_annuler.data:
                return redirect(url_for("categories_afficher"))

            if form_delete.submit_btn_conf_del.data:
                # On récupère les produits associés depuis la session
                data_produits_associes = session.get('data_produits_associes')
                flash("Effacer la catégorie de façon définitive de la BD !!!", "danger")
                btn_submit_del = True

            if form_delete.submit_btn_del.data:
                valeur_delete_dictionnaire = {"value_id_categorie": id_categorie}

                # 1. Supprimer les associations dans t_produit_catégorie
                str_sql_delete_assoc = """DELETE FROM t_produit_catégorie WHERE fk_categorie = %(value_id_categorie)s"""
                # 2. Supprimer la catégorie
                str_sql_delete_categorie = """DELETE FROM t_categorie WHERE id_categorie = %(value_id_categorie)s"""
                with DBconnection() as mconn_bd:
                    mconn_bd.execute(str_sql_delete_assoc, valeur_delete_dictionnaire)
                    mconn_bd.execute(str_sql_delete_categorie, valeur_delete_dictionnaire)

                flash("Catégorie définitivement effacée !!", "success")
                return redirect(url_for('categories_afficher'))

        if request.method == "GET":
            valeur_select_dictionnaire = {"value_id_categorie": id_categorie}

            # Récupérer les produits associés à la catégorie
            str_sql_produits_associes = """
                SELECT DISTINCT p.id_produit, p.nom_produit, p.stock_actuel, p.prix_produit
                FROM t_produit_catégorie pc
                INNER JOIN t_produit p ON pc.fk_produit = p.id_produit
                WHERE pc.fk_categorie = %(value_id_categorie)s
            """
            with DBconnection() as mydb_conn:
                mydb_conn.execute(str_sql_produits_associes, valeur_select_dictionnaire)
                data_produits_associes = mydb_conn.fetchall()
                session['data_produits_associes'] = data_produits_associes

                str_sql_id_categorie = "SELECT * FROM t_categorie WHERE id_categorie = %(value_id_categorie)s"
                mydb_conn.execute(str_sql_id_categorie, valeur_select_dictionnaire)
                data_nom_categorie = mydb_conn.fetchone()
                if data_nom_categorie is None:
                    flash("La catégorie demandée n'existe pas.", "danger")
                    return redirect(url_for('categories_afficher'))
                form_delete.categorie_delete_wtf.data = data_nom_categorie["nom_categorie"]
            btn_submit_del = False

    except Exception as e:
        flash(f"Erreur lors de la suppression : {e}", "danger")
        return redirect(url_for('categories_afficher'))

    return render_template(
        "categorie/categories_delete.html",
        form=form_delete,
        btn_submit_del=btn_submit_del,
        data_produits_associes=data_produits_associes
    )

