-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 18-10-2025 a las 16:12:18
-- Versión del servidor: 5.7.31
-- Versión de PHP: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sisca`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menus`
--

DROP TABLE IF EXISTS `menus`;
CREATE TABLE IF NOT EXISTS `menus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(255) NOT NULL,
  `iconcls` varchar(255) DEFAULT NULL,
  `viewtype` varchar(255) NOT NULL,
  `leaf` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `menus`
--

INSERT INTO `menus` (`id`, `text`, `iconcls`, `viewtype`, `leaf`) VALUES
(1, 'Dashboardd', 'x-fa fa-desktop', 'admindashboard', 1),
(2, 'Usuario', 'x-fa fa-table', 'usuarioview', 1),
(3, 'Varios', 'x-fa fa-table', 'usuarioview', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menu_items`
--

DROP TABLE IF EXISTS `menu_items`;
CREATE TABLE IF NOT EXISTS `menu_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_id` int(11) NOT NULL,
  `text` varchar(255) NOT NULL,
  `iconCls` varchar(255) DEFAULT NULL,
  `viewType` varchar(255) NOT NULL,
  `leaf` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `menu_id` (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `menu_items`
--

INSERT INTO `menu_items` (`id`, `menu_id`, `text`, `iconCls`, `viewType`, `leaf`) VALUES
(1, 3, 'ejemplo1', 'x-fa fa-table', 'reporte', 1),
(2, 3, 'ejemplo2', 'x-fa fa-table', 'reporte', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sub_menus`
--

DROP TABLE IF EXISTS `sub_menus`;
CREATE TABLE IF NOT EXISTS `sub_menus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_item_id` int(11) NOT NULL,
  `text` varchar(255) NOT NULL,
  `iconCls` varchar(255) DEFAULT NULL,
  `viewType` varchar(255) NOT NULL,
  `leaf` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `menu_item_id` (`menu_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` longtext,
  `email` longtext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `email`) VALUES
(1, 'jaider ponce', 'jaiderponce@gmail.com'),
(2, 'romairi55', 'jjjjja@gmail.com'),
(11, 'prueba jaider', 'ponceqqqqqqq@gmaol.com'),
(9, 'jgjfgjfgjf', 'jaider@gmail.com'),
(19, 'jfjfjfgjfgj', 'fhdhdfhdfh@gmail.com'),
(12, 'hdfhdfhdhfd', 'prueba@gmail.com'),
(13, 'pueba final', 'jaiderpobneq@gmail.com'),
(16, 'jjjjjjaider', 'hhh@gmail.com');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
