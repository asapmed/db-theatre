--удалить номинацию Лучший мюзикл в награде Премия Лоуренсе Оливье
DELETE 
FROM nomination
WHERE achievement_id in (
SELECT achievement_id
FROM achievement
WHERE achievement_name = 'Премия Лоуренсе Оливье')
AND nomination_name = 'Лучший мюзикл'
