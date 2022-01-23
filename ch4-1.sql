USE market_db ; 
CREATE TABLE hongong4 (
	tinyint_col TINYINT,
    smallint_col SMALLINT, 
    int_col INT, 
    bigint_col BIGINT); 
INSERT INTO hongong4 VALUES(127, 32767, 2147483647, 9000000000000000000) ; 
SELECT * FROM hongong4 ; 

#--------- 실행 ㄴㄴ -----------
CREATE TABLE member 
(mem_id	      CHAR(8)       NOT NULL PRIMARY KEY, 
 mem_name     VARCHAR(10)   NOT NULL, 
 mem_number   TINYINT       NOT NULL,
 addr		  CHAR(2)       NOT NULL, 
 phone1		  CHAR(3), 
 phone2       CHAR(8), 
 height       SMALLINT, 
 debut_date   date
) ;
CREATE TABLE member 
(mem_id	      CHAR(8)       NOT NULL PRIMARY KEY, 
 mem_name     VARCHAR(10)   NOT NULL, 
 mem_number   TINYINT       NOT NULL,
 addr		  CHAR(2)       NOT NULL, 
 phone1		  CHAR(3), 
 phone2       CHAR(8), 
 height       TINYINT UNSIGNED, 
 debut_date   date
 ) ; 
CREATE DATABASE netflix_db ; 
USE netflix_db ; 
CREATE TABLE movie
(movie_id        INT, 
 movie_title     VARCHAR(30), 
 movie_director  VARCHAR(20), 
 movie_star      VARCHAR(20), 
 movie_script    LONGTEXT,   -- 영화 스크립트나
 movie_film      LONGBLOB    -- 영화 영상 데이터
 ) ;

-- 변수의 사용
USE market_db ; 
SET @myVar1 = 5 ;
SET @myVar2 = 4.25 ; 
SELECT @myVar1; 
SELECT @myVar1 + @myVar2 ;

SET @txt = '가수 이름 ====> ' ; 
SET @height = 166 ;
SELECT @txt, mem_name FROM member WHERE height > @height ;  

-- LIMIT에 변수 이용
SET @count = 3 ;
SELECT mem_name, height FROM member ORDER BY height LIMIT @count ; -- 에러발생

-- PREPARE과 EXECUTE 사용
SET @count = 3 ; 
PREPARE mySQL FROM 'SELECT mem_name, height FROM member ORDER BY height LIMIT ?' ; 
EXECUTE mySQL USING @count ; 

-- 함수를 이용한 명시적인 데이터 형 변환
SELECT AVG(price) AS '평균가격' FROM buy ; -- 소수점이 없는 정수형으로 바꾸기
SELECT CAST(AVG(price) AS SIGNED) '평균가격' FROM buy ; 
SELECT CONVERT(AVG(price), SIGNED) '평균가격' FROM buy ; 

SELECT CAST('2022$12$12' AS DATE) ; 
SELECT CAST('2022/12/12' AS DATE) ; 
SELECT CAST('2022%12%12' AS DATE) ; 
SELECT CAST('2022@12@12' AS DATE) ; 

SELECT num, CONCAT(CAST(price AS CHAR), 'X', CAST(amount AS CHAR), '=') 
       '가격x수량', price * amount '구매액'  
       FROM buy ;
       
-- 암시적인 변환
SELECT '100' + '200' ; 
SELECT CONCAT('100', '200') ; 