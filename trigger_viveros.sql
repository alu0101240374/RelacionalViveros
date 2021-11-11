DROP TABLE IF EXISTS VIVEROS;

CREATE TABLE IF NOT EXISTS VIVEROS (
  Latitud INT NOT NULL,
  Longitud INT NOT NULL,
  Localidad VARCHAR(30) NULL,
  PRIMARY KEY (Latitud, Longitud));


-- -----------------------------------------------------
-- Table ZONAS
-- -----------------------------------------------------
DROP TABLE IF EXISTS ZONAS ;

CREATE TABLE IF NOT EXISTS ZONAS (
  VIVEROS_Latitud INT NOT NULL,
  VIVEROS_Longitud INT NOT NULL,
  Nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (VIVEROS_Latitud, VIVEROS_Longitud, Nombre),
  CONSTRAINT fk_ZONAS_VIVEROS
    FOREIGN KEY (VIVEROS_Latitud , VIVEROS_Longitud)
    REFERENCES VIVEROS (Latitud , Longitud)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table EMPLEADO
-- -----------------------------------------------------
DROP TABLE IF EXISTS EMPLEADO;

CREATE TABLE IF NOT EXISTS EMPLEADO (
  DNI VARCHAR(9) NOT NULL,
  Nombre VARCHAR(20) NULL,
  Sueldo FLOAT NULL,
  Css VARCHAR(40) NULL,
  Ambiguedad VARCHAR(45) NULL,
  Correo VARCHAR(60) NULL,
  PRIMARY KEY (DNI));

-- -----------------------------------------------------
-- Table Trabaja_Zona_Empleado
-- -----------------------------------------------------
DROP TABLE IF EXISTS trabaja_ZONA_EMPLEADO ;

CREATE TABLE IF NOT EXISTS trabaja_ZONA_EMPLEADO (
  ZONAS_VIVEROS_Latitud INT NOT NULL,
  ZONAS_VIVEROS_Longitud INT NOT NULL,
  ZONAS_Nombre VARCHAR(45) NOT NULL,
  EMPLEADO_DNI VARCHAR(9) NOT NULL,
  Fecha_ini DATE NOT NULL,
  Fecha_fin DATE NULL,
  Ventas INT NULL,
  PRIMARY KEY (Fecha_ini),
  CONSTRAINT fk_trabaja_ZONA_EMPLEADO_ZONAS1
    FOREIGN KEY (ZONAS_VIVEROS_Latitud , ZONAS_VIVEROS_Longitud , ZONAS_Nombre)
    REFERENCES ZONAS (VIVEROS_Latitud , VIVEROS_Longitud , Nombre)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_trabaja_ZONA_EMPLEADO_EMPLEADO1
    FOREIGN KEY (EMPLEADO_DNI)
    REFERENCES EMPLEADO (DNI)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table PRODUCTO
-- -----------------------------------------------------
DROP TABLE IF EXISTS PRODUCTO;

CREATE TABLE IF NOT EXISTS PRODUCTO (
  Cod_producto INT NOT NULL,
  Stock INT NULL DEFAULT 0,
  Precio FLOAT NULL,
  PRIMARY KEY (Cod_producto));


-- -----------------------------------------------------
-- Table PRODUCTO_ubica_VIVEROS
-- -----------------------------------------------------
DROP TABLE IF EXISTS PRODUCTO_ubica_VIVEROS;

CREATE TABLE IF NOT EXISTS PRODUCTO_ubica_VIVEROS (
  PRODUCTO_Cod_producto INT NOT NULL,
  VIVEROS_Latitud INT NOT NULL,
  VIVEROS_Longitud INT NOT NULL,
  Cantidad_Stock INT NOT NULL,
  CONSTRAINT fk_PRODUCTO_has_VIVEROS_PRODUCTO1
    FOREIGN KEY (PRODUCTO_Cod_producto)
    REFERENCES PRODUCTO (Cod_producto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_PRODUCTO_has_VIVEROS_VIVEROS1
    FOREIGN KEY (VIVEROS_Latitud , VIVEROS_Longitud)
    REFERENCES VIVEROS (Latitud , Longitud)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table CLIENTE
-- -----------------------------------------------------
DROP TABLE IF EXISTS CLIENTE ;

CREATE TABLE IF NOT EXISTS CLIENTE (
  DNI VARCHAR(9) NOT NULL,
  Bonificacion INT NULL,
  Total_mesual FLOAT NULL,
  PRIMARY KEY (DNI));


-- -----------------------------------------------------
-- Table compra_PRODUCTO_EMPLEADO_CLIENTE
-- -----------------------------------------------------
DROP TABLE IF EXISTS compra_PRODUCTO_EMPLEADO_CLIENTE;

CREATE TABLE IF NOT EXISTS compra_PRODUCTO_EMPLEADO_CLIENTE (
  Fecha DATE NOT NULL,
  PRODUCTO_Cod_producto INT NOT NULL,
  CLIENTE_DNI VARCHAR(9) NOT NULL,
  EMPLEADO_DNI VARCHAR(9) NOT NULL,
  Cantidad INT NULL,
  PRIMARY KEY (Fecha),
  CONSTRAINT fk_PRODUCTO_has_CLIENTE_PRODUCTO1
    FOREIGN KEY (PRODUCTO_Cod_producto)
    REFERENCES PRODUCTO (Cod_producto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_PRODUCTO_has_CLIENTE_CLIENTE1
    FOREIGN KEY (CLIENTE_DNI)
    REFERENCES CLIENTE (DNI)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_PRODUCTO_compra_CLIENTE_EMPLEADO1
    FOREIGN KEY (EMPLEADO_DNI)
    REFERENCES EMPLEADO (DNI)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);




START TRANSACTION;

INSERT INTO VIVEROS (Latitud, Longitud, Localidad) VALUES (54321, 12345, 'La Laguna');
INSERT INTO VIVEROS (Latitud, Longitud, Localidad) VALUES (23423, 645645, 'Adeje');

COMMIT;


-- -----------------------------------------------------
-- Data for table ZONAS
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO ZONAS (VIVEROS_Latitud, VIVEROS_Longitud, Nombre) VALUES (54321, 12345, 'ALMACEN');
INSERT INTO ZONAS (VIVEROS_Latitud, VIVEROS_Longitud, Nombre) VALUES (54321, 12345, 'RECOGIDA');
INSERT INTO ZONAS (VIVEROS_Latitud, VIVEROS_Longitud, Nombre) VALUES (54321, 12345, 'ENTREGA');
INSERT INTO ZONAS (VIVEROS_Latitud, VIVEROS_Longitud, Nombre) VALUES (54321, 12345, 'CAJAS');

COMMIT;


-- -----------------------------------------------------
-- Data for table EMPLEADO
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO EMPLEADO (DNI, Sueldo, Css, Ambiguedad, Nombre, Correo) VALUES ('42245738W', 1000, '453834773', '1.50', 'Perita', NULL);
INSERT INTO EMPLEADO (DNI, Sueldo, Css, Ambiguedad, Nombre, Correo) VALUES ('40045738W', 1000, '453834773', '1.50', 'Perita', NULL);
COMMIT;


-- -----------------------------------------------------
-- Data for table Trabaja_Zona_Empleado
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO trabaja_Zona_Empleado (fecha_ini, fecha_fin, ventas, EMPLEADO_DNI, ZONAS_VIVEROS_Latitud, ZONAS_VIVEROS_Longitud, ZONAS_Nombre) VALUES ('2021-05-08', '2021-06-08', NULL, '42245738W', 54321, 12345, 'ALMACEN');

COMMIT;


-- -----------------------------------------------------
-- Data for table PRODUCTO
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO PRODUCTO (Cod_producto, Precio) VALUES (1111, 1.95);

COMMIT;


-- -----------------------------------------------------
-- Data for table PRODUCTO_ubica_VIVEROS
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO PRODUCTO_ubica_VIVEROS (PRODUCTO_Cod_producto, VIVEROS_Latitud, VIVEROS_Longitud, Cantidad_Stock) VALUES (1111, 54321, 12345, 3);
INSERT INTO PRODUCTO_ubica_VIVEROS (PRODUCTO_Cod_producto, VIVEROS_Latitud, VIVEROS_Longitud, Cantidad_Stock) VALUES (1111, 23423, 645645, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table CLIENTE
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO CLIENTE (DNI, Bonificacion, Total_mesual) VALUES ('11111111A', NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table compra_PRODUCTO_EMPLEADO_CLIENTE
-- -----------------------------------------------------
START TRANSACTION;

INSERT INTO compra_PRODUCTO_EMPLEADO_CLIENTE (Fecha, PRODUCTO_Cod_producto, CLIENTE_DNI, EMPLEADO_DNI, Cantidad) VALUES ('2021-05-14', 1111, '11111111A', '42245738W', 1);

COMMIT;


/* Create function 'create_email' */
CREATE OR REPLACE FUNCTION create_email() RETURNS TRIGGER AS $create_email$
   BEGIN
      IF new.Correo IS NULL THEN
        new.Correo := CONCAT(new.Nombre, '@', TG_ARGV[0]);
      ELSE
        IF new.Correo !~ '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$' THEN
          RAISE EXCEPTION 'Invalid email'
          USING HINT = 'Please check your user email format';
        END IF;
      END IF;
      RETURN NEW;
   END;
$create_email$ LANGUAGE plpgsql;

/* Create trigger 'employee_insert_trigger' */
DROP TRIGGER IF EXISTS create_email ON EMPLEADO;

CREATE TRIGGER create_email BEFORE INSERT ON EMPLEADO
FOR EACH ROW EXECUTE PROCEDURE create_email('viveros.com');

/* Create funtion 'locality_check' */
CREATE OR REPLACE FUNCTION locality_check() RETURNS TRIGGER AS $locality_check$
        BEGIN
                IF ((new.localidad IS NOT NULL) AND (new.localidad = ANY(SELECT localidad FROM VIVEROS)))
                        THEN
                        RAISE EXCEPTION 'Existing locality';
                END IF;
                RETURN NEW;
        END;
$locality_check$ LANGUAGE plpgsql;

/* Create trigger 'locality_check' */
DROP TRIGGER IF EXISTS locality_check ON VIVEROS;

CREATE TRIGGER locality_check BEFORE INSERT ON VIVEROS
FOR EACH ROW EXECUTE PROCEDURE locality_check();



/* Create funtion 'stock_update_on_insert' */
CREATE OR REPLACE FUNCTION stock_update_on_insert() RETURNS TRIGGER AS $stock_update_on_insert$
        BEGIN
                UPDATE PRODUCTO
                SET Stock = Stock + new.Cantidad_Stock
                WHERE Cod_Producto = new.PRODUCTO_Cod_Producto;
        RETURN NEW;
        END;
$stock_update_on_insert$ LANGUAGE plpgsql;

/* Create trigger 'stock_update_on_insert' */
DROP TRIGGER IF EXISTS stock_update_on_insert ON PRODUCTO_ubica_VIVEROS;

CREATE TRIGGER stock_update_on_insert BEFORE INSERT ON PRODUCTO_ubica_VIVEROS
FOR EACH ROW EXECUTE PROCEDURE stock_update_on_insert();


/* Create funtion 'stock_update_on_update' */
CREATE OR REPLACE FUNCTION stock_update_on_update() RETURNS TRIGGER AS $stock_update_on_update$
        BEGIN
                UPDATE PRODUCTO
                SET Stock = Stock - old.Cantidad_Stock + new.Cantidad_Stock
                WHERE Cod_Producto = new.PRODUCTO_Cod_Producto;
                RETURN NEW;
        END;
$stock_update_on_update$ LANGUAGE plpgsql;

/* Create trigger 'stock_update_on_update' */
DROP TRIGGER IF EXISTS stock_update_on_update ON PRODUCTO_ubica_VIVEROS;

CREATE TRIGGER stock_update_on_update BEFORE UPDATE ON PRODUCTO_ubica_VIVEROS
FOR EACH ROW EXECUTE PROCEDURE stock_update_on_update();


/* Create funtion 'stock_update_on_update' */
CREATE OR REPLACE FUNCTION stock_update_on_delete() RETURNS TRIGGER AS $stock_update_on_delete$
        BEGIN
                UPDATE PRODUCTO
                SET Stock = Stock - old.Cantidad_Stock
                WHERE Cod_Producto = old.PRODUCTO_Cod_Producto;
                RETURN OLD;
        END;
$stock_update_on_delete$ LANGUAGE plpgsql;

/* Create trigger 'stock_update_on_update' */
DROP TRIGGER IF EXISTS stock_update_on_delete ON PRODUCTO_ubica_VIVEROS;

CREATE TRIGGER stock_update_on_delete BEFORE DELETE ON PRODUCTO_ubica_VIVEROS
FOR EACH ROW EXECUTE PROCEDURE stock_update_on_delete();
