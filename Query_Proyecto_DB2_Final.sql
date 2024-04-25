--========================================== Creacion de la base de datos ==============================================================================================================
CREATE DATABASE ProjectoDB2
use ProjectoDB2
go

--========================================== Creacion de las tablas ====================================================================================================================
--Esta tabla muesta la ruta con su lugar de llegada y salida
Create TABLE dbo.Ruta(
idRuta INT PRIMARY KEY identity(1,1),
LugarSalida NVARCHAR(50) NOT NULL,
LugarLlegada NVARCHAR(50) NOT NULL,
latitud float,
longitud float,
)
go

--Con forme a las ruta podemos generar ciertas paradas
CREATE TABLE dbo.Paradas(
idRuta INT FOREIGN KEY REFERENCES dbo.Ruta(idRuta),
idParada INT PRIMARY KEY,
direccion NVARCHAR(80) NOT NULL,
costo float NOT NULL,
)
go

--Crea la tabla de cliente donde dentro de una de las variables viene contrasena para posteriormente iniciar sesion con cedula y contrasena en la app
CREATE TABLE dbo.Cliente(
Cedula INT PRIMARY KEY NOT NULL,
nombre NVARCHAR(40) NOT NULL,
apellidos NVARCHAR(40) NOT NULL,
telefono INT NOT NULL,
direccion NVARCHAR(80) NOT NULL,
contrasena VARBINARY(MAX) NOT NULL,
saldo float NOT NULL,
discapacitado BIT)
go

--Crea la tabla de chofer donde dentro de una de las variables viene contrasena para posteriormente iniciar sesion con cedula y contrasena en la app
CREATE TABLE dbo.Chofer(
idChofer INT PRIMARY KEY IDENTITY(1,1),
cedula INT UNIQUE NOT NULL,
nombre NVARCHAR(40) NOT NULL,
apellidos NVARCHAR(40) NOT NULL,
telefono INT NOT NULL,
direccion NVARCHAR(80) NOT NULL,
contrasena VARBINARY(MAX) NOT NULL
)
go

--Toda la informacion recaee sobre el vehiculo y sus composiciones 
CREATE TABLE dbo.Vehiculos(
BusSerie NVARCHAR(25) PRIMARY KEY NOT NULL,
idChoferaCargo INT FOREIGN KEY REFERENCES dbo.Chofer(idChofer) NOT NULL,
placa NVARCHAR(10) UNIQUE NOT NULL,
marca NVARCHAR(20) NOT NULL,
modelo NVARCHAR(20) NOT NULL,
anio date NOT NULL,
estado NVARCHAR(20) NOT NULL,
latitud float,
longitud float,
)
go

--A partir del Bus se Generan los Asientos basados en el mismo
CREATE TABLE dbo.Asientos(
BusSerie NVARCHAR(25) FOREIGN KEY REFERENCES dbo.Vehiculos(BusSerie),
idAsiento INT PRIMARY KEY IDENTITY(1,1),
CedulaCliente INT FOREIGN KEY REFERENCES dbo.Cliente(Cedula) NULL,
Ocupado BIT NOT NULL,
Exclusive BIT NOT NULL
)
go

--Almacena Info de Pago
CREATE TABLE dbo.Pagos(
idPago INT PRIMARY KEY IDENTITY(1,1),
CedulaCliente INT FOREIGN KEY REFERENCES dbo.Cliente(cedula) NOT NULL,
descripcipon NVARCHAR(15) NOT NULL,
Fecha DATE NOT NULL,
NumeroSerieBus NVARCHAR(25) FOREIGN KEY REFERENCES dbo.Vehiculos(BusSerie),
Costo float NOT NULL
)
go

CREATE TABLE dbo.Horarios(
idHorario INT PRIMARY KEY IDENTITY (1,1),
Hora TIME NOT NULL,
Parada int FOREIGN KEY REFERENCES dbo.Paradas(idParada),
BusDeRuta NVARCHAR(25) FOREIGN KEY REFERENCES dbo.Vehiculos(BusSerie)
)

--========================================== Creacion de la logins y usuarios con permisos ==============================================================================================================
--Crear Login Admin
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'Administrador')
BEGIN
    CREATE LOGIN Administrador WITH PASSWORD = 'Administrador';
END
ELSE
BEGIN
    PRINT 'El login Administrador ya existe.';
END

--Crear Login Usuarios
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'Usuarios')
BEGIN
    CREATE LOGIN Usuarios WITH PASSWORD = 'Usuarios';
END
ELSE
BEGIN
    PRINT 'El login Usuarios ya existe.';
END

--Crear Login Contador
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'Contador')
BEGIN
    CREATE LOGIN Contador WITH PASSWORD = 'Contador';
END
ELSE
BEGIN
    PRINT 'El login Contador ya existe.';
END

