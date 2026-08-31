-- Empresa principal: Factoría (proyectos de Josué).
INSERT INTO seguridad.empresas (empresa_id, codigo_empresa, nombre_empresa, indicador_principal, activo)
VALUES (1, 'FACTORIA', 'Factoría de Proyectos', TRUE, TRUE);

INSERT INTO seguridad.modulos (modulo_id, codigo_modulo, nombre_modulo, ruta_frontend, activo)
VALUES (1, 'APP_TAXIMETRO', 'Taxímetro Digital', '/taximetro', TRUE);

INSERT INTO seguridad.perfiles (perfil_id, codigo_perfil, nombre_perfil, activo)
VALUES
    (1, 'ROOT', 'Super Administrador Global', TRUE),
    (2, 'ADMIN_TAXI', 'Administrador de Taxis', TRUE);

INSERT INTO seguridad.perfil_modulo (perfil_id, modulo_id)
VALUES
    (1, 1),
    (2, 1);

-- Josué es el usuario principal de Factoría.
-- Hash PBKDF2-SHA256 / 30000 iter / 32 bytes (mismo algoritmo que Factoría.Api).
INSERT INTO seguridad.usuarios (
    usuario_id, codigo_usuario, nombre_completo, correo,
    contrasena_hash, salt, requiere_mfa, empresa_id, activo
) VALUES (
    1,
    'josue',
    'Josué Alejandro Díaz Contreras',
    'josueac20@gmail.com',
    '4e6da521670466e1010c94dc2d95928b7d5f08c7759cd9f030c31f776417ad33',
    '8361f467091da99745a0a91425aa89d735a10b4d6ce3286b67361768379b9b3c',
    FALSE,
    1,
    TRUE
);

INSERT INTO seguridad.usuarios (
    usuario_id, codigo_usuario, nombre_completo, correo,
    contrasena_hash, salt, requiere_mfa, empresa_id, activo
) VALUES (
    2,
    'admin',
    'Conductor Taxímetro',
    'admin@factoria.com',
    '4e6da521670466e1010c94dc2d95928b7d5f08c7759cd9f030c31f776417ad33',
    '8361f467091da99745a0a91425aa89d735a10b4d6ce3286b67361768379b9b3c',
    FALSE,
    1,
    TRUE
);

INSERT INTO seguridad.usuario_perfil (usuario_id, perfil_id)
VALUES
    (1, 1),
    (2, 2);

INSERT INTO taximetro.tarifas (estado_vehiculo, costo_por_segundo)
VALUES
    ('PARADO', 0.0200),
    ('MOVIMIENTO', 0.0500);

SELECT setval('seguridad.empresas_empresa_id_seq', (SELECT MAX(empresa_id) FROM seguridad.empresas));
SELECT setval('seguridad.modulos_modulo_id_seq', (SELECT MAX(modulo_id) FROM seguridad.modulos));
SELECT setval('seguridad.perfiles_perfil_id_seq', (SELECT MAX(perfil_id) FROM seguridad.perfiles));
SELECT setval('seguridad.usuarios_usuario_id_seq', (SELECT MAX(usuario_id) FROM seguridad.usuarios));
