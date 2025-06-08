from flask_wtf import FlaskForm
from wtforms import StringField, TextAreaField, SubmitField
from wtforms.validators import DataRequired, Length

class FormWTFAjouterCategorie(FlaskForm):
    nom_categorie = StringField(
        "Nom de la catégorie",
        validators=[DataRequired(), Length(min=2, max=50)]
    )
    description = TextAreaField(
        "Description",
        validators=[Length(max=255)]
    )
    submit = SubmitField("Ajouter")

class FormWTFDeleteCategorie(FlaskForm):
    """
        Dans le formulaire "genre_delete_wtf.html"

        nom_genre_delete_wtf : Champ qui reçoit la valeur du genre, lecture seule. (readonly=true)
        submit_btn_del : Bouton d'effacement "DEFINITIF".
        submit_btn_conf_del : Bouton de confirmation pour effacer un "genre".
        submit_btn_annuler : Bouton qui permet d'afficher la table "t_genre".
    """
    categorie_delete_wtf = StringField("Effacer cette catégorie")
    submit_btn_del = SubmitField("Effacer la catégorie")
    submit_btn_conf_del = SubmitField("Etes-vous sur d'effacer ?")
    submit_btn_annuler = SubmitField("Annuler")