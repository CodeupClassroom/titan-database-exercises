create database  if not exists codeup_teest_db;

USE codeup_teest_db;

DROP TABLE if exists albums;

CREATE TABLE IF NOT EXISTS albums (
                                      id INT UNSIGNED NOT NULL AUTO_INCREMENT,
                                      artist VARCHAR(100) NOT NULL,
                                      name VARCHAR(100) NOT NULL,
                                      release_date INT NOT NULL,
                                      sales FLOAT,
                                      genre VARCHAR(200),
                                      PRIMARY KEY (id)
)
