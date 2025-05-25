"""Gestion des "routes" FLASK et des données pour les genres.
Fichier : gestion_genres_crud.py
Auteur : OM 2021.03.16
"""
from pathlib import Path

from flask import redirect
from flask import request
from flask import session
from flask import url_for

from APP_FILMS_164 import app
from APP_FILMS_164.database.database_tools import DBconnection
from APP_FILMS_164.erreurs.exceptions import *
from APP_FILMS_164.genres.gestion_genres_wtf_forms import FormWTFAjouterGenres
from APP_FILMS_164.genres.gestion_genres_wtf_forms import FormWTFDeleteGenre
from APP_FILMS_164.genres.gestion_genres_wtf_forms import FormWTFUpdateGenre

"""
    Auteur : OM 2021.03.16
    Définition d'une "route" /genres_afficher
    
    Test : ex : http://127.0.0.1:5575/genres_afficher
    
    Paramètres : order_by : ASC : Ascendant, DESC : Descendant
                id_genre_sel = 0 >> tous les genres.
                id_genre_sel = "n" affiche le genre dont l'id est "n"
"""


@app.route("/genres_afficher/<string:order_by>/<int:id_genre_sel>", methods=['GET', 'POST'])
def genres_afficher(order_by, id_genre_sel):
    if request.method == "GET":
        try:
            with DBconnection() as mc_afficher:
                if order_by == "ASC" and id_genre_sel == 0:
                    strsql_genres_afficher = """SELECT * FROM t_produit ORDER BY id_produit  """
                    mc_afficher.execute(strsql_genres_afficher)
                elif order_by == "ASC":
                    # C'EST LA QUE VOUS ALLEZ DEVOIR PLACER VOTRE PROPRE LOGIQUE MySql
                    # la commande MySql classique est "SELECT * FROM t_genre"
                    # Pour "lever"(raise) une erreur s'il y a des erreurs sur les noms d'attributs dans la table
                    # donc, je précise les champs à afficher
                    # Constitution d'un dictionnaire pour associer l'id du genre sélectionné avec un nom de variable
                    valeur_id_genre_selected_dictionnaire = {"value_id_genre_selected": id_genre_sel}
                    strsql_genres_afficher = """SELECT *  FROM t_produit WHERE id_produit = %(value_id_genre_selected)s"""

                    mc_afficher.execute(strsql_genres_afficher, valeur_id_genre_selected_dictionnaire)
                else:
                    strsql_genres_afficher = """SELECT *  FROM t_produit ORDER BY id_produit """

                    mc_afficher.execute(strsql_genres_afficher)

                data_genres = mc_afficher.fetchall()

                print("data_genres ", data_genres, " Type : ", type(data_genres))

                # Différencier les messages si la table est vide.
                if not data_genres and id_genre_sel == 0:
                    flash("""La table "t_genre" est vide. !!""", "warning")
                elif not data_genres and id_genre_sel > 0:
                    # Si l'utilisateur change l'id_genre dans l'URL et que le genre n'existe pas,
                    flash(f"Le genre demandé n'existe pas !!", "warning")
                else:
                    # Dans tous les autres cas, c'est que la table "t_genre" est vide.
                    # OM 2020.04.09 La ligne ci-dessous permet de donner un sentiment rassurant aux utilisateurs.
                    flash(f"Données genres affichés !!", "success")

        except Exception as Exception_genres_afficher:
            raise ExceptionGenresAfficher(f"fichier : {Path(__file__).name}  ;  "
                                          f"{genres_afficher.__name__} ; "
                                          f"{Exception_genres_afficher}")

    # Envoie la page "HTML" au serveur.
    return render_template("genres/genres_afficher.html", data=data_genres)


"""
    Auteur : OM 2021.03.22
    Définition d'une "route" /genres_ajouter
    
    Test : ex : http://127.0.0.1:5575/genres_ajouter
    
    Paramètres : sans
    
    But : Ajouter un genre pour un film
    
    Remarque :  Dans le champ "name_genre_html" du formulaire "genres/genres_ajouter.html",
                le contrôle de la saisie s'effectue ici en Python.
                On transforme la saisie en minuscules.
                On ne doit pas accepter des valeurs vides, des valeurs avec des chiffres,
                des valeurs avec des caractères qui ne sont pas des lettres.
                Pour comprendre [A-Za-zÀ-ÖØ-öø-ÿ] il faut se reporter à la table ASCII https://www.ascii-code.com/
                Accepte le trait d'union ou l'apostrophe, et l'espace entre deux mots, mais pas plus d'une occurence.
"""


