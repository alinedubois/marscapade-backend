CREATE TABLE `circuit` (
`id` INT NOT NULL AUTO_INCREMENT,
`title` VARCHAR(100) NOT NULL,
`image_1` VARCHAR(250) NULL,
`image_2` VARCHAR(250) NULL,
`image_3` VARCHAR(250) NULL,
`image_4` VARCHAR(250) NULL,
`description` TEXT NULL,
`distance` INT NULL,

`duration` TIMESTAMP NULL,

`difflevel` VARCHAR(10),
PRIMARY KEY (`id`)
);

alter table circuit add image_4 varchar(250);


CREATE TABLE `activity` (
`id` INT NOT NULL AUTO_INCREMENT,
`name` VARCHAR(100) NOT NULL,
`description` VARCHAR(100) NOT NULL,
`image_1` VARCHAR(250) NULL,
`image_2` VARCHAR(250) NULL,
`image_3` VARCHAR(250) NULL,
`image_4` VARCHAR(250) NULL,
`nbpax` INT NOT NULL,
`location` TEXT NULL,
PRIMARY KEY (`id`)
);


CREATE TABLE `martian` (
`id` INT NOT NULL AUTO_INCREMENT,
`firstname` VARCHAR(100) NOT NULL,

`lastname` VARCHAR(100) NOT NULL,
`email` VARCHAR(100) NOT NULL,
PRIMARY KEY (`id`)
);


CREATE TABLE `book_activity` (
`id_martian` INT NOT NULL,
`id_activity` INT NOT NULL,
PRIMARY KEY (`id_martian`, `id_activity`),
CONSTRAINT fk_martian_activity FOREIGN KEY (id_martian) 
REFERENCES martian(id),
CONSTRAINT fk_activity FOREIGN KEY (id_activity) 
REFERENCES activity(id) 
);


CREATE TABLE `book_circuit` (
`id_martian` INT NOT NULL,
`id_circuit` INT NOT NULL,
PRIMARY KEY (`id_martian`, `id_circuit`),
CONSTRAINT fk_martian_circuit FOREIGN KEY (id_martian) 
REFERENCES martian(id),
CONSTRAINT fk_circuit FOREIGN KEY (id_circuit)  
REFERENCES circuit(id) 
);

CREATE TABLE `circuit_images` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `url` VARCHAR(500) NOT NULL,
    `is_main` BOOLEAN NOT NULL,
    `id_circuit` INT NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT fk_circuit_img FOREIGN KEY (id_circuit)
    REFERENCES circuit(id)
);

CREATE TABLE `activity_images` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `url` VARCHAR(500) NOT NULL,
    `is_main` BOOLEAN NOT NULL,
    `id_activity` INT NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT fk_activity_img FOREIGN KEY (id_activity)
    REFERENCES activity(id)
);


INSERT INTO circuit_images (url, is_main, id_circuit) values ('https://imgur.com/a/1uPSzAN', true, 1), ('', false, 1), ('https://imgur.com/a/W0m6W2P', true, 2), ('', false, 2);

INSERT INTO activity_images (url, is_main, id_activity) values ('https://imgur.com/a/3boiSfg', true, 2), ('https://imgur.com/a/0nzQAhw', true, 1);

UPDATE circuit SET image_1 = 'https://imgur.com/a/W0m6W2P' WHERE id = 2;


SELECT *
FROM circuit
INNER JOIN circuit_images 
ON circuit.id = circuit_images.id_circuit

SELECT *
FROM circuit
INNER JOIN circuit_images 
ON circuit.id = circuit_images.id_circuit
WHERE id = ?

