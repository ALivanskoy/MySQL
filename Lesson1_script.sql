# Создаём базу данных
DROP DATABASE IF EXISTS mobile_phones;
CREATE DATABASE mobile_phones;
USE mobile_phones;

# Создаём в базе данных таблицу
CREATE TABLE mobile_phones (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  product_name VARCHAR(45) NOT NULL,
  manufacturer VARCHAR(45) NOT NULL,
  product_count INT UNSIGNED NULL,
  price INT UNSIGNED NOT NULL);
  
# Наполняем таблицу объектами
INSERT INTO mobile_phones (product_name, manufacturer, product_count, price) 
VALUES
('iPhone X', 'Apple', '3', '76000'),
('iPhone 8', 'Apple', '2', '51000'),
('Galaxy S8', 'Samsung', '2', '41000'),
('Galaxy S9', 'Samsung', '1', '56000'),
('P20 Pro', 'Huawei', '5', '36000');

# 1. Выведим название, производителя и цену для товаров, количество которых превышает 2
SELECT product_name, manufacturer, price FROM mobile_phones WHERE product_count > 2;
 
# 2. Выведим весь ассортимент товаров марки “Samsung”
SELECT * FROM mobile_phones WHERE manufacturer = 'Samsung';

# 3. Товары, в которых есть упоминание "Iphone"
SELECT * FROM mobile_phones
WHERE 
product_name LIKE '%Iphone%';

# 4. Товары, в которых есть упоминание"Samsung"
SELECT * FROM mobile_phones
WHERE 
manufacturer LIKE '%Samsung%';

# 5. Товары, в которых есть ЦИФРЫ
SELECT * FROM mobile_phones
WHERE 
product_name LIKE ('%1%') OR
product_name LIKE ('%2%') OR
product_name LIKE ('%3%') OR
product_name LIKE ('%4%') OR
product_name LIKE ('%5%') OR
product_name LIKE ('%6%') OR
product_name LIKE ('%7%') OR
product_name LIKE ('%8%') OR
product_name LIKE ('%9%');

# 6. Товары, в которых есть ЦИФРА "8"
SELECT * FROM mobile_phones
WHERE 
product_name LIKE ('%8%');