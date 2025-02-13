﻿/*
WITH TEMP AS
(
    SELECT 0 AS HOUR FROM DUAL UNION SELECT 1 AS HOUR FROM DUAL UNION SELECT 2 AS HOUR FROM DUAL UNION
    SELECT 3 AS HOUR FROM DUAL UNION SELECT 4 AS HOUR FROM DUAL UNION SELECT 5 AS HOUR FROM DUAL UNION
    SELECT 6 AS HOUR FROM DUAL UNION SELECT 7 AS HOUR FROM DUAL UNION SELECT 8 AS HOUR FROM DUAL UNION
    SELECT 9 AS HOUR FROM DUAL UNION SELECT 10 AS HOUR FROM DUAL UNION SELECT 11 AS HOUR FROM DUAL UNION
    SELECT 12 AS HOUR FROM DUAL UNION SELECT 13 AS HOUR FROM DUAL UNION SELECT 14 AS HOUR FROM DUAL UNION
    SELECT 15 AS HOUR FROM DUAL UNION SELECT 16 AS HOUR FROM DUAL UNION SELECT 17 AS HOUR FROM DUAL UNION
    SELECT 18 AS HOUR FROM DUAL UNION SELECT 19 AS HOUR FROM DUAL UNION SELECT 20 AS HOUR FROM DUAL UNION
    SELECT 21 AS HOUR FROM DUAL UNION SELECT 22 AS HOUR FROM DUAL UNION SELECT 23 AS HOUR FROM DUAL
)
(
    SELECT HOUR, 0 AS COUNT FROM TEMP
    WHERE HOUR NOT IN (SELECT HOUR(DATETIME) FROM ANIMAL_OUTS)   -- 그냥 GROUP BY를 해버리면 COUNT가 없는 경우가 아예 안나옴. 그러므로 억지로 COUNT 값이 0인 상태를 끼워넣음
)
UNION
(
    SELECT HOUR(DATETIME), COUNT(HOUR(DATETIME)) FROM ANIMAL_OUTS
    GROUP BY HOUR(DATETIME)
)
ORDER BY HOUR
*/



--0으로 있는 테이블에 COUNT가 존재하는 실제 테이블을 LEFT JOIN하는 방식
SELECT HOUR, ifnull(COUNT, 0) AS COUNT FROM (SELECT @N := @N + 1 AS HOUR FROM ANIMAL_OUTS, (SELECT @N := -1 FROM DUAL)NN LIMIT 24) AS A
LEFT JOIN (SELECT HOUR(DATETIME) AS HR, COUNT(*) AS COUNT FROM ANIMAL_OUTS GROUP BY HR) AS B
ON A.HOUR = B.HR
