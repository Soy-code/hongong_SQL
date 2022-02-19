-- member 테이블 확인
USE market_db ; 
SELECT * FROM member ;
DESC member ; 

-- 인덱스 확인
SHOW INDEX FROM member ; 

-- 인덱스 크기 확인
SHOW TABLE STATUS LIKE 'member' ; 

-- 단순 보조 인덱스 생성
CREATE INDEX idx_member_addr
   ON member (addr) ; 
SHOW INDEX FROM member ; 

-- 인덱스 크기 확인
SHOW TABLE STATUS LIKE 'member' ; 
-- 테이블의 분석 및 처리
ANALYZE TABLE member ; 
SHOW TABLE STATUS LIKE 'member' ; 

-- mem_number 고유 보조 인덱스 생성
CREATE UNIQUE INDEX idx_member_mem_number 
   ON member (mem_number) ; -- 에러 발생, 중복값 존재 때문.
   
-- mem_name으로 고유 보조 인덱스 생성
CREATE UNIQUE INDEX idx_member_mem_name 
   ON member (mem_name) ;  
SHOW INDEX FROM member ; 
INSERT INTO member VALUES('MOO', '마마무', 2, '태국', '001', '12341234', 155, '2020.10.10') ; 

-- 인덱스 확인
ANALYZE TABLE member ; 
SHOW INDEX FROM member ; 

-- 인덱스의 활용
SELECT * FROM member ; 
SELECT mem_id, mem_name, addr FROM member ; 
SELECT mem_id, mem_name, addr FROM member
   WHERE mem_name = '에이핑크' ; 

CREATE INDEX idx_member_mem_number 
   ON member (mem_number) ; 
ANALYZE TABLE member ; 
SELECT mem_name, mem_number, addr FROM member 
	WHERE mem_number >= 7 ; 

-- 인덱스를 사용하지 않는 경우
SELECT mem_name, mem_number, addr FROM member
   WHERE mem_number >= 1 ; 
SELECT mem_name, mem_number, addr FROM member
	WHERE mem_number * 2 >= 14 ; 

-- 인덱스 제거
SHOW INDEX FROM member ; 
DROP INDEX idx_member_mem_name ON member ; 
DROP INDEX idx_member_addr ON member ; 
DROP INDEX idx_member_mem_number ON member ; 
SHOW INDEX FROM member ; 
-- 기본 키 제거
ALTER TABLE member
   DROP PRIMARY KEY ; -- 에러 발생

-- 외래 키 이름 알아내기
SELECT table_name, constraint_name
	FROM information_schema.referential_constraints 
	WHERE constraint_schema = 'market_db' ; 
    
-- 외래키, 기본키 제거
ALTER TABLE buy
	DROP FOREIGN KEY buy_ibfk_1 ; 
ALTER TABLE member
    DROP PRIMARY KEY ; 
SHOW INDEX FROM member ; 