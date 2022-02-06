# PRIMARY KEY 제약조건
USE naver_db ; 
DROP TABLE IF EXISTS buy, member ; 
CREATE TABLE member (
   mem_id     CHAR(8) NOT NULL PRIMARY KEY,
   mem_name   VARCHAR(10) NOT NULL,
   height     TINYINT UNSIGNED NULL
) ; 
DESC member ;

# PRIMARY KEY 제약조건 
DROP TABLE IF EXISTS member ;
CREATE TABLE member ( 
   mem_id    CHAR(8) NOT NULL,
   mem_name  VARCHAR(10) NOT NULL,
   height    TINYINT UNSIGNED NULL,
   PRIMARY KEY (mem_id) -- 맨 마지막 줄에서 primary key 설정할 수도 있음. 
) ; 

# ALTER TABLE
DROP TABLE IF EXISTS member ;
CREATE TABLE member (
   mem_id   CHAR(8) NOT NULL,
   mem_name VARCHAR(10) NOT NULL,
   height   TINYINT UNSIGNED NULL
) ;  -- PRIMARY KEY가 지정되지 않은 경우의 테이블 생성
DESC member ; 
ALTER TABLE member 
   ADD CONSTRAINT  -- 제약조건 추가
   PRIMARY KEY (mem_id) ; 
DESC member ; 

# PK 이름 지정
DROP TABLE IF EXISTS member ; 
CREATE TABLE member (
   mem_id   CHAR(8) NOT NULL,
   mem_name   VARCHAR(10) NOT NULL, 
   height    TINYINT UNSIGNED, 
   CONSTRAINT PRIMARY KEY PK_member_mem_id (mem_id) -- PK 이름 지정
) ; 
DESC member ;

# FOREIGN KEY 제약조건
DROP TABLE IF EXISTS member, buy ; 
-- member 테이블 만들기
CREATE TABLE member (
   mem_id   CHAR(8) NOT NULL PRIMARY KEY,
   mem_name   VARCHAR(10)  NOT NULL,
   height   TINYINT UNSIGNED
) ; 
-- buy 테이블 만들기
CREATE TABLE buy (
   num  INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
   mem_id   CHAR(8) NOT NULL, 
   prod_name   CHAR(6) NOT NULL, 
   FOREIGN KEY(mem_id) REFERENCES member(mem_id)
) ;
DESC member ; 
DESC buy ; 
   
# ALTER TABLE
DROP TABLE IF EXISTS buy ; 
CREATE TABLE buy (
   num     INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
   mem_id  CHAR(8) NOT NULL, 
   prod_name  CHAR(6) NOT NULL
) ; 
ALTER TABLE buy 
   ADD CONSTRAINT 
   FOREIGN KEY(mem_id) REFERENCES member(mem_id) ; 
DESC buy ; 

# 기준테이블의 열이 바뀔 때
DESC member ; 
INSERT INTO member VALUES('BLK', '블랙핑크', 163) ; 
DESC buy ; 
INSERT INTO buy VALUES(NULL, 'BLK', '지갑') ; 
INSERT INTO buy VALUES(NULL, 'BLK', '맥북') ; 
SELECT * FROM buy ; 

# 내부 조인을 이용하여 BLK 구매 내역 출력
SELECT M.mem_id, M.mem_name, B.prod_name
   FROM buy B 
      INNER JOIN member M 
      ON B.mem_id = M.mem_id ; 
      
# 'BLK' -> 'PINK' : 오류 발생
UPDATE member SET mem_id = 'PINK' WHERE mem_id = 'BLK' ; 
# 'BLK' 삭제 : 오류 발생
DELETE FROM member WHERE mem_id = 'BLK' ; 

# ON UPDATE/DELETE CASCADE
DROP TABLE IF EXISTS buy ; 
CREATE TABLE buy (
   num    INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
   mem_id   CHAR(8) NOT NULL, 
   prod_name   CHAR(6) NOT NULL
) ; 
DESC buy ; 
ALTER TABLE buy 
   ADD CONSTRAINT 
   FOREIGN KEY(mem_id) REFERENCES member(mem_id) 
   ON UPDATE CASCADE 
   ON DELETE CASCADE ; 

INSERT INTO buy VALUES(NULL, 'BLK', '지갑') ; 
INSERT INTO buy VALUES(NULL, 'BLK', '맥북') ;
SELECT * FROM buy ; 

UPDATE member SET mem_id = 'PINK' WHERE mem_id = 'BLK' ;  
SELECT * FROM member ; 
SELECT * FROM buy ; 

SELECT M.mem_id, M.mem_name, B.prod_name
   FROM buy B
      INNER JOIN member M
      ON B.mem_id = M.mem_id ; 
      
DELETE FROM member WHERE mem_id = 'PINK' ; 
SELECT * FROM member ; 
SELECT * FROM buy ; 

# UNIQUE
DROP TABLE IF EXISTS buy, member ; 
CREATE TABLE member (
   mem_id  CHAR(8) NOT NULL PRIMARY KEY, 
   mem_name  VARCHAR(10) NOT NULL, 
   height TINYINT UNSIGNED NULL, 
   email CHAR(30) NULL UNIQUE 
) ; 
INSERT INTO member VALUES('BLK', '블랙핑크', 163, 'pink@gmail.com') ;
INSERT INTO member VALUES('TWC', '트와이스', 167, NULL) ;
INSERT INTO member VALUES('APN', '에이핑크', 164, 'pink@gmail.com') ;  -- 에러발생: 중복된 값

DROP TABLE IF EXISTS member ; 
CREATE TABLE member (
   mem_id  CHAR(8) NOT NULL PRIMARY KEY, 
   mem_name VARCHAR(10) NOT NULL, 
   height TINYINT UNSIGNED NULL CHECK(height >= 100), 
   phone1 CHAR(3) NULL
) ; 
DESC member ; 
INSERT INTO member VALUES('BLK', '블랙핑크', 163, NULL) ; 
INSERT INTO member VALUES('TWC', '트와이스', 67, NULL) ; -- 에러발생

ALTER TABLE member
   ADD CONSTRAINT 
   CHECK ( phone1 IN ('02', '031', '032', '054', '055', '061') ) ; -- 체크 조건 추가

INSERT INTO member VALUES('TWC', '트와이스', 167, '02') ; 
INSERT INTO member VALUES('OMY', '오마이걸', 167, '010') ; -- 에러 발생  

SELECT * FROM member ;

# DEFAULT 값 정의
DROP TABLE IF EXISTS member ; 
CREATE TABLE member (
   mem_id  CHAR(8) NOT NULL PRIMARY KEY,
   mem_name  VARCHAR(10) NOT NULL, 
   height  TINYINT UNSIGNED NULL DEFAULT 160, 
   phone1  CHAR(3) NULL
) ; 
ALTER TABLE member 
   ALTER COLUMN phone1 SET DEFAULT '02' ; -- 열의 조건을 바꿀 때에는 ALTER COLUMN

INSERT INTO member VALUES('RED', '레드벨벳', 161, '054') ; 
INSERT INTO member VALUES('SPC', '우주소녀', DEFAULT, DEFAULT) ; 
SELECT  * FROM member ; 