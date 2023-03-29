USE lesson_4;

-- Подсчитать общее количество лайков, которые получили пользователи младше 12 лет.

SELECT COUNT(*) as Likes 
FROM likes l
LEFT JOIN profiles p ON l.user_id = p.user_id
WHERE birthday >= CURDATE() - INTERVAL 12 YEAR;

-- Определить кто больше поставил лайков (всего): мужчины или женщины.

SELECT gender, COUNT(gender) as LikesNumber FROM likes l LEFT JOIN profiles p ON l.user_id = p.user_id WHERE gender = "f"

UNION

SELECT gender, COUNT(gender) as LikesNumber FROM likes l LEFT JOIN profiles p ON l.user_id = p.user_id WHERE gender = "m";

-- Вывести всех пользователей, которые не отправляли сообщения.

SELECT u.id, CONCAT(firstname,' ', lastname) AS Name
FROM users u
LEFT JOIN (SELECT DISTINCT from_user_id FROM messages) m
ON u.id= m.from_user_id
WHERE m.from_user_id IS NULL;





