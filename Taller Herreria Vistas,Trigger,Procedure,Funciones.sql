-- Vistas

-- Vista 1: Listado de trabajos con datos del cliente
CREATE VIEW vista_trabajos_clientes AS
SELECT t.id_trabajo, t.descripcion, t.estado, c.nombre AS cliente, t.fecha_inicio, t.fecha_fin
FROM Trabajos t
JOIN Clientes c ON t.id_cliente = c.id_cliente;

-- Vista 2: Resumen de pagos por trabajo
CREATE VIEW vista_resumen_pagos AS
SELECT t.id_trabajo, t.descripcion, SUM(p.monto) AS total_pagado
FROM Trabajos t
LEFT JOIN Pagos p ON t.id_trabajo = p.id_trabajo
GROUP BY t.id_trabajo, t.descripcion;

-- Vista 3: Materiales utilizados en cada trabajo
CREATE VIEW vista_materiales_por_trabajo AS
SELECT t.id_trabajo, t.descripcion, m.nombre AS material, d.cantidad, m.unidad_medida
FROM Trabajos t
JOIN Detalle_Materiales_Trabajo d ON t.id_trabajo = d.id_trabajo
JOIN Materiales m ON d.id_material = m.id_material;

-- Vista 4: Trabajos ordenados por fecha
CREATE VIEW vista_trabajos_ordenados_fecha AS
SELECT * FROM Trabajos
ORDER BY fecha_inicio ASC;

-- Vista 5: Precios actuales de materiales
CREATE VIEW vista_precios_actuales AS
SELECT pm.id_material, m.nombre, pm.precio_unitario, pm.fecha
FROM Precios_Materiales pm
JOIN Materiales m ON pm.id_material = m.id_material
WHERE pm.fecha = (
    SELECT MAX(fecha)
    FROM Precios_Materiales pm2
    WHERE pm2.id_material = pm.id_material
);

-- Funciones

-- Función 1: Verificar si un trabajo está totalmente pagado
DELIMITER //
CREATE FUNCTION trabajo_pagado(trabajo_id INT) RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE total_pago DECIMAL(10,2);
    DECLARE total_presupuesto DECIMAL(10,2);

    SELECT SUM(monto) INTO total_pago FROM Pagos WHERE id_trabajo = trabajo_id;
    SELECT monto_total INTO total_presupuesto FROM Presupuestos WHERE id_trabajo = trabajo_id;

    IF total_pago >= total_presupuesto THEN
        RETURN 'Pagado';
    ELSE
        RETURN 'Pendiente';
    END IF;
END//
DELIMITER ;

-- Función 2: Verificar si un material necesita reposición
DELIMITER //
CREATE FUNCTION necesita_reposicion(id_mat INT) RETURNS VARCHAR(2)
DETERMINISTIC
BEGIN
    DECLARE stock DECIMAL(10,2);
    SELECT cantidad_disponible INTO stock
    FROM Inventario
    WHERE id_material = id_mat;

    IF stock < 5 THEN
        RETURN 'Sí';
    ELSE
        RETURN 'No';
    END IF;
END//
DELIMITER ;


-- Stored Procedure: Registrar trabajo con presupuesto asociado
DELIMITER //
CREATE PROCEDURE registrar_trabajo_con_presupuesto(
    IN p_id_cliente INT,
    IN p_descripcion TEXT,
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE,
    IN p_estado VARCHAR(50),
    IN p_fecha_presupuesto DATE,
    IN p_monto_total DECIMAL(10,2),
    IN p_observaciones TEXT
)
BEGIN
    DECLARE nuevo_trabajo_id INT;

    INSERT INTO Trabajos (id_cliente, descripcion, fecha_inicio, fecha_fin, estado)
    VALUES (p_id_cliente, p_descripcion, p_fecha_inicio, p_fecha_fin, p_estado);

    SET nuevo_trabajo_id = LAST_INSERT_ID();

    INSERT INTO Presupuestos (id_trabajo, fecha, monto_total, observaciones)
    VALUES (nuevo_trabajo_id, p_fecha_presupuesto, p_monto_total, p_observaciones);
END//
DELIMITER ;

-- Stored Procedure: Registrar pago de un trabajo
DELIMITER //
CREATE PROCEDURE registrar_pago(
    IN p_id_trabajo INT,
    IN p_fecha DATE,
    IN p_monto DECIMAL(10,2),
    IN p_metodo_pago VARCHAR(50)
)
BEGIN
    INSERT INTO Pagos (id_trabajo, fecha, monto, metodo_pago)
    VALUES (p_id_trabajo, p_fecha, p_monto, p_metodo_pago);
END//
DELIMITER ;

-- Trigger 1: Actualizar inventario cuando se usa material
DELIMITER //
CREATE TRIGGER actualizar_stock_material
AFTER INSERT ON Detalle_Materiales_Trabajo
FOR EACH ROW
BEGIN
    UPDATE Inventario
    SET cantidad_disponible = cantidad_disponible - NEW.cantidad
    WHERE id_material = NEW.id_material;
END//
DELIMITER ;

-- Trigger 2: Registrar historial de estado de trabajo
DELIMITER //
CREATE TRIGGER registrar_cambio_estado
BEFORE UPDATE ON Trabajos
FOR EACH ROW
BEGIN
    IF NEW.estado <> OLD.estado THEN
        INSERT INTO Historial_Estado_Trabajo (id_trabajo, fecha, estado_anterior, estado_nuevo, observaciones)
        VALUES (NEW.id_trabajo, CURDATE(), OLD.estado, NEW.estado, 'Cambio automático registrado por trigger');
    END IF;
END//
DELIMITER ;
