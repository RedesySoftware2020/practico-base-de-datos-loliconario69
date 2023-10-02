CREATE TABLE USUARIOS (
    Cedula VARCHAR(8) PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Apellido VARCHAR(255),
    Email VARCHAR(255) NOT NULL,
    Email_de_Usuario VARCHAR(255) NOT NULL,
    Tipo_de_usuario INT
);

CREATE TABLE PROFESOR (
    Cedula VARCHAR(8) PRIMARY KEY,
    IdProfesor INT IDENTITY(1,1),
    Grado VARCHAR(255),
    FOREIGN KEY (Cedula) REFERENCES USUARIOS(Cedula)
);

CREATE TABLE ALUMNOS (
    Cedula VARCHAR(8) PRIMARY KEY,
    IdAlumnos INT IDENTITY(1,1),
    FOREIGN KEY (Cedula) REFERENCES USUARIOS(Cedula)
);

CREATE TABLE BEDELIAS (
    Cedula VARCHAR(8) PRIMARY KEY,
    IdBedelia INT IDENTITY(1,1),
    Cargo VARCHAR(255),
    GradoDelCargo VARCHAR(255),
    FOREIGN KEY (Cedula) REFERENCES USUARIOS(Cedula)
);

CREATE TABLE MATERIAS (
    IdMateria INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL
);

CREATE TABLE GRUPOS (
    idGrupo VARCHAR(10) PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    año_electivo INT NOT NULL,
    fecha_Creacion INT NOT NULL
);

CREATE TABLE FORO (
    IdForo BIGINT IDENTITY(1,1) PRIMARY KEY,
    Información VARCHAR(MAX),
    Data VARBINARY(MAX)
);

CREATE TABLE TAREAS (
    IdTareas INT IDENTITY(1,1) PRIMARY KEY,
    Descripción VARCHAR(MAX) NOT NULL,
    Fecha_de_Vencimiento VARCHAR(255) NOT NULL,
    Archivo VARBINARY(MAX),
    Fecha_de_Creación DATE NOT NULL
);

CREATE TABLE DATOS_FORO (
    IdDatos INT IDENTITY(1,1) PRIMARY KEY,
    IdForo BIGINT,
    idUsuario VARCHAR(8),
    mensaje VARCHAR(MAX) NOT NULL,
    archivo VARBINARY(MAX),
    FOREIGN KEY (idUsuario) REFERENCES USUARIOS(Cedula),
    FOREIGN KEY (IdForo) REFERENCES FORO(IdForo)
);

CREATE TABLE HISTORIAL_REGISTRO (
    IdUsuario VARCHAR(8) PRIMARY KEY,
    app VARCHAR(255),
    acción VARCHAR(255),
    Mensaje VARCHAR(255),
    FOREIGN KEY (IdUsuario) REFERENCES USUARIOS(Cedula)
);

CREATE TABLE MATERIAL_PUBLICO (
    IdUsuario VARCHAR(8) PRIMARY KEY,
    titulo VARCHAR(255),
    Mensaje VARCHAR(MAX),
    FOREIGN KEY (IdUsuario) REFERENCES USUARIOS(Cedula)
);

CREATE TABLE CARRERA (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    categoria VARCHAR(10) NOT NULL,
    planificacion VARCHAR(8) NOT NULL
);

CREATE TABLE GRADO (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    carrera_id INT,
    FOREIGN KEY (carrera_id) REFERENCES CARRERA(Id),
);

CREATE TABLE DICTA (
    IdMateria INT,
    idProfesor VARCHAR(8),
    PRIMARY KEY (IdMateria, idProfesor),
    FOREIGN KEY (IdMateria) REFERENCES MATERIAS(IdMateria),
    FOREIGN KEY (idProfesor) REFERENCES PROFESOR(Cedula)
);

CREATE TABLE PERTENECEN (
    IdAlumno VARCHAR(8),
    idGrupo VARCHAR(10),
    PRIMARY KEY (IdAlumno, idGrupo),
    FOREIGN KEY (IdAlumno) REFERENCES ALUMNOS(Cedula),
    FOREIGN KEY (idGrupo) REFERENCES GRUPOS(idGrupo)
);

CREATE TABLE TIENEN (
    IdMateria INT,
    idGrupo VARCHAR(10),
    idProfesor VARCHAR(8),
    PRIMARY KEY (IdMateria, idGrupo, idProfesor),
    FOREIGN KEY (IdMateria) REFERENCES MATERIAS(IdMateria),
    FOREIGN KEY (idGrupo) REFERENCES GRUPOS(idGrupo),
    FOREIGN KEY (idProfesor) REFERENCES PROFESOR(Cedula)
);

CREATE TABLE CREA (
    IdMateria INT,
    IdTareas INT,
    idGrupo VARCHAR(10),
    idProfesor VARCHAR(8),
    PRIMARY KEY (IdMateria, IdTareas, idGrupo, idProfesor),
    FOREIGN KEY (IdMateria) REFERENCES MATERIAS(IdMateria),
    FOREIGN KEY (IdTareas) REFERENCES TAREAS(IdTareas),
    FOREIGN KEY (idGrupo) REFERENCES GRUPOS(idGrupo),
    FOREIGN KEY (idProfesor) REFERENCES PROFESOR(Cedula)
);

CREATE TABLE ENTREGA (
    IdAlumno VARCHAR(8),
    IdTareas INT,
    Archivo VARBINARY(MAX),
    Calificación INT,
    Fecha_entrega INT NOT NULL,
    PRIMARY KEY (IdAlumno, IdTareas),
    FOREIGN KEY (IdAlumno) REFERENCES ALUMNOS(Cedula),
    FOREIGN KEY (IdTareas) REFERENCES TAREAS(IdTareas)
);

CREATE TABLE ESTAN (
    IdForo BIGINT,
    IdMateria INT,
    idGrupo VARCHAR(10),
    idProfesor VARCHAR(8),
    PRIMARY KEY (IdForo, IdMateria, idGrupo, idProfesor),
    FOREIGN KEY (IdForo) REFERENCES FORO(IdForo),
    FOREIGN KEY (IdMateria) REFERENCES MATERIAS(IdMateria),
    FOREIGN KEY (idGrupo) REFERENCES GRUPOS(idGrupo),
    FOREIGN KEY (idProfesor) REFERENCES PROFESOR(Cedula)
);

CREATE TABLE RE_HACER_TAREA (
    IdTareasNueva BIGINT IDENTITY(1,1),
    IdTareas INT,
    Calificación INT,
    Fecha_entrega INT NOT NULL,
    Archivo VARBINARY(MAX),
    PRIMARY KEY (IdTareasNueva, IdTareas),
    FOREIGN KEY (IdTareas) REFERENCES TAREAS(IdTareas),
);

CREATE TABLE CARRERA_MATERIA (
    IdMateria INT,
    IdCarrera INT,
    IdGrado INT,
    PRIMARY KEY (IdMateria, IdCarrera, IdGrado),
    FOREIGN KEY (IdMateria) REFERENCES MATERIAS(IdMateria),
    FOREIGN KEY (IdCarrera) REFERENCES CARRERA(Id),
    FOREIGN KEY (IdGrado) REFERENCES GRADO(Id)
);