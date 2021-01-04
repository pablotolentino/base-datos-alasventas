-- --------------------------------------------------------
-- Host:                         208.91.199.125
-- Versión del servidor:         5.6.41-84.1 - Percona Server (GPL), Release 84.1, Revision b308619
-- SO del servidor:              Linux
-- HeidiSQL Versión:             11.1.0.6116
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para alasvent_prod
DROP DATABASE IF EXISTS `alasvent_prod`;
CREATE DATABASE IF NOT EXISTS `alasvent_prod` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `alasvent_prod`;

-- Volcando estructura para tabla alasvent_prod.roles
DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `idrol` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `activo` bit(1) DEFAULT NULL,
  `orden` int(11) DEFAULT NULL,
  PRIMARY KEY (`idrol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla alasvent_prod.roles: ~2 rows (aproximadamente)
DELETE FROM `roles`;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`idrol`, `nombre`, `activo`, `orden`) VALUES
	(1, 'Administrador', b'1', 1),
	(2, 'Vendedor', b'1', 2);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

-- Volcando estructura para procedimiento alasvent_prod.sp_usuarios_buscar
DROP PROCEDURE IF EXISTS `sp_usuarios_buscar`;
DELIMITER //
CREATE PROCEDURE `sp_usuarios_buscar`(
	IN `@usuario` VARCHAR(150)
)
BEGIN
	SELECT 
	id
	,usuario
	,contrasena
	,activo
	,correoElectronico
	,eliminado
	,telefonoMovil
	,rolId
	FROM usuarios
	WHERE usuario = `@usuario`;
	
END//
DELIMITER ;

-- Volcando estructura para procedimiento alasvent_prod.usp_usuarios_actualizar
DROP PROCEDURE IF EXISTS `usp_usuarios_actualizar`;
DELIMITER //
CREATE PROCEDURE `usp_usuarios_actualizar`(
in `@id` varchar(36),
in `@usuario` varchar(150),
in `@correoElectronico` varchar(150),
in `@usuarioEdicion` varchar(36),
in `@telefonoMovil` varchar(150),
in `@rolId` int,
out `@operacionExitosa` bit
)
BEGIN
set `@operacionExitosa` = 0;
update
usuarios
	set usuario = `@usuario`,
	correoElectronico = `@correoElectronico`,
	usuarioEdicion= `@usuarioEdicion`,
	telefonoMovil= `@telefonoMovil`,
	rolId= `@rolId`
where  id = `@id`;
set `@operacionExitosa` = 1;

select `@operacionExitosa` as operacionExitosa;
END//
DELIMITER ;

-- Volcando estructura para procedimiento alasvent_prod.usp_usuarios_cambiarActivo
DROP PROCEDURE IF EXISTS `usp_usuarios_cambiarActivo`;
DELIMITER //
CREATE PROCEDURE `usp_usuarios_cambiarActivo`(
IN `@idUsuario` VARCHAR(36),
IN `@activo` BIT,
out `@operacionExitosa` bit

)
BEGIN

set `@operacionExitosa` = 0;

update
`usuarios`
set
`activo` = `@activo`
WHERE `id` = `@idUsuario`;
set `@operacionExitosa` = 1;

select `@operacionExitosa` as operacionExitosa;
	
END//
DELIMITER ;

-- Volcando estructura para procedimiento alasvent_prod.usp_usuarios_cambiarContrasena
DROP PROCEDURE IF EXISTS `usp_usuarios_cambiarContrasena`;
DELIMITER //
CREATE PROCEDURE `usp_usuarios_cambiarContrasena`(
in `@id` varchar(36)
,in `@contrasena` varchar(150)
, out `@operacionExitosa` bit
)
BEGIN

	set `@operacionExitosa` = 0;
    
    update
    usuarios 
    set contrasena = `@contrasena`
    where id = `@id`;
    
    set `@operacionExitosa` = 1;
    
    select `@operacionExitosa` as  operacionExitosa;
END//
DELIMITER ;

-- Volcando estructura para procedimiento alasvent_prod.usp_usuarios_insertar
DROP PROCEDURE IF EXISTS `usp_usuarios_insertar`;
DELIMITER //
//
DELIMITER ;

-- Volcando estructura para procedimiento alasvent_prod.usp_usuarios_lista
DROP PROCEDURE IF EXISTS `usp_usuarios_lista`;
DELIMITER //
CREATE PROCEDURE `usp_usuarios_lista`()
BEGIN
SELECT 
	u.id
	,u.usuario 
	,u.contrasena 
	,u.correoElectronico 
	,u.activo 
	,u.eliminado 
	,u.fechaAlta 
	,u.usuarioAlta
	,u.usuarioEdicion
	,u.telefonoMovil
	,u.rolId
    ,r.nombre as 'rol'
 FROM usuarios as u
 LEFT JOIN roles as r on u.rolid = r.idRol
 ORDER BY id ASC;
END//
DELIMITER ;

-- Volcando estructura para procedimiento alasvent_prod.usp_usuarios_lista_vendedores
DROP PROCEDURE IF EXISTS `usp_usuarios_lista_vendedores`;
DELIMITER //
CREATE PROCEDURE `usp_usuarios_lista_vendedores`()
BEGIN

	SELECT 
		u.id
		,u.usuario 
		,u.contrasena 
		,u.correoElectronico 
		,u.activo 
		,u.eliminado 
		,u.fechaAlta 
		,u.usuarioAlta
		,u.usuarioEdicion
		,u.telefonoMovil
		,u.rolId
	   ,r.nombre as 'rol'
	FROM usuarios as u
	LEFT JOIN roles as r on u.rolid = r.idRol
	WHERE u.rolId = 2
	ORDER BY id ASC;

END//
DELIMITER ;

-- Volcando estructura para tabla alasvent_prod.usuarios
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` varchar(36) NOT NULL,
  `usuario` varchar(80) NOT NULL,
  `contrasena` varchar(150) NOT NULL,
  `correoElectronico` varchar(150) DEFAULT NULL,
  `activo` bit(1) NOT NULL,
  `eliminado` bit(1) DEFAULT NULL,
  `fechaAlta` datetime DEFAULT NULL,
  `usuarioAlta` varchar(36) DEFAULT NULL,
  `usuarioEdicion` varchar(36) DEFAULT NULL,
  `telefonoMovil` varchar(50) DEFAULT NULL,
  `rolId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla alasvent_prod.usuarios: ~3 rows (aproximadamente)
DELETE FROM `usuarios`;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` (`id`, `usuario`, `contrasena`, `correoElectronico`, `activo`, `eliminado`, `fechaAlta`, `usuarioAlta`, `usuarioEdicion`, `telefonoMovil`, `rolId`) VALUES
	('1361D396-D3A2-DE2D-DD46-1D8CF145D330', 'jennifer', '$2y$10$4W/Glzwhe0GipXLk3wYIXuwBVB7Va6Vyp7DJy9K9GKc0L2DdJt1bu', 'jennifer@gmail.com', b'1', b'0', '2020-11-05 15:47:54', '8C11A352-88AF-C364-C888-7BD2FCA0A5E9', NULL, '3008090404', 2),
	('8C11A352-88AF-C364-C888-7BD2FCA0A5E9', 'admin', '$2y$10$twNw6SleWCNjTWAkK88sROB0AaitPYHuJbtiHF.XLAemSNFXPfj7O', 'admin@correo.com', b'1', b'0', '2020-09-01 03:24:52', 'userd', '8C11A352-88AF-C364-C888-7BD2FCA0A5E9', '5533976281', 1),
	('EC6B67F9-D493-C51C-407D-F1BF3E874981', 'paula', '$2y$10$CUkQMR5WVb/nDgeljGQSgOnE7191LV0qKZnkVsq6XnjyLULvBlqGC', 'vendedor@correo.com', b'1', b'0', '2020-09-06 20:20:18', '8C11A352-88AF-C364-C888-7BD2FCA0A5E9', '8C11A352-88AF-C364-C888-7BD2FCA0A5E9', '5533976281', 2);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
