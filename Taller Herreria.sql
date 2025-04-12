-- Script SQL para sistema de gestión de taller metalúrgico

-- Creo la base de datos
CREATE DATABASE IF NOT EXISTS taller_herreria;
USE taller_herreria;

-- Tabla de Clientes
CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100)
);

-- Tabla de Trabajos
CREATE TABLE Trabajos (
    id_trabajo INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    descripcion TEXT,
    fecha_inicio DATE,
    fecha_fin DATE,
    estado VARCHAR(50),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

-- Tabla de Materiales
CREATE TABLE Materiales (
    id_material INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo VARCHAR(50),
    unidad_medida VARCHAR(20),
    precio_estimado DECIMAL(10,2)
);

-- Tabla intermedia: Materiales usados en cada trabajo
CREATE TABLE Detalle_Materiales_Trabajo (
    id_trabajo INT,
    id_material INT,
    cantidad DECIMAL(10,2),
    PRIMARY KEY (id_trabajo, id_material),
    FOREIGN KEY (id_trabajo) REFERENCES Trabajos(id_trabajo),
    FOREIGN KEY (id_material) REFERENCES Materiales(id_material)
);

-- Tabla de Presupuestos
CREATE TABLE Presupuestos (
    id_presupuesto INT AUTO_INCREMENT PRIMARY KEY,
    id_trabajo INT NOT NULL,
    fecha DATE,
    monto_total DECIMAL(10,2),
    observaciones TEXT,
    FOREIGN KEY (id_trabajo) REFERENCES Trabajos(id_trabajo)
);

-- Tabla de Pagos
CREATE TABLE Pagos (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_trabajo INT NOT NULL,
    fecha DATE,
    monto DECIMAL(10,2),
    metodo_pago VARCHAR(50),
    FOREIGN KEY (id_trabajo) REFERENCES Trabajos(id_trabajo)
);
