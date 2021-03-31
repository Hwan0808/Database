--1
select last_name,salary
from employees 
where salary >=12000;
--2
select last_name,first_name,department_id
from employees
where employee_id = 176; 
--3
select last_name,salary
from employees
where salary <=5000;
--4
select last_name,first_name,salary,department_id
from employees
where salary >=12000;
--5
select employee_id,last_name,salary
from employees
where salary between 5000 and 12000
order by salary desc;
--6
select last_name,hire_date,job_id
from employees
where last_name = 'Matos'or last_name = 'Taylor'
order by hire_date asc;
--7
select last_name,department_id
from employees
where department_id between 20 and 50
order by last_name desc;
--8
select distinct job_id
from employees
where department_id = 50;
--9
select last_name,hire_date
from employees
where hire_date like '03%' or hire_date like '05%'; 
--10
select last_name,job_id
from employees
where manager_id is null;
--11
select employee_id,salary,commission_pct
from employees
where commission_pct is not null
order by salary, commission_pct desc;
--12
select last_name,department_id,salary,job_id
from employees
where salary <=3000 and department_id <100;

-------------------------------±×·ì°ú ÇØºù-----------------------------------------------
--1
select max(salary) as "Maximum", 
       min(salary) as "Minimum",
       sum(salary) as "Sum",
       avg(salary) as "Average"
from employees;
--2
select job_id,
       max(salary) as "Maximum",
       min(salary) as "Minimum",
       sum(salary) as "Sum",
       avg(salary) as "Average"
from employees
group by job_id;
--3
select job_id,count(*)
from employees
group by job_id;
--4
select count(distinct manager_id)
from employees;
--5
select department_id, sum(salary)
from employees
where salary <= 5000
group by department_id;
--6
select job_id,min(salary)
from employees
group by job_id
having count(job_id) >=5;
--7 **
select department_id, job_id ,count(*)
from employees
group by department_id,job_id
order by department_id,job_id;
--8
select department_id, sum(salary)
from employees
group by department_id
having avg(salary) >5000;