INSERT INTO seguridad.modulos (modulo_id, codigo_modulo, nombre_modulo, ruta_frontend) 
VALUES 
(1, 'APP_TAXIMETRO', 'Taxímetro Digital', '/taximetro');

INSERT INTO seguridad.perfiles (perfil_id, codigo_perfil, nombre_perfil) 
VALUES 
(1, 'ROOT', 'Super Administrador Global'),
(2, 'ADMIN_TAXI', 'Administrador de Taxis');

INSERT INTO seguridad.perfil_modulo (perfil_id, modulo_id) 
VALUES 
(1, 1), 
(2, 1);

INSERT INTO seguridad.usuarios 
(usuario_id, codigo_usuario, nombre_completo, correo, contrasena_hash, salt, requiere_mfa, activo) 
VALUES 
(1, 'root', 'Josué Díaz (Root)', 'root@factoria.com', 'hash_temporal_root', 'salt_temporal', FALSE, TRUE),
(2, 'admin', 'Conductor Taximetro', 'admin@factoria.com', 'hash_temporal_admin', 'salt_temporal', FALSE, TRUE);

INSERT INTO seguridad.usuario_perfil (usuario_id, perfil_id) 
VALUES 
(1, 1), 
(2, 2); 

INSERT INTO taximetro.tarifas 
(estado_vehiculo, costo_por_segundo) 
VALUES 
('PARADO', 0.0200),
('MOVIMIENTO', 0.0500);

SELECT setval('seguridad.modulos_modulo_id_seq', (SELECT MAX(modulo_id) FROM seguridad.modulos));
SELECT setval('seguridad.perfiles_perfil_id_seq', (SELECT MAX(perfil_id) FROM seguridad.perfiles));
SELECT setval('seguridad.usuarios_usuario_id_seq', (SELECT MAX(usuario_id) FROM seguridad.usuarios));