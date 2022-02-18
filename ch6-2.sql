USE market_db ;
DROP TABLE IF EXISTS cluster ; 
-- cluster 테이블 생성
CREATE TABLE cluster (
   mem_id CHAR(8), 
   mem_name VARCHAR(10)
) ; 
INSERT INTO cluster VALUES('TWC', '투와이스') ;
INSERT INTO cluster VALUES('BLK', '블랙핑크') ;
INSERT INTO cluster VALUES('WNN', '여자친구') ;
INSERT INTO cluster VALUES('OMY', '오마이걸') ;
INSERT INTO cluster VALUES('GRL', '소녀시대') ;
INSERT INTO cluster VALUES('ITZ', '잇지') ;
INSERT INTO cluster VALUES('RED', '레드벨벳') ; 
INSERT INTO cluster VALUES('APN', '에이핑크') ;
INSERT INTO cluster VALUES('SPC', '우주소녀') ;
INSERT INTO cluster VALUES('MMW', '마마무') ;
SELECT * FROM cluster ;
-- 클러스터형 인덱스 구성하기 
ALTER TABLE cluster 
   ADD CONSTRAINT 
   PRIMARY KEY (mem_id) ; 
SHOW INDEX FROM cluster ;
SELECT * FROM cluster ;  

-- 똑같은 테이블 만들기
CREATE TABLE second (
   mem_id CHAR(8), 
   mem_name VARCHAR(10)
) ; 
INSERT INTO second VALUES('TWC', '트와이스') ; 
INSERT INTO second VALUES('BLK', '블랙핑크') ; 
INSERT INTO second VALUES('WMN', '여자친구') ; 
INSERT INTO second VALUES('OMY', '오마이걸') ; 
INSERT INTO second VALUES('GRL', '소녀시대') ; 
INSERT INTO second VALUES('ITZ', '잇지') ; 
INSERT INTO second VALUES('RED', '레드벨벳') ; 
INSERT INTO second VALUES('APN', '에이핑크') ; 
INSERT INTO second VALUES('SPC', '우주소녀') ; 
INSERT INTO second VALUES('MMW', '마마무') ; 
SELECT * FROM second ; 
-- 보조 인덱스 생성
ALTER TABLE second 
   ADD CONSTRAINT
   UNIQUE (mem_id) ; 
SELECT * FROM second ; 
