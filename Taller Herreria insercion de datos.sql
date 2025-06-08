-- Inserción de datos extendido para análisis

-- Clientes
INSERT INTO Clientes (nombre, telefono, email) VALUES
('Juan Pérez', '1134567890', 'juan@mail.com'),
('Laura Fernández', '1145678901', 'laura@mail.com'),
('Carlos Díaz', '1156789012', 'carlos@mail.com'),
('Marta Gómez', '1167890123', 'marta@mail.com'),
('Lucía Romero', '1178901234', 'lucia@mail.com');

-- Materiales
INSERT INTO Materiales (nombre, tipo, unidad_medida, precio_estimado) VALUES
('Hierro ángulo', 'chapa', 'metro', 800.00),
('Electrodo E6013', 'consumible', 'unidad', 120.00),
('Chapa galvanizada', 'chapa', 'm2', 950.00),
('Tubo estructural', 'estructura', 'metro', 1100.00);

-- Inventario
INSERT INTO Inventario (id_material, cantidad_disponible) VALUES
(1, 4), (2, 50), (3, 8), (4, 3);

-- Precios materiales
INSERT INTO Precios_Materiales (id_material, fecha, precio_unitario) VALUES
(1, '2025-05-01', 800.00),
(1, '2025-06-01', 820.00),
(2, '2025-05-01', 120.00),
(3, '2025-06-01', 950.00),
(4, '2025-06-01', 1100.00);

-- Trabajos
INSERT INTO Trabajos (id_cliente, descripcion, fecha_inicio, fecha_fin, estado) VALUES
(1, 'Reja de ventana artística', '2025-05-01', '2025-05-10', 'Completado'),
(2, 'Portón corredizo reforzado', '2025-05-05', NULL, 'En proceso'),
(3, 'Puerta de chapa', '2025-05-10', NULL, 'Pendiente'),
(4, 'Baranda de escalera', '2025-06-01', NULL, 'Pendiente'),
(5, 'Reja perimetral', '2025-06-03', NULL, 'Pendiente');

-- Detalle materiales por trabajo
INSERT INTO Detalle_Materiales_Trabajo (id_trabajo, id_material, cantidad) VALUES
(1, 1, 6.5),
(1, 2, 10),
(2, 1, 12),
(2, 4, 4),
(3, 3, 3.5),
(4, 4, 6);

-- Presupuestos
INSERT INTO Presupuestos (id_trabajo, fecha, monto_total, observaciones) VALUES
(1, '2025-04-25', 15000.00, 'Incluye materiales reciclados'),
(2, '2025-05-02', 27000.00, 'Falta definir automatización'),
(3, '2025-05-08', 12000.00, ''),
(4, '2025-05-30', 18000.00, 'Requiere terminación artística'),
(5, '2025-06-01', 20000.00, 'Proyecto a largo plazo');

-- Pagos
INSERT INTO Pagos (id_trabajo, fecha, monto, metodo_pago) VALUES
(1, '2025-05-10', 15000.00, 'Efectivo'),
(2, '2025-05-07', 15000.00, 'Transferencia'),
(2, '2025-06-01', 12000.00, 'Efectivo'),
(3, '2025-06-03', 5000.00, 'Efectivo'),
(5, '2025-06-04', 20000.00, 'Transferencia');