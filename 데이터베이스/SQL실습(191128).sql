--(���տ���)--

--1��
select department_name
from departments
minus
select department_name
from departments
where department_id in ( select department_id from employees );

--2��
select job_title
from jobs
minus
select job_title
from jobs
where job_id in ( select job_id from employees );

--3��
select department_name, street_address
from departments natural join locations 
where location_id in 
( select location_id from departments where department_name = 'Shipping'
union
 select location_id from departments where department_name = 'Human Resources' );
 
--5��
select first_name
from employees
where salary = ( select MAX(salary) from employees );

--6��
select department_name
from departments
where department_id in ( select department_id from employees 
group by department_id 
having count(employee_id)>=5);

--7��
select first_name
from employees
where job_id in ( 
select job_id from jobs where job_title like '%Purchasing%');

--8��
select city
from locations l
where
not exists 
( select * 
from departments d
where l.location_id = d.location_id );

--(���̺����)--

--1��
CREATE TABLE DEPT3 (
ID NUMBER(7) PRIMARY KEY,
NAME VARCHAR2(25));

--2��
CREATE TABLE EMP3 (
ID NUMBER(7),
LAST_NAME VARCHAR2(25),
FIRST_NAME VARCHAR2(25),
DEPT_ID NUMBER(7) REFERENCES DEPT3(ID) ON DELETE CASCADE);

--3��
CREATE TABLE EMPLOYEES2 AS
SELECT FIRST_NAME, LAST_NAME, SALARY, EMPLOYEE_ID AS "ID",DEPARTMENT_ID AS "DEPT_ID"
FROM EMPLOYEES
WHERE 1=2;

--4��
ALTER TABLE EMP3 MODIFY LAST_NAME VARCHAR2(50);

--5��
ALTER TABLE EMP3 ADD LOC VARCHAR2(10) DEFAULT 'LA';

--6��
ALTER TABLE EMP3 RENAME COLUMN LOC TO LOC2;

--7��
ALTER TABLE EMPLOYEE2 DROP COLUMN FIRST_NAME;

--8��
ALTER TABLE EMP3 DROP COLUMN ID;
ALTER TABLE DEPT3 DROP COLUMN ID ;

--9��
DROP TABLE DEPT3;


--(��������)--

--1��
CREATE TABLE DEPT3 AS
SELECT DEPARTMENT_ID AS "ID",DEPARTMENT_NAME AS "NAME"
FROM DEPARTMENTS
WHERE 1=2;
ALTER TABLE DEPT3 ADD CONSTRAINT MY_DEPT_ID_PK PRIMARY KEY (ID);

--2��
CREATE TABLE EMP3 (
ID NUMBER(7) CONSTRAINT EMP3_ID_PK PRIMARY KEY,
LAST_NAME VARCHAR2(25),
FIRST_NAME VARCHAR2(25),
DEPT_ID NUMBER(7));

--3��
ALTER TABLE EMP3 ADD CONSTRAINT MY_EMP_DEPT_ID FOREIGN KEY (ID) REFERENCES DEPT3 (ID) ON DELETE SET NULL;

--4��
ALTER TABLE DEPT3 ADD MANAGER_ID REFERENCES EMP3(ID);

--5��
ALTER TABLE EMP3 ADD COMMISSION NUMBER(2,2) CHECK(COMMISSION > 0);

--6��
DROP TABLE DEPT3; --�ܷ� Ű�� ���� �����Ǵ� ����/�⺻ Ű�� ���̺� �ֽ��ϴ�. EMP3 ���̺��� �ܷ�Ű�� �����ǰ� �ִ� �⺻Ű�� �ִ�.

--7��
ALTER TABLE DEPT3 DROP CONSTRAINT MY_DEPT_ID_PK; --EMP3 ���̺��� �ܷ�Ű�� �����ϰ� �־� ������ �Ұ����ϴ�.

--8��
ALTER TABLE EMP3 DROP CONSTRAINT MY_EMP_DEPT_ID; --EMP3 ���̺� �ܷ�Ű�� ����

--9��
ALTER TABLE DEPT3 DROP CONSTRAINT MY_DEPT_ID_PK; -- PRIMARYKEY �� MY_DEPT_ID_PK ������ ����

--10��
DROP TABLE DEPT3; -- ������ �����ϴ�.

--DML

--1
INSERT INTO MY_EMPLOYEE
VALUES(1,'patel','Ralph','rpatel',895);

--2
INSERT INTO MY_EMPLOYEE
(ID,LAST_NAME,FIRST_NAME,USERID,SALARY)
VALUES
(2,'Dancs','Betty','bdancs',860);

