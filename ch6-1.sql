USE market_db ; 
CREATE TABLE table1 (
   col1 INT PRIMARY KEY, 
   col2 INT, 
   col3 INT
)  ; 
SELECT * FROM table1 ; 
-- 인덱스 정보 확인
SHOW INDEX FROM table1 ; 

-- UNIQUE 열 인덱스 확인
CREATE TABLE table2 (
   col1 INT PRIMARY KEY, 
   col2 INT UNIQUE, 
   col3 INT UNIQUE
) ; 
SHOW INDEX FROM table2 ;

-- 자동 정렬되는 클러스터형 인덱스
USE market_db ; 
DROP TABLE IF EXISTS buy, member ; 
-- 기본 키 지정 안 함 
CREATE TABLE member (
   mem_id CHAR(8),
   mem_name VARCHAR(10),
   mem_number INT, 
   addr CHAR(2)
) ; 
-- 데이터 입력
INSERT INTO member VALUES('TWC', '트와이스', 9, '서울') ; 
INSERT INTO member VALUES('BLK', '블랙핑크', 4, '경남') ; 
INSERT INTO member VALUES('WMN', '여자친구', 6, '경기') ; 
INSERT INTO member VALUES('OMY', '오마이걸', 7, '서울') ; 
SELECT * FROM member ;
-- 기본 키 지정
ALTER TABLE member
   ADD CONSTRAINT
   PRIMARY KEY (mem_id) ; 
SELECT * FROM member ;
-- 기본 키 변경
ALTER TABLE member DROP PRIMARY KEY ; 
ALTER TABLE member
   ADD CONSTRAINT 
   PRIMARY KEY (mem_name) ;
SELECT * FROM member ;
-- 새로운 데이터를 넣어도 순서대로 정렬됨
INSERT INTO member VALUES('GRL', '소녀시대', 8, '서울') ;  
SELECT * FROM member ; 

-- 고유 키 지정
DROP TABLE IF EXISTS member ; 
CREATE TABLE member (
    mem_id  CHAR(8), 
    mem_name VARCHAR(10), 
    mem_number INT, 
    addr CHAR(2)
) ; 
-- 데이터 입력
INSERT INTO member VALUES('TWC', '트와이스', 9, '서울') ; 
INSERT INTO member VALUES('BLK', '블랙핑크', 4, '경남') ; 
INSERT INTO member VALUES('WMN', '여자친구', 6, '경기') ; 
INSERT INTO member VALUES('OMY', '오마이걸', 7, '서울') ; 
SELECT * FROM member ;
-- mem_id 고유 키 설정
ALTER TABLE member 
   ADD CONSTRAINT 
   UNIQUE (mem_id) ; 
SELECT * FROM member ; 
SHOW INDEX FROM member ; 
-- mem_name에 고유 키 설정
ALTER TABLE member 
   ADD CONSTRAINT 
   UNIQUE (mem_name) ; 
SHOW INDEX FROM member ; 
