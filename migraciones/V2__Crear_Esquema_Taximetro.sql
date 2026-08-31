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
