CREATE SCHEMA IF NOT EXISTS seguridad;

CREATE TABLE seguridad.empresas (
    empresa_id SERIAL PRIMARY KEY,
    codigo_empresa VARCHAR(50) UNIQUE NOT NULL,
    nombre_empresa VARCHAR(150) NOT NULL,
    indicador_principal BOOLEAN DEFAULT FALSE,
    activo BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

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
    empresa_id INT REFERENCES seguridad.empresas(empresa_id),
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
