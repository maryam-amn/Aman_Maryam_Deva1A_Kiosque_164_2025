-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 07, 2025 at 12:45 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `aman_maryam_kiosque`
--
CREATE DATABASE IF NOT EXISTS `aman_maryam_kiosque` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `aman_maryam_kiosque`;

-- --------------------------------------------------------

--
-- Table structure for table `t_categorie`
--

DROP TABLE IF EXISTS `t_categorie`;
CREATE TABLE IF NOT EXISTS `t_categorie` (
  `id_categorie` int(11) NOT NULL AUTO_INCREMENT,
  `nom_categorie` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_categorie`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `t_categorie`
--

INSERT INTO `t_categorie` (`id_categorie`, `nom_categorie`, `description`) VALUES
(1, 'Fruits', 'Fruits frais, locaux ou exotiques, pour tous les goûts.'),
(2, 'Légumes', 'Légumes frais, de saison, riches en vitamines et minéraux.'),
(3, 'Boulangerie', 'Pains, viennoiseries et pâtisseries artisanales.'),
(4, 'Produits Laitiers', 'Lait, fromages, yaourts et autres produits laitiers.'),
(5, 'Viande', 'Viandes fraîches et de qualité pour tous vos plats.'),
(6, 'Céréales', 'Grains, flocons et produits céréaliers pour une alimentation équilibrée.');

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
  PRIMARY KEY (`id_produit`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `t_produit`
--

INSERT INTO `t_produit` (`id_produit`, `nom_produit`, `stock_actuel`, `prix_produit`) VALUES
(1, 'Pommes', 100, 1.99),
(2, 'Tomates', 50, 2.49),
(3, 'Pain Blanc', 200, 1.29),
(4, 'Fromage Cheddar', 75, 5.99),
(5, 'Poulet Entier', 30, 6.99),
(6, 'Riz Blanc', 150, 1.79),
(7, 'Lait Entier', 100, 2.49),
(14, 'pains', 2, 3.2),
(15, 'raisins', 2, 5);

-- --------------------------------------------------------

--
-- Table structure for table `t_produit_catégorie`
--

DROP TABLE IF EXISTS `t_produit_catégorie`;
CREATE TABLE IF NOT EXISTS `t_produit_catégorie` (
  `id_produit_categorie` int(11) NOT NULL AUTO_INCREMENT,
  `fk_produit` int(11) NOT NULL,
  `fk_categorie` int(11) NOT NULL,
  `date_insert_produit` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id_produit_categorie`),
  KEY `fk_produit_pc` (`fk_produit`),
  KEY `fk_categorie_pc` (`fk_categorie`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `t_produit_catégorie`
--

INSERT INTO `t_produit_catégorie` (`id_produit_categorie`, `fk_produit`, `fk_categorie`, `date_insert_produit`) VALUES
(1, 1, 1, '2025-06-07 08:12:07'),
(3, 2, 2, '2025-06-07 08:14:26'),
(4, 3, 3, '2025-06-07 08:14:26'),
(5, 4, 4, '2025-06-07 08:14:26'),
(6, 5, 5, '2025-06-07 08:14:26'),
(7, 6, 6, '2025-06-07 08:14:26'),
(8, 2, 2, '2025-06-07 08:14:34'),
(9, 3, 3, '2025-06-07 08:14:34'),
(10, 4, 4, '2025-06-07 08:14:34'),
(11, 5, 5, '2025-06-07 08:14:34'),
(12, 6, 6, '2025-06-07 08:14:34'),
(13, 7, 4, '2025-06-07 08:14:34');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `t_fournisseur_produit`
--
ALTER TABLE `t_fournisseur_produit`
  ADD CONSTRAINT `fk_fournisseur` FOREIGN KEY (`fk_fournisseur`) REFERENCES `t_fournisseur` (`id_fournisseur`),
  ADD CONSTRAINT `fk_produit` FOREIGN KEY (`fk_produit`) REFERENCES `t_produit` (`id_produit`);

--
-- Constraints for table `t_produit_catégorie`
--
ALTER TABLE `t_produit_catégorie`
  ADD CONSTRAINT `fk_categorie_pc` FOREIGN KEY (`fk_categorie`) REFERENCES `t_categorie` (`id_categorie`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_produit_pc` FOREIGN KEY (`fk_produit`) REFERENCES `t_produit` (`id_produit`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
