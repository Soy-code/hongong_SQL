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