@app.route("/genres_ajouter", methods=['GET', 'POST'])
def genres_ajouter_wtf():
    form = FormWTFAjouterGenres()
    if request.method == "POST":
        try:
            if form.validate_on_submit():
                nom_produit = form.nom_produit_ajouter_wtf.data
                categorie_produit = form.categorie_produit_ajouter_wtf.data
                stock_actuel = form.stock_actuel_ajouter_wtf.data
                prix_produit = form.prix_produit_ajouter_wtf.data

                valeurs_insertion_dictionnaire = {
                    "value_nom_produit": nom_produit,
                    "value_categorie_produit": categorie_produit,
                    "value_stock_actuel": stock_actuel,
                    "value_prix_produit": prix_produit
                }
                print("valeurs_insertion_dictionnaire ", valeurs_insertion_dictionnaire)

                strsql_insert_genre = """
                    INSERT INTO t_produit (nom_produit, categorie_produit, stock_actuel, prix_produit)
                    VALUES (%(value_nom_produit)s, %(value_categorie_produit)s, %(value_stock_actuel)s, %(value_prix_produit)s)
                """
                with DBconnection() as mconn_bd:
                    mconn_bd.execute(strsql_insert_genre, valeurs_insertion_dictionnaire)

                flash(f"Données insérées !!", "success")
                print(f"Données insérées !!")

                return redirect(url_for('genres_afficher', order_by='DESC', id_genre_sel=0))

        except Exception as Exception_genres_ajouter_wtf:
            raise ExceptionGenresAjouterWtf(f"fichier : {Path(__file__).name}  ;  "
                                            f"{genres_ajouter_wtf.__name__} ; "
                                            f"{Exception_genres_ajouter_wtf}")

    return render_template("genres/genres_ajouter_wtf.html", form=form)


"""
    Auteur : OM 2021.03.29
    Définition d'une "route" /genre_update
    
    Test : ex cliquer sur le menu "genres" puis cliquer sur le bouton "EDIT" d'un "genre"
    
    Paramètres : sans
    
    But : Editer(update) un genre qui a été sélectionné dans le formulaire "genres_afficher.html"
    
    Remarque :  Dans le champ "nom_genre_update_wtf" du formulaire "genres/genre_update_wtf.html",
                le contrôle de la saisie s'effectue ici en Python.
                On transforme la saisie en minuscules.
                On ne doit pas accepter des valeurs vides, des valeurs avec des chiffres,
                des valeurs avec des caractères qui ne sont pas des lettres.
                Pour comprendre [A-Za-zÀ-ÖØ-öø-ÿ] il faut se reporter à la table ASCII https://www.ascii-code.com/
                Accepte le trait d'union ou l'apostrophe, et l'espace entre deux mots, mais pas plus d'une occurence.
"""


@app.route("/genre_update", methods=['GET', 'POST'])
def genre_update_wtf():
    form_update = FormWTFUpdateGenre()
    if request.method == "POST" and form_update.validate_on_submit():

        id_produit_update = form_update.id_produit_update_wtf.data
        valeur_update_dictionnaire = {
            "value_id_produit": id_produit_update,
            "value_nom_produit": form_update.nom_produit_update_wtf.data,
            "value_categorie_produit": form_update.categorie_produit_update_wtf.data,
            "value_stock_actuel": form_update.stock_actuel_update_wtf.data,
            "value_prix_produit": form_update.prix_produit_update_wtf.data
        }
        str_sql_update_produit = """
            UPDATE t_produit SET nom_produit = %(value_nom_produit)s,
                                 categorie_produit = %(value_categorie_produit)s,
                                 stock_actuel = %(value_stock_actuel)s,
                                 prix_produit = %(value_prix_produit)s
            WHERE id_produit = %(value_id_produit)s
        """
        with DBconnection() as mconn_bd:
            mconn_bd.execute(str_sql_update_produit, valeur_update_dictionnaire)
        flash("Produit modifié avec succès", "success")
        return redirect(url_for('genres_afficher', order_by="ASC", id_genre_sel=0))

    elif request.method == "POST":
        # Affichage du formulaire pré-rempli
        id_produit_update = request.values['id_produit_btn_edit_html']
        str_sql_id_produit = "SELECT * FROM t_produit WHERE id_produit = %(value_id_produit)s"
        valeur_select_dictionnaire = {"value_id_produit": id_produit_update}
        with DBconnection() as mybd_conn:
            mybd_conn.execute(str_sql_id_produit, valeur_select_dictionnaire)
            data_nom_produit = mybd_conn.fetchone()
            if data_nom_produit is None:
                flash("Le produit demandé n'existe pas.", "danger")
                return redirect(url_for('genres_afficher', order_by="ASC", id_genre_sel=0))
            # Remplir les champs du formulaire

            form_update.nom_produit_update_wtf.data = data_nom_produit["nom_produit"]
            form_update.categorie_produit_update_wtf.data = data_nom_produit["categorie_produit"]
            form_update.stock_actuel_update_wtf.data = data_nom_produit["stock_actuel"]
            form_update.prix_produit_update_wtf.data = data_nom_produit["prix_produit"]
            form_update.id_produit_update_wtf.data = id_produit_update

    return render_template("genres/genre_update_wtf.html", form_update=form_update)


