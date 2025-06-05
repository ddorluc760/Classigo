CREATE TABLE roles(
    id SERIAL,
    nombreRol VARCHAR(20) NOT NULL,
    descripcion VARCHAR(250),
    CONSTRAINT pk_idRol PRIMARY KEY (id),
    CONSTRAINT ck_nombreRol CHECK(nombreRol IN ('Alumno', 'Instructor', 'Admin'))
);

CREATE TABLE usuarios(
    id SERIAL,
    nombre VARCHAR(20) NOT NULL,
    apellido1 VARCHAR(20) NOT NULL,
    apellido2 VARCHAR(20) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    contraseña TEXT UNIQUE NOT NULL,
    teléfono NUMERIC(9),
    fechaRegistro DATE,
    estado VARCHAR(15) DEFAULT 'Activo',
    idRol SERIAL,
    CONSTRAINT pk_idUsuario PRIMARY KEY (id),
    CONSTRAINT ck_estado CHECK (estado IN ('Activo', 'Suspendido', 'Eliminado')),
    CONSTRAINT fk_idRol FOREIGN KEY (idRol) REFERENCES roles(id)
);

CREATE TABLE categorias(
    id SERIAL,
    nombre VARCHAR(20) NOT NULL,
    descripcion VARCHAR(250),
    CONSTRAINT pk_idCategoria PRIMARY KEY (id)
);

CREATE TABLE ubicaciones(
    id SERIAL,
    nombreLugar VARCHAR(20) NOT NULL,
    calle VARCHAR(20) NOT NULL,
    numero NUMERIC(3) NOT NULL,
    ciudad VARCHAR(20) NOT NULL,
    codigoPostal NUMERIC(5) NOT NULL,
    latitud DECIMAL(9,6),
    longitud DECIMAL(9,6),
    CONSTRAINT pk_idUbicacion PRIMARY KEY (id)
);

CREATE TABLE clases(
    id SERIAL,
    titulo VARCHAR(20) NOT NULL,
    descripcion VARCHAR(250),
    capacidadMaxima NUMERIC(7) NOT NULL,
    precio DECIMAL(7,2) NOT NULL,
    estado VARCHAR(15) NOT NULL,
    idCategoria SERIAL NOT NULL,
    idInstructor SERIAL NOT NULL,
    idUbicacion SERIAL NOT NULL,
    CONSTRAINT pk_idClase PRIMARY KEY (id),
    CONSTRAINT ck_estadoClase CHECK (estado IN ('Activa', 'Cancelada', 'Completada')),
    CONSTRAINT fk_idCategoria FOREIGN KEY (idCategoria) REFERENCES categorias(id),
    CONSTRAINT fk_idInstructor FOREIGN KEY (idInstructor) REFERENCES usuarios(id),
    CONSTRAINT fk_idUbicacion FOREIGN KEY (idUbicacion) REFERENCES ubicaciones(id)
);

CREATE TABLE horarios(
    id SERIAL,
    fechaHoraInicio DATETIME NOT NULL,
    fechaHoraFin DATETIME NOT NULL,
    cuposDisponibles NUMERIC(5),
    idClase SERIAL NOT NULL,
    CONSTRAINT pk_idHorario PRIMARY KEY (id),
    CONSTRAINT fk_idClase FOREIGN KEY (idClase) REFERENCES clases(id)
);

CREATE TABLE reservas(
    id SERIAL,
    fechaReserva DATE NOT NULL,
    estado VARCHAR(15) NOT NULL,
    idUsuario SERIAL NOT NULL,
    idHorario SERIAL NOT NULL,
    CONSTRAINT pk_idReserva PRIMARY KEY (id),
    CONSTRAINT ck_estadoReserva CHECK (estado IN ('Confirmada', 'Reservada', 'Pendiente')),
    CONSTRAINT fk_idUsuario FOREIGN KEY (idUsuario) REFERENCES usuarios(id),
    CONSTRAINT fk_idHorario FOREIGN KEY (idHorario) REFERENCES horarios(id)
);

CREATE TABLE pagos(
    id SERIAL,
    monto DECIMAL(10,2) NOT NULL,
    fechaPago DATE NOT NULL,
    metodoPago VARCHAR(20) NOT NULL,
    estadoPago VARCHAR(15) NOT NULL,
    idReserva SERIAL NOT NULL,
    CONSTRAINT pk_idPago PRIMARY KEY (id),
    CONSTRAINT ck_metodoPago CHECK (metodoPago IN ('Tarjeta', 'Paypal', 'Transferencia', 'Efectivo')),
    CONSTRAINT ck_estadoPago CHECK (estadoPago IN ('Completado', 'Pendiente', 'Fallido')),
    CONSTRAINT fk_idReserva FOREIGN KEY (idReserva) REFERENCES reservas(id)
);

CREATE TABLE notificaciones(
    id SERIAL,
    tipo VARCHAR(15) NOT NULL,
    fechaEnvio TIMESTAMP NOT NULL,
    estadoEnvio VARCHAR(20) DEFAULT 'Pendiente',
    contenido TEXT NOT NULL,
    idUsuario SERIAL NOT NULL,
    CONSTRAINT pk_idNotificaciones PRIMARY KEY (id),
    CONSTRAINT ck_tipoNotificaciones CHECK (tipo IN ('Confirmación', 'Cancelación', 'Recordatorio')),
    CONSTRAINT ck_estadoEnvio CHECK (estadoEnvio IN ('Enviado', 'Pendiente', 'Fallido')),
    CONSTRAINT fk_idUsuario FOREIGN KEY (id) REFERENCES usuarios(id)
);

CREATE TABLE valoraciones(
    id SERIAL,
    puntuacion INTEGER NOT NULL,
    comentario VARCHAR(150),
    fechaValoracion TIMESTAMP NOT NULL,
    idUsuario SERIAL NOT NULL,
    idClase SERIAL NOT NULL,
    CONSTRAINT pk_idValoracion PRIMARY KEY (id),
    CONSTRAINT ck_puntuacion CHECK (puntuacion BETWEEN 1 AND 5),
    CONSTRAINT fk_idUsuario FOREIGN KEY (idUsuario) REFERENCES usuarios(id),
    CONSTRAINT fk_idClase FOREIGN KEY (idClase) REFERENCES clases(id)
);

CREATE TABLE mensajes(
    id SERIAL,
    contenido VARCHAR(500) NOT NULL,
    fechaEnvio TIMESTAMP NOT NULL,
    leido BOOLEAN DEFAULT FALSE,
    idEmisor SERIAL,
    idReceptor SERIAL,
    CONSTRAINT pk_idMensajes PRIMARY KEY (id),
    CONSTRAINT fk_idEmisor FOREIGN KEY (idEmisor) REFERENCES usuarios(id),
    CONSTRAINT fk_idReceptor FOREIGN KEY (idReceptor) REFEREMCES usuarios(id)
);