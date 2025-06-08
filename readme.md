# 🏪 Kiosque – Gestion des Fournisseurs, Produits et Catégories

Projet réalisé par **Maryam Aman** – Module 164

---

## 📖 Présentation

Cette application web (Flask + Bootstrap) permet de gérer efficacement les **fournisseurs**, les **produits** et leurs **catégories** pour un kiosque.  
Elle centralise les informations, facilite la gestion des relations plusieurs-à-plusieurs, et propose une interface utilisateur moderne et responsive.

---

## ✨ Fonctionnalités principales

- **Gestion des fournisseurs** : ajout, modification, suppression, consultation
- **Gestion des produits** : ajout, modification, suppression, consultation
- **Gestion des catégories** : création, modification, suppression, consultation
- **Association produits/fournisseurs** : lier et délier des produits à des fournisseurs
- **Association produits/catégories** : lier et délier des produits à des catégories


---

## 🗂️ Structure du projet



```
Aman_Maryam_Deva1A_Kiosque_164_2025/
├── app/ # Code source principal
│ ├── fournisseurs/ # Routes et logique fournisseurs
│ ├── produits/ # Routes et logique produits
│ ├── categories/ # Routes et logique catégories
│ ├── static/ # Fichiers CSS, JS, images
│ └── templates/ # Templates HTML (Jinja2)
├── gestion_fournisseurs.py # CRUD fournisseurs
├── gestion_produits.py # CRUD produits
├── gestion_categories.py # CRUD catégories
├── requirements.txt # Dépendances Python
└── README.md
```

ext

---

## 🗃️ Modèle Conceptuel de Données (MCD)

![MCD du kiosque](https://pplx-res.cloudinary.com/image/private/user_uploads/60304841/08c9995f-6606-457f-89b5-7e92e380866f/image.jpg)

- **Produit** : `id_produit`, `nom_produit`, `stock_actuel`, `prix_produit`
- **Catégorie** : `id_categorie`, `nom_categorie`, `description`
- **Fournisseur** : `id_fournisseur`, `nom_entreprise`, `adresse_entreprise`
- **Produit_Catégorie** : table de liaison (N:N)
- **Fournisseur_Produit** : table de liaison (N:N)

---

## 🚀 Installation

1. **Cloner le dépôt**
    ```
    git clone https://github.com/maryam-amn/Aman_Maryam_Deva1A_Kiosque_164_2025.git
    cd Aman_Maryam_Deva1A_Kiosque_164_2025
    ```

2. **Créer un environnement virtuel**
    ```
    python -m venv .venv
    # Sur Windows :
    .venv\Scripts\activate
    # Sur Mac/Linux :
    source .venv/bin/activate
    ```

3. **Installer les dépendances**
    ```
    pip install -r requirements.txt
    ```

4. **Configurer la base de données**
    - Adapter les paramètres de connexion dans le code si besoin.
    - Importer le schéma SQL fourni (`aman_maryam_kiosque.sql`) via phpMyAdmin ou un outil équivalent.

5. **Lancer l’application**
    ```
    flask run
    ```
    Accéder à l’application via [http://localhost:5000](http://localhost:5000)

---

## 💡 Exemples de requêtes SQL

- **Lister tous les produits avec leurs catégories**
    ```
    SELECT p.nom_produit, c.nom_categorie
    FROM t_produit p
    JOIN t_produit_catégorie pc ON p.id_produit = pc.fk_produit
    JOIN t_categorie c ON pc.fk_categorie = c.id_categorie;
    ```

- **Lister tous les fournisseurs d’un produit**
    ```
    SELECT f.nom_entreprise
    FROM t_fournisseur f
    JOIN t_fournisseur_produit fp ON f.id_fournisseur = fp.fk_fournisseur
    WHERE fp.fk_produit = ?;
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