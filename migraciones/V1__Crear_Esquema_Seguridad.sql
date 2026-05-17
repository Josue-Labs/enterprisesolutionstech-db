CREATE SCHEMA IF NOT EXISTS seguridad;

CREATE TABLE seguridad.usuarios (
    usuario_id SERIAL PRIMARY KEY,
    codigo_usuario VARCHAR(50) UNIQUE NOT NULL,
    nombre_completo VARCHAR(150) NOT NULL,
    correo VARCHAR(150) UNIQUE NOT NULL,
    contrasena_hash VARCHAR(255) NOT NULL,
    salt VARCHAR(100) NOT NULL,
    requiere_mfa BOOLEAN DEFAULT FALSE,
    secret_key_mfa VARCHAR(100),
    estado_secret_mfa VARCHAR(3) DEFAULT 'PEN',
    qr_code_base64 TEXT,
    indicador_olvido_contrasena BOOLEAN DEFAULT FALSE,
    indicador_contrasena_expirada BOOLEAN DEFAULT FALSE,
    indicador_contrasena_temporal BOOLEAN DEFAULT FALSE,
    empresa_id INT,
    activo BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE seguridad.refresh_tokens (
    token_id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES seguridad.usuarios(usuario_id),
    token VARCHAR(255) NOT NULL UNIQUE,
    fecha_expiracion TIMESTAMP NOT NULL,
    origen VARCHAR(50),
    indicador_mfa_validado CHAR(1) DEFAULT '0',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE seguridad.modulos (
    modulo_id SERIAL PRIMARY KEY,
    codigo_modulo VARCHAR(50) UNIQUE NOT NULL,
    nombre_modulo VARCHAR(100) NOT NULL,
    ruta_frontend VARCHAR(255),
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE seguridad.perfiles (
    perfil_id SERIAL PRIMARY KEY,
    codigo_perfil VARCHAR(50) UNIQUE NOT NULL,
    nombre_perfil VARCHAR(100) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE seguridad.perfil_modulo (
    perfil_id INT REFERENCES seguridad.perfiles(perfil_id),
    modulo_id INT REFERENCES seguridad.modulos(modulo_id),
    PRIMARY KEY (perfil_id, modulo_id)
);

CREATE TABLE seguridad.usuario_perfil (
    usuario_id INT REFERENCES seguridad.usuarios(usuario_id),
    perfil_id INT REFERENCES seguridad.perfiles(perfil_id),
    PRIMARY KEY (usuario_id, perfil_id)
);


CREATE SCHEMA IF NOT EXISTS taximetro;

CREATE TABLE taximetro.tarifas (
    tarifa_id SERIAL PRIMARY KEY,
    estado_vehiculo VARCHAR(20) UNIQUE NOT NULL,
    costo_por_segundo DECIMAL(10,4) NOT NULL,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE taximetro.viajes (
    viaje_id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES seguridad.usuarios(usuario_id),
    fecha_inicio TIMESTAMP NOT NULL,
    fecha_fin TIMESTAMP,
    tiempo_total_segundos DECIMAL(10,2),
    tiempo_parado_segundos DECIMAL(10,2),
    tiempo_movimiento_segundos DECIMAL(10,2),
    costo_total DECIMAL(10,2),
    estado_viaje VARCHAR(20) DEFAULT 'FINALIZADO',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);