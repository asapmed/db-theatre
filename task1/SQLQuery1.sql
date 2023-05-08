--выбрать список начальников отдела города DALLAS

SELECT DISTINCT employee.manager_id, managers.last_name, managers.first_name
FROM employee managers, employee, department, location
WHERE employee.department_id = department.department_id
AND department.location_id = location.location_id
AND regional_group = 'DALLAS'
AND employee.manager_id = managers.employee_id;