-- Crear Usuarios para los logins
CREATE USER userAdministrador FOR LOGIN Administrador;
CREATE USER userUsuarios FOR LOGIN Usuarios;
CREATE USER userContador FOR LOGIN Contador;

--Dar permisos a los Usuarios
GRANT SELECT, INSERT, UPDATE, DELETE TO userAdministrador WITH GRANT OPTION;
GRANT SELECT, INSERT ON Pagos TO userUsuarios;
GRANT SELECT ON Pagos TO userContador;

--========================================== Creacion de los procedimientos almacenados ==============================================================================================================
-- Aun no funciona
CREATE PROCEDURE SP_RealizarCompra
    @CedulaCliente INT,
    @IdAsiento INT,
    @IdParada INT,
    @IdHora INT  -- Change parameter name
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Obtener el saldo del cliente
        DECLARE @SaldoCliente FLOAT;
        SELECT @SaldoCliente = saldo FROM dbo.Cliente WHERE Cedula = @CedulaCliente;

        -- Obtener el costo del boleto según la parada
        DECLARE @Costo FLOAT;
        SELECT @Costo = costo FROM dbo.Paradas WHERE idParada = @IdParada;

        -- Obtener la serie del bus de la tabla Horarios utilizando el IdHora
        DECLARE @SerieDelBus NVARCHAR(25);
        SELECT @SerieDelBus = BusDeRuta FROM dbo.Horarios WHERE idHorario = @IdHora;

        -- Verificar si el saldo del cliente es suficiente
        IF @SaldoCliente >= @Costo
        BEGIN
            -- Actualizar el saldo del cliente
            UPDATE dbo.Cliente SET saldo = saldo - @Costo WHERE Cedula = @CedulaCliente;

            -- Registrar el pago
            INSERT INTO dbo.Pagos (CedulaCliente, descripcipon, Fecha, NumeroSerieBus, Costo)
            VALUES (@CedulaCliente, 'TiketeBus', GETDATE(), @SerieDelBus, @Costo);

            -- Marcar el asiento como ocupado
            UPDATE dbo.Asientos SET Ocupado = 1 WHERE idAsiento = @IdAsiento;

            -- Confirmar la transacción
            COMMIT TRANSACTION;
            PRINT 'Pedido completado.';
        END
        ELSE
        BEGIN
            -- Indicar que el cliente no tiene suficientes fondos
            RAISERROR('No tiene los suficientes fondos', 16, 1);
        END
    END TRY
    BEGIN CATCH
        -- Deshacer la transacción en caso de error
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END

        -- Capturar el error y mostrar un mensaje
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        PRINT 'Error: ' + @ErrorMessage;
    END CATCH
    SET NOCOUNT OFF;
END;


--Crear procedimiento para agregar Clientes
CREATE PROCEDURE SP_RegistrarPersona
    @CedulaCliente INT,
    @nombre NVARCHAR(40),
    @apellidos NVARCHAR(40),
    @telefono INT,
    @direccion NVARCHAR(80),
    @contrasena VARCHAR(MAX),
    @saldo FLOAT,
	@discap BIT
AS
BEGIN
    SET XACT_ABORT ON; 
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO dbo.Cliente (Cedula, nombre, apellidos, telefono, direccion, contrasena, saldo, discapacitado)
        VALUES (@CedulaCliente, 
    @nombre, 
    @apellidos, 
    @telefono, 
    @direccion, 
    CONVERT(VARBINARY(MAX), ENCRYPTBYPASSPHRASE('password', @contrasena)), 
    @saldo,
	@discap);

        -- Confirmar la transacción
        COMMIT TRANSACTION;
        PRINT 'Cliente Agregado.';
    END TRY
    BEGIN CATCH
        -- Manejar el error
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        PRINT 'An error occurred: ' + ERROR_MESSAGE();
    END CATCH
END;

--Crear procedimiento para agregar Choferes
CREATE PROCEDURE SP_RegistrarChofer
    @CedulaChofer INT,
    @nombre NVARCHAR(40),
    @apellidos NVARCHAR(40),
    @telefono INT,
	@direccion NVARCHAR(80),
	@contrasena VARCHAR(MAX)
AS
BEGIN
	SET XACT_ABORT ON; -- This will automatically rollback the transaction if any statement raises an error
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO dbo.Chofer (Cedula, nombre, apellidos, telefono, direccion, contrasena)
        VALUES (@CedulaChofer, 
    @nombre, 
    @apellidos, 
    @telefono, 
    @direccion, 
    CONVERT(VARBINARY(MAX), ENCRYPTBYPASSPHRASE('password', @contrasena)));
        -- Confirmar la transacción
        COMMIT TRANSACTION;
        PRINT 'Chofer Agregado.';
    END TRY
    BEGIN CATCH
        -- Manejar el error
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        PRINT 'An error occurred: ' + ERROR_MESSAGE();
    END CATCH
