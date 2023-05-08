--Вывести мужчин, которые в 2018 году получиои премию Лоуренсе Оливье
SELECT  first_name, last_name, nomination_name, achievement_name, performance_name
FROM performance, achievement_actor, nomination, achievement, person_general_information, sex
WHERE achievement_actor.performance_id = performance.performance_id
AND achievement_actor.nomination_id = nomination.nomination_id
AND nomination.achievement_id = achievement.achievement_id
AND achievement_name = 'Премия Лоуренсе Оливье'
AND achievement_actor.actor_id = person_general_information.person_id
AND person_general_information.sex_id = sex.sex_id
AND sex = 'Мужской'
AND DATEPART (year, date_of_getting) = 2018