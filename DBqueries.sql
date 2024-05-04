-- Операторы языка DDL

-- Добавление столбца в таблицу `products` для отображения наличие товара:
ALTER TABLE mydb.products
ADD COLUMN available BOOLEAN DEFAULT true;

-- Добавление ограничения целостности CHECK для таблицы `products` - цена должна быть больше нуля:
ALTER TABLE mydb.products
ADD CONSTRAINT check_if_price_is_positive CHECK (price > 0);


-- Операторы языка DML

-- Добавление новой строки в таблицу `clients` (новый клиент):
INSERT INTO mydb.clients (
id_client, 
name, 
surname, 
patronymic, 
cluster_name,
discount
)
VALUES (
1, 
'Ivan', 
'Ivanov', 
'Ivanovich', 
'Age:65+',
0
);


-- Изменение данных о пользователе категории возраст от 65:
UPDATE mydb.clients
SET discount = 0.25
WHERE cluster_name = 'Age:65+' AND id_client > 0;

-- Фиксируем изменения оператором языка TCL
COMMIT;


-- Операторы языка DQL

-- Выборка всех клиентов с их заказами, соединение таблицы clients и orders,
-- сортировка по имени клиентов в алфавитном порядке:
SELECT clients.name, orders.id_order, orders.status
FROM mydb.clients
LEFT JOIN mydb.orders ON clients.id_client = orders.clients_id_client
ORDER BY clients.name;


-- Выборка всех акций, которые актуальны в данный момент:
SELECT *
FROM mydb.promotions
WHERE NOW() BETWEEN start_time AND end_time;

-- Выборка и подсчёт продуктов (инструментов) с 3-мя струнами:
SELECT 
    COUNT(*) AS three_strings_count 
FROM 
    mydb.products 
WHERE 
    number_strings = 3;


-- Выборка всех заказов со статусом 'отправлен':
SELECT *
FROM mydb.orders
WHERE status = 2;

