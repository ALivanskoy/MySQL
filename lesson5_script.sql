USE lesson_4;

-- 1. Создайте представление, в которое попадет информация о пользователях (имя, фамилия, город и пол), которые не старше 20 лет.

CREATE OR REPLACE VIEW users_under20 AS

SELECT id, firstname, lastname, hometown, gender, birthday
FROM users u
LEFT JOIN profiles p
ON u.id = p.user_id
WHERE birthday >= CURDATE() - INTERVAL 20 YEAR;

SELECT * FROM users_under20;


/* 
2. Найдите кол-во, отправленных сообщений каждым пользователем и выведите ранжированный список пользователей, 
указав имя и фамилию пользователя, количество отправленных сообщений и место в рейтинге 
(первое место у пользователя с максимальным количеством сообщений). (используйте DENSE_RANK)
*/

-- Создание удобного представления для работы
CREATE OR REPLACE VIEW topmsg AS
SELECT 
u.id as id, firstname, lastname, 
COUNT(from_user_id) OVER (PARTITION BY from_user_id) AS messages_count
FROM messages m
LEFT JOIN users u
ON m.from_user_id = u.id;

-- Проверка представления
select * from topmsg;

-- Выборка
SELECT firstname, lastname, messages_count, 
DENSE_RANK() OVER (ORDER BY messages_count DESC) AS "Dense Rank"  
FROM topmsg
GROUP BY id ;


/* 
3. Выберите все сообщения, отсортируйте сообщения по возрастанию даты отправления (created_at) 
и найдите разницу дат отправления между соседними сообщениями, получившегося списка. (используйте LEAD или LAG)  
*/

-- Создание удобного представления для работы
CREATE OR REPLACE VIEW qwerty AS
SELECT id, created_at,
LAG(created_at, 1, 0) OVER w AS prev_msg_time,
LEAD(created_at, 1, 0) OVER w AS next_msg_time
FROM messages
WINDOW w AS (ORDER BY  created_at);

-- Проверка представления
select * from qwerty;

select id as msg_id,
TIMEDIFF(created_at, prev_msg_time) AS prev_time_gap,
TIMEDIFF(created_at, prev_msg_time) AS next_time_gap
from qwerty;
