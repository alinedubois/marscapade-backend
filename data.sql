CREATE DATABASE marscapade;

USE marscapade;

CREATE TABLE `circuit` (
`id` INT NOT NULL AUTO_INCREMENT,
`title` VARCHAR(100) NOT NULL,
`image_1` VARCHAR(250) NULL,
`image_2` VARCHAR(250) NULL,
`image_3` VARCHAR(250) NULL,
`image_4` VARCHAR(250) NULL,
`description` TEXT NULL,
`distance` INT NULL,
`duration` VARCHAR(10) NULL,
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

CREATE TABLE `admin` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(50) NOT NULL,
    `password` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`id`)
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


INSERT INTO activity(name, description, image_1, image_2, image_3, image_4, nbpax, location) VALUES ('Jardin d asperges','Rendez-vous jeu avec des asperges','https://scx2.b-cdn.net/gfx/news/hires/fivebipedalm.jpg','http://www.ffrob.fr/img/Toulouse-Robot-Race.jpg','https://www.1jour1actu.com/wp-content/uploads/P5A9842vf.jpg','https://fracademic.com/pictures/frwiki/75/KSC-03PD-0786.jpg', 9, 'Martian Race');
INSERT INTO activity(name, description, image_1, image_2, image_3, image_4, nbpax, location) VALUES ('Courses de Rovers','La Martian Robot Race est une course de vitesse : le vainqueur sera celui qui aura obtenu','https://scx2.b-cdn.net/gfx/news/hires/fivebipedalm.jpg','http://www.ffrob.fr/img/Toulouse-Robot-Race.jpg','https://www.1jour1actu.com/wp-content/uploads/P5A9842vf.jpg','https://fracademic.com/pictures/frwiki/75/KSC-03PD-0786.jpg', 9, 'Martian Race');
INSERT INTO activity(name, description, image_1, image_2, image_3, image_4, nbpax, location) VALUES ('Le potager sur Mars','Apprenez à planter et récolter des asperges martiennes, activité à faire en famille !','https://cdn.futura-sciences.com/buildsv6/images/mediumoriginal/3/2/9/329fea1da1_102937_mars-potager-nasa.jpg','https://static.lexpress.fr/medias_11407/w_630,h_352,c_crop,x_0,y_6/w_2000,h_1125,c_fill,g_north/v1489140559/seul-sur-mars-nasa-patate-mars_5840711.jpg','https://img.over-blog-kiwi.com/0/55/36/22/20170322/ob_e8295c_w-jeb11438-copie-medium.jpg','https://recette.supertoinette.com/151347/m/asperges.jpg', 5, 'partout sur Mars');
INSERT INTO activity(name, description, image_1, image_2, image_3, image_4, nbpax, location) VALUES ('Find the 7','Trouver les 7 rovers en marche et abandonnés disséminés sur la planète','https://upload.wikimedia.org/wikipedia/commons/a/a3/Rover1.jpg','https://www.numerama.com/wp-content/uploads/2021/01/curiosity-rover-mars.jpg','https://mars.nasa.gov/system/content_pages/main_images/382_viking-lander-PIA09703.jpg', 'https://www.cieletespace.fr/media/default/0001/15/Mars3_1000x700-5ac4.jpeg', 5, 'partout sur Mars');


INSERT INTO `circuit` (title, description, distance, duration, difflevel, image_1) VALUES ('Mont Olympe', 'Le Mont Olympe voila voila', 8000, '2h00', 'easy', 'https://imgur.com/a/1uPSzAN');
INSERT INTO `circuit` (title, description, distance, duration, difflevel, image_1) VALUES ('Mont Elysium', 'Le plus grand des Monts', 14000, '1h45', 'hard', 'https://albdoblog.files.wordpress.com/2019/04/mars__valles_marineris_by_grafik-d1yzdxv.jpg?w=705&h=435&crop=1');
INSERT INTO `circuit` (title, description, distance, duration, difflevel, image_1) VALUES ('Noctis Labyrinthus', 'vous vous y perdrez', 2000, '2h30', 'medium', 'https://zupimages.net/viewer.php?id=21/19/isfu.jpg');
INSERT INTO `circuit` (title, description, distance, duration, difflevel, image_1) VALUES ('Mawrth Vallis', 'la vallée du Mars et ça repart', 9500, '5h00', 'fatality', 'https://zupimages.net/up/21/19/id53.jpg');
INSERT INTO `circuit` (title, description, distance, duration, difflevel, image_1) VALUES ('Dunes Fantômes', 'Bhou!', 5700, '3h00', 'easy', 'https://zupimages.net/viewer.php?id=21/19/qsyo.jpg');

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

