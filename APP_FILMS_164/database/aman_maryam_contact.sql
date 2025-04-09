-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 21, 2024 at 08:43 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
DROP DATABASE IF EXISTS `aman_maryam_contact`;
--
-- Database: `aman_maryam_contact`
--
CREATE DATABASE IF NOT EXISTS `aman_maryam_contact` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `aman_maryam_contact`;

-- --------------------------------------------------------

--
-- Table structure for table `id_per`
--

DROP TABLE IF EXISTS `id_per`;
CREATE TABLE IF NOT EXISTS `id_per` (
  `id_personne` int(11) NOT NULL,
  `nom_per` varchar(30) DEFAULT NULL,
  `prenom_per` varchar(40) DEFAULT NULL,
  `date_de_nais_per` datetime DEFAULT NULL,
  PRIMARY KEY (`id_personne`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `id_per`
--

INSERT INTO `id_per` (`id_personne`, `nom_per`, `prenom_per`, `date_de_nais_per`) VALUES
(1, 'Dupont', 'Jean', '1990-05-15 00:00:00'),
(2, 'Martin', 'Alice', '1985-11-22 00:00:00'),
(3, 'Bernard', 'Luc', '1978-03-30 00:00:00'),
(4, 'Leroy', 'Sophie', '1992-09-08 00:00:00'),
(5, 'Dubois', 'Paul', '1980-07-17 00:00:00'),
(6, 'Durand', 'Claire', '1993-01-12 00:00:00'),
(7, 'Lemoine', 'Marc', '1989-05-25 00:00:00'),
(8, 'Petit', 'Emma', '1995-08-30 00:00:00'),
(9, 'Rousseau', 'Lucas', '1991-03-18 00:00:00'),
(10, 'Morel', 'Chloé', '1987-11-02 00:00:00'),
(11, 'Fournier', 'Julien', '1994-07-22 00:00:00'),
(12, 'Girard', 'Anaïs', '1996-09-14 00:00:00'),
(13, 'Chevalier', 'Thomas', '1983-12-01 00:00:00'),
(14, 'Blanc', 'Juliette', '1998-04-20 00:00:00'),
(15, 'Garnier', 'Antoine', '1992-06-10 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `p_personnne`
--

DROP TABLE IF EXISTS `p_personnne`;
CREATE TABLE IF NOT EXISTS `p_personnne` (
  `id_personne` int(11) NOT NULL,
  `nom_per` varchar(42) DEFAULT NULL,
  `prenom_per` varchar(42) DEFAULT NULL,
  `date_de_nais_per` date DEFAULT NULL,
  `telephone` int(20) NOT NULL,
  PRIMARY KEY (`id_personne`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `p_personnne`
--

INSERT INTO `p_personnne` (`id_personne`, `nom_per`, `prenom_per`, `date_de_nais_per`, `telephone`) VALUES
(1, 'Dupont', 'Jean', '1990-05-15', 612345678),
(2, 'Martin', 'Alice', '1985-11-22', 612345679),
(3, 'Bernard', 'Luc', '1978-03-30', 612345680),
(4, 'Leroy', 'Sophie', '1992-09-08', 612345681),
(5, 'Dubois', 'Paul', '1980-07-17', 612345682),
(6, 'Durand', 'Claire', '1993-01-12', 612345683),
(7, 'Lemoine', 'Marc', '1989-05-25', 612345684),
(8, 'Petit', 'Emma', '1995-08-30', 612345685),
(9, 'Rousseau', 'Lucas', '1991-03-18', 612345686),
(10, 'Morel', 'Chloé', '1987-11-02', 612345687),
(11, 'Fournier', 'Julien', '1994-07-22', 612345688),
(12, 'Girard', 'Anaïs', '1996-09-14', 612345689),
(13, 'Chevalier', 'Thomas', '1983-12-01', 612345690),
(14, 'Blanc', 'Juliette', '1998-04-20', 612345691),
(15, 'Garnier', 'Antoine', '0000-00-00', 612345692);

-- --------------------------------------------------------

--
-- Table structure for table `t_adresse`
--

DROP TABLE IF EXISTS `t_adresse`;
CREATE TABLE IF NOT EXISTS `t_adresse` (
  `id_adresse` int(11) NOT NULL AUTO_INCREMENT,
  `id_personne` int(11) NOT NULL,
  `rue` varchar(100) DEFAULT NULL,
  `ville` varchar(50) DEFAULT NULL,
  `code_postal` int(10) DEFAULT NULL,
  PRIMARY KEY (`id_adresse`),
  KEY `id_personne` (`id_personne`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `t_adresse`
--

INSERT INTO `t_adresse` (`id_adresse`, `id_personne`, `rue`, `ville`, `code_postal`) VALUES
(1, 1, '10 Rue de Paris', 'Paris', 75001),
(2, 2, '15 Avenue de Lyon', 'Lyon', 69002),
(3, 3, '20 Boulevard Saint-Michel', 'Marseille', 13003),
(4, 4, '25 Place de la République', 'Nantes', 44004),
(5, 5, '30 Rue de Strasbourg', 'Strasbourg', 67005),
(6, 6, '35 Rue de Lille', 'Lille', 59006),
(7, 7, '40 Rue de Nice', 'Nice', 6007),
(8, 8, '45 Rue de Bordeaux', 'Bordeaux', 33008),
(9, 9, '50 Rue de Toulouse', 'Toulouse', 31009),
(10, 10, '55 Rue de Montpellier', 'Montpellier', 34010),
(11, 11, '60 Rue de Rennes', 'Rennes', 35011),
(12, 12, '65 Rue de Dijon', 'Dijon', 21012),
(13, 13, '70 Rue de Clermont-Ferrand', 'Clermont-Ferrand', 63013),
(14, 14, '75 Rue de Caen', 'Caen', 14014),
(15, 15, '80 Rue d\'Amiens', 'Amiens', 80015);

-- --------------------------------------------------------

--
-- Table structure for table `t_personnne`
--

DROP TABLE IF EXISTS `t_personnne`;
CREATE TABLE IF NOT EXISTS `t_personnne` (
  `id_personne` int(11) NOT NULL,
  `nom_per` varchar(42) DEFAULT NULL,
  `prenom_per` varchar(42) DEFAULT NULL,
  `date_de_nais_per` date DEFAULT NULL,
  PRIMARY KEY (`id_personne`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `t_personnne`
--

INSERT INTO `t_personnne` (`id_personne`, `nom_per`, `prenom_per`, `date_de_nais_per`) VALUES
(1, 'Dupont', 'Jean', '0000-00-00'),
(2, 'Martin', 'Alice', '0000-00-00'),
(3, 'Bernard', 'Luc', '0000-00-00'),
(4, 'Leroy', 'Sophie', '0000-00-00'),
(5, 'Dubois', 'Paul', '0000-00-00'),
(6, 'Durand', 'Claire', '0000-00-00'),
(7, 'Lemoine', 'Marc', '0000-00-00'),
(8, 'Petit', 'Emma', '0000-00-00'),
(9, 'Rousseau', 'Lucas', '0000-00-00'),
(10, 'Morel', 'Chloé', '0000-00-00'),
(11, 'Fournier', 'Julien', '0000-00-00'),
(12, 'Girard', 'Anaïs', '0000-00-00'),
(13, 'Chevalier', 'Thomas', '0000-00-00'),
(14, 'Blanc', 'Juliette', '0000-00-00'),
(15, 'Garnier', 'Antoine', '0000-00-00');

-- --------------------------------------------------------

--
-- Table structure for table `t_per_mail`
--

DROP TABLE IF EXISTS `t_per_mail`;
CREATE TABLE IF NOT EXISTS `t_per_mail` (
  `t_mail` varchar(250) NOT NULL,
  `mail` int(11) NOT NULL,
  PRIMARY KEY (`t_mail`),
  KEY `mail` (`mail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `t_per_mail`
--

INSERT INTO `t_per_mail` (`t_mail`, `mail`) VALUES
('jean.dupont@example.com', 1),
('alice.martin@example.com', 2),
('luc.bernard@example.com', 3),
('sophie.leroy@example.com', 4),
('paul.dubois@example.com', 5),
('claire.durand@example.com', 6),
('marc.lemoine@example.com', 7),
('emma.petit@example.com', 8),
('lucas.rousseau@example.com', 9),
('chloe.morel@example.com', 10),
('julien.fournier@example.com', 11),
('anais.girard@example.com', 12),
('thomas.chevalier@example.com', 13),
('juliette.blanc@example.com', 14),
('antoine.garnier@example.com', 15);

-- --------------------------------------------------------

--
-- Table structure for table `t_profession`
--

DROP TABLE IF EXISTS `t_profession`;
CREATE TABLE IF NOT EXISTS `t_profession` (
  `id_profession` int(11) NOT NULL AUTO_INCREMENT,
  `id_personne` int(11) NOT NULL,
  `intitule` varchar(100) DEFAULT NULL,
  `entreprise` varchar(100) DEFAULT NULL,
  `date_debut` date DEFAULT NULL,
  `id_personne_t_personnne` int(11) DEFAULT NULL,
  `id_reference` int(11) NOT NULL,
  PRIMARY KEY (`id_profession`),
  KEY `id_personne` (`id_personne`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `t_profession`
--

INSERT INTO `t_profession` (`id_profession`, `id_personne`, `intitule`, `entreprise`, `date_debut`, `id_personne_t_personnne`, `id_reference`) VALUES
(1, 0, '[Ingénieur]', '[TechCorp]', '0000-00-00', NULL, 0),
(2, 0, '[Médecin]', '[Hôpital Central]', '0000-00-00', NULL, 0),
(3, 0, '[Professeur]', '[Université de Paris]', '0000-00-00', NULL, 0),
(4, 0, '[Architecte]', '[Bureau d\'études]', '0000-00-00', NULL, 0),
(5, 0, '[Artiste]', '[Galerie d\'art]', '0000-00-00', NULL, 0),
(6, 0, '[Développeur]', '[Start-up Innovante]', '0000-00-00', NULL, 0),
(7, 0, '[Chef de projet]', '[Entreprise X]', '0000-00-00', NULL, 0),
(8, 0, '[Journaliste]', '[Média Y]', '0000-00-00', NULL, 0),
(9, 0, '[Comptable]', '[Cabinet Z]', '0000-00-00', NULL, 0),
(10, 0, '[Vétérinaire]', '[Clinique Animale A]', '0000-00-00', NULL, 0),
(11, 0, '[Pharmacien]', '[Pharmacie B]', '0000-00-00', NULL, 0),
(12, 0, '[Designer]', '[Agence C]', '0000-00-00', NULL, 0),
(13, 0, '[Consultant]', '[Société D]', '0000-00-00', NULL, 0),
(14, 0, '[Responsable marketing]', '[Entreprise E]', '0000-00-00', NULL, 0),
(15, 0, '[Analyste financier]', '[Banque F]', '0000-00-00', NULL, 0);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `t_adresse`
--
ALTER TABLE `t_adresse`
  ADD CONSTRAINT `t_adresse_ibfk_1` FOREIGN KEY (`id_personne`) REFERENCES `id_per` (`id_personne`);

--
-- Constraints for table `t_personnne`
--
ALTER TABLE `t_personnne`
  ADD CONSTRAINT `t_personnne_ibfk_1` FOREIGN KEY (`id_personne`) REFERENCES `id_per` (`id_personne`);

--
-- Constraints for table `t_per_mail`
--
ALTER TABLE `t_per_mail`
  ADD CONSTRAINT `t_per_mail_ibfk_1` FOREIGN KEY (`mail`) REFERENCES `id_per` (`id_personne`),
  ADD CONSTRAINT `t_per_mail_ibfk_2` FOREIGN KEY (`mail`) REFERENCES `t_personnne` (`id_personne`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