--3
INSERT INTO MY_EMPLOYEE
VALUES(3,'biri','ben','bbin',1100);
INSERT INTO MT_EMPLOYEE
VALUES(4,'newman','chad','cnewman',750)

--4
SELECT *
FROM MY_EMPLOYEE;

--5


--6
UPDATE MY_EMPLOYEE
SET LAST_NAME = 'Drexler'
WHERE ID = 3;

--7
UPDATE MY_EMPLOYEE
SET SALARY = 1000
WHERE SALARY < 1000;

--8
SELECT *
FROM MY_EMPLOYEE;

--9
DELETE FROM MY_EMPLOYEE
WHERE FIRST_NAME LIKE 'BETTY'
AND LAST_NAME LIKE 'DANCS';

SELECT *
FROM MY_EMPLOYEE;

--10
INSERT INTO MY_EMPLOYEE
VALUES(5,'Ropeburn','Audrey','aropebur',1550)

SELECT *
FROM MY_EMPLOYEE;


--(�����Լ�)--
select to_char(sysdate,'rrrr-mm-dd hh12:mi:ss am')
from dual;

select last_name, to_char(hire_date,'yyyy-mm-dd')
from employees
where hire_date < to_date('2005-01-01','yyyy-mm-dd');

DROP TABLE SAL_HISTORY;

CREATE table SAL_HISTORY
(EMPLOYEE_ID	NUMBER(6),
HIRE_DATE	DATE,
SALARY	NUMBER(8,2));

DROP TABLE MGR_HISTORY;

CREATE table MGR_HISTORY
(EMPLOYEE_ID	NUMBER(6),
MANAGER_ID	NUMBER(6),
SALARY	NUMBER(8,2));

CREATE table SPECIAL_SAL
(EMPLOYEE_ID	NUMBER(6),
SALARY	NUMBER(8,2));

create table sal_history_2 as 
SELECT employee_id EMPID, hire_date HIREDATE,
       salary SAL
FROM employees
WHERE department_id > 80;	

select *
from sal_histoty_2;

--1��
select employee_id, hire_date, salary, manager_id
from employees
where employee_id < 125;

--2��
insert into special_sal (employee_id)
select employee_id
from employees
where salary > 20000 and employee_id < 125;

select * from employees;

--3��
insert into sal_history (employee_id,hire_date,salary)
select employee_id,hire_date,salary
from employees
where employee_id < 125 and salary <= 20000;

--4��
insert into sal_history_2 (empid,hiredate,sal)
values (207,to_date('2015/05/10',yyyy-mm-dd),5000);

--5��
select *
from sal_history_2;

--6��
insert into sal_history_2 (empid,hiredate,sal)
values (208,sysdate,10000);

select *
from sal_history_2;

--7��
update sal_history_2
set sal = sal + sal/10
where empid <= 200;

--8��
delete from sal_history_2
where sal <= 10000;

--(���� �Լ�)--

--1��
select last_name, round(salary,-3), round(commission_pct,1)
from employees;

--2��
select 3.14, ceil(3.14), floor(3.14) 
from dual;

--3��
select upper(last_name)
from employees
where department_id = 60;

--4��
select 'choichanghwan', length('choichanghwan')
from dual;

--5��
select employee_id, substr(phone_number,1,3)
from employees
where department_id = 50 or department_id = 60 or department_id = 90;

--6��
select employee_id, rpad(salary,6,'*')
from employees
where round(commission_pct,1) > 0.1

--7��
select employee_id, last_day(add_months(end_date,2))   
from job_history

--8��
select to_char(sysdate,'yyyy/dd/mm hh:mi:ss AM')
from dual;

--9��
select e.employee_id, to_char(start_date,'yyyy-mm-dd'), to_char(end_date,'yyyy-mm-dd')
from employees e, job_history j
where e.employee_id = j.employee_id and e.employee_id >= 200 and e.employee_id < 300;

--10��
select last_name, hire_date
from employees
where hire_date <= to_date('1999/03/01','yyyy-mm-dd');

--11��
select last_name, salary, to_char(hire_date,'yyyy-mm-dd')
from employees
where salary >= 20000
order by salary desc;

--12��
select employee_id, salary*12*(1 + nvl(commission_pct,0)) "YEAR_SAL"
from employees
order by YEAR_SAL;

--13��
select last_name, first_name, salary
from 
(   select last_name, first_name, salary
    from employees
    order by salary desc  )
where rownum <= 3;