"""
    Auteur : OM 2021.04.08
    Définition d'une "route" /genre_delete
    
    Test : ex. cliquer sur le menu "genres" puis cliquer sur le bouton "DELETE" d'un "genre"
    
    Paramètres : sans
    
    But : Effacer(delete) un genre qui a été sélectionné dans le formulaire "genres_afficher.html"
    
    Remarque :  Dans le champ "nom_genre_delete_wtf" du formulaire "genres/genre_delete_wtf.html",
                le contrôle de la saisie est désactivée. On doit simplement cliquer sur "DELETE"
"""


@app.route("/genre_delete", methods=['GET', 'POST'])
def genre_delete_wtf():
    data_films_attribue_genre_delete = None
    btn_submit_del = None
    # Récupère la valeur de "id_produit" envoyée par le bouton Delete
    id_genre_delete = request.values.get('id_produit_btn_delete_html') or request.args.get('id_produit_btn_delete_html')

    form_delete = FormWTFDeleteGenre()
    try:
        print(" on submit ", form_delete.validate_on_submit())
        if request.method == "POST" and form_delete.validate_on_submit():

            if form_delete.submit_btn_annuler.data:
                return redirect(url_for("genres_afficher", order_by="ASC", id_genre_sel=0))

            if form_delete.submit_btn_conf_del.data:
                data_films_attribue_genre_delete = session.get('data_films_attribue_genre_delete')
                print("data_films_attribue_genre_delete ", data_films_attribue_genre_delete)
                flash(f"Effacer le genre de façon définitive de la BD !!!", "danger")
                btn_submit_del = True

            if form_delete.submit_btn_del.data:
                valeur_delete_dictionnaire = {"value_id_produit": id_genre_delete}
                print("valeur_delete_dictionnaire ", valeur_delete_dictionnaire)

                str_sql_delete_films_genre = """DELETE FROM t_fournisseur_produit WHERE fk_produit = %(value_id_produit)s"""
                str_sql_delete_idgenre = """DELETE FROM t_produit WHERE id_produit = %(value_id_produit)s"""
                with DBconnection() as mconn_bd:
                    mconn_bd.execute(str_sql_delete_films_genre, valeur_delete_dictionnaire)
                    mconn_bd.execute(str_sql_delete_idgenre, valeur_delete_dictionnaire)

                flash(f"Genre définitivement effacé !!", "success")
                print(f"Genre définitivement effacé !!")
                return redirect(url_for('genres_afficher', order_by="ASC", id_genre_sel=0))

        if request.method == "GET":
            valeur_select_dictionnaire = {"value_id_produit": id_genre_delete}
            print(id_genre_delete, type(id_genre_delete))

            str_sql_genres_films_delete = """SELECT *
                        FROM t_fournisseur_produit
                        INNER JOIN t_fournisseur ON t_fournisseur_produit.fk_fournisseur = t_fournisseur.id_fournisseur
                        INNER JOIN t_produit ON t_fournisseur_produit.fk_produit = t_produit.id_produit
                        WHERE fk_produit = %(value_id_produit)s;
                        """

            with DBconnection() as mydb_conn:
                mydb_conn.execute(str_sql_genres_films_delete, valeur_select_dictionnaire)
                data_films_attribue_genre_delete = mydb_conn.fetchall()
                print("data_films_attribue_genre_delete...", data_films_attribue_genre_delete)
                session['data_films_attribue_genre_delete'] = data_films_attribue_genre_delete

                str_sql_id_produit = "SELECT * FROM t_produit WHERE id_produit = %(value_id_produit)s"
                mydb_conn.execute(str_sql_id_produit, valeur_select_dictionnaire)
                data_nom_produit = mydb_conn.fetchone()
                if data_nom_produit is None:
                    flash("Le produit demandé n'existe pas.", "danger")
                    return redirect(url_for('genres_afficher', order_by="ASC", id_genre_sel=0))
                print("data_nom_produit ", data_nom_produit, " type ", type(data_nom_produit), " genre ",
                      data_nom_produit["nom_produit"])

            form_delete.nom_genre_delete_wtf.data = data_nom_produit["nom_produit"]
            btn_submit_del = False

    except Exception as Exception_genre_delete_wtf:
        raise ExceptionGenreDeleteWtf(f"fichier : {Path(__file__).name}  ;  "
                                      f"{genre_delete_wtf.__name__} ; "
                                      f"{Exception_genre_delete_wtf}")

    return render_template("genres/genre_delete_wtf.html",
                           form_delete=form_delete,
                           btn_submit_del=btn_submit_del,
                           data_films_associes=data_films_attribue_genre_delete)
