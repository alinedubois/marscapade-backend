CREATE TABLE circuit
(
    id          SERIAL,
    title       VARCHAR(100) NOT NULL,
    image_1     VARCHAR(250) NULL,
    image_2     VARCHAR(250) NULL,
    image_3     VARCHAR(250) NULL,
    image_4     VARCHAR(250) NULL,
    description TEXT NULL,
    distance    INT NULL,
    duration    VARCHAR(10) NULL,
    difflevel   VARCHAR(10),
    PRIMARY KEY (id)
);


CREATE TABLE activity
(
    id          SERIAL,
    name        VARCHAR(100) NOT NULL,
    description TEXT NULL,
    price       DECIMAL      NOT NULL,
    image_1     VARCHAR(250) NULL,
    image_2     VARCHAR(250) NULL,
    image_3     VARCHAR(250) NULL,
    image_4     VARCHAR(250) NULL,
    nbpax       INT          NOT NULL,
    location    TEXT NULL,
    PRIMARY KEY (id)
);


CREATE TABLE martian
(
    id        SERIAL,
    firstname VARCHAR(100) NOT NULL,

    lastname  VARCHAR(100) NOT NULL,
    email     VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);


CREATE TABLE book_activity
(
    id_martian  INT NOT NULL,
    id_activity INT NOT NULL,
    PRIMARY KEY (id_martian, id_activity),
    CONSTRAINT fk_martian_activity FOREIGN KEY (id_martian)
        REFERENCES martian (id),
    CONSTRAINT fk_activity FOREIGN KEY (id_activity)
        REFERENCES activity (id)
);


CREATE TABLE book_circuit
(
    id_martian INT NOT NULL,
    id_circuit INT NOT NULL,
    PRIMARY KEY (id_martian, id_circuit),
    CONSTRAINT fk_martian_circuit FOREIGN KEY (id_martian)
        REFERENCES martian (id),
    CONSTRAINT fk_circuit FOREIGN KEY (id_circuit)
        REFERENCES circuit (id)
);

CREATE TABLE admin
(
    id       SERIAL,
    email    VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE circuit_images
(
    id         SERIAL,
    url        VARCHAR(500) NOT NULL,
    is_main    BOOLEAN      NOT NULL,
    id_circuit INT          NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_circuit_img FOREIGN KEY (id_circuit)
        REFERENCES circuit (id)
);

CREATE TABLE activity_images
(
    id          SERIAL,
    url         VARCHAR(500) NOT NULL,
    is_main     BOOLEAN      NOT NULL,
    id_activity INT          NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_activity_img FOREIGN KEY (id_activity)
        REFERENCES activity (id)
);