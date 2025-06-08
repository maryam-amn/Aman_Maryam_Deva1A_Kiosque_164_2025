# Kiosque Fournisseurs/Produits – Module 164

Ce projet est une application web Flask permettant de gérer des fournisseurs et leurs produits, avec une interface moderne basée sur Bootstrap.

## Fonctionnalités principales

- **Gestion des fournisseurs** : Ajouter, modifier, supprimer des fournisseurs.
- **Gestion des produits** : Ajouter, modifier, supprimer des produits.
- **Association fournisseurs/produits** : Lier des produits à des fournisseurs via une interface intuitive.
- **Affichage dynamique** : Listes, filtres, recherche, et affichage des relations.
- **Interface responsive** : Utilisation de Bootstrap 5 pour un affichage agréable sur tous supports.

## Structure du projet

```
APP_FILMS_164/
│
├── films/                  # Routes et logique pour les fournisseurs
├── films_genres/           # Routes et logique pour l'association fournisseurs/produits
├── static/                 # Fichiers CSS, JS, images
│   └── bootstrap-5.0.0...  # Bootstrap
├── templates/              # Templates HTML (Jinja2)
│   ├── base.html           # Template principal
│   └── films_genres/       # Pages pour l'association
├── gestion_films_crud.py   # CRUD fournisseurs
├── gestion_films_genres_crud.py # CRUD associations
└── ...
```

## Installation

1. **Cloner le dépôt**
   ```bash
   git clone <url_du_repo>
   cd Aman_Maryam_Deva1A_Kiosque_164_2025
   ```

2. **Créer un environnement virtuel**
   ```bash
   python -m venv .venv
   .venv\Scripts\activate
   ```

3. **Installer les dépendances**
   ```bash
   pip install -r requirements.txt
   ```

4. **Configurer la base de données**
   - Adapter les paramètres de connexion dans le code si besoin.
   - Importer le schéma SQL fourni.

5. **Lancer l’application**
   ```bash
   flask run
   ```

## Utilisation

- Accéder à l’application via [http://localhost:5000](http://localhost:5000)
- Naviguer dans les menus pour gérer fournisseurs, produits et leurs associations.

## Personnalisation

- **Couleurs et styles** : Modifier les fichiers dans `static/` ou ajouter un fichier `custom.css`.
- **Templates** : Adapter les fichiers HTML dans `templates/` selon vos besoins.

## Ressources

- [Documentation du module 164](https://info164.github.io/doc164ver1/index.html)
- [Documentation Flask](https://flask.palletsprojects.com/)
- [Documentation Bootstrap](https://getbootstrap.com/)

---

**Projet réalisé par Maryam Aman – Module 164**