END;

--Muestra los gastos del usuario en billetes
CREATE PROCEDURE ConsultarInformacionCliente
    @Cedula INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT c.nombre AS Nombre,
           c.apellidos AS Apellidos,
           COUNT(p.idPago) AS CantidadBoletos,
           SUM(p.Costo) AS PlataGastada
    FROM dbo.Cliente c
    INNER JOIN dbo.Pagos p ON c.Cedula = p.CedulaCliente
    WHERE c.Cedula = @Cedula
    GROUP BY c.nombre, c.apellidos;
END;
GO

-- Valida el inicio de sesion mediante la desincriptacion de la contrasena
CREATE PROCEDURE SP_getInfoInicio
    @CedulaCliente INT,
    @ContrasenaIngresada NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ContrasenaGuardada VARBINARY(MAX);

    BEGIN TRY
        SELECT @ContrasenaGuardada = contrasena 
        FROM dbo.Cliente 
        WHERE Cedula = @CedulaCliente;

        IF @ContrasenaGuardada IS NULL
        BEGIN
            RAISERROR('La cédula proporcionada no es válida o el cliente no existe.', 16, 1);
            RETURN;
        END

        IF @ContrasenaIngresada = CONVERT(VARCHAR(MAX), DECRYPTBYPASSPHRASE('password', @ContrasenaGuardada))
        BEGIN
            SELECT Cedula,nombre,apellidos,telefono,direccion,Convert(NVARCHAR(MAX),contrasena) as contrasena,saldo,discapacitado from dbo.Cliente
            WHERE Cedula = @CedulaCliente;
        END
        ELSE
        BEGIN
            RAISERROR('La contrasena ingresada no es correcta.', 16, 1);
        END
    END TRY
    BEGIN CATCH
        PRINT 'Error'
    END CATCH
END;
GO

-- Valida el inicio de sesion del chofer mediante la desincriptacion de la contrasena
CREATE PROCEDURE SP_getInfoChofer
    @CedulaChofer INT,
    @ContrasenaIngresada NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ContrasenaGuardada VARBINARY(MAX);

    BEGIN TRY
        SELECT @ContrasenaGuardada = contrasena 
        FROM dbo.Chofer 
        WHERE Cedula = @CedulaChofer;

        IF @ContrasenaGuardada IS NULL
        BEGIN
            RAISERROR('La cédula proporcionada no es válida o el cliente no existe.', 16, 1);
            RETURN;
        END

        IF @ContrasenaIngresada = CONVERT(VARCHAR(MAX), DECRYPTBYPASSPHRASE('password', @ContrasenaGuardada))
        BEGIN
            SELECT cedula,nombre,apellidos,telefono,direccion,Convert(NVARCHAR(MAX),contrasena) as contrasena from dbo.Chofer
            WHERE cedula = @CedulaChofer;
        END
        ELSE
        BEGIN
            RAISERROR('La contrasena ingresada no es correcta.', 16, 1);
        END
    END TRY
    BEGIN CATCH
        PRINT 'Error'
    END CATCH
END;
GO

-- Revisa si ya existe un usuario con esa cédula

CREATE PROCEDURE SP_checkExiste
    @Cedula INT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM dbo.Cliente WHERE Cedula = @Cedula)
        SELECT 1 AS UserExists;
    ELSE
        SELECT 0 AS UserExists;
END
GO

-- Procedimiento para las recargas de saldo

CREATE PROCEDURE SP_updateSaldo
    @Cedula INT,
    @Amount FLOAT
AS
BEGIN
    BEGIN TRANSACTION;
    
    UPDATE dbo.Cliente
    SET saldo = saldo + @Amount
    WHERE Cedula = @Cedula;
    
    IF @@ERROR <> 0
    BEGIN
        ROLLBACK TRANSACTION;
        RETURN;
    END
    
    COMMIT TRANSACTION;
END;
GO

-- Procedimiento para consultar el horario de los buses

Create Procedure SP_ConsultaHorario
AS
BEGIN
SELECT 
    H.idHorario,
    H.Hora,
	P.idParada,
    P.direccion AS Parada,
    P.costo AS CostoParada,
    V.BusSerie
FROM 
    dbo.Horarios H
INNER JOIN 
    dbo.Vehiculos V ON H.BusDeRuta = V.BusSerie
INNER JOIN 
    dbo.Paradas P ON H.Parada = P.idParada
END

-- Procedimiento para consultar los asientos disponibles en el bus
CREATE PROCEDURE SP_ConsultaAsientos
    @ParadaID INT,
    @HorarioID INT
