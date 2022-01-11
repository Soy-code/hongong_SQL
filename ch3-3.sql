USE market_db ; 

CREATE TABLE hongong1 (toy_id INT, toy_name CHAR(4), age INT) ; -- TABLE 만들기 
INSERT INTO hongong1 VALUES (1, '우디', 25) ; -- 데이터 입력하기
SELECT * FROM hongong1 ;

INSERT INTO hongong1 (toy_id, toy_name) VALUES (2, '버즈') ; -- 열 이름 입력, 
SELECT * FROM hongong1 ; 
 
INSERT INTO hongong1 (toy_name, age, toy_id) VALUES ('제시', 20, 3) ; 
SELECT * FROM hongong1 ; 

-- hongong2 테이블 만들기
CREATE TABLE hongong2
  (toy_id INT AUTO_INCREMENT PRIMARY KEY, 
   toy_name CHAR(4), 
   age INT) ; 
-- 테이블에 데이터 입력하기
INSERT INTO hongong2 VALUES (NULL, '보핍', 25) ;
INSERT INTO hongong2 VALUES (NULL, '슬링키', 22) ; 
INSERT INTO hongong2 VALUES (NULL, '렉스', 21) ; 
SELECT * FROM hongong2 ; 
-- 마지막 ID 숫자 확인 
SELECT last_insert_id() ; 

-- AUTO_INCREMENT 100부터 시작
ALTER TABLE hongong2 AUTO_INCREMENT = 100 ; 
INSERT INTO hongong2 VALUES (NULL, '재남', 35) ; 
SELECT * FROM hongong2 ; 

CREATE TABLE hongong3 
  (toy_id INT AUTO_INCREMENT PRIMARY KEY, 
   toy_name CHAR(4), 
   age INT) ; 
ALTER TABLE hongong3 AUTO_INCREMENT = 1000 ; 
SET @@AUTO_INCREMENT_INCREMENT = 3 ; -- 증가값은 3으로 지정
SELECT * FROM hongong3 ; 

INSERT INTO hongong3 VALUES (NULL, '토마스', 20) ; 
INSERT INTO hongong3 VALUES (NULL, '제임스', 23) ; 
INSERT INTO hongong3 VALUES (NULL, '고든', 25) ; 
SELECT * FROM hongong3 ; 

SELECT @@AUTO_INCREMENT_INCREMENT ; 
SHOW GLOBAL VARIABLES ; 

-- city 테이블의 행 개수 확인
SELECT COUNT(*) FROM world.city ; 
-- city 테이블의 description 확인
DESC world.city ; 
-- 맨 처음 다섯 개의 데이터 확인
SELECT * FROM world.city LIMIT 5 ; 

-- 테이블 만들기 
CREATE TABLE city_popul 
  (city_name CHAR(35), 
   population INT) ; 
SELECT * FROM city_popul ; 
-- city테이블에서 데이터 불러오기 
INSERT INTO city_popul
  SELECT Name, Population FROM world.city ; 
SELECT * FROM city_popul ; 

-- UPDATE
USE market_db ; 
SELECT * FROM city_popul ; 
UPDATE city_popul
  SET city_name = '서울' 
  WHERE city_name = 'Seoul'; 
SELECT * FROM city_popul 
  WHERE city_name = '서울' ; 
  
-- 한꺼번에 여러 데이터 변경
UPDATE city_popul 
  SET city_name = '뉴욕', population = 0 
  WHERE city_name = 'New York' ; 
SELECT * FROM city_popul WHERE city_name = '뉴욕' ; 

-- 인구 수 만명단위로 변경
 UPDATE city_popul 
   SET population = population / 10000 ; 
SELECT * FROM city_popul LIMIT 5 ; 

-- New로 시작하는 도시 출력
SELECT * FROM city_popul WHERE city_name LIKE "New%" ; 
-- New로 시작하는 도시 삭제
DELETE FROM city_popul WHERE city_name LIKE "New%" ; 
-- New로 시작하는 도시 재출력
SELECT * FROM city_popul WHERE city_name LIKE "New%" ; 

-- sakila DB의 country 테이블 description
DESC sakila.country ; 
SELECT * FROM sakila.country LIMIT 5 ;
SELECT count(*) FROM sakila.country ; 
-- world DB의 city 테이블 description 
DESC world.city ; 
SELECT * FROM world.city LIMIT 5 ; 
SELECT count(*) FROM world.city ; 
-- create big table
CREATE TABLE big_table1 (SELECT * FROM world.city, sakila.country) ; -- 어떻게 44만개가 만들어졌는지 모르겠음.. JOINING시켜서 그런건가 
SELECT * FROM big_table1 LIMIT 5 ; 
CREATE TABLE big_table2 (SELECT * FROM world.city, sakila.country) ;
CREATE TABLE big_table3 (SELECT * FROM world.city, sakila.country) ; 
-- 대용량 테이블 삭제하는 법
DELETE FROM big_table1 ; -- 시간이 오래 걸림
DROP TABLE big_table2 ; -- 테이블 자체를 삭제함. 속도 빠름. 
TRUNCATE TABLE big_table3 ;  -- 테이블의 구조는 남겨놓음. 속도 빠름. 

