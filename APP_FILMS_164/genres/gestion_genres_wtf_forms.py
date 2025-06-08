"""
    Fichier : gestion_genres_wtf_forms.py
    Auteur : OM 2021.03.22
    Gestion des formulaires avec WTF
"""
from flask_wtf import FlaskForm
from wtforms import StringField, DateField
from wtforms import SubmitField, HiddenField, SelectField
from wtforms import DecimalField, IntegerField
from wtforms.validators import Length, InputRequired, DataRequired
from wtforms.validators import Regexp, NumberRange
from wtforms import SelectMultipleField


class FormWTFAjouterGenres(FlaskForm):
    """
        Formulaire pour ajouter un produit (genre)
    """
    nom_produit_ajouter_regexp = r'^[A-Za-zÀ-ÿ\s\'-]+$'
    stock_actuel_ajouter_regexp = r'^\d+$'
    prix_produit_ajouter_regexp = r'^\d+([.,]\d{1,2})?$'

    nom_produit_ajouter_wtf = StringField(
        "Nom du produit",
        validators=[
            Length(min=2, max=20, message="min 2 max 20"),
            Regexp(
                nom_produit_ajouter_regexp,
                message="Pas de chiffres, de caractères spéciaux, d'espace à double, de double apostrophe, de double trait union"
            )
        ]
    )
    stock_actuel_ajouter_wtf = IntegerField(
        "Stock actuel",
        validators=[
            DataRequired(message="Le stock doit être un nombre entier"),
            NumberRange(min=0, message="Le stock ne peut pas être négatif")
        ]
    )
    prix_produit_ajouter_wtf = DecimalField(
        "Prix du produit",
        places=2,
        rounding=None,
        validators=[
            DataRequired(message="Le prix doit être un nombre (ex: 10 ou 10.99)")
        ]
    )
    categorie_produit_ajouter_wtf = SelectMultipleField(
        "Catégories",
        coerce=int,  # Pour récupérer l'id de la catégorie comme un entier
        validators=[DataRequired(message="Choisissez au moins une catégorie")]
    )

    submit = SubmitField("Ajouter produit")


class FormWTFUpdateGenre(FlaskForm):
    """
        Dans le formulaire "genre_update_wtf.html" on impose que le champ soit rempli.
        Définition d'un "bouton" submit avec un libellé personnalisé.
    """
    id_produit_update_wtf = HiddenField()
    # Regex pour chaque champ
    nom_produit_update_regexp = r'^[A-Za-zÀ-ÿ\s\'-]+$'
    stock_actuel_update_regexp = r'^\d+$'
    prix_produit_update_regexp = r'^\d+([.,]\d{1,2})?$'

    # Champ nom du produit
    nom_produit_update_wtf = StringField(
        "Ecrire le produit",
        validators=[
            Length(min=2, max=20, message="min 2 max 20"),
            Regexp(
                nom_produit_update_regexp,
                message="Pas de chiffres, de caractères spéciaux, d'espace à double, de double apostrophe, de double trait union"
            )
        ]
    )

    # Champ stock actuel
    stock_actuel_update_wtf = IntegerField(
        "Ecrire le stock",
        validators=[
            DataRequired(message="Le stock doit être un nombre entier")
        ]
    )

    # Champ prix du produit
    prix_produit_update_wtf = DecimalField(
        "Ecrire le prix",
        places=2,
        validators=[
            DataRequired(message="Le prix doit être un nombre (ex: 10 ou 10.99)")
        ]
    )

    submit = SubmitField("Update genre")


class FormWTFDeleteGenre(FlaskForm):
    """
        Dans le formulaire "genre_delete_wtf.html"

        nom_genre_delete_wtf : Champ qui reçoit la valeur du genre, lecture seule. (readonly=true)
        submit_btn_del : Bouton d'effacement "DEFINITIF".
        submit_btn_conf_del : Bouton de confirmation pour effacer un "genre".
        submit_btn_annuler : Bouton qui permet d'afficher la table "t_genre".
    """
    nom_genre_delete_wtf = StringField("Effacer ce produit")
    submit_btn_del = SubmitField("Effacer produit")
    submit_btn_conf_del = SubmitField("Etes-vous sur d'effacer ?")
    submit_btn_annuler = SubmitField("Annuler")
