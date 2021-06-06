/* 06장 */

USE cookDB;

CREATE TABLE testTBL1 (id  int, userName char(3), age int);

INSERT INTO testTBL1 VALUES (1, '뽀로로', 16);

INSERT INTO testTBL1(id, userName) VALUES (2, '크롱');

INSERT INTO testTBL1(userName, age, id) VALUES ('루피', 14,  3);

USE  cookDB;
CREATE TABLE testTBL2 
  (id  int AUTO_INCREMENT PRIMARY KEY, 
   userName char(3), 
   age int );
INSERT INTO testTBL2 VALUES (NULL, '에디', 15);
INSERT INTO testTBL2 VALUES (NULL, '포비', 12);
INSERT INTO testTBL2 VALUES (NULL, '통통이', 11);
SELECT * FROM testTBL2;

ALTER TABLE testTBL2 AUTO_INCREMENT=100;
INSERT INTO testTBL2 VALUES (NULL, '패티', 13);
SELECT * FROM testTBL2;

USE  cookDB;
CREATE TABLE testTBL3 
  (id  int AUTO_INCREMENT PRIMARY KEY, 
   userName char(3), 
   age int );
ALTER TABLE testTBL3 AUTO_INCREMENT=1000;
SET @@auto_increment_increment=3;
INSERT INTO testTBL3 VALUES (NULL, '우디', 20);
INSERT INTO testTBL3 VALUES (NULL, '버즈', 18);
INSERT INTO testTBL3 VALUES (NULL, '제시', 19);
SELECT * FROM testTBL3;

INSERT INTO testTBL3 VALUES (NULL, '토이', 17), (NULL, '스토리', 18), (NULL, '무비', 19);
SELECT * FROM testTBL3;

USE cookDB;
CREATE TABLE testTBL4 (id int, Fname varchar(50), Lname varchar(50));
INSERT INTO testTBL4 
  SELECT emp_no, first_name, last_name
    FROM employees.employees ;

CREATE TABLE testTBL5 

   (SELECT emp_no, first_name, last_name  FROM employees.employees) ;
SELECT * FROM testTBL5 LIMIT 3;

CREATE TABLE testTBL6 
   (SELECT emp_no AS id, first_name AS Fname, last_name AS Lname
		FROM employees.employees) ;
SELECT * FROM testTBL6 LIMIT 3;

USE cookDB;
UPDATE testTBL4
    SET Lname = '없음'
    WHERE Fname = 'Kyichi';

UPDATE buyTBL SET price = price * 1.5 ;

USE cookDB;
DELETE FROM testTBL4 WHERE Fname = 'Aamer';

DELETE FROM testTBL4 WHERE Fname = 'Aamer'  LIMIT 5;

-- <실습> 대용량의 테이블을 삭제하자.

USE cookDB;
CREATE TABLE bigTBL1 (SELECT * FROM employees.employees);
CREATE TABLE bigTBL2 (SELECT * FROM employees.employees);
CREATE TABLE bigTBL3 (SELECT * FROM employees.employees);

DELETE FROM bigTBL1;
DROP TABLE bigTBL2;
TRUNCATE TABLE bigTBL3;

-- </실습> 


-- <실습> INSERT의 다양한 방식을 실습하자.

USE cookDB;
CREATE TABLE memberTBL (SELECT userID, userName, addr FROM userTBL LIMIT 3); -- 3건만 가져옴
ALTER TABLE memberTBL 
	ADD CONSTRAINT pk_memberTBL PRIMARY KEY (userID); -- PK를 지정함
SELECT * FROM memberTBL;

INSERT INTO memberTBL VALUES('KHD' , '강후덜', '미국');
INSERT INTO memberTBL VALUES('LSM' , '이상민', '서울');
INSERT INTO memberTBL VALUES('KSJ' , '김성주', '경기');

INSERT IGNORE INTO memberTBL VALUES('KHD' , '강후덜', '미국');
INSERT IGNORE INTO memberTBL VALUES('LSM' , '이상민', '서울');
INSERT IGNORE INTO memberTBL VALUES('KSJ' , '김성주', '경기');
SELECT * FROM memberTBL;

INSERT INTO memberTBL VALUES('KHD' , '강후덜', '미국')
	ON DUPLICATE KEY UPDATE userName='강후덜', addr='미국';
INSERT INTO memberTBL VALUES('DJM' , '동짜몽', '일본')
	ON DUPLICATE KEY UPDATE userName='동짜몽', addr='일본';
SELECT * FROM memberTBL;

-- </실습> 


-- <실습> 순위 함수를 실습해 보자.

USE cookDB;
SELECT ROW_NUMBER( ) OVER(ORDER BY height DESC) "키큰순위", userName, addr, height
   FROM userTBL ;

