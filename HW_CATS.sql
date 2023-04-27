DROP DATABASE IF EXISTS lesson_4;
CREATE DATABASE IF NOT EXISTS lesson_4;
USE lesson_4;


DROP TABLE IF EXISTS shops; 
CREATE TABLE IF NOT EXISTS shops 
(
	id INT,
    shop_name VARCHAR (100),
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS cats; 
CREATE TABLE IF NOT EXISTS cats 
(
	cat_name VARCHAR (100),
    id INT,
    PRIMARY KEY (id),
    shops_id INT,
    CONSTRAINT fk_cats_shops_id FOREIGN KEY (shops_id)
        REFERENCES shops (id)
);

INSERT INTO shops
VALUES 
		(1, "Четыре лапы"),
        (2, "Мистер Зоо"),
        (3, "МурзиЛЛа"),
        (4, "Кошки и собаки");

INSERT INTO cats
VALUES 
		("Murzik",1,1),
        ("Nemo",2,2),
        ("Vicont",3,1),
        ("Zuza",4,3);


-- 1. Вывести всех котиков по магазинам по id (условие соединения shops.id = cats.shops_id)

SELECT s.id, s.shop_name, c.id, c.cat_name
FROM shops AS s
LEFT JOIN cats AS c
ON s.id = c.shops_id;


-- 2. Вывести магазин, в котором продается кот “Мурзик” (попробуйте выполнить 2 способами)

-- a) Первый способ

SELECT s.id, s.shop_name, c.id, c.cat_name
FROM shops s
JOIN cats c
ON s.id = c.shops_id
WHERE cat_name = "Murzik";


-- b) Вывести магазин, в котором продается кот “Мурзик” с помощью подзапроса

SELECT s.*, murzik.*
FROM shops s
JOIN (SELECT cat_name, shops_id, id FROM cats
WHERE cat_name = "Nemo") murzik
ON s.id = murzik.id;


-- 3. Вывести магазины, в которых НЕ продаются коты “Мурзик” и “Zuza”

SELECT s.id, s.shop_name
FROM shops s
JOIN cats c
ON s.id = c.shops_id
WHERE cat_name != "Murzik" && cat_name != "Zuza";