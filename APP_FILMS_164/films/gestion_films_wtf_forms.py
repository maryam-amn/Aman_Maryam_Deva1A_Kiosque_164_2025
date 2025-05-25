"""Gestion des formulaires avec WTF pour les films
Fichier : gestion_films_wtf_forms.py
Auteur : OM 2022.04.11

"""
from flask_wtf import FlaskForm
from wtforms import StringField, IntegerField, DateField
from wtforms import SubmitField, HiddenField
from wtforms.validators import Length, InputRequired, NumberRange, DataRequired
from wtforms.validators import Regexp
from wtforms.widgets import TextArea


class FormWTFAddFilm(FlaskForm):
    """
        Dans le formulaire "genres_ajouter_wtf.html" on impose que le champ soit rempli.
        Définition d'un "bouton" submit avec un libellé personnalisé.
    """
    nom_entreprise_ajouter_regexp = r'^[A-Za-zÀ-ÿ0-9\s\'\-,./()#@&]+$'
    addresse_entreprise_ajouter_regexp =  r'^[A-Za-zÀ-ÿ0-9\s\'-]+$' 
    nom_fournisseur_add_wtf = StringField(
        "Nom du fournisseur",
        validators=[
            Length(min=2, max=20, message="min 2 max 20"),
            Regexp(
                nom_entreprise_ajouter_regexp,
                message="Caractères spéciaux autorisés : - , . / ( ) # @"
            )
        ]
    )
    addresse_entreprise_add_wtf = StringField(
        "Adresse du fournisseur",
        validators=[
            Length(min=2, max=20, message="min 2 max 20"),
            Regexp(
                addresse_entreprise_ajouter_regexp,
                message="Pas de chiffres, de caractères spéciaux, d'espace à double, de double apostrophe, de double trait union"
            )
        ]
    )

    submit = SubmitField("Enregistrer film")


class FormWTFUpdateFilm(FlaskForm):
    """
        Dans le formulaire "film_update_wtf.html" on impose que le champ soit rempli.
        Définition d'un "bouton" submit avec un libellé personnalisé.
    """
    id_fournisseur_update_wtf = HiddenField()

    nom_entreprise_update_regexp = r'^[A-Za-zÀ-ÿ0-9\s\'\-,./()#@&]+$'
    addresse_entreprise_update_regexp = r'^[A-Za-zÀ-ÿ0-9\s\'-]+$'
    nom_fournisseur_update_wtf = StringField(
        "Nom du produit",
        validators=[
            Length(min=2, max=40, message="min 2 max 20"),
            Regexp(
                nom_entreprise_update_regexp,
                message="Caractères spéciaux autorisés : - , . / ( ) # @"
            )
        ]
    )
    addresse_entreprise_update_wtf = StringField(
        "Catégorie du produit",
        validators=[
            Length(min=2, max=70, message="min 2 max 20"),
            Regexp(
                addresse_entreprise_update_regexp,
                message="Pas de chiffres, de caractères spéciaux, d'espace à double, de double apostrophe, de double trait union"
            )
        ]
    )

    submit = SubmitField("Update film")


class FormWTFDeleteFilm(FlaskForm):
    """
        Dans le formulaire "film_delete_wtf.html"

        nom_film_delete_wtf : Champ qui reçoit la valeur du film, lecture seule. (readonly=true)
        submit_btn_del : Bouton d'effacement "DEFINITIF".
        submit_btn_conf_del : Bouton de confirmation pour effacer un "film".
        submit_btn_annuler : Bouton qui permet d'afficher la table "t_film".
    """
    nom_film_delete_wtf = StringField("Effacer ce fournisseur")
    submit_btn_del_film = SubmitField("Effacer ce fournisseur")
    submit_btn_conf_del_film = SubmitField("Etes-vous sur d'effacer ?")
    submit_btn_annuler = SubmitField("Annuler")
