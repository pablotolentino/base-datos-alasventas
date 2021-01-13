CREATE PROCEDURE `usp_metas_insertar`(
	IN ``
	IN `@IdUsuario` INT,
	IN `@FechaInicio` DATE,
	IN `@FechaFin` DATE,
	IN `@MetaVentas` INT,
	IN `@IdUsuarioAlta` INT,
	OUT `@operacionExitosa` BIT
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
BEGIN
	set `@operacionExitosa` = 0;
    
    INSERT into metas (IdMeta,IdUsuario,FechaInicio,FechaFin,MetaVentas,Activo,IdUsuarioAlta,FechaAlta)
	 VALUES(
	 @IdMeta,@IdUsuario,@FechaInicio,@FechaFin,@MetaVentas,1,@IdUsuarioAlta,NOW()
	 ) ;
    
    set `@operacionExitosa` = 1;
    
    select `@operacionExitosa` as  operacionExitosa;

END;
