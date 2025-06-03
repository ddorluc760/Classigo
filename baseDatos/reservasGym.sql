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
    idRol NUMERIC(5),
    CONSTRAINT pk_idUsuario PRIMARY KEY (id),
    CONSTRAINT ck_estado CHECK (estado IN ('Activo', 'Suspendido', 'Eliminado')),
    CONSTRAINT fk_idRol FOREIGN KEY (idRol) REFERENCES rol(id)
);