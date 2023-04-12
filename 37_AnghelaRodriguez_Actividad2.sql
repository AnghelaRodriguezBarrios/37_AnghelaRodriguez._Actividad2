/* Si la base de datos ya existe la eliminamos */
DROP DATABASE IF EXISTS db_SalesClothes;

/* Crear base de datos Sales Clothes */
CREATE DATABASE db_SalesClothes;

/* Poner en uso la base de datos */
USE db_SalesClothes;


/* Poner en uso base de datos master
USE master;*/

/* Eliminar base de datos
DROP DATABASE db_SalesClothes;*/

/*Crear tabla client*/
CREATE TABLE client (
    id_client int,
    type_document char(3),
    number_document varchar(15),
    names varchar(60),
    last_name varchar(90),
    email varchar(80),
    cell_phone char(9),
    birthdate date,
    active bit,
    CONSTRAINT client_pk PRIMARY KEY  (id_client)
);

/* Ver estructura de tabla client */
EXEC sp_columns @table_name = 'client';

/* Eliminar tabla client
DROP TABLE client;*/

/*Crear tabla seller*/
CREATE TABLE seller (
    id_seller int,
    type_document char(3),
    number_document varchar(15),
    names varchar(60),
    last_name varchar(90),
    salary decimal(8,2),
    cell_phone char(9),
    email varchar(80),
    activo bit,
    CONSTRAINT seller_pk PRIMARY KEY  (id_seller)
);

/* Ver estructura de tabla seller */
EXEC sp_columns @table_name = 'seller';

/*Crear tabla clothes*/
CREATE TABLE clothes (
    id_clothes int,
    description varchar(60),
    brand varchar(60),
    amount int,
    size varchar(10),
    price decimal(8,2),
    active bit,
    CONSTRAINT clothes_pk PRIMARY KEY  (id_clothes)
);

/* Ver estructura de tabla clothes */
EXEC sp_columns @table_name = 'clothes';

/*Crear tabla sale*/
CREATE TABLE sale (
    id_sale int,
    date_time datetime,
    active bit,
    id_client int,
    id_seller int,
    CONSTRAINT sale_pk PRIMARY KEY  (id_sale)
);

/* Ver estructura de tabla sale */
EXEC sp_columns @table_name = 'sale';

/*Crear tabla sale_detail*/
CREATE TABLE sale_detail (
    id_sale_detail int,
    amount int,
    id_sale int,
    id_clothes int,
    CONSTRAINT sale_detail_pk PRIMARY KEY  (id_sale_detail)
);

/* Ver estructura de tabla sale_detail */
EXEC sp_columns @table_name = 'sale_detail';

/* Relacionar tabla sale con tabla client (table: sale) */
ALTER TABLE sale 
ADD CONSTRAINT sale_client FOREIGN KEY (id_client)
    REFERENCES client (id_client)
	ON UPDATE CASCADE 
    ON DELETE CASCADE;

/* Relacionar tabla sale con sale_detail_clothes (table: sale_detail) */
ALTER TABLE sale_detail 
ADD CONSTRAINT sale_detail_clothes FOREIGN KEY (id_clothes)
    REFERENCES clothes (id_clothes)
	ON UPDATE CASCADE 
    ON DELETE CASCADE;

/* Relacionar tabla sale con sale_detail_sale (table: sale_detail) */
ALTER TABLE sale_detail 
ADD CONSTRAINT sale_detail_sale FOREIGN KEY (id_sale)
    REFERENCES sale (id_sale)
	ON UPDATE CASCADE 
    ON DELETE CASCADE;

/* Relacionar tabla sale con sale_seller (table: sale) */
ALTER TABLE sale 
ADD CONSTRAINT sale_seller FOREIGN KEY (id_seller)
    REFERENCES seller (id_seller)
	ON UPDATE CASCADE 
    ON DELETE CASCADE;

/* Ver relaciones creadas entre las tablas de la base de datos */
SELECT 
    fk.name [Constraint],
    OBJECT_NAME(fk.parent_object_id) [Tabla],
    COL_NAME(fc.parent_object_id,fc.parent_column_id) [Columna FK],
    OBJECT_NAME (fk.referenced_object_id) AS [Tabla base],
    COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS [Columna PK]
FROM 
    sys.foreign_keys fk
    INNER JOIN sys.foreign_key_columns fc ON (fk.OBJECT_ID = fc.constraint_object_id);

/* Eliminar una relación
ALTER TABLE sale
	DROP CONSTRAINT sale_client*/

/* Ver relaciones creadas entre las tablas de la base de datos */
SELECT 
    fk.name [Constraint],
    OBJECT_NAME(fk.parent_object_id) [Tabla],
    COL_NAME(fc.parent_object_id,fc.parent_column_id) [Columna FK],
    OBJECT_NAME (fk.referenced_object_id) AS [Tabla base],
    COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS [Columna PK]
FROM 
    sys.foreign_keys fk
    INNER JOIN sys.foreign_key_columns fc ON (fk.OBJECT_ID = fc.constraint_object_id);
