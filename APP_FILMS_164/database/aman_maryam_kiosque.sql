-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 02 avr. 2025 à 11:32
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
DROP DATABASE IF EXISTS `aman_maryam_kiosque`;

--
-- Base de données : `aman_maryam_kiosque`
--
CREATE DATABASE IF NOT EXISTS `aman_maryam_kiosque` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `aman_maryam_kiosque`;

-- --------------------------------------------------------

--
-- Structure de la table `t_client`
--

Corrige DROP TABLE IF EXISTS `t_client`;
CREATE TABLE IF NOT EXISTS `t_client` (
  `Id_client` int(11) NOT NULL,
  `téléphone` varchar(11) NOT NULL,
  `Email` varchar(250) NOT NULL,
  `prénom` varchar(42) DEFAULT NULL,
  `Nom` varchar(42) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `t_employé`
--

DROP TABLE IF EXISTS `t_employé`;
CREATE TABLE IF NOT EXISTS `t_employé` (
  `id_employé` int(11) NOT NULL,
  `nom` varchar(42) DEFAULT NULL,
  `prénom` varchar(42) DEFAULT NULL,
  `poste` varchar(30) DEFAULT NULL,
  `date_de_début` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `t_fournisseur`
--

DROP TABLE IF EXISTS `t_fournisseur`;
CREATE TABLE IF NOT EXISTS `t_fournisseur` (
  `id_fournisseur` int(11) NOT NULL,
  `nom_entreprise` int(11) NOT NULL,
  `adresse_entreprise` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `t_produit`
--

DROP TABLE IF EXISTS `t_produit`;
CREATE TABLE IF NOT EXISTS `t_produit` (
  `id_produit` int(11) NOT NULL,AUTO_INCREMENT PRIMARY KEY
  `nom_produit` varchar(30) DEFAULT NULL,
  `stock_actuel` int(11) NOT NULL,
  `prix_produit` float DEFAULT NULL,
  `categorie_produit` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `t_produit` (`nom_produit`, `stock_actuel`, `prix_produit`, `categorie_produit`) VALUES
('Pommes', 100, 1.99, 'Fruits'),
('Tomates', 50, 2.49, 'Légumes'),
('Pain Blanc', 200, 1.29, 'Boulangerie'),
('Fromage Cheddar', 75, 5.99, 'Produits Laitiers'),
('Poulet Entier', 30, 6.99, 'Viande'),
('Riz Blanc', 150, 1.79, 'Céréales'),
('Lait Entier', 100, 2.49, 'Produits Laitiers');
-- --------------------------------------------------------

--
-- Structure de la table `t_vente`
--

DROP TABLE IF EXISTS `t_vente`;
CREATE TABLE IF NOT EXISTS `t_vente` (
  `id_vente` int(11) NOT NULL,
  `date_vente` date NOT NULL,
  `montant_totale` varchar(15) DEFAULT NULL,
  `mode_paiment` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
