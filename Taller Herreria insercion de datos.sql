-- Inserción de datos

-- Clientes
INSERT INTO Clientes (nombre, telefono, email) VALUES
('Juan Pérez', '1134567890', 'juan@mail.com'),
('Laura Fernández', '1145678901', 'laura@mail.com');

-- Trabajos
INSERT INTO Trabajos (id_cliente, descripcion, fecha_inicio, fecha_fin, estado) VALUES
(1, 'Reja de ventana artística', '2025-05-01', '2025-05-10', 'Completado'),
(2, 'Portón corredizo reforzado', '2025-05-05', NULL, 'En proceso');

-- Materiales
INSERT INTO Materiales (nombre, tipo, unidad_medida, precio_estimado) VALUES
('Hierro ángulo', 'chapa', 'metro', 800.00),
('Electrodo E6013', 'consumible', 'unidad', 120.00);

-- Detalle_Materiales_Trabajo
INSERT INTO Detalle_Materiales_Trabajo (id_trabajo, id_material, cantidad) VALUES
(1, 1, 6.5),
(1, 2, 10),
(2, 1, 12);

-- Presupuestos
INSERT INTO Presupuestos (id_trabajo, fecha, monto_total, observaciones) VALUES
(1, '2025-04-25', 15000.00, 'Incluye materiales reciclados'),
(2, '2025-05-02', 27000.00, 'Falta definir automatización');

-- Pagos
INSERT INTO Pagos (id_trabajo, fecha, monto, metodo_pago) VALUES
(1, '2025-05-10', 15000.00, 'Efectivo'),
(2, '2025-05-07', 15000.00, 'Transferencia');