SELECT ROW_NUMBER( ) OVER(ORDER BY height DESC, userName ASC) "키큰순위", userName, addr, height
   FROM userTBL ;

SELECT addr, ROW_NUMBER( ) OVER(PARTITION BY addr ORDER BY height DESC, userName ASC) "지역별키큰순위", userName, height
   FROM userTBL ;

SELECT DENSE_RANK( ) OVER(ORDER BY height DESC) "키큰순위", userName, addr, height
   FROM userTBL ;

SELECT RANK( ) OVER(ORDER BY height DESC) "키큰순위", userName, addr, height
   FROM userTBL ;

SELECT NTILE(2) OVER(ORDER BY height DESC) "반번호", userName, addr, height
   FROM userTBL;

SELECT NTILE(4) OVER(ORDER BY height DESC) "반번호", userName, addr, height
   FROM userTBL;

-- </실습> 



-- <실습> 분석 함수를 실습해 보자.

USE cookDB;
SELECT  userName, addr, height AS "키",
       height - (LEAD(height, 1, 0) OVER (ORDER BY height DESC)) AS "다음 사람과 키 차이"
   FROM userTBL ;

SELECT addr, userName, height AS "키",
       height - ( FIRST_VALUE(height) OVER (PARTITION BY addr ORDER BY height DESC) ) 
             AS "지역별 최대키와 차이"
   FROM userTBL ;

SELECT  addr, userName, height AS "키",
      (CUME_DIST() OVER (PARTITION BY addr ORDER BY height DESC)) * 100 AS "누적인원 백분율%"
   FROM userTBL ;

-- </실습> 



-- <실습> 간단한 피벗 테이블을 실습하자.

USE cookDB;
CREATE TABLE pivotTest
   (  uName CHAR(3),
      season CHAR(2),
      amount INT);

INSERT  INTO  pivotTest VALUES ('유재석' , '겨울',  10) ;
INSERT  INTO  pivotTest VALUES ('강호동' , '여름',  15) ;
INSERT  INTO  pivotTest VALUES ('유재석' , '가을',  25) ;
INSERT  INTO  pivotTest VALUES ('유재석' , '봄',    3) ;
INSERT  INTO  pivotTest VALUES ('유재석' , '봄',    37) ;
INSERT  INTO  pivotTest VALUES ('강호동' , '겨울',  40) ;
INSERT  INTO  pivotTest VALUES ('유재석' , '여름',  14) ;
INSERT  INTO  pivotTest VALUES ('유재석' , '겨울',  22) ;
INSERT  INTO  pivotTest VALUES ('강호동' , '여름',  64) ; 
SELECT * FROM pivotTest;

SELECT  uName,
    SUM(CASE WHEN season='봄' THEN amount END) AS '봄',
    SUM(CASE WHEN season='여름' THEN amount END) AS '여름',
    SUM(CASE WHEN season='가을' THEN amount END) AS '가을',
    SUM(CASE WHEN season='겨울' THEN amount END) AS '겨울'
FROM   pivotTest
GROUP BY uName;

-- </실습> 




USE cookDB;
SELECT userid AS '사용자', SUM(price*amount) AS '총구매액'  
  FROM buyTBL GROUP BY userid;

WITH abc(userid, total)
AS
(SELECT userid, SUM(price*amount)  
  FROM buyTBL GROUP BY userid )
SELECT * FROM abc ORDER BY total DESC ;

SELECT addr, MAX(height) FROM userTBL GROUP BY addr;

WITH cte_userTBL(addr, maxHeight)
AS
  ( SELECT addr, MAX(height) FROM userTBL GROUP BY addr)
SELECT AVG(maxHeight*1.0) AS '각 지역별 최고키의 평균' FROM cte_userTBL;

-- </연습문제>
CREATE TABLE examTable3
( SELECT emp_no as id, first_name as Fname, last_name as Lname
FROM employees.employees ) ;
SELECT * FROM examTable3 LIMIT 3;

DROP TABLE examtable3;

USE cookDB;
SELECT  userName, addr, height AS "키",
       height - (LEAD(height, 1, 0) OVER (ORDER BY height DESC)) AS "다음 사람과 키 차이"
   FROM userTBL ;

SELECT userName, addr, mDate AS '가입일', datediff(LEAD(mdate, 1, 0) OVER (ORDER BY mdate ASC), mDate) AS '다음 사람과의 가입 일자 차이'
FROM userTBL;

SELECT season,
SUM(CASE WHEN uName='유재석' THEN amount END) AS '유재석',
SUM(CASE WHEN uName='강호동' THEN amount END) AS '강호동'
FROM pivotTest
GROUP BY season;

WITH myTable(uid, total)
AS
(SELECT userid, SUM(price * amount)
FROM buyTBL GROUP BY userid)
SELECT uid, total FROM myTable ORDER BY total DESC;