AS
BEGIN
    SELECT
        H.idHorario,
        H.Hora,
        P.direccion AS DireccionParada,
        P.costo AS CostoParada,
        V.BusSerie,
        V.estado,
        A.idAsiento,
        A.Ocupado,
        A.Exclusive,
        CASE WHEN C.nombre IS NULL THEN 1 ELSE 0 END AS ClientePresente
    FROM 
        dbo.Horarios H
    INNER JOIN 
        dbo.Vehiculos V ON H.BusDeRuta = V.BusSerie
    INNER JOIN 
        dbo.Paradas P ON H.Parada = P.idParada
    INNER JOIN 
        dbo.Asientos A ON V.BusSerie = A.BusSerie
    LEFT JOIN 
        dbo.Cliente C ON A.CedulaCliente = C.Cedula
    WHERE 
        P.idParada = @ParadaID AND H.idHorario = @HorarioID;
END

-- Procedimiento para realizar la consulta de los tiquetes comprados por el usuario

Create PROCEDURE SP_ConsultaTiquete
    @CedulaCliente INT
AS
BEGIN
    SELECT Distinct
        P.idPago,
        P.CedulaCliente,
        P.descripcipon,
        P.Fecha,
        P.NumeroSerieBus,
        P.Costo,
        R.LugarSalida,
		R.LugarLlegada
    FROM 
        dbo.Pagos P
    INNER JOIN 
        dbo.Cliente C ON P.CedulaCliente = C.Cedula
    INNER JOIN 
        dbo.Vehiculos V ON P.NumeroSerieBus = V.BusSerie
    INNER JOIN
        dbo.Horarios H ON V.BusSerie = H.BusDeRuta
    INNER JOIN
        dbo.Paradas Pa ON H.Parada = Pa.idParada
	INNER JOIN
        dbo.Ruta R ON Pa.idRuta = R.idRuta
    WHERE 
        P.CedulaCliente = @CedulaCliente;
END
go

--Obtiene los buses a nombre del chofer

CREATE PROCEDURE SP_getBusesChofer
    @CedulaChofer INT
AS
BEGIN
    SELECT 
        v.BusSerie,
        v.placa,
        h.hora,
        p.direccion,
        r.LugarLlegada,
        r.LugarSalida
    FROM 
        dbo.Horarios h
        INNER JOIN dbo.Vehiculos v ON h.BusDeRuta = v.BusSerie
        INNER JOIN dbo.Paradas p ON h.Parada = p.idParada
        INNER JOIN dbo.Ruta r ON p.idRuta = r.idRuta
    WHERE 
        v.idChoferaCargo = (select idChofer from Chofer where cedula = @CedulaChofer);
END
go

-- Obtiene la localizacion del bus al momento

CREATE PROCEDURE SP_getLocation
    @BusSerie NVARCHAR(25)
AS
BEGIN
    SELECT latitud, longitud FROM dbo.Vehiculos
    WHERE BusSerie = @BusSerie
END
go

-- Actualiza la localizacion del bus al momento

CREATE PROCEDURE SP_setLocation
    @BusSerie NVARCHAR(25),
	@Latitud float,
	@Longitud float
AS
BEGIN
    UPDATE dbo.Vehiculos
	SET latitud = @Latitud
	Where BusSerie = @BusSerie

	UPDATE dbo.Vehiculos
	SET longitud = @Longitud
	Where BusSerie = @BusSerie
END

-- Obtiene las coodenadas de la ruta

CREATE PROCEDURE SP_getRutaCoords
    @BusSerie NVARCHAR(25)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Latitud FLOAT;
    DECLARE @Longitud FLOAT;

    SELECT @Latitud = r.latitud,
           @Longitud = r.longitud
    FROM dbo.Ruta r
    INNER JOIN dbo.Horarios h ON r.idRuta = h.Parada
    WHERE h.BusDeRuta = @BusSerie;

    SELECT @Latitud AS latitud, @Longitud AS longitud;
END;


select * from Cliente
exec SP_RegistrarPersona 201230456,'Dummy','User',12345678,'lorem ipsum, dolor sit amet','abc123456',22000,1
select * from Chofer
exec SP_RegistrarChofer 204560789,'Dummy','Driver',45678912,'lorm ipsum','chofer1234'

exec SP_ConsultaTiquete 208560486

select * from Pagos

delete from Pagos

exec SP_ConsultaAsientos 1,1

exec SP_ConsultaHorario

exec SP_RealizarCompra 208560486,2,1,1

exec SP_getInfoChofer 204560789,'chofer1234'

exec SP_updateSaldo 208560486, 10000

exec SP_getInfoChofer 204560789, 'chofer1234'

exec SP_getBusesChofer 203560478

exec SP_getRutaCoords 'BS001'

select * from Ruta
go

-- 203560478 Danomoli14

select * from Vehiculos
select * from Chofer

exec SP_getLocation 'BS001'
exec SP_setLocation 'BS001',18.9876,18.9762