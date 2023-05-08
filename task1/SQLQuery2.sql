--определить имена менеджеров, у которых за 1 пять лет работы появились в подчинении аналитики (ANALYST)

SELECT DISTINCT managers.employee_id, managers.last_name, managers.first_name
FROM employee, job, employee managers
WHERE employee.job_id = job.job_id 
AND "function" = 'ANALYST'
AND employee.manager_id = managers.employee_id
AND YEAR(managers.hire_date) >= YEAR(employee.hire_date) - 5
AND YEAR(managers.hire_date)<=YEAR(employee.hire_date)
AND MONTH(managers.hire_date)<=MONTH(employee.hire_date)
AND DAY(managers.hire_date)<=DAY(employee.hire_date);
