set transaction isolation level read uncommitted
begin transaction


update person_general_information set date_of_birth=dateadd(day,4,date_of_birth)
where person_id = 15

commit
select * from person_general_information
where person_id = 15