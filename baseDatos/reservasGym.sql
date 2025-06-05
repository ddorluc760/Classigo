CREATE TABLE rol(
    id SERIAL,
    nombreRol VARCHAR(20) NOT NULL,
    descripcion VARCHAR(250),
    CONSTRAINT pk_idRol PRIMARY KEY (id),
    CONSTRAINT ck_nombreRol CHECK(nombreRol IN ('Alumno', 'Instructor', 'Admin'))
);

CREATE TABLE usuario(
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
    CONSTRAINT fk_idRol FOREIGN KEY (idRol) REFERENCES rol(id)
);

CREATE TABLE categoria(
    id SERIAL,
    nombre VARCHAR(20) NOT NULL,
    descripcion VARCHAR(250),
    CONSTRAINT pk_idCategoria PRIMARY KEY (id)
);

CREATE TABLE ubicacion(
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

CREATE TABLE clase(
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
    CONSTRAINT fk_idCategoria FOREIGN KEY (idCategoria) REFERENCES categoria(id),
    CONSTRAINT fk_idInstructor FOREIGN KEY (idInstructor) REFERENCES instructor(id),
    CONSTRAINT fk_idUbicacion FOREIGN KEY (idUbicacion) REFERENCES ubicacion(id)
);

CREATE TABLE horario(
    id SERIAL,
    fechaHoraInicio DATETIME NOT NULL,
    fechaHoraFin DATETIME NOT NULL,
    cuposDisponibles NUMERIC(5),
    idClase SERIAL NOT NULL,
    CONSTRAINT pk_idHorario PRIMARY KEY (id),
    CONSTRAINT fk_idClase FOREIGN KEY (idClase)
);

CREATE TABLE reserva(
    id SERIAL,
    fechaReserva DATE NOT NULL,
    estado VARCHAR(15) NOT NULL,
    idUsuario SERIAL NOT NULL,
    idHorario SERIAL NOT NULL,
    idPago SERIAL NOT NULL,
    CONSTRAINT pk_idReserva PRIMARY KEY (id),
    CONSTRAINT ck_estadoReserva CHECK (estado IN ('Confirmada', 'Reservada', 'Pendiente')),
    CONSTRAINT fk_idUsuario FOREIGN KEY (idUsuario) REFERENCES usuario(id),
    CONSTRAINT fk_idHorario FOREIGN KEY (idHorario) REFERENCES horario(id),
    CONSTRAINT fk_idPago FOREIGN KEY (idPago) REFERENCES pago(id)
);