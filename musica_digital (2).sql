-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 24-05-2024 a las 17:58:41
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `musica_digital`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `activarCuenta` (IN `idEstudiante` INT)   BEGIN
    UPDATE estudiante
    SET estado_estudiante = 1
    WHERE id_estudiante = idEstudiante;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerIdEstudiantePorCorreo` (IN `p_correo_electronico` VARCHAR(255))   BEGIN
    DECLARE v_id_estudiante INT;

    SELECT id_estudiante INTO v_id_estudiante
    FROM estudiante
    WHERE correo_electronico = p_correo_electronico;

    SELECT v_id_estudiante AS id_estudiante;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aporte`
--

CREATE TABLE `aporte` (
  `id_aporte` int(6) NOT NULL,
  `fecha_aporte` date NOT NULL,
  `monto` float NOT NULL,
  `id_inscripcion` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso`
--

CREATE TABLE `curso` (
  `id_curso` int(6) NOT NULL,
  `descripcion_curso` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_inscripcion`
--

CREATE TABLE `estado_inscripcion` (
  `id_estado_inscripcion` int(3) NOT NULL,
  `descripcion_estado_inscripcion` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiante`
--

CREATE TABLE `estudiante` (
  `id_estudiante` int(6) NOT NULL,
  `correo_electronico` varchar(255) NOT NULL,
  `contrasena_estudiante` text NOT NULL,
  `nombre1` varchar(50) NOT NULL,
  `nombre2` varchar(50) DEFAULT NULL,
  `apellido1` varchar(50) NOT NULL,
  `apellido2` varchar(50) DEFAULT NULL,
  `estado_estudiante` tinyint(1) NOT NULL,
  `nombre_usuario` varchar(50) DEFAULT NULL,
  `avatar` text DEFAULT NULL,
  `edad` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estudiante`
--

INSERT INTO `estudiante` (`id_estudiante`, `correo_electronico`, `contrasena_estudiante`, `nombre1`, `nombre2`, `apellido1`, `apellido2`, `estado_estudiante`, `nombre_usuario`, `avatar`, `edad`) VALUES
(29, 'nicompj@gmail.com', '$2y$10$PgC8ghY1z9LgkFW84f1hku.AXsfrfTpXMMNS2vjb8yQF6FCmibS7a', 'nicolas', 'mateo', 'prieto', 'jimenez', 1, '', '', 20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inscripcion`
--

CREATE TABLE `inscripcion` (
  `id_inscripcion` int(6) NOT NULL,
  `fecha_inscripcion` date NOT NULL,
  `id_estudiante` int(6) NOT NULL,
  `id_modulo` int(6) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `progreso` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`progreso`)),
  `id_estado_inscripcion` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modulo`
--

CREATE TABLE `modulo` (
  `id_modulo` int(6) NOT NULL,
  `descripcion_modulo` varchar(50) NOT NULL,
  `contenido_modulo` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`contenido_modulo`)),
  `id_profesor` int(6) NOT NULL,
  `id_curso` int(6) NOT NULL,
  `id_nivel` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nivel`
--

CREATE TABLE `nivel` (
  `id_nivel` int(6) NOT NULL,
  `descripcion_nivel` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pin_verificacion`
--

CREATE TABLE `pin_verificacion` (
  `id_pin_verificacion` int(6) NOT NULL,
  `pin` int(6) NOT NULL,
  `fecha_creacion_pin` datetime NOT NULL,
  `id_estudiante` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pin_verificacion`
--

INSERT INTO `pin_verificacion` (`id_pin_verificacion`, `pin`, `fecha_creacion_pin`, `id_estudiante`) VALUES
(4, 950511, '2024-05-20 23:33:12', 29);

--
-- Disparadores `pin_verificacion`
--
DELIMITER $$
CREATE TRIGGER `before_insert_pin_verificacion` BEFORE INSERT ON `pin_verificacion` FOR EACH ROW BEGIN
    SET NEW.fecha_creacion_pin = CURRENT_TIMESTAMP;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesor`
--

CREATE TABLE `profesor` (
  `id_profesor` int(6) NOT NULL,
  `correo_profesor` varchar(50) DEFAULT NULL,
  `contrasena_profesor` text DEFAULT NULL,
  `nombre1_profesor` varchar(50) DEFAULT NULL,
  `nombre2_profesor` varchar(50) DEFAULT NULL,
  `apellido1_profesor` varchar(50) DEFAULT NULL,
  `apellido2_profesor` varchar(50) DEFAULT NULL,
  `estado_profesor` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `aporte`
--
ALTER TABLE `aporte`
  ADD KEY `id_estudiante` (`id_inscripcion`);

--
-- Indices de la tabla `curso`
--
ALTER TABLE `curso`
  ADD PRIMARY KEY (`id_curso`);

--
-- Indices de la tabla `estado_inscripcion`
--
ALTER TABLE `estado_inscripcion`
  ADD PRIMARY KEY (`id_estado_inscripcion`);

--
-- Indices de la tabla `estudiante`
--
ALTER TABLE `estudiante`
  ADD PRIMARY KEY (`id_estudiante`),
  ADD UNIQUE KEY `correo_electronico` (`correo_electronico`);

--
-- Indices de la tabla `inscripcion`
--
ALTER TABLE `inscripcion`
  ADD PRIMARY KEY (`id_inscripcion`),
  ADD KEY `id_estudiante` (`id_estudiante`,`id_modulo`),
  ADD KEY `id_modulo` (`id_modulo`),
  ADD KEY `id_estado_inscripcion` (`id_estado_inscripcion`);

--
-- Indices de la tabla `modulo`
--
ALTER TABLE `modulo`
  ADD PRIMARY KEY (`id_modulo`),
  ADD KEY `id_profesor` (`id_profesor`),
  ADD KEY `id_curso` (`id_curso`,`id_nivel`),
  ADD KEY `id_nivel` (`id_nivel`);

--
-- Indices de la tabla `nivel`
--
ALTER TABLE `nivel`
  ADD PRIMARY KEY (`id_nivel`);

--
-- Indices de la tabla `pin_verificacion`
--
ALTER TABLE `pin_verificacion`
  ADD PRIMARY KEY (`id_pin_verificacion`),
  ADD KEY `id_estudiante` (`id_estudiante`);

--
-- Indices de la tabla `profesor`
--
ALTER TABLE `profesor`
  ADD PRIMARY KEY (`id_profesor`),
  ADD UNIQUE KEY `correo_profesor` (`correo_profesor`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `curso`
--
ALTER TABLE `curso`
  MODIFY `id_curso` int(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estado_inscripcion`
--
ALTER TABLE `estado_inscripcion`
  MODIFY `id_estado_inscripcion` int(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estudiante`
--
ALTER TABLE `estudiante`
  MODIFY `id_estudiante` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de la tabla `modulo`
--
ALTER TABLE `modulo`
  MODIFY `id_modulo` int(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `nivel`
--
ALTER TABLE `nivel`
  MODIFY `id_nivel` int(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pin_verificacion`
--
ALTER TABLE `pin_verificacion`
  MODIFY `id_pin_verificacion` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `profesor`
--
ALTER TABLE `profesor`
  MODIFY `id_profesor` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `aporte`
--
ALTER TABLE `aporte`
  ADD CONSTRAINT `aporte_ibfk_1` FOREIGN KEY (`id_inscripcion`) REFERENCES `inscripcion` (`id_inscripcion`);

--
-- Filtros para la tabla `inscripcion`
--
ALTER TABLE `inscripcion`
  ADD CONSTRAINT `inscripcion_ibfk_1` FOREIGN KEY (`id_modulo`) REFERENCES `modulo` (`id_modulo`),
  ADD CONSTRAINT `inscripcion_ibfk_2` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiante` (`id_estudiante`),
  ADD CONSTRAINT `inscripcion_ibfk_3` FOREIGN KEY (`id_estado_inscripcion`) REFERENCES `estado_inscripcion` (`id_estado_inscripcion`);

--
-- Filtros para la tabla `modulo`
--
ALTER TABLE `modulo`
  ADD CONSTRAINT `modulo_ibfk_1` FOREIGN KEY (`id_profesor`) REFERENCES `profesor` (`id_profesor`),
  ADD CONSTRAINT `modulo_ibfk_2` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id_curso`),
  ADD CONSTRAINT `modulo_ibfk_3` FOREIGN KEY (`id_nivel`) REFERENCES `nivel` (`id_nivel`);

--
-- Filtros para la tabla `pin_verificacion`
--
ALTER TABLE `pin_verificacion`
  ADD CONSTRAINT `pin_verificacion_ibfk_1` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiante` (`id_estudiante`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
