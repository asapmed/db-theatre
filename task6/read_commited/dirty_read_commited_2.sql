SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRAN

SELECT * FROM performance
WHERE performance_id = 1

COMMIT