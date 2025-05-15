-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 13, 2025 at 08:48 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
DROP DATABASE IF EXISTS `aman_maryam_kiosque`;

--
-- Database: `aman_maryam_kiosque`
--
CREATE DATABASE IF NOT EXISTS `aman_maryam_kiosque` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `aman_maryam_kiosque`;

-- --------------------------------------------------------

--
-- Table structure for table `t_client`
--

DROP TABLE IF EXISTS `t_client`;
CREATE TABLE IF NOT EXISTS `t_client` (
  `Id_client` int(11) NOT NULL,
  `téléphone` varchar(11) NOT NULL,
  `Email` varchar(250) NOT NULL,
  `prénom` varchar(42) DEFAULT NULL,
  `Nom` varchar(42) DEFAULT NULL,
  PRIMARY KEY (`Id_client`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `t_employé`
--

DROP TABLE IF EXISTS `t_employé`;
CREATE TABLE IF NOT EXISTS `t_employé` (
  `id_employé` int(11) NOT NULL,
  `nom` varchar(42) DEFAULT NULL,
  `prénom` varchar(42) DEFAULT NULL,
  `poste` varchar(30) DEFAULT NULL,
  `date_de_début` date NOT NULL,
  PRIMARY KEY (`id_employé`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `t_fournisseur`
--

DROP TABLE IF EXISTS `t_fournisseur`;
CREATE TABLE IF NOT EXISTS `t_fournisseur` (
  `id_fournisseur` int(11) NOT NULL AUTO_INCREMENT,
  `nom_entreprise` varchar(100) NOT NULL,
  `adresse_entreprise` varchar(200) NOT NULL,
  PRIMARY KEY (`id_fournisseur`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `t_fournisseur`
--

INSERT INTO `t_fournisseur` (`id_fournisseur`, `nom_entreprise`, `adresse_entreprise`) VALUES
(2, 'Marché Bio', '45 rue Verte, Toulouse'),
(3, 'Fromagerie Fine', '12 avenue des Alpes, Grenoble'),
(4, 'Boulangerie du Centre', '8 place de la République, Nantes'),
(5, 'Épicerie Locale', '23 boulevard Saint-Michel, Paris'),
(6, 'Fruits Exotiques', '17 rue des Palmiers, Marseille'),
(7, 'Primeur Sud', '12 rue des Pommiers, Marseille'),
(8, 'Laiterie du Nord', '8 avenue du Lait, Lille'),
(9, 'Boulangerie Centrale', '3 place du Pain, Lyon');

-- --------------------------------------------------------

--
-- Table structure for table `t_fournisseur_produit`
--

DROP TABLE IF EXISTS `t_fournisseur_produit`;
CREATE TABLE IF NOT EXISTS `t_fournisseur_produit` (
  `id_fournisseur_produit` int(11) NOT NULL AUTO_INCREMENT,
  `fk_fournisseur` int(11) DEFAULT NULL,
  `fk_produit` int(11) DEFAULT NULL,
  `date_insert_fournisseur_produit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_fournisseur_produit`),
  KEY `fk_fournisseur` (`fk_fournisseur`),
  KEY `fk_produit` (`fk_produit`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `t_fournisseur_produit`
--

INSERT INTO `t_fournisseur_produit` (`id_fournisseur_produit`, `fk_fournisseur`, `fk_produit`, `date_insert_fournisseur_produit`) VALUES
(1, 2, 1, '2024-05-01 08:00:00'),
(2, 3, 2, '2024-05-01 08:10:00'),
(3, 4, 3, '2024-05-01 08:20:00'),
(4, 2, 3, '2024-05-01 08:30:00'),
(5, 5, 4, '2024-05-01 09:00:00'),
(6, 6, 1, '2024-05-01 09:10:00'),
(7, 3, 5, '2024-05-01 09:20:00');

-- --------------------------------------------------------

--
-- Table structure for table `t_produit`
--

DROP TABLE IF EXISTS `t_produit`;
CREATE TABLE IF NOT EXISTS `t_produit` (
  `id_produit` int(11) NOT NULL AUTO_INCREMENT,
  `nom_produit` varchar(30) DEFAULT NULL,
  `stock_actuel` int(11) NOT NULL,
  `prix_produit` float DEFAULT NULL,
  `categorie_produit` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_produit`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `t_produit`
--

INSERT INTO `t_produit` (`id_produit`, `nom_produit`, `stock_actuel`, `prix_produit`, `categorie_produit`) VALUES
(1, 'Pommes', 100, 1.99, 'Fruits'),
(2, 'Tomates', 50, 2.49, 'Légumes'),
(3, 'Pain Blanc', 200, 1.29, 'Boulangerie'),
(4, 'Fromage Cheddar', 75, 5.99, 'Produits Laitiers'),
(5, 'Poulet Entier', 30, 6.99, 'Viande'),
(6, 'Riz Blanc', 150, 1.79, 'Céréales'),
(7, 'Lait Entier', 100, 2.49, 'Produits Laitiers'),
(14, 'pains', 0, NULL, NULL),
(15, 'raisins', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `t_produit_catégorie`
--

DROP TABLE IF EXISTS `t_produit_catégorie`;
CREATE TABLE IF NOT EXISTS `t_produit_catégorie` (
  `id_produit_categorie` int(11) NOT NULL,
  `fk_produit` int(11) NOT NULL,
  `fk_categorie` int(11) NOT NULL,
  `date_insert_produit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `t_vente`
--

DROP TABLE IF EXISTS `t_vente`;
CREATE TABLE IF NOT EXISTS `t_vente` (
  `id_vente` int(11) NOT NULL,
  `date_vente` date NOT NULL,
  `montant_totale` varchar(15) DEFAULT NULL,
  `mode_paiment` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_vente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `t_fournisseur_produit`
--
ALTER TABLE `t_fournisseur_produit`
  ADD CONSTRAINT `fk_fournisseur` FOREIGN KEY (`fk_fournisseur`) REFERENCES `t_fournisseur` (`id_fournisseur`),
  ADD CONSTRAINT `fk_produit` FOREIGN KEY (`fk_produit`) REFERENCES `t_produit` (`id_produit`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
